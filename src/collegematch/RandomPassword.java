package collegematch;

/*
   Well the name is pretty obvious but if you haven't figured it out yet,
   this class generates random passwords of any given length.
   This class will generate strong passwords.

*/
import java.util.Random;

public class RandomPassword {
  private Random r = new Random(System.currentTimeMillis());
  private char[] password;
  private char[] values = {33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,
      56,57,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,
      83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,
      109,110,111,112,113,114,115,116,117,118,119,120,121,122};

  public String generatePassword(int length){
    password = new char[length];
    for(int i=0;i<length;i++){
      password[i]=values[r.nextInt(values.length)];
    }
    return new String(password);
  }
}
