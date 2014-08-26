<%@ page import="java.util.*,java.net.*,java.io.*,java.sql.*,javax.sql.*,javax.naming.*" session="false"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();

// read post from PayPal system and add 'cmd'
Enumeration en = request.getParameterNames();
String str = "&cmd = _notify-validate";
while(en.hasMoreElements()){
	String paramName = (String)en.nextElement();
	String paramValue = request.getParameter(paramName);
	out.println("<br>paramName: " + paramName);
	out.println("<br>paramValue: " + paramValue);
	str = str + "&" + paramName + "=" + URLEncoder.encode(paramValue,"UTF-8");
}
// post back to PayPal system to validate
URL u = new URL("http://www.paypal.com/cgi-bin/webscr");
//URL u = new URL("http://www.eliteweaver.co.uk/testing/ipntest.php");
URLConnection uc = u.openConnection();
uc.setDoOutput(true);
uc.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
PrintWriter pw = new PrintWriter(uc.getOutputStream());
pw.print(str);
pw.close();
out.println("<br><br> <b>String</b>: " + str);
BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream()));
String res = in.readLine();
in.close();

// assign posted variables to local variables
//String itemName = request.getParameter("item_name");
//String itemNumber = request.getParameter("item_number");
String paymentStatus = request.getParameter("payment_status");
String paymentAmount = request.getParameter("mc_gross");
//String paymentCurrency = request.getParameter("mc_currency");
String txnId = request.getParameter("txn_id");
String receiverEmail = request.getParameter("receiver_email");
//String payerEmail = request.getParameter("payer_email");
out.println("<br>Payment Status: " + paymentStatus);
out.println("<br>paymentAmount: " + paymentAmount);
out.println("<br>txnID: " + txnId);
out.println("<br>receiverEmail: " + receiverEmail);
//check notification validation
out.println("<br>response: " + res);

if(res.equalsIgnoreCase("VERIFIED")) {
		if(paymentStatus.equalsIgnoreCase("Completed") && receiverEmail.equalsIgnoreCase("xfactor973@hotmail.com") && paymentAmount.equalsIgnoreCase("0.01")){
                	out.println("<br>verified, completed etc");
			PreparedStatement ps = con.prepareStatement("Select * from processed where txnID=?");
                     	ps.setString(1,txnId);
			if(!ps.executeQuery().next()){
                		// everything is legit // process it
                                out.println("<b>Everything was processed ok</b>");
			}
		}
	// check that paymentStatus=Completed
	// check that txnId has not been previously processed
	// check that receiverEmail is your Primary PayPal email
	// check that paymentAmount/paymentCurrency are correct
	// process payment
}
else if(res.equalsIgnoreCase("INVALID")) {
	// log for investigation
	%>Error: Invalid transaction.  Response:<%=res%> Please contact the administrator: <a href="mailto:xfactor973@hotmail.com">Admin</a><%
}
else {
	// error
	%>Response:<%=res%> An Error has occured while processing your transaction.  Please contact the administrator: <a href="mailto:xfactor973@hotmail.com">Admin</a> <%
}
%>
<form name="form1" method="post" action="">
  <table width="90%" border="0" cellpadding="8" bgcolor="#FFFFFF">
    <tr>
      <td colspan="3" bgcolor="#CCCCCC">
        <b>Register</b></td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC" nowrap>
        User Name<font size="-2">*</font></td>
      <td colspan="2" bgcolor="#FFFFFF">
        <input type="text" name="textfield">        <br>
          <font size="-2">*</font>
          <font size="-1"> Please enter the username here that you would like to use.  Remember when you
                           login that this password is case sensitive. Example: Username and username are different. </font></td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Password<font size="-2">*</font></td>
      <td colspan="2" bgcolor="#FFFFFF">        <input type="password" name="textfield2">        </td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Confirm<br>
        Password</td>
      <td colspan="2" bgcolor="#FFFFFF">
        <input type="password" name="textfield3">
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Name</td>
      <td width="43%" bgcolor="#FFFFFF">        <input type="text" name="textfield4">        <br>        <font size="-1">First</font></td>
      <td width="46%" bgcolor="#FFFFFF">        <input type="text" name="textfield5">        <br>        <font size="-1">Last</font></td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Email</td>
      <td colspan="2" bgcolor="#FFFFFF">        <input type="text" name="textfield6" size="50">        </td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Gender</td>
      <td colspan="2" bgcolor="#FFFFFF">        <p>
          <input type="radio" name="radiobutton1" value="radiobutton">
          Male
          <input type="radio" name="radiobutton1" value="radiobutton">
        Female </p></td>
    </tr>
    <tr valign="top">
      <td align="right" bgcolor="#CCCCCC">
        Birth Date</td>
      <td colspan="2" bgcolor="#FFFFFF">        <table border="0" cellspacing="2" cellpadding="0">
          <tr align="left">
            <td><input type="text" name="textfield7" size="2"></td>
            <td><input type="text" name="textfield8" size="2"></td>
            <td><input type="text" name="textfield9" size="4"></td>
          </tr>
          <tr align="left">
            <td>MM</td>
            <td>DD</td>
            <td>YYYY</td>
          </tr>
        </table></td>
    </tr>
    <tr valign="top" bgcolor="#FFFFFF">
      <td colspan="3"><input type="submit" name="Submit" value="Submit"></td>
    </tr>
  </table>
</form>
</body>
</html>
