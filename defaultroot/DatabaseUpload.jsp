<html>
<%@ page language="java" import="collegematch.*,java.io.*,java.util.*,java.sql.*,javax.naming.*,javax.sql.*" %>
<jsp:useBean id ="upBean" scope="application" class="collegematch.UploadBean"/>
<%
  upBean.connect();
%>
<head>
<title>CollegeMatch Picture Upload</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<div align="center"><img src="Banner2.jpg" width="500" height="85" align="middle"/></div>
<ul><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">
<%
	ValidUser user = (ValidUser)session.getAttribute("validUser");
	if(user==null){
        	%>
			<jsp:forward page="login.jsp">
			  <jsp:param name="errorMsg" value="Please login first"/>
                        </jsp:forward>
		<%
	}

	if(upBean.isMultiPartRequest(request)){
	  upBean.store(request,user.getID());
	  int lastid = upBean.getLastID();
	  out.println("<br>File uploaded Successfully");
	  out.println("<br>LastID: " + lastid);
	}
%>
</font></ul>
<form method="post" action="DatabaseUpload.jsp" name="upform" enctype="multipart/form-data">
  <table width="60%" border="0" cellspacing="1" cellpadding="1" align="center">
    <tr>
      <td align="left"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif"><b>Select
        a picture to upload :</b></font></td>
    </tr>
    <tr>
      <td align="left"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">
        <input type="file" name="uploadfile" size="50">
        </font></td>
    </tr>
    <tr>
      <td align="left"><font size="-1" face="Verdana, Arial, Helvetica, sans-serif">
		<input type="hidden" name="todo" value="upload">
        <input type="submit" name="Submit" value="Upload">
        <input type="reset" name="Reset" value="Cancel">
        </font></td>
    </tr>
  </table>
  <br>
  <br>
</form>
<%
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();

%>

</body>
</html>
