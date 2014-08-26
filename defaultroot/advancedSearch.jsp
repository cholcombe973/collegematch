<%@ page import="java.sql.*" %>
<html>
<head>
<title>
advancedSearch
</title>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	Connection con = null;

	       	try{
	        	Class.forName("org.gjt.mm.mysql.Driver");
		}catch(ClassNotFoundException e){out.println("ClassNotFoundException: " + e);}
		try{
			//this needs to be loaded from a properties file
	        	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CollegeMatch?user=ColdFusion&password=password");
	        }catch(SQLException e){out.println("SQL Exception: "+e);}

%>
<div align="center"><img src="Banner2.jpg" width="500" height="85" align="middle"  />
</div>
<form name="form1" method="post" action="searchResults.jsp">
  <table width="100%" border="0" cellspacing="0" cellpadding="1" bgcolor="#000000">
    <tr>
      <td> <table width="100%" border="0" cellspacing="0" cellpadding="4" bgcolor="#CCCCCC">
          <tr bgcolor="#000000">
            <td colspan="3"><font color="#CCCCCC"><font color="#CCCCCC"><b>Search for matches
              </b></font></font></td>
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
	<%      //debug
	long start = System.currentTimeMillis();
	//debug
	try{
		PreparedStatement ps = con.prepareStatement("SELECT school FROM interests group by school");
		ResultSet rs = ps.executeQuery();

%>
<select name="school">
	<option value="allSchools" selected>All Schools</option>
<% while(rs.next()){%>
	<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%}
		rs.close();
              	ps.close();
              	con.close();
	}catch(SQLException e){out.println("SQLException: " + e);}

%>
</select>
<%	//debug
	out.println("<br>execution time: " + (System.currentTimeMillis()- start)+ " ms");
	//debug
%>
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
  <div align="right"><br>
    <br>
    <img src="tomcat-power.gif"/>
  </div>
  <input type="hidden" name="type" value="advanced"/>
</form>


</body>

</html>
