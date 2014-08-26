package collegematch;

import java.io.*;
import javax.servlet.http.*;
import com.oreilly.servlet.multipart.*;

public class UploadBean {
  private MySQLBlobDBStore database;
  private MultipartParser parser;
  private Part part;

  public UploadBean() {
    database = new MySQLBlobDBStore();
  }
  public void connect(){
    database.connect();
  }
  public int getLastID(){
    return database.getLastId();
  }
  public boolean isMultiPartRequest(HttpServletRequest request){
    String s = null;
    String s1 = request.getHeader("Content-Type");
    String s2 = request.getContentType();
    if(s1 == null && s2 != null)
      s = s2;
    else
    if(s2 == null && s1 != null)
      s = s1;
    else
    if(s1 != null && s2 != null)
      s = s1.length() <= s2.length() ? s2 : s1;
    return s != null && s.toLowerCase().startsWith("multipart/form-data");
  }
  public void store(HttpServletRequest request,int userID){
    try {
      parser = new MultipartParser(request, 1000000);
      Part part;
      while((part = parser.readNextPart())!=null){
        String name = part.getName();
        if(part.isParam()){ //what am I going to do with these params?
          //if I'm using this for only file upload i don't need these params
          String paramName = part.getName();
          String value = ((ParamPart)part).getStringValue();
        }
        else if(part.isFile()){
          FilePart fPart = (FilePart)part;
          String fileName = fPart.getFileName();
          if(fileName!=null){
            File temp = new File("C:\\CollegeMatchPictureDump\\"+fileName);
            long l = fPart.writeTo(temp);
            database.store(temp,false,userID);
          }
        }
        else{
          //shizzle is unknown??
        }
      }
    }catch (IOException e) {System.out.println("IOException: " + e);}
  }
}
