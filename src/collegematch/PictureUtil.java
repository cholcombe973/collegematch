package collegematch;

import java.io.*;
import java.sql.*;
import javax.swing.*;

public class PictureUtil {
  private Thread internalThread;
  private volatile boolean noStopRequested;
  private Connection con;
  private PreparedStatement prepStmt;
  private JOptionPane jOption = new JOptionPane();
  private PrintStream pOut;

  public PictureUtil() {
    try {
      File f = new File("D:\\Documents and Settings\\Chris Holcombe\\jbproject\\CollegeMatch\\StackTrace.txt");
      pOut = new PrintStream(new FileOutputStream(f));
    }catch (FileNotFoundException ex) {JOptionPane.showMessageDialog(null,ex,"FileNotFoundException ", JOptionPane.ERROR_MESSAGE);}
    JOptionPane.showMessageDialog(null,"Initializing...");
    noStopRequested = true;
    Runnable r = new Runnable() {
      public void run() {
        try {
          runWork();
        }catch (Exception e) {
          e.printStackTrace(pOut);
          pOut.close();
          JOptionPane.showMessageDialog(null,e,"Exception in Runnable()", JOptionPane.ERROR_MESSAGE);
        }
      }
    };
    internalThread = new Thread(r);
    internalThread.start();
  }

  public static void main(String args[]) {
    JOptionPane.showMessageDialog(null,"starting...");
    PictureUtil util = new PictureUtil(); //start my active object :)
  }
  private void runWork() {
    if (Thread.currentThread() != internalThread) {
      throw new RuntimeException("only the internal thread is allowed to invoke run()");
    }
    getConnected();
    prepareStatement();

    while (noStopRequested) {
      JOptionPane.showMessageDialog(null,"Test2");
//      System.out.println("Running...");
      checkForNewFiles();
      try {
        Thread.sleep(300000);//1 minutes //1,800,000 = 30 minutes
      }catch (InterruptedException e) {Thread.currentThread().interrupt();}
    }
    try {
      con.close();
    }catch (SQLException ex) {
      System.out.println("SQLException in runWork(): " + ex);
      JOptionPane.showMessageDialog(null,ex,"SQLException in runWork()",JOptionPane.ERROR_MESSAGE);
    }
  }
  private void checkForNewFiles(){
    JOptionPane.showMessageDialog(null,"Checking for files");
    File[] directoryFiles = new File("C:\\CollegeMatchPictureDump").listFiles();
    if(directoryFiles!=null){
      File blob = null;
      for (int i = 0; i < directoryFiles.length; i++) {
        blob = directoryFiles[i];
        try {
          prepStmt.setInt(1,Integer.parseInt( (blob.getName()).substring(0,blob.getName().indexOf('-'))));
          prepStmt.setBinaryStream(2, new FileInputStream(blob),(int) blob.length());
          prepStmt.executeUpdate();
        }catch (FileNotFoundException ex) {
          System.out.println("FileNotFoundException in checkForNewFiles(): " +ex);
          JOptionPane.showMessageDialog(null,ex,"FileNotFoundException in checkForNewFiles()",JOptionPane.ERROR_MESSAGE);
        }
        catch (SQLException e) {
          System.out.println("SQLException in checkForNewFiles(): " + e);
          JOptionPane.showMessageDialog(null,e,"SQLException in checkForNewFiles()",JOptionPane.ERROR_MESSAGE);
        }
        blob.delete();
        System.out.println("Picture: " + blob.getName() +" inserted");
      }
    }
  }
  public void stopRequest() {
    noStopRequested = false;
    internalThread.interrupt();
  }

  public boolean isAlive() {
    return internalThread.isAlive();
  }

  public void getConnected(){
    // get connected to the database;
    try{
      Class.forName("org.gjt.mm.mysql.Driver");
    }catch(ClassNotFoundException e){
      System.out.println("ClassNotFoundException in getConnected(): " + e);
      JOptionPane.showMessageDialog(null,e,"ClassNotFoundException in getConnected()",JOptionPane.ERROR_MESSAGE);
    }
    try{
      con = DriverManager.getConnection("jdbc:mysql://localhost:3306/collegematch?user=UploadPics&password=xkdfndcüd");
    }catch(SQLException e){
      System.out.println("SQL Exception in getConnected(): " + e);
      JOptionPane.showMessageDialog(null,e,"SQLException in getConnected()",JOptionPane.ERROR_MESSAGE);
    }
  }

  public void prepareStatement(){
    try{
      prepStmt = con.prepareStatement("Insert into pictures(ID,Picture) values(?,?)");
    }catch(SQLException e){System.out.println("SQLExeception in preparestatment: " + e);}
  }
}
