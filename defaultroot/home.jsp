<%@ page import="java.sql.*,java.io.*,collegematch.*,javax.naming.*,javax.sql.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Profile Home</title>
<link rel="stylesheet" href="emx_nav_right.css" type="text/css">

<!-- Javascript Cross Browser menu-->
<script language="JavaScript1.2">dqm__codebase = "" //script folder location</script>
<script language="JavaScript1.2" src="sample_settings.js"></script>
<script language="JavaScript1.2" src="tdqm_loader.js"></script>
<!-- Javascript Cross Browser menu-->

</head>
<body>
<%
	ValidUser user = (ValidUser)session.getAttribute("validUser");
	if(user==null){
%>
		<jsp:forward page="login.jsp">
		  <jsp:param name="errorMsg" value="Please login first"/>
                </jsp:forward>
<%
	}
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();
%>
<div id="masthead">

  <h1 id="siteName">College Match </h1>
  <div id="utility">
    <a href="logOut.jsp">Logout</a>
  </div>
  <div id="globalNav">
    <img alt="" src="gblnav_left.gif" height="32" width="4" id="gnl"> <img alt="" src="glbnav_right.gif" height="32" width="4" id="gnr">

    <div id="globalLink">
      <script language="JavaScript1.2">generate_mainitems()</script>
    </div>

    <form id="search" action="">
      <input name="searchFor" type="text" size="10">
      <a href="">search</a>
    </form>
  </div>
</div>

<!-- end masthead -->
<div id="pagecell1">
  <!--pagecell1-->
  <img alt="" src="tl_curve_white.gif" height="6" width="6" id="tl"> <img alt="" src="tr_curve_white.gif" height="6" width="6" id="tr">
  <div id="breadCrumb">

  </div>
  <div id="pageName">
    <h2>Welcome <%=user.getFirstName()%></h2>
<!--    <img alt="small logo" src="smLogo.gif" height="59" width="66"/>-->
  </div>
  <div id="pageNav">
    <div id="sectionLinks">
      <a href="http://collegematch.no-ip.com:9090/CollegeMatch/DatabaseUpload.jsp">Add Photo's</a>
      <a href="http://collegematch.no-ip.com:9090/CollegeMatch/createProfile.jsp?edit=true">Edit Profile</a>
    </div>
<!-- **Advertising can be put here**
    <div class="relatedLinks">
      <h3>Related Link Category</h3>
      <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
    </div>
    <div class="relatedLinks">
      <h3>Related Link Category</h3>
      <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
	  <a href="#">Related Link</a>
    </div>
-->
    <div id="advert">
      <img src="tomcat-power.gif" alt="Tomcat Power" />
      <br>
      <img src="powered-by-mysql-167x86.jpg" alt="MySQL Power"/>
    </div>
  </div>
  <div id="content">
    <div class="feature">
	<!-- Picture loaded from the database -->
      <img src="picservlet?a=BINARYFILE&b=<%=user.getID()%>">
	<!--Picture loaded from the database -->
      <h3>My Profile </h3>
      <p>
       <!--*Describe yourself*-->
       <br>
<%
		long start = System.currentTimeMillis();
		long end2 = 0;
              	PreparedStatement ps = null;
              	ResultSet rs = null;
	try{
	      	ps = con.prepareStatement("Select DescribeYourself,DescribeYourMatch from ownwords, users where ownwords.id = users.id and users.username=?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ps.setString(1,user.getUserName());
              	rs = ps.executeQuery();
                if(rs.next()){
			out.println(rs.getString(1));
                }
%>
      </p>
      </div>
      <div class="story">
      <h3>My Perfect Match </h3>
      <p>
      <!--*Describe your match*-->
	<br>
<%
		if(rs.first()){
			out.println(rs.getString(2));
		}
	}catch(SQLException e){out.println("SQLException: " + e);}
%>
      </p>
    </div>
    <div class="story">
      <table width="640" border"1">
	<tr>
          <td colspan="2"><a href="#" class="capsule">Appearance</a></td>
        </tr>
	<tr>
<%
            	StringBuffer buff = new StringBuffer();
		try{
			ps = con.prepareStatement("Select EyeColor,HairColor,BodyType,BestFeature,Age,Height from appearance,users where appearance.id = users.id and users.username=?");
			ps.setString(1,user.getUserName());
			rs = ps.executeQuery();
			if(rs.next()){
				buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">EyeColor:</span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\" width=\"360\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(1)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">HairColor: </span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(2)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Body Type:</span> </td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(3)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Best Feature:</span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"> <span class=\"cssGlobalSysText_LightGray\">" + rs.getString(4)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Age:</span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(5)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Height:</span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">"+ (rs.getInt(6)/12) + "ft "+(rs.getInt(6)%12)+"in" + "</span></td>");
				out.println(buff.toString());
			}
		}catch(SQLException e){out.println("SQLException: " + e);}
%>
            </tr>
          </table>
      <table width="640" border="1">
        <tr>
          <td colspan="2"><a href="#" class="capsule">Interests</a> </td>
        </tr>
        <tr>
            <%
            try{
		ps = con.prepareStatement("select FavHotSpots,FavThings,LastBookRead,Sign,Major,School,Dating, DoForFun from interests,users where interests.id = users.id and users.username=?");
              	ps.setString(1,user.getUserName());
		rs = ps.executeQuery();
		if(rs.next()){
			buff.delete(0,buff.length());

			buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">Favorite Hot Spots: </span></td>");
                	buff.append("<td bgcolor=\"#F7F7F7\" width=\"360\"<span class=\"cssGlobalSysText_LightGray\">" + rs.getString(1)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Favorite Things: " + "</span></td>");
			buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">"+ rs.getString(2)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Last Book Read: </span></td>");
			buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(3)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Sign: </span></td>");
                      	buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(4)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Major: </span></td>");
                      	buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(5)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">School: </span></td>");
			buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(6)+"</span></td>");
			buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Dating: </span></td>");
			if(rs.getInt(7)!=1)
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">no</span></td>");
			else
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">yes</span></td>");
                      	buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">What do you do for fun:</span></td>");
			buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(8)+"</span></td>");
			out.println(buff.toString());
		}
            }catch(SQLException e){out.println("SQLException: " + e);}
            %>
            </tr>
          </table>
      <table width="640" border="1">
        <tr>
          <td colspan="2"><a href="#" class="capsule">Lifestyle</a> </td>
        </tr>
        <tr>
            <%
		try{
                	ps = con.prepareStatement("Select Exercise,Diet,Smoke,Drink,Major,CurrentLivingLocation from lifestyle,users where lifestyle.id = users.id and users.username=?");
			ps.setString(1,user.getUserName());
			rs = ps.executeQuery();
			if(rs.next()){
				buff.delete(0,buff.length());

				buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">Exercise Habits:</span></td>");
	                	buff.append("<td bgcolor=\"#F7F7F7\" width=\"360\"><span class=\"cssGlobalSysText_LightGray\">" +rs.getString(1)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Diet: </span></td>");
      				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(2)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Smoke Habits: </span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(3)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Drink Habits: </span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(4)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Major: </span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(5)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Current Living Location: </span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(6)+"</span></td>");
				out.println(buff.toString());
	      		}
		}catch(SQLException e){out.println("SQLException: " + e);}
            %>
            </tr>
          </table>
      <table width="640" border="1">
        <tr>
<!--          <td colspan="2"><a href="#" class="capsule">Turnon's</a> </td>
-->
	<td><a href="#" class="capsule">Turnon's</a> </td>
	<td><img alt="" src="ColdToHot.jpg"/></td>
        </tr>
        <tr>
            <%
            	try{
			ps = con.prepareStatement("Select PublicDisplaysOfAffection,BodyPiercings,Boldness,Brainiacs,Candlelight,Dancing,Erotica,Flirting,LongHair,Money,Power,Sarcasm,SkinnyDipping,Tattoos,Thrills from turnons,users where turnons.id = users.id and users.username=?");
      			ps.setString(1,user.getUserName());
			rs = ps.executeQuery();
                        if(rs.next()){
				buff.delete(0,buff.length());

				buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">Public Displays of Affection</span></td><td bgcolor=\"#F7F7F7\" width=\"360\"><span class=\"cssGlobalSysText_LightGray\">");
				int[] addValues = {3,50,110,180,257,337};
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(1))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
                            	buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Body Piercings:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(2))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
                              	buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Boldness:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(3))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Brainiacs:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(4))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Candlelight:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(5))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Dancing:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(6))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Erotica:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(7))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Flirting:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(8))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Long Hair:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(9))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Money:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(10))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Power:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(11))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Sarcasm:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(12))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
                              	buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Skinny Dipping:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(13))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Tattoos:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(14))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
				buff.append("</span></td></tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Thrills:</span></td><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">");
				for(int i=0;i<6;i++){
                                  if(i!=rs.getInt(15))
                              		buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \">"+i+"</span>");
                                  else
                                  	buff.append("<span style=\"position:relative; left:"+addValues[i]+"px \"><b>"+i+"</b></span>");
				}
                                buff.append("</span></td>");
				out.println(buff.toString());
                        }
              	}catch(SQLException e){out.println("SQLException: " + e);}
            %>
		</tr>
              </table>
      <table width="640" border="1">
        <tr>
          <td colspan="2"><a href="#" class="capsule">Value's</a> </td>
        </tr>
        <tr>
            <%
		try{
                	ps = con.prepareStatement("Select Ethnicities,Faith,Languages from value,users where value.id = users.id and users.username=?");
                      	ps.setString(1,user.getUserName());
                      	rs = ps.executeQuery();
			if(rs.next()){
				buff.delete(0,buff.length());

                        	buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">Ethnicities:</span></td>");
				buff.append("<td bgcolor=\"#F7F7F7\" width=\"360\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(1)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Faith:</span></td>");
                              	buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(2)+"</span></td>");
				buff.append("</tr><tr><td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">Languages:</span></td>");
                              	buff.append("<td bgcolor=\"#F7F7F7\"><span class=\"cssGlobalSysText_LightGray\">" + rs.getString(3)+"</span></td>");
				out.println(buff.toString());
			}
		}catch(SQLException e){out.println("SQLException: " + e);}
              	ps.close();
		rs.close();
              	con.close();
            %>
		</tr>
              </table>
      <table width="640" border="1">
        <tr>
          <td colspan="2"><a href="#" class="capsule">Debug Output</a> </td>
        </tr>
        <tr>
        <%
		buff.delete(0,buff.length());
        	buff.append("<td bgcolor=\"#F7F7F7\" width=\"264\"><span class=\"cssGlobalSysText_LightGray\">Total Execution time:</span></td>");
             	buff.append("<td bgcolor=\"#F7F7F7\" width=\"360\"><span class=\"cssGlobalSysText_LightGray\">"+(System.currentTimeMillis() - start)+"</span></td>");
		out.println(buff.toString());
        %>
        </tr>
      </table>
    </div>
  </div>
  <!--end content -->
  <div id="siteInfo">
    <img src="placehold.gif" width="44" height="22">
      	<a href="AboutUs.html">About Us</a> |
      	<a href="SiteMap.html">Site Map</a> |
  	<a href="faq.htm">FAQ</a> |
      	<a href="ContactUs.html">Contact Us</a> | &copy;2004 Collegematch.no-ip.com
  </div>
</div>
<!--end pagecell1-->
<br>
</body>
</html>
