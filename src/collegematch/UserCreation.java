package collegematch;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import javax.naming.*;

public class UserCreation {
  private Connection con;
  private String userEmail, txnID,firstName,lastName;
  private double payment, fee;
  private Random r = new Random(System.currentTimeMillis());
  private long randomID = r.nextLong();


  public void setUserID(){
    try {
      PreparedStatement ps = con.prepareStatement("UPDATE processed SET ID = ? where txnID=?");
      ps.setLong(1,randomID);
      ps.setString(2,txnID);

      if(ps.executeUpdate()>0){
        //success, email user
        emailUser();
      }
      else{
        //email the admin something went wrong
        Emailer e = new Emailer();
        e.sendAdminMessage("UserCreation failed","UserCreation has failed to insert a random ID into the database. Please check the database");
      }
      ps.close();
    }catch (SQLException ex) {System.out.println("SQLException in UserCreation setUserID(): " + ex);}
  }
  public void setAccountingInfo(){
    try{
      PreparedStatement ps = con.prepareStatement("Insert into accounting values(?,now(),?)");
      ps.setDouble(1,payment);
      ps.setDouble(2,fee);
      if(ps.executeUpdate()==0){
        Emailer e = new Emailer();
        e.sendAdminMessage("UserCreation failed","UserCreation has failed to insert Accounting Info into the database. Please check the database");
      }
      ps.close();
    }catch(SQLException e){System.out.println("SQLException in UserCreation in setAccountingInfo(): " + e);}
  }
/*
  private void parseSubscription(){
    SimpleDateFormat format = new SimpleDateFormat("HH:mm:ss MMM dd, yyyy zzz");
    SimpleDateFormat newFormat = new SimpleDateFormat("yyyyMMddHHmmss");
    SimpleDateFormat emailFormat = new SimpleDateFormat("EEE, MMM d, yyyy");
    try{
      subscriptionDate = newFormat.format(format.parse(subscriptionDate));
    }catch(ParseException e){System.out.println("ParseException in UserCreation in parseSubscription(): " + e);}
  }
*/
  public void setFirstName(String firstName){
    this.firstName = firstName;
  }
  public void setLastName(String lastName){
    this.lastName = lastName;
  }
  public void setTxnID(String txnID){
    this.txnID = txnID;
  }
  public void setUserEmail(String userEmail){
    this.userEmail = userEmail;
  }
  public void setPayment(double payment){
    this.payment = payment;
  }
  public void setFee(double fee){
    this.fee = fee;
  }
  private void emailUser(){
    Emailer e = new Emailer();
    StringBuffer b = new StringBuffer();
    b.append(firstName+ " " + lastName);
    b.append(",\r\nThank you for purchasing a CollegeMatch subscription. \r\n");
    b.append("Your subscription starts " + new java.util.Date(System.currentTimeMillis()) + " and is valid for 1 month\r\n");
    b.append("Your user account is almost complete.  The next step is setting up your member account\r\n");
    b.append("Please click on this link to confirm the creation of your account: http://collegematch.no-ip.com:9090/CollegeMatch/accountvalidate?id="+randomID+" \r\n");
    b.append("The link contains a password that is only good for one use, if you have any problems email the admin at: admin@collegematch.no-ip.com \r\n");
    b.append("In case of error, your txnID is " + txnID + " please email this to the admin along with your first and last name for verification purposes if you have trouble creating an account\r\n");
    b.append("Thank you,\r\n");
    b.append("CollegeMatch team");
    e.sendCustomerMessage(null,userEmail,"CollegeMatch Subscription Info",b.toString());
  }
  public void connect(){
    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/CollegeMatch");
      con = ds.getConnection();
    }catch (SQLException ex) {System.out.println("SQLException in UserCreation connect(): " + ex);}
    catch (NamingException ex) {System.out.println("NamingException in UserCreation connect(): " + ex);}
  }
  public void disconnect(){
    try {

      con.close();
    }catch (SQLException ex) {System.out.println("SQLException in UserCreation disconnect(): " + ex);}
  }
}
