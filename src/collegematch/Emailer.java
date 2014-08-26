package collegematch;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class Emailer {

  public void sendCustomerMessage(String from, String to, String subject, String message) {
    //from is optional

    Properties props = System.getProperties();
    props.put("mail.smtp.host", "localhost");
    props.put("mail.smtp.auth","true");
    Session session = Session.getDefaultInstance(props,new SMTPAuthenticator());
    try {
      MimeMessage mMessage = new MimeMessage(session);
      if(from!=null)
        mMessage.setFrom(new InternetAddress(from));
      else
        mMessage.setFrom(new InternetAddress("admin@collegematch.no-ip.com"));
      mMessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
      mMessage.setSubject(subject);
      mMessage.setText(message);
      Transport.send(mMessage);
    }catch (MessagingException e) {
      System.out.println("MessagingException: " + e);
      e.printStackTrace(System.out);
    }
  }

  public void sendAdminMessage(String subject, String message) {

    Properties props = System.getProperties();
    props.put("mail.smtp.host", "localhost");
    props.put("mail.smtp.auth","true");
    Session session = Session.getDefaultInstance(props, new SMTPAuthenticator());
    try {
      MimeMessage mMessage = new MimeMessage(session);
      mMessage.setFrom(new InternetAddress("admin@collegematch.no-ip.com"));
      mMessage.addRecipient(Message.RecipientType.TO, new InternetAddress("admin@collegematch.no-ip.com"));
      mMessage.setSubject(subject);
      mMessage.setText(message);
      Transport.send(mMessage);
    }catch (MessagingException e) {
      System.out.println("MessagingException: " + e);
      System.out.println("Message: " + e.getMessage());
    }
  }
  private class SMTPAuthenticator extends Authenticator{
    protected PasswordAuthentication getPasswordAuthentication(){
      return new PasswordAuthentication("xfactor973","password");
    }
  }
}
