package collegematch;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.*;
import java.util.*;

/*

You have successfully saved your preferences.
Please use the following identity token when setting up Payment Data Transfer on your website.
jPzHkI08p9Fi_MkTnwhg_5NbKBZTk3CoyN83QBGTOhF_DHNhefwTlrgFe6K

*/

public class PDT extends HttpServlet {
//  private static final String CONTENT_TYPE = "text/html";

  //Initialize global variables
  public void init() throws ServletException {
  }

  //Clean up resources
  public void destroy() {
  }
  public void doCommon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String identityToken = "jPzHkI08p9Fi_MkTnwhg_5NbKBZTk3CoyN83QBGTOhF_DHNhefwTlrgFe6K";
    String transToken = request.getParameter("tx");

    PrintWriter out = response.getWriter();
    response.setContentType("text/html");
    String res = null;

    StringBuffer command = new StringBuffer();
    command.append("cmd=_notify-synch");
    command.append("&at="+identityToken);
    command.append("&tx="+transToken);

    //debug
    out.println("<br> **Variable dump**");
    Enumeration en = request.getParameterNames();
    while(en.hasMoreElements()){
      out.println("<br> element: " + en.nextElement());
    }
    //debug

    /*
     * Post Message back to PAYPAL PDT
     */

    try {
      //Live Server
      //URL u = new URL("https://www.paypal.com/cgi-bin/webscr");

      //Sandbox Server
      URL u = new URL("https://www.sandbox.paypal.com/cgi-bin/webscr");
      out.println("Opening Connection to test server");

      URLConnection uc = u.openConnection();
      uc.setDoOutput(true);

      OutputStream os = uc.getOutputStream();
      os.write(command.toString().getBytes());
      os.close();

      BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
      res = in.readLine();
      in.close();
    }catch (Exception e) {
      out.println("AccessControlException: " + e.getMessage() + "");
      e.printStackTrace(System.out);
      res = null;
    }

    out.println("<br>PAYPAL Response: " + res);

    if ("SUCCESS".equals(res)) {
      //show the user the request is good etc
      out.println("<br> Thank you " + request.getParameter("first_name") + " " + request.getParameter("last_name") +" for your purchase");
      out.println("<br> Subscription start date: "+ request.getParameter("subscr_date"));
      out.println("<br> Next is setting up your CollegeMatch username and password to access the member site.");
      out.println("<br> Please click here to continue <a href=\"something.html\">Link </a>");
    }
    if("FAIL".equals(res)){
      //paypal threw back an INVALID error from the transaction
      out.println("**Paypal returned failed response**");
      out.println("<br>You're stupid chris");
      out.println("<br> Debug Time:");
      out.println("<br> Transaction Token: " + transToken);
      out.println("<br> Identity Token: " + identityToken);
    }
  }
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException ,IOException{
    doCommon(request, response);
  }

}
