<html>
<head>
<title>
logOut
</title>
</head>
<body bgcolor="#ffffff">
<%
	session.invalidate();
%>
<jsp:forward page="login.jsp" >
 <jsp:param name="exitMsg" value="Thank you.  Come again"/>
</jsp:forward>
</body>
</html>
