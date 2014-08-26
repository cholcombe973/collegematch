<%@ page import="java.sql.*,collegematch.ValidUser,javax.sql.*,javax.naming.*" %>
<%
	String user = request.getParameter("userName");
	String password = request.getParameter("password");
	if((user==null) || (password == null)){
        	%><jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="You must enter a User Name and Password"/>
		  </jsp:forward>
		<%
	}
	//check to see if the params are valid
      	Context initCtx = new InitialContext();
	Context envCtx = (Context) initCtx.lookup("java:comp/env");
	DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
	Connection con = ds.getConnection();

	try{
	/*
           Problem 2: Figure out how to block double session login's or session stealing.
           The servlet doesn't care if a new session is made which i haven't built protection for that
           yet so why would it.
        */
		PreparedStatement ps = con.prepareStatement("Select ID,Username,Roles,FirstName,LastName,EndServiceDate,EmailAddress from users where username=? and password=md5(?)");
		ps.setString(1,user);
		ps.setString(2,password);
                ResultSet rs = ps.executeQuery();
		if(rs.next()){
                	ValidUser validUser = new ValidUser();
                      	validUser.setID(rs.getInt(1));
                      	validUser.setUserName(rs.getString(2));
                      	validUser.setRoles(rs.getString(3));
                      	validUser.setFirstName(rs.getString(4));
			validUser.setLastName(rs.getString(5));
			validUser.setEndServiceDate(rs.getDate(6));
			validUser.setEmailAddress(rs.getString(7));
			if(!validUser.validServiceDate()){
			// subscription has expired.
			%>
				<jsp:forward page="login.jsp">
				  <jsp:param name="errorMsg" value="Your subscription has expired.  Please renew"/>
				</jsp:forward>
			<%
			}
//			session.setMaxInactiveInterval(1800);
			session.setAttribute("validUser",validUser);
		}
		else{
			%>
                          <jsp:forward page="login.jsp">
                            <jsp:param name="errorMsg" value="The User Name or Password you entered is not valid"/>
			  </jsp:forward>
			<%
		}
		//everything is good forward to home
		%>
			<jsp:forward page="home.jsp"/>
		<%
              	ps.close();
              	rs.close();
		con.close();
	}catch(SQLException e){out.println("SQLException: " + e);}
%>
