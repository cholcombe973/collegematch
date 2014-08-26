<html>
<head>
<title>
usernameSearch
</title>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<div align="center"><img src="Banner2.jpg" width="500" height="85" align="middle"  />
</div>
<!--<form name="form1" method="post" action="http://collegematch.no-ip.com:9090/CollegeMatch/searchResults.jsp?type=user">
-->
<form name="form1" method="POST" action="searchResults.jsp">
  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#000000">
    <tr>
      <td> <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#CCCCCC">
          <tr bgcolor="#000000">
            <td colspan="3"><font color="#CCCCCC"><font color="#CCCCCC"><b>Search for matches
              </b></font></font></td>
          </tr>
          <tr>
            <td align="right"> UserName:</td>
            <td><input size="25" name="userName" value=""></td>
            <td rowspan="5" valign="middle"><p>&nbsp;</p>  </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>
				<input type="submit" name="Submit" value="Search">
			</td>
          </tr>
        </table></td>
    </tr>
  </table>
  <div align="right"><br>
    <br>
    <img src="tomcat-power.gif"/>
  </div>
<input type="hidden" name="type" value="user"/>
</form>


</body>
</html>
