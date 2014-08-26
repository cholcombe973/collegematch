<%@ page import="collegematch.*,java.sql.*,java.io.*,java.util.*,javax.sql.rowset.*,com.sun.rowset.*,javax.sql.*,javax.naming.*" %>
<html>
<head>
<title>
Search Results
</title>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%
	//new paging code

      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();

      	String type = request.getParameter("type");
	StringBuffer limitCmd = new StringBuffer();
      	limitCmd.append("Select count(*) ");

	PreparedStatement limitps = null;
	PreparedStatement dataps = null;

	ResultSet limitrs = null;
      	ResultSet datars = null;

	ArrayList params = new ArrayList();
	ArrayList paramValues = new ArrayList();

      	int currentRSPlaceHolder = 0;
	if(request.getParameter("currentRSPlaceHolder")!=null)
      		currentRSPlaceHolder = Integer.parseInt(request.getParameter("currentRSPlaceHolder"));

	if(type.equalsIgnoreCase("advanced")){
		params.add("type");
      		paramValues.add("advanced");
		//Advanced could specify school, age, keywords, gender,
               	boolean noKeywords=false;
              	boolean allSchools=false;

               	if((request.getParameter("keyWords").equalsIgnoreCase(""))){
                       	noKeywords=true;
			params.add("keyWords");
                     	paramValues.add("");
               	}
		if((request.getParameter("school").equalsIgnoreCase("allSchools"))){
                       	allSchools=true;
			params.add("school");
                      	paramValues.add("allSchools");
		}
               	StringBuffer temp = new StringBuffer();
		temp.append("Select u.id, u.username, u.emailaddress, a.age, o.describeYourself, i.school, a.gender FROM users u, ownwords o, appearance a, interests i WHERE ");
		limitCmd.append("FROM users u, ownwords o, appearance a, interests i WHERE ");
		if(!noKeywords){
                       	temp.append("MATCH(describeyourself) AGAINST (? in BOOLEAN MODE) ");
			temp.append(" AND a.gender = ? ");
			limitCmd.append("MATCH(describeyourself) AGAINST (? in BOOLEAN MODE) ");
			limitCmd.append(" AND a.gender = ? ");
		}
                else{
                       	temp.append(" a.gender = ? ");
                      	limitCmd.append(" a.gender = ? ");
                }
               	if(!allSchools){
                       	temp.append(" AND i.school= ? ");
			limitCmd.append(" AND i.school= ? ");
               	}
		temp.append(" AND i.dating=? AND a.age > ? AND a.age < ? AND u.id=o.id AND u.id=a.id AND u.id=i.id LIMIT ?,10");
		limitCmd.append(" AND i.dating=? AND a.age > ? AND a.age < ? AND u.id=o.id AND u.id=a.id AND u.id=i.id");

		dataps = con.prepareStatement(temp.toString());
              	limitps = con.prepareStatement(limitCmd.toString());

		int paramCount = 1;
               	if(!noKeywords){
			dataps.setString(paramCount,request.getParameter("keywords"));
			limitps.setString(paramCount,request.getParameter("keywords"));

                      	params.add("keywords");
                      	paramValues.add(request.getParameter("keywords"));

               		paramCount++;
               	}
		limitps.setString(paramCount,request.getParameter("lookingFor"));
		dataps.setString(paramCount,request.getParameter("lookingFor"));

		params.add("lookingFor");
		paramValues.add(request.getParameter("lookingFor"));

               	paramCount++;
               	if(!allSchools){
			limitps.setString(paramCount,request.getParameter("school"));
			dataps.setString(paramCount,request.getParameter("school"));

			params.add("school");
                      	paramValues.add(request.getParameter("school"));

               		paramCount++;
              	}
		limitps.setInt(paramCount,request.getParameter("dating").equalsIgnoreCase("dating")?1:0);
              	dataps.setInt(paramCount,request.getParameter("dating").equalsIgnoreCase("dating")?1:0);

		params.add("dating");
              	paramValues.add(request.getParameter("dating"));

              	paramCount++;
              	limitps.setInt(paramCount,Integer.parseInt(request.getParameter("lowerAge")));
		dataps.setInt(paramCount,Integer.parseInt(request.getParameter("lowerAge")));

              	params.add("lowerAge");
              	paramValues.add(request.getParameter("lowerAge"));

              	paramCount++;
		limitps.setInt(paramCount,Integer.parseInt(request.getParameter("upperAge")));
		dataps.setInt(paramCount,Integer.parseInt(request.getParameter("upperAge")));

		params.add("upperAge");
              	paramValues.add(request.getParameter("upperAge"));

		paramCount++;

		params.add("currentRSPlaceHolder");
              	paramValues.add(new Integer(paramCount));
              	currentRSPlaceHolder = paramCount;

              	limitrs = limitps.executeQuery();

	}
	else if(type.equalsIgnoreCase("keyword")){
		params.add("type");
              	paramValues.add("keyword");

          	limitps = con.prepareStatement("Select count(*) FROM users u, ownwords o, appearance a, interests i WHERE MATCH (describeyourself) AGAINST (? IN BOOLEAN MODE) AND a.gender=? AND i.school=? AND a.age > ? AND a.age < ? AND i.dating = ? AND u.id=o.id AND u.id=a.id AND u.id=i.id");
		limitps.setString(1,request.getParameter("keys"));
		limitps.setString(2,request.getParameter("lookingFor"));
		limitps.setString(3,request.getParameter("school"));
		limitps.setInt(4,Integer.parseInt(request.getParameter("lowerAge")));
		limitps.setInt(5,Integer.parseInt(request.getParameter("upperAge")));
    		limitps.setInt(6,request.getParameter("dating").equalsIgnoreCase("dating")?1:0);
		limitrs = limitps.executeQuery();

              	dataps = con.prepareStatement("SELECT u.id, u.username, u.emailaddress, a.age,o.describeYourself, i.school, a.gender FROM users u, ownwords o, appearance a, interests i WHERE MATCH (describeyourself) AGAINST (? IN BOOLEAN MODE) AND a.gender=? AND i.school=? AND a.age > ? AND a.age < ? AND i.dating = ? AND u.id=o.id AND u.id=a.id AND u.id=i.id LIMIT ?,10");
		dataps.setString(1,request.getParameter("keys"));
		dataps.setString(2,request.getParameter("lookingFor"));
		dataps.setString(3,request.getParameter("school"));
		dataps.setInt(4,Integer.parseInt(request.getParameter("lowerAge")));
		dataps.setInt(5,Integer.parseInt(request.getParameter("upperAge")));
    		dataps.setInt(6,request.getParameter("dating").equalsIgnoreCase("dating")?1:0);

		//add the params to build the page request strings
              	params.add("keys");
              	paramValues.add(request.getParameter("keys"));
              	params.add("lookingFor");
              	paramValues.add(request.getParameter("lookingFor"));
		params.add("school");
              	paramValues.add(request.getParameter("school"));
              	params.add("lowerAge");
              	paramValues.add(request.getParameter("lowerAge"));
		params.add("upperAge");
		paramValues.add(request.getParameter("upperAge"));
		params.add("dating");
              	paramValues.add(request.getParameter("dating"));
		currentRSPlaceHolder = 7;
		params.add("currentRSPlaceHolder");
		paramValues.add(new Integer(7));
	}
	else if(type.equalsIgnoreCase("user")){
		limitps = con.prepareStatement("Select count(*) FROM users u,appearance a,ownwords o, interests i WHERE u.username=? AND u.id=o.id AND u.id=a.id AND u.id=i.id");
              	limitps.setString(1,request.getParameter("userName"));
		limitrs = limitps.executeQuery();

             	dataps = con.prepareStatement("SELECT u.id, u.username, u.emailaddress, a.age,o.describeYourself, i.school, a.gender FROM users u,appearance a,ownwords o, interests i WHERE u.username=? AND u.id=o.id AND u.id=a.id AND u.id=i.id LIMIT ?,10");
              	dataps.setString(1,request.getParameter("userName"));

		//add the params to build the page request strings
		params.add("type");
              	paramValues.add("user");
		params.add("user");
            	paramValues.add(request.getParameter("userName"));
		currentRSPlaceHolder = 2;
		params.add("currentRSPlaceHolder");
		paramValues.add(new Integer(2));
	}
	else
		out.println("Error: unknown parameter: " + type);

      	out.println("<p align=\"center\"><img src=\"CollegeMatchLogo.jpg\"></p>");
      	out.println("<div align=\"center\">");

	// paging
	int currentRs;

	String pt = request.getParameter("mv");
      	int currentResult = 1;

	if (pt != null){
		currentRs = 10 * (Integer.parseInt((String)pt) - 1);
		currentResult = 10 * (Integer.parseInt((String)pt))-9;
	}
	else
		currentRs = 0;

	dataps.setInt(currentRSPlaceHolder,currentRs);
	datars = dataps.executeQuery();

	ValidUser user = (ValidUser)session.getAttribute("validUser");

	while (datars.next()){
		// add your table fields here ....
		out.println("<table width=\"90%\" border=\"1\" cellspacing=\"2\" cellpadding=\"4\">");
		out.println("<tr>");
		//Click on the username to get to their personal page
		out.println("<td><b>"+currentResult+". "+datars.getString(2)+"</b></td>");
		out.println("<td width=\"506\"> <b> <a href=\"showUser.jsp?user="+datars.getString(1)+"\">Click here</a>");
		if(user!=null)
                	out.println("&nbsp&nbsp <A HREF=\"mailto:"+datars.getString(3)+"\">EMail Me!</A>");
              	out.println("</b></td>");
		out.println("</tr>");
              	out.println("<tr>");
              	out.println("<td width=\"280\" height=\"150\">");
		out.println("<img src=\"picservlet?a=BINARYFILE&b="+datars.getString(1)+"\">");
		out.println("</td>");
              	out.println("<td>");
            	out.println("<p>");
		out.println(datars.getString(5));
		out.println("</p>");
		out.println("School: " + datars.getString(6)+"</p>");
		out.println("<p>Age: " + datars.getString(4)+"-year-old "+datars.getString(7)+"</p></td>");
		out.println("</tr>");
		out.println("</table>");
		currentResult++;
	}
	//begin paging code
	limitrs.next();
	int pages = limitrs.getInt(1);

	int cPage = (pages / 10) + 1;
	if ((cPage * 10) + 1 >= pages){
		cPage++;
	}

	StringBuffer link = new StringBuffer();
	for(int j=0;j<params.size();j++)
               	link.append("&"+params.get(j)+"="+paramValues.get(j));
	for(int i = 1; i < cPage ; i++)
      		out.println("<a href=searchResults.jsp?mv=" + i +link.toString()+">" + i + "</a>&nbsp;|&nbsp;");
	out.println("<hr>");

	//close down all your shit
	limitps.close();
	dataps.close();
	datars.close();
	limitrs.close();
	con.close();
%>
</div>
<p>&nbsp;</p>
<p align="right"><img src="tomcat-power.gif"></p>
</body>
</html>
