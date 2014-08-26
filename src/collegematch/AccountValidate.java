package collegematch;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

/*
    The purpose of this servlet is to validate users
    1. User clicks on email and sends a get over to the accountvalidate servlet with their ID
    2. Servlet looks up the ID, if valid generates a userName and password for the customer.
    3. Forwards user over to index.jsp for logging in.
*/
public class AccountValidate extends HttpServlet {

  //Initialize global variables
  public void init() throws ServletException {
  }

  public void doCommon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
    long id = Long.parseLong(request.getParameter("id"));
    try{
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
      Connection con = ds.getConnection();

      PreparedStatement ps = con.prepareStatement("SELECT txnID FROM processed WHERE id=?");
      ps.setLong(1,id);
      ResultSet rs = ps.executeQuery();
      if(rs.next()){                    //id exists and matches
        String txnID = rs.getString(1); //cross reference this to the paypal table for user information
                                        //remove that id.  it's only good once
        ps = con.prepareStatement("UPDATE processed SET ID=0 WHERE txnID=?");
        ps.setString(1,txnID);
        if(ps.executeUpdate()==0){
          Emailer e = new Emailer();
          StringBuffer b = new StringBuffer();
          b.append("AccountValidate has attempted to set an id to 0 and failed.\r\n");
          b.append("ID attempted: " + id + "\r\n");
          e.sendAdminMessage("RandomID error",b.toString());
        }

        //at this point, create a username/password and create the account
        //use the txnID to cross reference the paypal table and get and fill out account details
        ps = con.prepareStatement("select first_name,last_name,payer_email from paypal where txn_id=?");
        ps.setString(1,txnID);
        rs = ps.executeQuery();
        if(rs.next()){
          ps = con.prepareStatement("Insert into users values(null,?,md5(?),'user',?,?,curdate(),date_add(curdate(),interval 1 month),?)");
          String pw = new RandomPassword().generatePassword(12);
          String temp = rs.getString(3);
          String user = temp.substring(0,temp.indexOf('@'));
          ps.setString(1,user);
          ps.setString(2,pw);
          ps.setString(3,rs.getString(1));
          ps.setString(4,rs.getString(2));
          ps.setString(5,temp);
          if(ps.executeUpdate()==0){
            //User account couldn't be created.  Email the admin about this.
            Emailer e = new Emailer();
            StringBuffer b = new StringBuffer();
            b.append("AccountValidate failed while trying to create a new user account\r\n");
            b.append("Debug Information:\r\n");
            b.append("UserName: "+ user + "\r\n");
            b.append("Password: " + pw + "\r\n");
            b.append("FirstName: " + rs.getString(1)+"\r\n");
            b.append("LastName: " + rs.getString(2) + "\r\n");
            b.append("Email: " + temp + "\r\n");
            e.sendAdminMessage("User Account creation failed",b.toString());

            PrintWriter out = response.getWriter();
            out.println("<html>");
            out.println("<head><title>AccountValidate</title></head>");
            out.println("<body>");
            out.println("We're sorry but an error was encountered while creating your account");
            out.println("<br>The administrator has been informed of this error and we will work quickly to resolve this issue.  The CollegeMatch Team.");
            out.println("</body></html>");
          }
          //Print out to the screen that the users username and password is ...
          PrintWriter out = response.getWriter();
          out.println("<html>");
          out.println("<head><title>AccountValidate</title></head>");
          out.println("<body>");
          out.println("<div align=\"center\"><img src=\"Banner2.jpg\" width=\"500\" height=\"85\" align=\"middle\"/></div>");
          out.println("Thank you for your purchase.  Your username is <b>"+user+"</b> and your password is <b>"+pw+"</b>");
          out.println("<br>It is strongly recommended that you keep this password.  It was securely generated.  If you decide to change your password you can at your discretion at your user homepage.");
          out.println("<br>The CollegeMatch Team");
          out.println("</body></html>");
        }
        else{
          //Couldn't find any paypal information for the selected user
          //email the admin with this error
          Emailer e = new Emailer();
          StringBuffer b = new StringBuffer();
          b.append("AccountValidate has attempted to pull paypal information that doesn't exist.");
          b.append("Debug Information: \r\n");
          b.append("Attemped to pull txnID: " + txnID);
          e.sendAdminMessage("PayPal account missing",b.toString());

          PrintWriter out = response.getWriter();
          out.println("<html>");
          out.println("<head><title>AccountValidate</title></head>");
          out.println("<body>");
          out.println("We're sorry but your paypal account information couldn't be found.  The administrator has been informed of this situation");
          out.println("<br>We will look into this situation and resolve it as soon as possible.  We apologize for any inconvience. The CollegeMatch Team");
          out.println("</body></html>");
        }
      }else{
        //send an admin email with their ip address and all other details easily obtainable.
        Emailer e = new Emailer();
        StringBuffer b = new StringBuffer();
        b.append("A client has attempted to use an ID that doesn't exist.\r\n");
        b.append("Clients ip address: " + request.getRemoteAddr() + " and clients host name: " + request.getRemoteHost()+"\r\n");
        b.append("ID attempted: " + id + "\r\n");
        e.sendAdminMessage("Illegal ID attempt detected",b.toString());

        PrintWriter out = response.getWriter();
        out.println("<html>");
        out.println("<head><title>AccountValidate</title></head>");
        out.println("<body>");
        out.println("<b>Sorry but the ID you have entered is not valid.");
        out.println("<br>An email has been sent to the admin and your ip address has been logged.");
        out.println("</b></body></html>");
      }
      rs.close();
      ps.close();
      con.close();
    }catch(NamingException e){
      System.out.println("NamingException in AccountValidate doCommon():" + e);
      e.printStackTrace(System.out);
    }
    catch(SQLException e){
      System.out.println("SQLException in AccountValidate doCommon(): " + e);
      e.printStackTrace(System.out);
    }
  }

  //Process the HTTP Post request
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

  //Clean up resources
  public void destroy() {
  }
}
