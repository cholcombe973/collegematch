package collegematch;

import java.io.*;
import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class MySQLBlobDBStore { //extends DBStore {
  private final String SQLUPLOADTABLE = "pictures";
  private int id;
  private Connection con;

  public MySQLBlobDBStore() {
  }

  public int getLastId() {
    return id;
  }

  public void connect() {
    try {
      Context initCtx = new InitialContext();
      Context envCtx = (Context) initCtx.lookup("java:comp/env");
      DataSource ds = (DataSource) envCtx.lookup("jdbc/CollegeMatch");
      con = ds.getConnection();
    }catch (SQLException ex) {System.out.println("SQLException in connect(): " + ex);}
    catch (NamingException ex) {System.out.println("NamingException in connect(): " + ex);}
  }

  private void update(File file) {
    try {
      PreparedStatement ps = con.prepareStatement("SELECT BinaryFile FROM Pictures WHERE FILENAME = ? FOR UPDATE");
      ps.setString(1, file.getName());
      ResultSet rs = ps.executeQuery();
      Blob b = null;
      while (rs.next()) {
        b = rs.getBlob(1);
      }
      rs.close();
      //update the blob
      OutputStream out = b.setBinaryStream(0);
      FileInputStream is = new FileInputStream(file);
      byte[] buffer = new byte[(int)b.length()];
      int bytesRead = 0;
      while((bytesRead = is.read(buffer)) != -1){
        out.write(buffer,0,bytesRead);
      }
      out.close();
      ps.close();
    }catch (SQLException e) {System.out.println("SQLException: " + e);}
    catch(IOException e){System.out.println("IOException: " + e);}
  }

  public void store(File file, boolean overwrite,int userID) { //UploadFile file, boolean overwrite) throws Exception {

    if (overwrite == false) {
      insert(file,userID);
    }
    /*
    else {
      // Check for duplicate entry (filename)
      try {
        PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Pictures WHERE FILENAME ='" + file.getName() +"'");
        ResultSet r = ps.executeQuery();
        int size = 0;
        while (r.next()) {
          size = r.getInt(1);
        }
        r.close();
        ps.close();
        if (size > 0) {
          if (size > 1) {
            delete(file);
            insert(file,userID);
          }
          else if (size == 1) {
            update(file);
          }
        }
        else {
          insert(file,userID);
        }
      }catch (SQLException e) {System.out.println("SQLException: " + e);}
    }
    */
  }
  /*
  private void delete(File file) {
    try{
      PreparedStatement ps = con.prepareStatement("DELETE FROM Pictures WHERE Filename = ?");
      ps.setString(1, file.getName());
      ps.executeUpdate();
      ps.close();
    }catch(SQLException e){System.out.println("SQLException: " + e);}
  }
  */
  private void insert(File file,int userID) {
    try{
      PreparedStatement ps = con.prepareStatement("Insert into pictures (UploadID,BinaryFile,FileName,UserID) Values(?,?,?,?)");
      id = (int)System.currentTimeMillis();
      ps.setInt(1,id);
      ps.setBinaryStream(2, new FileInputStream(file),(int)file.length());
      ps.setString(3,file.getName());
      ps.setInt(4,userID);
      ps.executeUpdate();
      ps.close();
    }catch(SQLException e){System.out.println("SQLException: " + e);}
    catch(FileNotFoundException e){System.out.println("FileNotFoundException: " + e);}
  }
  public int countFiles() throws SQLException{
    if (con != null) {
      // Counts records in database to check max files in store.
      PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM Pictures");
      ResultSet r = ps.executeQuery();
      int size = 0;
      while (r.next()) {
        size = r.getInt(1);
      }
      r.close();
      ps.close();
      return size;
    }
    else {
      return -1;
    }
  }
}
