<%@ page import="collegematch.*,java.sql.*,javax.sql.*,javax.naming.*" %>
<%@ page errorPage="createProfile_error.jsp"%>
<html>
<head>
<title>
createProfile
</title>
</head>
<%
	ValidUser user = (ValidUser)session.getAttribute("validUser");
	if(user==null){
        	%>
			<jsp:forward page="login.jsp">
			  <jsp:param name="errorMsg" value="Please login first"/>
                        </jsp:forward>
		<%
	}

	boolean edit = false;
	PreparedStatement ps = null;
	ResultSet rs = null;
	if(((String)request.getParameter("edit")).equalsIgnoreCase("true"))
		edit = true;

%>
<body bgcolor="#ffffff">
<%

	Connection con = null;
	if(edit){
          //build the edit page
      		Context initCtx = new InitialContext();
          	Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/CollegeMatch");
		con = ds.getConnection();
		try{
			ps = con.prepareStatement("SELECT EyeColor,HairColor,BodyType,BestFeature,Age,Height FROM appearance,users WHERE appearance.id = users.id AND users.username=?");
                      	ps.setString(1,user.getUserName());
                      	rs = ps.executeQuery();
                      	if(rs.next()){
%>
<Form  action="insertProfile.jsp"  method="post" >
<!-- user id      -->
<h3><b><%=user.getFirstName()%>'s Profile</b></h3>

	<input type="hidden" name="UserID" value="<%=user.getID()%>">
	<input type="hidden" name="edit" value="<%=edit%>">
<h3><b>Appearence</b></h3><br>
<table>
	<tr>
		<td>
			Eye Color:
                </td>
		<td>
			<select name="EyeColor" size="1" >
<%
			String[] eyeColors = {"Light blue","Blue","Blue-green","Baby blue","Hazel","Light brown","Light blue","Brown","Dark brown"};
			String eyeColor = rs.getString(1);
			for(int i=0;i<eyeColors.length;i++){
				if(!eyeColor.equals(eyeColors[i]))
					out.println("<option value=\""+eyeColors[i]+"\" >"+eyeColors[i]+"</option>");
				else
                                	out.println("<option value=\""+eyeColors[i]+"\" selected>"+eyeColors[i]+"</option>");
			}
%>
			</select>
		</td>
	</tr>
        <tr>
		<td>
			Height:
		</td>
                <td>
			Feet:
				<select name="Height1" size="1" >
<%
			int[] height1 = {3,4,5,6,7,8};
                      	int[] height2 = {0,1,2,3,4,5,6,7,8,9,10,11,12};
			int temp1 = rs.getInt(6)/12; //feet
                        int temp2 = rs.getInt(6)%12; //inches
                      	for(int i=0;i<height1.length;i++){
				if(!(temp1==height1[i]))
					out.println("<option value=\""+height1[i]+"\">"+height1[i]+"</option>");
				else
                                	out.println("<option value=\""+height1[i]+"\"selected>"+height1[i]+"</option>");
                      	}

%>
				</select>
		</td>
		<td>
			Inches:
				<select name="Height2" size="1" >
<%
			for(int i=0;i<height2.length;i++){
				if(!(temp2==height2[i]))
                                	out.println("<option value=\""+height2[i]+"\">"+height2[i]+"</option>");
                            	else
                                    	out.println("<option value=\""+height2[i]+"\"selected>"+height2[i]+"</option>");
			}
%>
				</select>
                </td>
	</tr>
	<tr>
		<td>
			Hair Color:
		</td>
		<td>
			<select name="HairColor" size="1" >
<%
			String[] hairColor = {"Black","Blonde","Dark blonde","Light brown","Dark brown","Red","Salt and pepper","Platinum","Other"};
			String color = rs.getString(2);
			for(int i=0;i<hairColor.length;i++){
				if(!color.equals(hairColor[i]))
					out.println("<option value=\""+hairColor[i]+"\">"+hairColor[i]+"</option>");
				else
                              		out.println("<option value=\""+hairColor[i]+"\"selected>"+hairColor[i]+"</option>");
			}
%>
			</select>
</td>
</tr>
<tr>
<td>
Body Type:
</td>
<td>
			<select name="BodyType" size="1" >
<%
			String[] bodyTypes = {"Slender","Athletic and toned","Average","A few extra pounds","Heavyset","Other"};
			String bodyType = rs.getString(3);
			for(int i=0;i<bodyTypes.length;i++){
				if(!bodyType.equals(bodyTypes[i]))
                                	out.println("<option value=\""+bodyTypes[i]+"\">"+bodyTypes[i]+"</option>");
                                else
                                	out.println("<option value=\""+bodyTypes[i]+"\"selected>"+bodyTypes[i]+"</option>");
			}
%>
			</select>
</td>
</tr>
<tr>
<td>
Best Feature:
</td>
<td>
			<select name="BestFeature" size="1" >
<%
			String[] bestFeatures = {"Nothing","Hair","Eyes","Lips","Neck","Arms","Hands","Chest","Belly button","Butt","Legs","Calves","Feet","Other"};
              		String bestFeature = rs.getString(4);
			for(int i=0;i<bestFeatures.length;i++){
				if(!bestFeature.equals(bestFeatures[i]))
					out.println("<option value=\""+bestFeatures[i]+"\">"+bestFeatures[i]+"</option>");
                            	else
					out.println("<option value=\""+bestFeatures[i]+"\"selected>"+bestFeatures[i]+"</option>");
			}
%>
			</select>
</td>
</tr>
</table>
<%
		ps = con.prepareStatement("SELECT FavHotSpots,FavThings,LastBookRead,Sign,Major,School, DoForFun FROM interests,users WHERE interests.id = users.id AND users.username=?");
              	ps.setString(1,user.getUserName());
		rs = ps.executeQuery();
		if(rs.next()){


%>
<h3><b>Interests</b></h3><br>

<table>
<tr>
<td>
Favorite Hot Spots:
</td>
<td>
		<textarea name="FavHotSpots" cols="45" rows="5" ><%=rs.getString(1)%></textarea>
</td>
</tr>
<tr>
<td>
Favorite Things:
</td>
<td>
		<textarea name="FavThings" cols="45" rows="5"><%=rs.getString(2)%></textarea>
</td>
</tr>
<tr>
<td>
Last Book Read:
</td>
<td>
		<textarea name="LastBookRead" cols="45" rows="5"><%=rs.getString(3)%></textarea>
</td>
</tr>
<tr>
<td>
What do you do for fun:
</td>
<td>
		<textarea name="DoesForFun" cols="45" rows="5"><%=rs.getString(7)%></textarea>
</td>
</tr>
<tr>
<td>
Sign:
</td>
<td>
		<select name="Sign" size="1">
<%
		String[] signs = {"No Sign","Capircorn","Aquarius","Pisces","Aries","Taurus","Gemini","Cancer","Leo","Virgo","Libra","Scorpio","Sqaittarius"};
              	String sign = rs.getString(4);
		for(int i=0;i<signs.length;i++){
			if(!sign.equals(signs[i]))
				out.println("<option value=\""+signs[i]+"\">"+signs[i]+"</option>");
                        else
				out.println("<option value=\""+signs[i]+"\"selected>"+signs[i]+"</option>");
		}
%>
</select>
</td>
</tr>
<tr>
<td>
School you attend:
</td>
<td>
		<input name="School" type="text" size="50"  maxlength="50" value="<%=rs.getString(6)%>">
</td>
</tr>
<tr>
<td>
Major:
</td>
<td>
		<input type="text" name="Major" maxlength="100" size="40" value="<%=rs.getString(5)%>">
</td>
</tr>
</table>
<%
		}//                                          1                  2            3        4           5          6      7        8        9     10     11    12          13         14      15
                ps = con.prepareStatement("Select PublicDisplaysOfAffection,BodyPiercings,Boldness,Brainiacs,Candlelight,Dancing,Erotica,Flirting,LongHair,Money,Power,Sarcasm,SkinnyDipping,Tattoos,Thrills from turnons,users where turnons.id = users.id and users.username=?");
      		ps.setString(1,user.getUserName());
		rs = ps.executeQuery();
                if(rs.next()){

%>
<h3><b>Turn on's</b></h3><br>
<table>
<tr>
<td>
Public displays of affection:
</td>
<td>
<%
			int turnOnTemp= rs.getInt(1);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"PublicDisplaysOfAffection\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"PublicDisplaysOfAffection\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Body Piercings:
</td>
<td>
<%
			turnOnTemp = rs.getInt(2);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"BodyPiercings\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"BodyPiercings\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Boldness / Assertiveness:
</td>
<td>
<%
			turnOnTemp= rs.getInt(3);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Boldness\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Boldness\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}

%>
</td>
</tr>
<tr>
<td>
Brainiacs:
</td>
<td>
<%
			turnOnTemp= rs.getInt(4);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Brainiacs\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Brainiacs\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}

%>
</td>
</tr>
<tr>
<td>
Candlelight:
</td>
<td>
<%
			turnOnTemp= rs.getInt(5);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Candlelight\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Candlelight\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Dancing:
</td>
<td>
<%
			turnOnTemp= rs.getInt(6);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Dancing\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Dancing\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Erotica:
</td>
<td>
<%
			turnOnTemp= rs.getInt(7);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Erotica\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Erotica\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Flirting:
</td>
<td>
<%
			turnOnTemp= rs.getInt(8);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Flirting\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Flirting\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Long hair:
</td>
<td>
<%
			turnOnTemp= rs.getInt(9);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"LongHair\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"LongHair\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Money:
</td>
<td>
<%
			turnOnTemp= rs.getInt(10);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Money\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Money\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Power:
</td>
<td>
<%
			turnOnTemp= rs.getInt(11);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Power\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Power\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Sarcasm:
</td>
<td>
<%
			turnOnTemp= rs.getInt(12);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Sarcasm\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Sarcasm\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Skinny dipping:
</td>
<td>
<%
			turnOnTemp= rs.getInt(13);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"SkinnyDipping\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"SkinnyDipping\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Tattoos:
</td>
<td>
<%
			turnOnTemp= rs.getInt(14);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Tattoos\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Tattoos\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
<td>
Thrills:
</td>
<td>
<%
			turnOnTemp= rs.getInt(15);
			for(int i=0;i<6;i++){
				if(!(turnOnTemp==i))
					out.println("<input name=\"Thrills\" type=\"radio\" value=\""+i+"\">"+i);
				else
                                	out.println("<input name=\"Thrills\" type=\"radio\" value=\""+i+"\"checked>"+i);
			}
%>
</td>
</tr>
<tr>
</tr>
</table>
<%
                }
%>
<h3><b>Perfect Date</b></h3><br>
<table>
<tr>
<td>
What's your perfect date:
<br>
<%
			String[] perfectDates = {"Cozy","Sensual","Raw","Fun","Indulgent","Thrilling","Hot","Edgy","Relaxed","Revealing","Casual","Intimate","Stimulating","Hilarious","Natural"};
			for(int i=0;i<perfectDates.length;i++){
				out.println("<input name=\"PerfectDate\" type=\"radio\" value=\""+perfectDates[i]+"\">"+perfectDates[i]+"<br>");
			}
%>
</td>
</tr>
</table>


<h3><b>Lifestyle</b></h3><br>
<table>
<tr>
<td>
Exercise habits:
</td>
<td>
<%
                	ps = con.prepareStatement("SELECT Exercise,Diet,Smoke,Drink FROM lifestyle,users WHERE lifestyle.id = users.id AND users.username=?");
			ps.setString(1,user.getUserName());
			rs = ps.executeQuery();
			if(rs.next()){
				String[] exercises = {"Never","Sometimes","Occasionally","Regularly","Always"};
				String exercise = rs.getString(1);
%>
	<select name="Exercise" >
<%
				for(int i=0;i<exercises.length;i++){
					if(!exercise.equals(exercises[i]))
						out.println("<option value=\""+exercises[i]+"\">"+exercises[i]+"</option>");
					else
						out.println("<option value=\""+exercises[i]+"\"selected>"+exercises[i]+"</option>");
				}
%>
	</select>
</td>
</tr>
<tr>
<td>
Diet habits:
</td>
<td>
<%
				String[] diets = {"MeatAndPotatoes","KeepItHealthy","Vegetarian","JunkFoodJunkie","Other"};
				String diet = rs.getString(2);
				for(int i=0;i<diets.length;i++){
					StringBuffer temp = new StringBuffer();
					String dietTemp = diets[i];
                                        for(int j=0;j<dietTemp.length();j++){
						char x = dietTemp.charAt(j);
						if(!Character.isUpperCase(x))
                                              		temp.append(x);
                                                else
                                                	temp.append(" "+x);
                                        }
					if(!diet.equals(diets[i])){

                                        	out.println("<input name=\"Diet\" type=\"checkbox\" value=\""+diets[i]+"\">"+temp.toString()+"<br>");
					}
                                    	else{

                                        	out.println("<input name=\"Diet\" type=\"checkbox\" value=\""+diets[i]+"\"checked>"+temp.toString()+"<br>");
                                    	}
				}
%>
</td>
</tr>
<tr>
<td>
Smoking habits:
</td>
<td>
	<select name="Smoke">
<%
				String[] smokes = {"Never","Occasionally","CigarAfficionado","SmokelessTobacco","Daily","TryingToQuit"};
				String smoke = rs.getString(3);
                                for(int i=0;i<smokes.length;i++){
					StringBuffer temp = new StringBuffer();
					String smokeTemp = smokes[i];
                                        for(int j=0;j<smokeTemp.length();j++){
						char x = smokeTemp.charAt(j);
						if(!Character.isUpperCase(x))
                                              		temp.append(x);
                                                else
                                                	temp.append(" "+x);
                                        }
					if(!smoke.equals(smokes[i]))
                                        	out.println("<option value=\""+smokes[i]+"\">"+temp.toString()+"</option>");
                                    	else
                                        	out.println("<option value=\""+smokes[i]+"\"selected>"+temp.toString()+"</option>");
				}
%>
	</select>
</td>
</tr>
<tr>
<td>
Liquor habits:
</td>
<td>
	<select name="Drink">
<%
				String[] drinks = {"Never","GaveItUp","NonAlcoholicOnly","SocialDrinker","Regular"};
				String drink = rs.getString(4);
                                for(int i=0;i<drinks.length;i++){
					StringBuffer temp = new StringBuffer();
					String drinkTemp = drinks[i];
                                        for(int j=0;j<drinkTemp.length();j++){
						char x = drinkTemp.charAt(j);
						if(!Character.isUpperCase(x))
                                              		temp.append(x);
                                                else
                                                	temp.append(" "+x);
                                        }
					if(!drink.equals(drinks[i]))
                                        	out.println("<option value=\""+drinks[i]+"\">"+temp.toString()+"</option>");
                                    	else
                                        	out.println("<option value=\""+drinks[i]+"\"selected>"+temp.toString()+"</option>");
				}
			}
%>
</td>
</tr>
</table>
<br>

<h3><b>Values</b></h3><br>
<table>
<tr>
<td>
Which ethnicities describe you the best:
</td>
<td>
<%
			ps = con.prepareStatement("Select Ethnicities,Faith,Languages from value,users where value.id = users.id and users.username=?");
                      	ps.setString(1,user.getUserName());
                      	rs = ps.executeQuery();
                      	if(rs.next()){
				String[] ethnicities = {"Asian","NativeAmerican","Black","PacificIslander","EastIndian","White","Latino","Other","MiddleEastern"};
                              	String ethnicity = rs.getString(1);
				for(int i=0;i<ethnicities.length;i++){
					StringBuffer temp = new StringBuffer();
					String ethTemp = ethnicities[i];
                                        for(int j=0;j<ethTemp.length();j++){
						char x = ethTemp.charAt(j);
						if(!Character.isUpperCase(x))
                                              		temp.append(x);
                                                else
                                                	temp.append(" "+x);
                                        }
					if(!ethnicity.equals(ethnicities[i]))
                                        	out.println("<input name=\"ethnicity\" type=\"checkbox\" value=\""+ethnicities[i]+"\">"+temp.toString()+"<br>");
                                      	else
                                        	out.println("<input name=\"ethnicity\" type=\"checkbox\" value=\""+ethnicities[i]+"\"checked>"+temp.toString()+"<br>");
				}
%>
</td>
</tr>
<tr>
<td>
Faith
</td>
<td>
<%
				String[] faiths = {"Agnostic","Hindu","Atheist","Jewish","Buddhist","Muslim","ChristianCatholic","Spirtual","Other","ChristianLDS","ChristianProtestant","ChristianOther","Other"};
				String faith = rs.getString(2);
                              	for(int i=0;i<faiths.length;i++){
					StringBuffer temp = new StringBuffer();
					String faithTemp = faiths[i];
                                        for(int j=0;j<faithTemp.length();j++){
						char x = faithTemp.charAt(j);
						if(!Character.isUpperCase(x))
                                              		temp.append(x);
                                                else
                                                	temp.append(" "+x);
                                        }
                              		if(!faith.equals(faiths[i]))
                                        	out.println("<input name=\"Faith\" type=\"radio\" value=\""+faiths[i]+"\">"+temp.toString()+"<br>");
                                    	else
                                        	out.println("<input name=\"Faith\" type=\"radio\" value=\""+faiths[i]+"\"checked>"+temp.toString()+"<br>");
                              	}
%>
</td>
</tr>
<tr>
<td>
What other languages do you know:
</td>
<td>

<%
				String[] languages = {"Arabic","German","Portuguese","Other","Chinese","Hebrew","Russian","Dutch","Hindi","Spanish","English","Italian","Tagalog","French","Japanese","Urdu"};
                              	String language = rs.getString(3);
                              	for(int i=0;i<languages.length;i++){
                                	if(!language.equals(languages[i]))
                                        	out.println("<input name=\"Language\" type=\"checkbox\" value=\""+languages[i]+"\">"+languages[i]+"<br>");
                                  	else
                                        	out.println("<input name=\"Language\" type=\"checkbox\" value=\""+languages[i]+"\"checked>"+languages[i]+"<br>");
				}
                      	}
%>
</td>
</tr>
<tr>
<td>
What are your political views:
</td>
<td>
	<select name="Political" >
		<option value="None">None</option>
		<option value="UltraConservative">Ultra conservative</option>
		<option value="Conservative">Conservative</option>
		<option value="MiddleOfTheRoad">Middle of the road</option>
		<option value="Liberal">Liberal</option>
		<option value="VeryLiberal">Very liberal</option>
		<option value="NonConformist">Non-conformist</option>
		<option value="Other">Other</option>
	</select>
</td>
</tr>
</table>
	<br>
<%
	      	ps = con.prepareStatement("Select DescribeYourself,DescribeYourMatch from ownwords, users where ownwords.id = users.id and users.username=?",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
		ps.setString(1,user.getUserName());
              	rs = ps.executeQuery();
                if(rs.next()){
%>
<h3><b>Own Words</b></h3><br>
Describe yourself and who you want to meet:<br>
	<textarea name="DescribeYourself" cols="60" rows="21" ><%=rs.getString(1)%></textarea>
<br>
Describe your ideal match:<br>
	<textarea name="DescribeYourMatch" cols="60" rows="21"><%=rs.getString(2)%></textarea>
<br>
<%
                }
%>
<input name="" type="submit" value="Submit" >
</Form>

<%
				}
                            	ps.close();
                            	rs.close();
                      		con.close();
                           }catch(SQLException e){System.out.println("SQLException in createProfile edit: " + e);}
                          }else{
                            //build the new user page

%>
<Form  action="insertProfile.jsp"  method="post" >
<!-- user id      -->
<h3><b><%=user.getFirstName()%>'s Profile</b></h3>

	<input type="hidden" name="UserID" value="<%=user.getID()%>">

<h3><b>Appearence</b></h3><br>
<table>
	<tr>
		<td>
			Eye Color:
                </td>
		<td>
			<select name="EyeColor" size="1" >
                          <option value="Light blue"  selected>Light blue</option>
			  <option value="Blue" >Blue</option>
			  <option value="Blue-green" >Blue-green</option>
			  <option value="Baby blue" >Baby blue</option>
			  <option value="Hazel" >Hazel</option>
			  <option value="Light brown" >Light brown</option>
			  <option value="Light blue" >Light blue</option>
			  <option value="Brown" >Brown</option>
			  <option value="Dark brown" >Dark brown</option>
			</select>
		</td>
	</tr>
        <tr>
		<td>
			Height:
		</td>
                <td>
			Feet:
				<select name="Height1" size="1" >
					<option value="3" selected>3</option>
					<option value="4" >4</option>
					<option value="5" >5</option>
					<option value="6" >6</option>
					<option value="7" >7</option>
					<option value="8" >8</option>
				</select>
		</td>
		<td>
			Inches:
				<select name="Height2" size="1" >
					<option value="0" selected>0</option>
					<option value="1" >1</option>
					<option value="2" >2</option>
					<option value="3" >3</option>
					<option value="4" >4</option>
					<option value="5" >5</option>
					<option value="6" >6</option>
					<option value="7" >7</option>
					<option value="8" >8</option>
					<option value="9">9</option>
					<option value="10">10</option>
					<option value="11">11</option>
				</select>
                </td>
	</tr>
	<tr>
		<td>
			Hair Color:
		</td>
		<td>
			<select name="HairColor" size="1" >
				<option value="Black"  selected>Black</option>
				<option value="Blonde" >Blonde</option>
				<option value="Dark blonde" >Dark blonde</option>
				<option value="Light brown" >Light brown</option>
				<option value="Dark brown" >Dark brown</option>
				<option value="Red" >Red</option>
				<option value="Salt and pepper" >Salt and pepper</option>
				<option value="Platinum" >Platinum</option>
				<option value="Other" >Other</option>
			</select>
</td>
</tr>
<tr>
<td>
Body Type:
</td>
<td>
<select name="BodyType" size="1" >
	<option value="Slender" selected>Slender</option>
	<option value="Athletic and toned" >Athletic and toned</option>
	<option value="Average" >Average</option>
	<option value="A few extra pounds"  >A few extra pounds</option>
	<option value="Heavyset" >Heavyset</option>
	<option value="Other" >Other</option>
</select>
</td>
</tr>
<tr>
<td>
Best Feature:
</td>
<td>
<select name="BestFeature" size="1" >
	<option value="Nothing" selected>Nothing</option>
	<option value="Hair" >Hair</option>
	<option value="Eyes" >Eyes</option>
	<option value="Lips" >Lips</option>
	<option value="Neck" >Neck</option>
	<option value="Arms" >Arms</option>
	<option value="Hands" >Hands</option>
	<option value="Chest" >Chest</option>
	<option value="Belly button" >Belly button</option>
	<option value="Butt">Butt</option>
	<option value="Legs">Legs</option>
	<option value="Calves">Calves</option>
	<option value="Feet">Feet</option>
	<option value="Other">Other</option>
</select>
</td>
</tr>
</table>

<h3><b>Interests</b></h3><br>

<table>
<tr>
<td>
Favorite Hot Spots:
</td>
<td>
<textarea name="FavHotSpots" cols="45" rows="5"></textarea>
</td>
</tr>
<tr>
<td>
Favorite Things:
</td>
<td>
<textarea name="FavThings" cols="45" rows="5"></textarea>
</td>
</tr>
<tr>
<td>
Last Book Read:
</td>
<td>
<textarea name="LastBookRead" cols="45" rows="5"></textarea>
</td>
</tr>
<tr>
<td>
What do you do for fun:
</td>
<td>
<textarea name="DoesForFun" cols="45" rows="5"></textarea>
</td>
</tr>
<tr>
<td>
Sign:
</td>
<td>
<select name="Sign" size="1">
	<option value="No Sign" selected>No sign</option>
	<option value="Capricorn" >Capricorn</option>
	<option value="Aquarius">Aquarius</option>
	<option value="Pisces">Pisces</option>
	<option value="Aries">Aries</option>
	<option value="Taurus">Taurus</option>
	<option value="Gemini">Gemini</option>
	<option value="Cancer">Cancer</option>
	<option value="Leo">Leo</option>
	<option value="Virgo">Virgo</option>
	<option value="Libra">Libra</option>
	<option value="Scorpio">Scorpio</option>
	<option value="Saqittarius">Saqittarius</option>
</select>
</td>
</tr>
<tr>
<td>
School you attend:
</td>
<td>
<input name="School" type="text" size="50"  maxlength="50">
</td>
</tr>
<tr>
<td>
Major:
</td>
<td>
<input type="text" name="Major" maxlength="100" size="40">
</td>
</tr>
</table>

<h3><b>Turn on's</b></h3><br>
<table>
<tr>
<td>
Body Piercings:
</td>
<td>
				<input name="BodyPiercings" type="radio" value="1" checked>1
				<input name="BodyPiercings" type="radio" value="2" >2
				<input name="BodyPiercings" type="radio" value="3" >3
				<input name="BodyPiercings" type="radio" value="4" >4
				<input name="BodyPiercings" type="radio" value="5" >5

</td>
</tr>
<tr>
<td>
Boldness / Assertiveness:
</td>
<td>
				<input name="Boldness" type="radio" value="1" checked>1
				<input name="Boldness" type="radio" value="2" >2
				<input name="Boldness" type="radio" value="3" >3
				<input name="Boldness" type="radio" value="4" >4
				<input name="Boldness" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Brainiacs:
</td>
<td>
				<input name="Brainiacs" type="radio" value="1"checked>1
				<input name="Brainiacs" type="radio" value="2">2
				<input name="Brainiacs" type="radio" value="3">3
				<input name="Brainiacs" type="radio" value="4">4
				<input name="Brainiacs" type="radio" value="5">5
</td>
</tr>
<tr>
<td>
Candlelight:
</td>
<td>
				<input name="Candlelight" type="radio" value="1" checked>1
				<input name="Candlelight" type="radio" value="2" >2
				<input name="Candlelight" type="radio" value="3" >3
				<input name="Candlelight" type="radio" value="4" >4
				<input name="Candlelight" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Dancing:
</td>
<td>
				<input name="Dancing" type="radio" value="1" checked>1
				<input name="Dancing" type="radio" value="2" >2
				<input name="Dancing" type="radio" value="3" >3
				<input name="Dancing" type="radio" value="4" >4
				<input name="Dancing" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Erotica:
</td>
<td>
				<input name="Erotica" type="radio" value="1" checked>1
				<input name="Erotica" type="radio" value="2" >2
				<input name="Erotica" type="radio" value="3" >3
				<input name="Erotica" type="radio" value="4" >4
				<input name="Erotica" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Flirting:
</td>
<td>
				<input name="Flirting" type="radio" value="1" checked>1
				<input name="Flirting" type="radio" value="2" >2
				<input name="Flirting" type="radio" value="3" >3
				<input name="Flirting" type="radio" value="4" >4
				<input name="Flirting" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Long hair:
</td>
<td>
				<input name="LongHair" type="radio" value="1" checked>1
				<input name="LongHair" type="radio" value="2" >2
				<input name="LongHair" type="radio" value="3" >3
				<input name="LongHair" type="radio" value="4" >4
				<input name="LongHair" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Money:
</td>
<td>
				<input name="Money" type="radio" value="1" checked>1
				<input name="Money" type="radio" value="2" >2
				<input name="Money" type="radio" value="3" >3
				<input name="Money" type="radio" value="4" >4
				<input name="Money" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Public displays of affection:
</td>
<td>
				<input name="PublicDisplaysOfAffection" type="radio" value="1" checked>1
				<input name="PublicDisplaysOfAffection" type="radio" value="2" >2
				<input name="PublicDisplaysOfAffection" type="radio" value="3" >3
				<input name="PublicDisplaysOfAffection" type="radio" value="4" >4
				<input name="PublicDisplaysOfAffection" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Power:
</td>
<td>
				<input name="Power" type="radio" value="1" checked>1
				<input name="Power" type="radio" value="2" >2
				<input name="Power" type="radio" value="3" >3
				<input name="Power" type="radio" value="4" >4
				<input name="Power" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Sarcasm:
</td>
<td>
				<input name="Sarcasm" type="radio" value="1" checked>1
				<input name="Sarcasm" type="radio" value="2" >2
				<input name="Sarcasm" type="radio" value="3" >3
				<input name="Sarcasm" type="radio" value="4" >4
				<input name="Sarcasm" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Skinny dipping:
</td>
<td>
				<input name="SkinnyDipping" type="radio" value="1" checked>1
				<input name="SkinnyDipping" type="radio" value="2" >2
				<input name="SkinnyDipping" type="radio" value="3" >3
				<input name="SkinnyDipping" type="radio" value="4" >4
				<input name="SkinnyDipping" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Tattoos:
</td>
<td>
				<input name="Tattoos" type="radio" value="1" checked>1
				<input name="Tattoos" type="radio" value="2" >2
				<input name="Tattoos" type="radio" value="3" >3
				<input name="Tattoos" type="radio" value="4" >4
				<input name="Tattoos" type="radio" value="5" >5
</td>
</tr>
<tr>
<td>
Thrills:
</td>
<td>
				<input name="Thrills" type="radio" value="1" checked>1
				<input name="Thrills" type="radio" value="2" >2
				<input name="Thrills" type="radio" value="3" >3
				<input name="Thrills" type="radio" value="4" >4
				<input name="Thrills" type="radio" value="5" >5
</td>
</tr>
<tr>
</tr>
</table>

<h3><b>Perfect Date</b></h3><br>
<table>
<tr>
<td>
What's your perfect date:
<br>
	<input name="PerfectDate" type="radio" value="Cozy" checked>Cozy<br>
	<input name="PerfectDate" type="radio" value="Sensual" >Sensual<br>
	<input name="PerfectDate" type="radio" value="Raw" >Raw<br>
	<input name="PerfectDate" type="radio" value="Fun" >Fun<br>
	<input name="PerfectDate" type="radio" value="Indulgent" >Indulgent<br>
	<input name="PerfectDate" type="radio" value="Thrilling" >Thrilling<br>
	<input name="PerfectDate" type="radio" value="Hot" >Hot<br>
	<input name="PerfectDate" type="radio" value="Edgy" >Edgy<br>
	<input name="PerfectDate" type="radio" value="Relaxed" >Relaxed<br>
	<input name="PerfectDate" type="radio" value="Revealing" >Revealing<br>
	<input name="PerfectDate" type="radio" value="Casual" >Casual<br>
	<input name="PerfectDate" type="radio" value="Intimate" >Intimate<br>
	<input name="PerfectDate" type="radio" value="Stimulating" >Stimulating<br>
	<input name="PerfectDate" type="radio" value="Hilarious" >Hilarious<br>
	<input name="PerfectDate" type="radio" value="Natural" >Natural<br>
</td>
</tr>
</table>


<h3><b>Lifestyle</b></h3><br>
<table>
<tr>
<td>
Exercise habits:
</td>
<td>
	<select name="Exercise" >
		<option value="Never">Never</option>
		<option value="Sometimes">Sometimes</option>
		<option value="Occasionally">Occasionally</option>
		<option value="Regularly">Regularly</option>
		<option value="Always">Always</option>
	</select>
</td>
</tr>
<tr>
<td>
Diet habits:
</td>
<td>
	<input name="Diet" type="checkbox" value="MeatAndPotatoes" checked>Meat and potatoes<br>
	<input name="Diet" type="checkbox" value="KeepItHealthy">Keep it healthy<br>
	<input name="Diet" type="checkbox" value="Vegetarian">Vegetarian<br>
	<input name="Diet" type="checkbox" value="JunkFoodJunkie">Junk food junkie<br>
	<input name="Diet" type="checkbox" value="Other">Other<br>
</td>
</tr>
<tr>
<td>
Smoking habits:
</td>
<td>
	<select name="Smoke">
		<option value="Never">Never</option>
		<option value="Occasionally">Occasionally</option>
		<option value="CigarAficionado">Cigar aficionado</option>
		<option value="SmokelessTobacco">Smokeless tobacco</option>
		<option value="Daily">Daily</option>
		<option value="TryingToQuit">Trying to quit</option>
	</select>
</td>
</tr>
<tr>
<td>
Liquor habits:
</td>
<td>
	<select name="Drink">
		<option value="Never">Never</option>
		<option value="GaveItUp">Gave it up</option>
		<option value="NonAlcoholicOnly">Non-alcoholic beverages only</option>
		<option value="SocialDrinker">Social drinker, maybe one or two</option>
		<option value="Regular">Regularly</option>
	</select>
</td>
</tr>
</table>
<br>

<h3><b>Values</b></h3><br>
<table>
<tr>
<td>
Which ethnicities describe you the best:
</td>
<td>
	<input name="ethnicity" type="checkbox" value="Asian" checked>Asian<br>
	<input name="ethnicity" type="checkbox" value="NativeAmerican">Native American<br>
	<input name="ethnicity" type="checkbox" value="Black">Black / African<br>
	<input name="ethnicity" type="checkbox" value="PacificIslander">Pacific Islander<br>
	<input name="ethnicity" type="checkbox" value="EastIndian">East Indian<br>
	<input name="ethnicity" type="checkbox" value="White">White / Caucasian<br>
	<input name="ethnicity" type="checkbox" value="Latino">Latino / Hispanic<br>
	<input name="ethnicity" type="checkbox" value="Other">Other<br>
	<input name="ethnicity" type="checkbox" value="MiddleEastern">Middle Eastern<br>
</td>
</tr>
<tr>
<td>
Faith
</td>
<td>
	<input name="Faith" type="radio" value="Agnostic" checked>Agnostic<br>
	<input name="Faith" type="radio" value="Hindu" >Hindu<br>
	<input name="Faith" type="radio" value="Atheist" >Atheist<br>
	<input name="Faith" type="radio" value="Jewish" >Jewish<br>
	<input name="Faith" type="radio" value="Buddhist">Buddhist / Taoist<br>
	<input name="Faith" type="radio" value="Muslim" >Muslim / Islam<br>
	<input name="Faith" type="radio" value="ChristianCatholic" >Christian / Catholic<br>
	<input name="Faith" type="radio" value="Spirtual" >Spirtual but not religious<br>
	<input name="Faith" type="radio" value="Other" >Other<br>
	<input name="Faith" type="radio" value="ChristianLDS" >Christian / LDS<br>
	<input name="Faith" type="radio" value="ChristianProtestant" >Christian / Protestant<br>
	<input name="Faith" type="radio" value="ChristianOther" >Christian / Other<br>
	<input name="Faith" type="radio" value="Other" >Other<br>
</td>
</tr>
<tr>
<td>
What other languages do you know:
</td>
<td>
	<input name="Language" type="checkbox" value="Arabic" checked>Arabic<br>
	<input name="Language" type="checkbox" value="German" >German<br>
	<input name="Language" type="checkbox" value="Portuguese" >Portuguese<br>
	<input name="Language" type="checkbox" value="Other" >Other<br>
	<input name="Language" type="checkbox" value="Chinese" >Chinese<br>
	<input name="Language" type="checkbox" value="Hebrew" >Hebrew<br>
	<input name="Language" type="checkbox" value="Russian" >Russian<br>
	<input name="Language" type="checkbox" value="Dutch" >Dutch<br>
	<input name="Language" type="checkbox" value="Hindi" >Hindi<br>
	<input name="Language" type="checkbox" value="Spanish" >Spanish<br>
	<input name="Language" type="checkbox" value="English" >English<br>
	<input name="Language" type="checkbox" value="Italian" >Italian<br>
	<input name="Language" type="checkbox" value="Tagalog" >Tagalog<br>
	<input name="Language" type="checkbox" value="French" >French<br>
	<input name="Language" type="checkbox" value="Japanese" >Japanese<br>
	<input name="Language" type="checkbox" value="Urdu" >Urdu<br>
</td>
</tr>
<tr>
<td>
What are your political views:
</td>
<td>
	<select name="Political" >
		<option value="None">None</option>
		<option value="UltraConservative">Ultra conservative</option>
		<option value="Conservative">Conservative</option>
		<option value="MiddleOfTheRoad">Middle of the road</option>
		<option value="Liberal">Liberal</option>
		<option value="VeryLiberal">Very liberal</option>
		<option value="NonConformist">Non-conformist</option>
		<option value="Other">Other</option>
	</select>
</td>
</tr>
</table>
	<br>

<h3><b>Own Words</b></h3><br>
Describe yourself and who you want to meet:<br>
	<textarea name="DescribeYourself" cols="60" rows="21" ></textarea>
<br>
Describe your ideal match:<br>
	<textarea name="DescribeYourMatch" cols="60" rows="21"></textarea>
<br>


<input name="" type="submit" value="Submit" >
</Form>
<%
                          }
%>
</body>
</html>
