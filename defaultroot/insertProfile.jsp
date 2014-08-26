<%@ page errorPage="insertProfile_error.jsp" import="collegematch.*,java.sql.*,javax.sql.*,javax.naming.*" %>
<html>
<head>
<title>
insertProfile
</title>
</head>
<body bgcolor="#ffffff">

<!--
	************************These queries need the userID somehow*******************************************
	This needs a userID to reference back to the user table to know where to make the update
-->
<%
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();

	boolean edit = false;
	if(((String)request.getParameter("edit")).equalsIgnoreCase("true"))
		edit = true;

	ValidUser user = (ValidUser)session.getAttribute("validUser");
	if(edit){
        try{
        	System.out.println("Running database edit updates");
		//UPDATE appearance SET EyeColor=?,HairColor=?,BodyType=?,BestFeature=?,Height=? where id=?
		PreparedStatement ps = con.prepareStatement("Update appearance SET EyeColor=?,HairColor=?,BodyType=?,BestFeature=?,Height=? WHERE id=?");
//		PreparedStatement ps = con.prepareStatement("Insert into appearance(ID,EyeColor,HairColor,BodyType,BestFeature,Height) Values(?,?,?,?,?,?)");
		ps.setString(1,request.getParameter("EyeColor"));
		ps.setString(2,request.getParameter("HairColor"));
		ps.setString(3,request.getParameter("BodyType"));
		ps.setString(4,request.getParameter("BestFeature"));
              	ps.setInt(5,(Integer.parseInt(request.getParameter("Height1"))*12)+Integer.parseInt(request.getParameter("Height2")));
		ps.setInt(6,user.getID());
		ps.executeUpdate();

		ps = con.prepareStatement("UPDATE interests SET FavHotSpots=?,FavThings=?,LastBookRead=?,Sign=?,Major=?,School=?,DoForFun=? WHERE id=?");
//		ps = con.prepareStatement("Insert into interests(ID,FavHotSpots,FavThings,LastBookRead,Sign,Major,School,DoForFun) Values(?,?,?,?,?,?,?,?)");
		ps.setString(1,request.getParameter("FavHotSpots"));
		ps.setString(2,request.getParameter("FavThings"));
		ps.setString(3,request.getParameter("LastBookRead"));
		ps.setString(4,request.getParameter("Sign"));
		ps.setString(5,request.getParameter("Major"));
		ps.setString(6,request.getParameter("School"));
		ps.setString(7,request.getParameter("DoesForFun"));
		ps.setInt(8,user.getID());
		ps.executeUpdate();

		ps = con.prepareStatement("UPDATE lifestyle SET Exercise=?,Diet=?,Smoke=?,Drink=?,Major=?,CurrentLivingLocation=? WHERE id=?");
//		ps = con.prepareStatement("Insert into lifestyle(ID,Exercise,Diet,Smoke,Drink,Major,CurrentLivingLocation) Values(?,?,?,?,?,?,?)");
		ps.setString(1,request.getParameter("Exercise"));
		ps.setString(2,request.getParameter("Diet"));
		ps.setString(3,request.getParameter("Smoke"));
		ps.setString(4,request.getParameter("Drink"));
              	ps.setString(5,request.getParameter("Major"));
		ps.setString(6,request.getParameter("School"));
		ps.setInt(7,user.getID());
		ps.executeUpdate();

              	ps = con.prepareStatement("UPDATE ownwords SET DescribeYourself=?,DescribeYourMatch=? WHERE id=?");
//		ps = con.prepareStatement("Insert into ownwords(ID,DescribeYourself,DescribeYourMatch) Values(?,?,?)");
		ps.setString(1,request.getParameter("DescribeYourself"));
		ps.setString(2,request.getParameter("DescribeYourMatch"));
		ps.setInt(3,user.getID());
		ps.executeUpdate();

              	ps = con.prepareStatement("UPDATE perfectDate SET idealDate=? WHERE id=?");
//		ps = con.prepareStatement("Insert into perfectDate(ID,idealdate) Values(?,?)");
		ps.setString(1,request.getParameter("PerfectDate"));
		ps.setInt(2,user.getID());
		ps.executeUpdate();

		ps = con.prepareStatement("UPDATE turnons SET PublicDisplaysOfAffection=?,BodyPiercings=?,Boldness=?,Brainiacs=?,Candlelight=?,Dancing=?,Erotica=?,Flirting=?,LongHair=?,Money=?,Power=?,Sarcasm=?,SkinnyDipping=?,Tattoos=?,Thrills=? WHERE id=?");
//		ps = con.prepareStatement("Insert into turnons(ID,PublicDisplaysOfAffection,BodyPiercings,Boldness,Brainiacs,Candlelight,Dancing,Erotica,Flirting,LongHair,Money,Power,Sarcasm,SkinnyDipping,Tattoos,Thrills) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		ps.setInt(1,Integer.parseInt(request.getParameter("PublicDisplaysOfAffection")));
		ps.setInt(2,Integer.parseInt(request.getParameter("BodyPiercings")));
		ps.setInt(3,Integer.parseInt(request.getParameter("Boldness")));
		ps.setInt(4,Integer.parseInt(request.getParameter("Brainiacs")));
		ps.setInt(5,Integer.parseInt(request.getParameter("Candlelight")));
		ps.setInt(6,Integer.parseInt(request.getParameter("Dancing")));
		ps.setInt(7,Integer.parseInt(request.getParameter("Erotica")));
		ps.setInt(8,Integer.parseInt(request.getParameter("Flirting")));
		ps.setInt(9,Integer.parseInt(request.getParameter("LongHair")));
		ps.setInt(10,Integer.parseInt(request.getParameter("Money")));
		ps.setInt(11,Integer.parseInt(request.getParameter("Power")));
		ps.setInt(12,Integer.parseInt(request.getParameter("Sarcasm")));
		ps.setInt(13,Integer.parseInt(request.getParameter("SkinnyDipping")));
		ps.setInt(14,Integer.parseInt(request.getParameter("Tattoos")));
		ps.setInt(15,Integer.parseInt(request.getParameter("Thrills")));
		ps.setInt(16,user.getID());
		ps.executeUpdate();

		ps = con.prepareStatement("UPDATE value SET Ethnicities=?,Faith=?,Languages=? WHERE id=?");
//		ps = con.prepareStatement("Insert into value(ID,Ethnicities,Faith,Languages) Values(?,?,?,?)");
		ps.setString(1,request.getParameter("ethnicity"));
		ps.setString(2,request.getParameter("Faith"));
		ps.setString(3,request.getParameter("Language"));
		ps.setInt(4,user.getID());
		ps.executeUpdate();

		ps.close();
//		out.println("<br>Complete! ");

    	}catch(SQLException e){System.out.println("SQLException: " + e);}
	}else{
          try{
          	System.out.println("Running database new user updates");
          	PreparedStatement ps = con.prepareStatement("Insert into appearance(ID,EyeColor,HairColor,BodyType,BestFeature,Height) Values(?,?,?,?,?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("EyeColor"));
		ps.setString(3,request.getParameter("HairColor"));
		ps.setString(4,request.getParameter("BodyType"));
		ps.setString(5,request.getParameter("BestFeature"));
              	ps.setInt(6,(Integer.parseInt(request.getParameter("Height1"))*12)+Integer.parseInt(request.getParameter("Height2")));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into interests(ID,FavHotSpots,FavThings,LastBookRead,Sign,Major,School,DoForFun) Values(?,?,?,?,?,?,?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("FavHotSpots"));
		ps.setString(3,request.getParameter("FavThings"));
		ps.setString(4,request.getParameter("LastBookRead"));
		ps.setString(5,request.getParameter("Sign"));
		ps.setString(6,request.getParameter("Major"));
		ps.setString(7,request.getParameter("School"));
		ps.setString(8,request.getParameter("DoesForFun"));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into lifestyle(ID,Exercise,Diet,Smoke,Drink,Major,CurrentLivingLocation) Values(?,?,?,?,?,?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("Exercise"));
		ps.setString(3,request.getParameter("Diet"));
		ps.setString(4,request.getParameter("Smoke"));
		ps.setString(5,request.getParameter("Drink"));
              	ps.setString(6,request.getParameter("Major"));
		ps.setString(7,request.getParameter("School"));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into ownwords(ID,DescribeYourself,DescribeYourMatch) Values(?,?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("DescribeYourself"));
		ps.setString(3,request.getParameter("DescribeYourMatch"));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into perfectDate(ID,idealdate) Values(?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("PerfectDate"));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into turnons(ID,PublicDisplaysOfAffection,BodyPiercings,Boldness,Brainiacs,Candlelight,Dancing,Erotica,Flirting,LongHair,Money,Power,Sarcasm,SkinnyDipping,Tattoos,Thrills) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		ps.setInt(1,user.getID());
		ps.setInt(2,Integer.parseInt(request.getParameter("PublicDisplaysOfAffection")));
		ps.setInt(3,Integer.parseInt(request.getParameter("BodyPiercings")));
		ps.setInt(4,Integer.parseInt(request.getParameter("Boldness")));
		ps.setInt(5,Integer.parseInt(request.getParameter("Brainiacs")));
		ps.setInt(6,Integer.parseInt(request.getParameter("Candlelight")));
		ps.setInt(7,Integer.parseInt(request.getParameter("Dancing")));
		ps.setInt(8,Integer.parseInt(request.getParameter("Erotica")));
		ps.setInt(9,Integer.parseInt(request.getParameter("Flirting")));
		ps.setInt(10,Integer.parseInt(request.getParameter("LongHair")));
		ps.setInt(11,Integer.parseInt(request.getParameter("Money")));
		ps.setInt(12,Integer.parseInt(request.getParameter("Power")));
		ps.setInt(13,Integer.parseInt(request.getParameter("Sarcasm")));
		ps.setInt(14,Integer.parseInt(request.getParameter("SkinnyDipping")));
		ps.setInt(15,Integer.parseInt(request.getParameter("Tattoos")));
		ps.setInt(16,Integer.parseInt(request.getParameter("Thrills")));
		ps.executeUpdate();

		ps = con.prepareStatement("Insert into value(ID,Ethnicities,Faith,Languages) Values(?,?,?,?)");
		ps.setInt(1,user.getID());
		ps.setString(2,request.getParameter("ethnicity"));
		ps.setString(3,request.getParameter("Faith"));
		ps.setString(4,request.getParameter("Language"));
		ps.executeUpdate();

		ps.close();

//		out.println("<br>Complete! ");
    	}catch(SQLException e){System.out.println("SQLException: " + e);}
	}
%>
<jsp:forward page="home.jsp"/>
<%
	con.close();
%>
</body>
</html>
