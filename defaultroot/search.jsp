<!--

This page has been deprecated.

-->
<%@ page errorPage="insertProfile_error.jsp" import="java.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
	//how am i gonna search
	//ok i got it, send the things the user wants to search for to the search results page and
	//then that page will search for the users...  Excellent!
%>
<!--Search for matches, list matches, login and logout need to be completed -->
<form name="searchForm" action="searchResults.jsp" method="post">
I am a
<select name="gender">
	<option value="Man">Man</option>
	<option value="Woman" selected>Woman</option>
</select>
seeking a
<select name="lookingFor">
	<option value="Woman">Woman</option>
	<option value="Man" selected>Man</option>
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

<br>
Search by school:
<!--populated by the database -->
<%      //debug
	long start = System.currentTimeMillis();
	//debug
	Connection con = null;
	try{
		Class.forName("org.gjt.mm.mysql.Driver");
	}catch(ClassNotFoundException e){out.println("ClassNotFoundException: " + e);}
	try{
        	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/CollegeMatch?user=ColdFusion&password=password");
        }catch(SQLException e){out.println("SQL Exception: "+e);}
	try{
		PreparedStatement ps = con.prepareStatement("SELECT school FROM interests group by school");
		ResultSet rs = ps.executeQuery();

%>
<select>
<% while(rs.next()){%>
	<option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
<%}
	}catch(SQLException e){out.println("SQLException: " + e);}

%>
</select>
<%	//debug
	out.println("<br>execution time: " + (System.currentTimeMillis()- start)+ " ms");
	//debug
%>
<br>
<input type="submit" value="Search">
</form>
</body>
</html>
