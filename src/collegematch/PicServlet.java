package collegematch;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class PicServlet extends HttpServlet {
  //Initialize global variables
  public void init() throws ServletException { }
  //Process the HTTP Get request
  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    BlobWriter blobwriter = new BlobWriter();

    OutputStream out = response.getOutputStream();
    response.setContentType("image/jpeg");
    String column = request.getParameter("a");
    int userID = Integer.parseInt(request.getParameter("b"));
    try{
      blobwriter.getBlob(userID,out,column);
      }catch(Exception e){System.out.println("Exception: " + e);}
  }
  //Clean up resources
  public void destroy() {
  }
}
