package collegematch;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

/*
//Database connection
Context initCtx = new InitialContext();
Context envCtx = (Context) initCtx.lookup("java:comp/env");
DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
Connection con = ds.getConnection();

   Payment Structure:
   1. First a user makes a purchase on paypal.com.
   2. IPN posts my paypal servlet and it takes care of verifying the transaction
   3. After verified and completed, it's kicked over to UserCreation class
   4. UserCreation sets some database records and sends an email to the user
   5. The email will contain a link with a 1 time good ID.
   6. My usercreation jsp page will verify the ID and junk it.
   7. My jsp page will create a user account after verifing the ID and other necessary login params
   8. If the user screws up, they'll have to email the admin(me) for another ID

   Paypal variables of use:
   mc_amount3     : Amount of payment for regular subscription period (**MUST BE VERIFIED**) 5.00
   period3        : Regular Subscription interval
   payer_email    : Buyer of the subscription
   receiver_email : CollegeMatchTester@hotmail.com                    (**MUST BE VERIFIED**) CollegeMatchTester@hotmail.com
   subscr_id      : Paypal generated subscriber ID
   subscr_date    : Date subscription was purchased
   first_name     : Obvious
   last_name      : Obvious
   payment_fee    : Amount taken from transaction by Paypal
   txn_id         : Transaction ID.  Prevents playback attacks        (**MUST BE VERIFIED**) NO DUPLICATES
   payer_status   : VERIFED or UNVERIFED
   item_name      : Name of the product purchased
   item_number    : Number of the product purchase                    (**MUST BE VERIFIED**) 105423
   test_ipn       : Value of 1 means we're sandboxing it
   payment_type   : instant or echeck                                 (** BLOCK THAT ECHECK SHIT **)
   receiver_id    : Unique account id of the payment receipt
   txn_type       : values= "subscr_signup,subscr_cancel,subscr_payment,subscr_eot,subscr_failed"
*/
public class Paypal extends HttpServlet {

  //Initialize global variables
  public void init() throws ServletException {
  }

  //Clean up resources
  public void destroy() {
  }
  private Hashtable pullParams(byte[] data){
/*
    System.out.println("\n*****************BINARY DATA DUMP*************************************");
    System.out.print("'");
    for(int i=0;i<data.length;i++){
      if(data[i]==0)
        break;
      System.out.print("["+data[i]+"] ");
      System.out.print((char)data[i]);
      System.out.print(' ');
    }
    System.out.print("'");
    System.out.println("\n*****************BINARY DATA DUMP*************************************");
*/
    //this method saves parameters from binary data streams
    Hashtable params = new Hashtable();
    String key = "";
    String value = "";
    int length = data.length;
    int offset = 0;
    for(int i=0;i<length;i++){
      //test code
      if(data[i]==0)
        break;
      //test code
      if(data[i]=='='){
        key = new String(data,offset,(i-offset));
        offset = i+1;
      }
      if(data[i]=='&'){
        try {
          value = URLDecoder.decode(new String(data, offset, (i - offset)),"UTF-8");
        }catch (UnsupportedEncodingException ex) {System.out.println("UnsupportedEncodingException: " + ex);}
        offset = i+1;
        params.put(key,value);
      }
      if(i==(length-1))
        value = new String(data,offset,(length-offset));
    }
    params.put(key,value);
    return params;
  }
  public void doCommon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String res = null;

    /*
     * Post Message back to PAYPAL authentication page
     */

    ServletInputStream is = request.getInputStream();
    byte[] command = "cmd=_notify-validate&".getBytes();
    byte[] binaryData = new byte[4096];
    int c = 0;
    int off = 0;

    while((c=is.read())!=-1){
      if(off==binaryData.length){
        //redo the capacity
        byte[] elementData = binaryData;
        binaryData = new byte[binaryData.length*2];
        System.arraycopy(elementData,0,binaryData,0,elementData.length);
      }
      binaryData[off] = (byte)c;
      off++;
    }
    Hashtable params  = pullParams(binaryData);

    try {
      //Live Server
      //URL u = new URL("https://www.paypal.com/cgi-bin/webscr");

      //EliteWeaver Testing server
      //URL u = new URL("http://www.eliteweaver.co.uk/testing/ipntest.php");

      //Sandbox Server
      URL u = new URL("https://www.sandbox.paypal.com/cgi-bin/webscr");

      URLConnection uc = u.openConnection();
      uc.setDoOutput(true);

      OutputStream os = uc.getOutputStream();
      os.write(command);
      os.write(binaryData);
      os.close();

      BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
      res = in.readLine();
      in.close();
    }catch (Exception e) {
      System.out.println("AccessControlException: " + e.getMessage() + "");
      e.printStackTrace(System.out);
      res = null;
    }

    if (("subscr_payment".equals((String)params.get("txn_type")))&&("VERIFIED".equals(res))){
      //the subscriber has made a payment

      //this should check the subscr_id and the payer_id to see if someone is already in the system paying
      //for a member account after a trial
      //payer_id should match another user unless we have a new user signing up
      //if a select on the paypal table doens't match any existing users create new entries for this member
      //this method could possibly only have to update the paypal and accounting tables

      if(("5.00".equals((String)params.get("mc_gross")))&&("CollegeMatchTester@hotmail.com".equals((String)params.get("receiver_email")))&&("105423".equals((String)params.get("item_number")))){
        try {
          Context initCtx = new InitialContext();
          Context envCtx = (Context) initCtx.lookup("java:comp/env");
          DataSource ds = (DataSource) envCtx.lookup("jdbc/CollegeMatch");
          Connection con = ds.getConnection();


          //  Faulty logic going on here.  I delete the txn_id from the processed table so this will always return true
          //  Solution: Leave all txnID's in the processed table, *but* do an UPDATE and set the randomID = 0;
          //  if randomID is 0 then the user is not allowed to create an account.

          PreparedStatement ps = con.prepareStatement("Select * from processed where txnID=?");
          ps.setString(1,(String)params.get("txn_id"));
          if(!(ps.executeQuery().next())){
            ps = con.prepareStatement("Insert into processed(txnID) values(?)");
            ps.setString(1,(String)params.get("txn_id"));
            if(ps.executeUpdate()==0){
              Emailer e = new Emailer();
              e.sendAdminMessage("Error inserting txnID","Paypal servlet has failed to insert a txnID.  Check the database.");
            }
            //insert all data into paypal table
            ps = con.prepareStatement("INSERT INTO paypal (mc_amount3,period3,payer_email,receiver_email,subscr_id,subscr_date,first_name,last_name,payment_fee,txn_id,payer_status,item_name,item_number,payment_type,receiver_id) VALUES(?,?,?,?,?,now(),?,?,?,?,?,?,?,?,?)");
            ps.setDouble(1, Double.parseDouble((String)params.get("mc_gross")));
            ps.setString(2, "1 M"); // 1 month is assumed since period3 is not include in the payment IPN post
            ps.setString(3, (String)params.get("payer_email"));
            ps.setString(4, (String)params.get("receiver_email"));
            ps.setString(5, (String)params.get("subscr_id"));
            ps.setString(6, (String)params.get("first_name"));
            ps.setString(7, (String)params.get("last_name"));
            ps.setString(8, (String)params.get("payment_fee"));
            ps.setString(9,(String)params.get("txn_id"));
            ps.setString(10,(String)params.get("payer_status"));
            ps.setString(11,(String)params.get("item_name"));
            ps.setString(12,(String)params.get("item_number"));
            ps.setString(13,(String)params.get("payment_type"));
            ps.setString(14,(String)params.get("receiver_id"));
            if(ps.executeUpdate()==0){
              //failed to insert paypal records into database
              Emailer e = new Emailer();
              StringBuffer b = new StringBuffer();
              b.append("While trying to update the database an insert query failed.\r\n");
              b.append("Paypal data that failed to insert: \r\n");
              b.append("mc_amount3: " + Double.parseDouble((String)params.get("mc_amount3"))+"\r\n");
              b.append("payer_email: " + params.get("payer_email") + "\r\n");
              b.append("receiver_email: " + params.get("receiver_email") + "\r\n");
              b.append("subscr_id : " + params.get("subscr_id") + "\r\n");
              b.append("first_name: " + params.get("first_name") + "\r\n");
              b.append("last_name: " + params.get("last_name") + "\r\n");
              b.append("payment_fee: " + params.get("payment_fee") + "\r\n");
              b.append("txn_id: " + params.get("txn_id") + "\r\n");
              b.append("payer_status: " + params.get("payer_status") + "\r\n");
              b.append("item_name: " + params.get("item_name") + "\r\n");
              b.append("item_number: " + params.get("item_number") + "\r\n");
              b.append("payment_type: " + params.get("payment_type") + "\r\n");
              b.append("receiver_id: " + params.get("receiver_id") + "\r\n");
              e.sendAdminMessage("Paypal information insert failed",b.toString());
            }
            //txnID is in the database now
            //insert all the paypal information into the table
            //everything is good correct amount, correct email, correct item number, correct payment type
            //Kick the user over to the UserCreation class
            UserCreation uc = new UserCreation();
            uc.connect();
            uc.setFirstName((String)params.get("first_name"));
            uc.setLastName((String)params.get("last_name"));
            uc.setTxnID((String)params.get("txn_id"));
            uc.setUserEmail((String)params.get("payer_email"));
            uc.setPayment(Double.parseDouble((String)params.get("mc_gross")));
            uc.setFee(Double.parseDouble((String)params.get("payment_fee")));
            uc.setUserID();
            uc.setAccountingInfo();
            uc.disconnect();
          }else{
            //txnID is duplicate.  Email the admin about this shit
            Emailer e = new Emailer();
            StringBuffer buff = new StringBuffer();
            Enumeration enum =params.keys();
            String element = null;
            while(enum.hasMoreElements()){
              element = (String)enum.nextElement();
              buff.append(element + " : " + params.get(element));
            }
            e.sendAdminMessage("Duplicate txnID attempting to be processed",buff.toString());
          }
          ps.close();
          con.close();
        }catch (SQLException ex) {
          System.out.println("SQLException in Paypal doCommon(): " + ex);
          ex.printStackTrace(System.out);
        }
        catch (NamingException ex) {
          System.out.println("NamingException in Paypal doCommon(): " + ex);
          ex.printStackTrace(System.out);
        }
      }
    }
    else if(("subscr_signup".equals((String)params.get("txn_type")))&&("VERIFIED".equals(res))){
      //the subscriber has signed up but is still on a trial period so they haven't paid anything yet
      //create a trial account for the user.  allow them to setup their user details.  no emailing or chatting allowed






    }
    else if(("subscr_cancel".equals((String)params.get("txn_type")))&&("VERIFIED".equals(res))){
      //the user has canceled the subscription, remove their user account
      //subscr_id matches when the user created the account.  Do a lookup on that id and delete the account
      try{
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource) envCtx.lookup("jdbc/CollegeMatch");
        Connection con = ds.getConnection();

        //now we need to go through and delete all references to that user.. dammit
        PreparedStatement ps = con.prepareStatement("Select id from users where firstname=? and lastname=?");
        ps.setString(1,(String)params.get("first_name"));
        ps.setString(2,(String)params.get("last_name"));
        int userID = 0;
        ResultSet rs = ps.executeQuery();
        if(rs.next()){
          userID = rs.getInt(1);
          Statement s = con.createStatement();
          s.addBatch("DELETE LOW_PRIORITY FROM appearance where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM idealmatch where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM interests where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM lifestyle where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM ownwords where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM perfectdate where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM turnons where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM users where id=" + userID);
          s.addBatch("DELETE LOW_PRIORITY FROM value where id=" + userID);

          int[] rowsRemoved = s.executeBatch();
          //email the admin when it's finished just to inform him that a user was deleted
          Emailer e = new Emailer();
          StringBuffer b = new StringBuffer();
          b.append("A user has been deleted from the database due to cancelation\r\n");
          Enumeration dumpKeys = params.keys();
          String dumpKey = "";
          while(dumpKeys.hasMoreElements()){
            dumpKey = (String)dumpKeys.nextElement();
            b.append(". '"+dumpKey + "' '" + params.get(dumpKey)+"'\r\n");
          }
          b.append("Rows removed from appearance: " + rowsRemoved[0] + "\r\n");
          b.append("Rows removed from idealmatch: " + rowsRemoved[1] + "\r\n");
          b.append("Rows removed from interests: " + rowsRemoved[2] + "\r\n");
          b.append("Rows removed from lifestyle: " + rowsRemoved[3] + "\r\n");
          b.append("Rows removed from ownwords: " + rowsRemoved[4] + "\r\n");
          b.append("Rows removed from perfectdate: " + rowsRemoved[5] + "\r\n");
          b.append("Rows removed from turnons: " + rowsRemoved[6] + "\r\n");
          b.append("Rows removed from users: " + rowsRemoved[7] + "\r\n");
          b.append("Rows removed from value: " + rowsRemoved[8] + "\r\n" );

          e.sendAdminMessage("User deletion confirmed",b.toString());
        }else{
          //couldn't find the user to delete, ..email the admin
          Emailer e = new Emailer();
          StringBuffer b = new StringBuffer();
          b.append("While attempting to find a user to delete the database returned a null set\r\n");
          b.append("Param dump:");

          Enumeration dumpKeys = params.keys();
          String dumpKey = "";
          while(dumpKeys.hasMoreElements()){
            dumpKey = (String)dumpKeys.nextElement();
            b.append(". '"+dumpKey + "' '" + params.get(dumpKey)+"'");
          }
          e.sendAdminMessage("User deletion failed",b.toString());
        }
        rs.close();
        ps.close();
        con.close();
      }catch(SQLException ex){
        System.out.println("SQLException in Paypal doCommon() subscr_cancel: " + ex);
        ex.printStackTrace(System.out);
      }
      catch(NamingException ex){
        System.out.println("NamingException in Paypal doCommon subscr_cancel: " + ex);
        ex.printStackTrace(System.out);
      }
    }
    if("INVALID".equals(res)){ //email the admin about this
      Emailer e = new Emailer();
      StringBuffer buff = new StringBuffer();
      Enumeration enum =params.keys();
      String element = null;
      while(enum.hasMoreElements()){
        element = (String)enum.nextElement();
        buff.append(element + " : " + params.get(element));
      }
      e.sendAdminMessage("Invalid PayPal payment",buff.toString());
    }
  }
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

}
