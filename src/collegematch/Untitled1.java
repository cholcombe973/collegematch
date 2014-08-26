package collegematch;

import java.sql.*;
import java.util.*;
/*Utility class for filling the database with random crap*/

public class Untitled1 {
  private Connection con;


  public void connect(){
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){System.out.println("ClassNotFoundException in getConnected(): " + e);}
    try{
      con = DriverManager.getConnection("jdbc:mysql://192.168.1.139:3306/collegematch?user=chris&password=password");
    }catch(SQLException e){System.out.println("SQL Exception in getConnected(): " + e);}
  }
  public void disconnect(){
    try {
      con.close();
    }catch (SQLException ex) {System.out.println("SQLException in disconnect(): " + ex);}
  }
  public void fillDatabase(){
    try {
/*
      String[] women = {"Marcie Bloomquist","Marcie Mains","Jeanie Lamantia","Elinor Lingenfelter","Annabelle Blecha","Eve Crisler","Avis Mcfee","Shannon Mourer","Sharron Hick","Alejandra Lenser","Milagros Peranio","Rosalinda Bilbo","Katy Hunter","Annabelle Flom","Maricela Rozman","Rosalinda Lyn","Zelma Simeon","Esmeralda Sleeman","Karina Noack","Liza Clingman","Mallory Kramp","Marcie Kohen","Saundra Karney","Esmeralda Mcgarrity","Benita Brosnan","Harriett Fregoe","Tameka Gilleland","Julianne Goodspeed","Kenya Anker","Loraine Hetherington"};
      for(int i=0;i<women.length;i++){
        PreparedStatement ps = con.prepareStatement("INSERT into users values(null,?,md5(?),'user',?,?,?,?,?)");
        ps.setString(1,women[i].substring(0,women[i].indexOf(' '))); //username
        ps.setString(2,"temp"); //password
        ps.setString(3,women[i].substring(0,women[i].indexOf(' '))); //firstname
        ps.setString(4,women[i].substring(women[i].indexOf(' '),women[i].length())); //lastname
        ps.setString(5,"2004-07-13"); //signupdate
        ps.setString(6,"2004-08-13"); //endservicedate
        ps.setString(7,women[i].substring(women[i].indexOf(' '),women[i].length())+"@hotmail.com"); //email address
//        System.out.println("Debug:: " + ps.toString());
        ps.executeUpdate();
      }
      String[] men = {"Christian Tschida","Clayton Noggle","Clayton Ownbey","Jamie Engberg","Javier Flynt","Max Wiggin","Tyrone Escudero","Christian Hudon","Neil Barrientez","Max Bartee","Darren Rossano","Clinton Lute","Mathew Lucena","Cody Whichard","Cody Pearcy","Hugh Kennamer","Hugh Viles","Mathew Kuffel","Fernando Myres","Erik Soliday","Javier Summa","Fernando Ried","Cody Aquilino","Ted Gutowski","Lonnie Scotto","Hugh Bourdeau","Erik Iorio","Hugh Diekmann","Christian Wenz","Nelson Dimatteo"};
      for(int i=0;i<men.length;i++){
        PreparedStatement ps = con.prepareStatement("INSERT into users values(null,?,md5(?),'user',?,?,?,?,?)");
        ps.setString(1,men[i].substring(0,men[i].indexOf(' '))); //username
        ps.setString(2,"temp"); //password
        ps.setString(3,men[i].substring(0,men[i].indexOf(' '))); //firstname
        ps.setString(4,men[i].substring(men[i].indexOf(' '),men[i].length())); //lastname
        ps.setString(5,"2004-07-13"); //signupdate
        ps.setString(6,"2004-08-13"); //endservicedate
        ps.setString(7,men[i].substring(men[i].indexOf(' '),men[i].length())+"@hotmail.com"); //email address
//        System.out.println("Debug:: " + ps.toString());
        ps.executeUpdate();
      }
*/
      int[] users = {7,8,9,10,11,12,14,15,16,17,18,20,22,23,24,25,26,27,28,30,31,32,33,34,35,38,39,41,42,43,44,46,47,48,49,56,57,59,60,61,62,65};
      Random r = new Random(System.currentTimeMillis());
      for(int i=0;i<users.length;i++){
        PreparedStatement ps = con.prepareStatement("INSERT into appearance values(?,?,?,?,?,?,?,?)");
        ps.setInt(1,users[i]);
        ps.setString(2,"green");
        ps.setString(3,"Black");
        ps.setString(4,"Athletic");
        ps.setString(5,"Eyes");
        ps.setString(6,"20");
        ps.setString(7,"");
        ps.setString(8,"67");
        ps.executeUpdate();
      }
    }catch (SQLException ex) {System.out.println("SQLException in fillDatabase(): " + ex);}
  }

  public static void main(String[] args){
    Untitled1 u = new Untitled1();
    u.connect();
    u.fillDatabase();
    u.disconnect();
  }
}
