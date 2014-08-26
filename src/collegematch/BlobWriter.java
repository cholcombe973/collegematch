package collegematch;

import java.sql.*;
import java.io.*;
import javax.sql.*;
import javax.naming.*;

public class BlobWriter {
  private Connection con;
  private PreparedStatement prepStmt;

  public void getBlob(int userID, OutputStream out, String columnName){
    try{
      prepareStatement(userID);
      writeBlob(out,columnName);
      prepStmt.close();
      con.close();
      }catch(SQLException e){System.out.println("SQLExeception in getBlob: " + e.getSQLState());}
      catch(Exception e){System.out.println("Exception in getBlob: " + e);}
  }

  private void writeBlob(OutputStream out,String columnName) throws Exception{
    //Art's approach
    int byteCount = 0;
    byte[] buffer = new byte[1024*2060];
    try{
      //execute the query
      ResultSet rs = prepStmt.executeQuery();
      if(!(rs.next())){
        System.out.println("blob row not found");
        throw new Exception("Blob row not found.");
      }
      InputStream input = rs.getBinaryStream(columnName);
      //read the bytes
      byteCount = input.read(buffer);
      while(byteCount > 0){
        out.write(buffer);
        byteCount = input.read(buffer);
      }
      input.close();
      out.close();
      rs.close();
      }catch(IOException e){System.out.println("IOException found in writeBlob: " + e);}
      catch(SQLException e){System.out.println("SQLException found in writeBlob: " + e.getSQLState());
      System.out.println("SQL Error code: "+e.getErrorCode());
      System.out.println("SQL Exception: " + e);
      System.out.println("SQL Statement to string: " + prepStmt.toString());}
  }
  public void prepareStatement(int userID){
    try{
      prepStmt = con.prepareStatement("SELECT * FROM pictures WHERE UserID =?");
      prepStmt.setInt(1,userID);
      }catch(SQLException e){System.out.println("SQLExeception in preparestatment: " + e);}
  }
  public void getConnected(){
    // get connected to the database;
    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/CollegeMatch");
      con = ds.getConnection();
    }catch (SQLException ex) {System.out.println("SQLException in getConnected(): " + ex);}
    catch (NamingException ex) {System.out.println("NamingException in getConnected(): " + ex);}
  }
  public BlobWriter(){
    getConnected();
  }
}
