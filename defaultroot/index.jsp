<%@page import="java.sql.*,javax.sql.*,javax.naming.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Index</title>
</head>
<style>
#siteInfo{
	clear: both;
	border-top: 1px solid #cccccc;
	font-size: small;
	color: #cccccc;
	padding: 10px 10px 10px 10px;
	margin-top: 0px;
}
a:link, a:visited{
	color: #005FA9;
	text-decoration: none;
}
</style>
<body>
<%
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();
%>
<table bgcolor="#cccccc" width="100%" >
	<tr>
		<td align="center"><img src="IndexHeader.gif"></td>
		<td align="right"><a href="login.jsp"><img src="IndexLoginSmall.jpg" border="0"/></a><br>
		<!-- Live Button -->

		<!-- Sandbox tester -->
                <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
                <input type="hidden" name="cmd" value="_s-xclick">
		<input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/x-click-but24.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
		<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----
		">
		</form>
                <br>

		<!-- Instant Payment Button-->
                <form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post">
                	<input type="hidden" name="cmd" value="_s-xclick">
			<input type="image" src="https://www.sandbox.paypal.com/en_US/i/btn/x-click-but24.gif" border="0" name="submit" alt="Make payments with PayPal - it's fast, free and secure!">
			<input type="hidden" name="encrypted" value="-----BEGIN PKCS7-----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-----END PKCS7-----">
		</form>

<!--                <b><a href="">Signup</a></b>
-->
                </td>
	</tr>
</table>
<br>
<br>
<div align="center">
	<img src="IndexPreviewTopper.jpg">
</div>
<table width="100%">
<tr>
<td><img src="IndexPreview2.jpg">

</td>
<td align="right">
	<img src="IndexPreview3.jpg">
</td>
</tr>
</table>
<table width="100%">
<tr>
<td width="50%">CollegeMatch is a global community of single college students who share common goals. If you're looking to make new friends, go out on dates and find that special someone you've come to the right place. </td>
<td align="right">
<form name="form1" method="post" action="searchResults.jsp">
  <table border="0" cellspacing="0" cellpadding="1" >
    <tr>
      <td> <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#CCCCCC">
          <tr bgcolor="#000000">
            <td colspan="3"><div align="center"><font color="#CCCCCC"><font color="#CCCCCC"><b>Search for matches
              </b></font></font></div></td>
          </tr>
          <tr>
            <td align="right">Key Words</td>
            <td><input size="25" name="keyWords" value=""/></td>
          </tr>
          <tr>
            <td align="right">Options: </td>
            <td>
            	<input type="radio" name="dating" value="dating" checked>Dating
                <input type="radio" name="dating" value="friends">Friends
              	<input name="photoOnly" type="checkbox" value="photoOnly">Photo's Only
            </td>
          </tr>
          <tr>
            <td><div align="right">I am a: </div></td>
            <td><select name="Gender">
              <option value="Male" selected>Man</option>
			  <option value="Female">Woman</option>
            </select>
              seeking a
              <select name="lookingFor">
				<option value="Female" selected>Woman</option>
				<option value="Male">Man</option>
              </select>
              between
<select name="lowerAge" >
	<option value="18" selected>18</option>
	<option value="19">19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>
	<option value="32">32</option>
	<option value="33">33</option>
	<option value="34">34</option>
	<option value="35">35</option>
	<option value="36">36</option>
	<option value="37">37</option>
	<option value="38">38</option>
	<option value="39">39</option>
	<option value="40">40</option>
	<option value="41">41</option>
	<option value="42">42</option>
	<option value="43">43</option>
	<option value="44">44</option>
	<option value="45">45</option>
	<option value="46">46</option>
	<option value="47">47</option>
	<option value="48">48</option>
	<option value="49">49</option>
	<option value="50">50</option>
	<option value="51">51</option>
	<option value="52">52</option>
	<option value="53">53</option>
	<option value="54">54</option>
	<option value="55">55</option>
	<option value="56">56</option>
	<option value="57">57</option>
	<option value="58">58</option>
	<option value="59">59</option>
	<option value="60">60</option>
</select>
and
<select name="upperAge" >
	<option value="18">18</option>
	<option value="19" selected>19</option>
	<option value="20">20</option>
	<option value="21">21</option>
	<option value="22">22</option>
	<option value="23">23</option>
	<option value="24">24</option>
	<option value="25">25</option>
	<option value="26">26</option>
	<option value="27">27</option>
	<option value="28">28</option>
	<option value="29">29</option>
	<option value="30">30</option>
	<option value="31">31</option>
	<option value="32">32</option>
	<option value="33">33</option>
	<option value="34">34</option>
	<option value="35">35</option>
	<option value="36">36</option>
	<option value="37">37</option>
	<option value="38">38</option>
	<option value="39">39</option>
	<option value="40">40</option>
	<option value="41">41</option>
	<option value="42">42</option>
	<option value="43">43</option>
	<option value="44">44</option>
	<option value="45">45</option>
	<option value="46">46</option>
	<option value="47">47</option>
	<option value="48">48</option>
	<option value="49">49</option>
	<option value="50">50</option>
	<option value="51">51</option>
	<option value="52">52</option>
	<option value="53">53</option>
	<option value="54">54</option>
	<option value="55">55</option>
	<option value="56">56</option>
	<option value="57">57</option>
	<option value="58">58</option>
	<option value="59">59</option>
	<option value="60">60</option>
</select>

		    </td>
          </tr>
          <tr>
            <td><div align="right">School:</div></td>
            <td>
	<%
	try{
		PreparedStatement ps = con.prepareStatement("SELECT school FROM interests group by school");
		ResultSet rs = ps.executeQuery();

%>
<select name="school">
	<option value="allSchools" selected>All Schools</option>
<% while(rs.next()){%>
	<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%}
	ps.close();
      	rs.close();
	con.close();
	}catch(SQLException e){out.println("SQLException: " + e);}

%>
</select>
			</td>
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
  <input type="hidden" name="type" value="advanced"/>
</form>
</td>
</tr>
</table>


<div id="siteInfo">
      	<a href="AboutUs.html">About Us</a> |
      	<a href="SiteMap.html">Site Map</a> |
      	<a href="ContactUs.html">Contact Us</a> | &copy;2004 Collegematch.no-ip.com</div>
</div>

</body>
</html>
