<html>
<head>
<title>Collegematch Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%
	if(request.getParameter("errorMsg")!=null){
        %>
        	<b>
		<font color="red">
                  <h3>
			<%=request.getParameter("errorMsg")%>
                  </h3>
		</font>
                </b>
        <%
	}
%>
<%
	if(request.getParameter("exitMsg")!=null){
        %>
		<font color="blue">
			<%=request.getParameter("exitMsg")%>
		</font>
        <%
	}
%>
<br>
<form action="authenticate.jsp" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#000000">
    <tr valign="top">
      <td> <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#CCCCCC">
          <tr bgcolor="#000000">
            <td width="20%" valign="top"><font color="#CCCCCC"><b>Sign
              In</b></font></td>
            <td width="80%" valign="top"><font color="#CCCCCC"></font></td>
          </tr>
          <tr valign="top">
            <td width="20%"><b>User Name</b><br>
              <input name="userName" type="text" size="25">
			  <p><b>Password</b><br>
                <input name="password" type="password" size="25">
              </p>
              <p>
                <input type="submit" name="Submit" value="Sign In">
            </p></td>
            <td width="80%"><b>Instructions:</b><br>
              Enter your User Name and Password. Please remember that these are case sensitive. Example User1 and user1 are different users.</td>
          </tr>
        </table></td>
    </tr>
  </table>
	<br>
	<br>
  <div align="right"><img src="tomcat-power.gif" width="77" height="80">
  </div>
</form>
</body>
</html>
