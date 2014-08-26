package collegematch;

import java.sql.Date;

public class ValidUser {

  private String userName,firstName,lastName,roles,emailAddress;
  private int id;
  private Date signupDate,endServiceDate;
  private Date currentDate = new Date(System.currentTimeMillis());

  public ValidUser() {
  }
  public String getUserName(){
    return userName;
  }
  public void setUserName(String userName){
    this.userName = userName;
  }
  public String getFirstName(){
    return firstName;
  }
  public void setFirstName(String firstName){
    this.firstName = firstName;
  }
  public String getLastName(){
    return lastName;
  }
  public void setLastName(String lastName){
    this.lastName = lastName;
  }
  public String getRoles(){
    return roles;
  }
  public void setRoles(String roles){
    this.roles = roles;
  }
  public int getID(){
    return id;
  }
  public void setID(int id){
    this.id = id;
  }
  public String getEmailAddress(){
    return emailAddress;
  }
  public void setEmailAddress(String emailAddress){
    this.emailAddress = emailAddress;
  }
  public Date getEndServiceDate(){
    return endServiceDate;
  }
  public void setEndServiceDate(Date endServiceDate){
    this.endServiceDate = endServiceDate;
  }
  public Date getSignupDate(){
    return signupDate;
  }
  public void setSignupDate(Date signupDate){
    this.signupDate = signupDate;
  }
  public void setCurrentDate(Date currentDate){
    this.currentDate = currentDate;
  }
  public Date getCurrentDate(){
    return currentDate;
  }
  public boolean validServiceDate(){
    if(currentDate.compareTo(endServiceDate)>0)
      return false;
    return true;
  }
}
