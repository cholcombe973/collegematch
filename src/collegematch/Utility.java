package collegematch;

import java.util.Hashtable;
import java.nio.*;
import java.util.*;

public class Utility {
  private String originalData = "receiver_email=xfactor973%40hotmail.com&receiver_id=I9OWF2HNCR2XH&business=paypal%40yourdomain.com&item_name=College+Match+Subscription&item_number=032&quantity=1&invoice=138721&custom=Custom&option_name1=Option&option_selection1=Selection&option_name2=Option&option_selection2=Selection&payment_status=Completed&payment_date=08%3A53%3A58+Jun+19%2C+2004+PDT&payment_gross=24.99&payment_fee=1.02&mc_gross=24.99&mc_fee=1.02&mc_currency=USD&tax=0.00&txn_id=4C89A1NCW4OZIVQAR&txn_type=web_accept&memo=PayPal+Special+Instructions%2FNote+Field.&first_name=Thomas&last_name=Tester&address_street=21+Test+Street&address_city=Testopia&address_state=Testville&address_zip=123456&address_country=United&address_status=confirmed&address_owner=1&payer_email=paypal%40theirdomain.com&paypal_address_id=4ZLJ7NQQ0K40H&payer_id=IQULQ8FG0FOV0&payer_business_name=Test+Company+Ltd.&payer_status=verified&payment_type=instant&notify_version=1.5&verify_sign=hWBRIZO8oPxJTNbWkxQRel3lshZvnjpBfPxu5kaaMcsC-4poQ0IyZU5C&subscr_date=08%3A53%3A58+Jun+19%2C+2004+PDT&subscr_effective=08%3A53%3A58+Jun+19%2C+2004+PDT&period1=7+d&period2=3+w&period3=11+m&amount1=1.99&amount2=6.49&amount3=19.99&mc_amount1=1.99&mc_amount2=6.49&mc_amount3=19.99&recurring=1&reattempt=1&retry_at=08%3A53%3A58+Jun+26%2C+2004+PDT&username=UtAXdoqa&password=Syo1MBbG3f9cs&subscr_id=S-89A40WH69T9YQWGNB";
  private String postBackData = "cmd=_notify-validate&amount3=19.99&option_selection2=Selection&amount2=6.49&option_selection1=Selection&amount1=1.99&payer_business_name=Test+Company+Ltd.&last_name=Tester&address_owner=1&option_name2=Option&option_name1=Option&subscr_id=S-89A40WH69T9YQWGNB&txn_type=web_accept&receiver_email=xfactor973%40hotmail.com&address_city=Testopia&subscr_effective=08%3A53%3A58+Jun+19%2C+2004+PDT&payment_gross=24.99&payment_date=08%3A53%3A58+Jun+19%2C+2004+PDT&address_zip=123456&payment_status=Completed&address_street=21+Test+Street&subscr_date=08%3A53%3A58+Jun+19%2C+2004+PDT&mc_amount3=19.99&paypal_address_id=4ZLJ7NQQ0K40H&first_name=Thomas&mc_amount2=6.49&period3=11+m&payer_email=paypal%40theirdomain.com&mc_amount1=1.99&period2=3+w&verify_sign=hWBRIZO8oPxJTNbWkxQRel3lshZvnjpBfPxu5kaaMcsC-4poQ0IyZU5C&payer_id=IQULQ8FG0FOV0&period1=7+d&payment_type=instant&business=paypal%40yourdomain.com&memo=PayPal+Special+Instructions%2FNote+Field.&address_status=confirmed&mc_fee=1.02&quantity=1&notify_version=1.5&mc_currency=USD&custom=Custom&address_state=Testville&recurring=1&payment_fee=1.02&payer_status=verified&password=Syo1MBbG3f9cs&retry_at=08%3A53%3A58+Jun+26%2C+2004+PDT&item_name=College+Match+Subscription&username=UtAXdoqa&tax=0.00&item_number=032&invoice=138721&mc_gross=24.99&txn_id=4C89A1NCW4OZIVQAR&receiver_id=I9OWF2HNCR2XH&reattempt=1&address_country=United";
  private static byte[] testData = "receiver_email=xfactor973%40hotmail.com&receiver_id=I9OWF2HNCR2XH&business=paypal%40yourdomain.com&item_name=College+Match+Subscription&item_number=032&quantity=1&invoice=138721&custom=Custom&option_name1=Option&option_selection1=Selection&option_name2=Option&option_selection2=Selection&payment_status=Completed&payment_date=08%3A53%3A58+Jun+19%2C+2004+PDT&payment_gross=24.99&payment_fee=1.02&mc_gross=24.99&mc_fee=1.02&mc_currency=USD&tax=0.00&txn_id=4C89A1NCW4OZIVQAR&txn_type=web_accept&memo=PayPal+Special+Instructions%2FNote+Field.&first_name=Thomas&last_name=Tester&address_street=21+Test+Street&address_city=Testopia&address_state=Testville&address_zip=123456&address_country=United&address_status=confirmed&address_owner=1&payer_email=paypal%40theirdomain.com&paypal_address_id=4ZLJ7NQQ0K40H&payer_id=IQULQ8FG0FOV0&payer_business_name=Test+Company+Ltd.&payer_status=verified&payment_type=instant&notify_version=1.5&verify_sign=hWBRIZO8oPxJTNbWkxQRel3lshZvnjpBfPxu5kaaMcsC-4poQ0IyZU5C&subscr_date=08%3A53%3A58+Jun+19%2C+2004+PDT&subscr_effective=08%3A53%3A58+Jun+19%2C+2004+PDT&period1=7+d&period2=3+w&period3=11+m&amount1=1.99&amount2=6.49&amount3=19.99&mc_amount1=1.99&mc_amount2=6.49&mc_amount3=19.99&recurring=1&reattempt=1&retry_at=08%3A53%3A58+Jun+26%2C+2004+PDT&username=UtAXdoqa&password=Syo1MBbG3f9cs&subscr_id=S-89A40WH69T9YQWGNB".getBytes();

  public static void main(String[] args){
    Utility t = new Utility();
//    t.formatPostData();
//    t.formatOriginalData();
//    t.pullParams(testData);
//    Emailer e = new Emailer();
//    e.sendCustomerMessage(null,"xfactor@jjcentertainment.no-ip.com","Test Test","This is a test message");
  }
  public void formatPostData(){
    int count = 0;
    int rowCount = 1;
    for(int i=0;i<postBackData.length();i++){
      System.out.print(postBackData.charAt(i));
      count++;
      if(count==16){
        System.out.print(" "+rowCount);
        rowCount++;
        System.out.print("\r\n");
        count=0;
      }
    }
  }
  public void formatOriginalData(){
    int count = 0;
    int rowCount = 1;
    for(int i=0;i<originalData.length();i++){
      System.out.print(originalData.charAt(i));
      count++;
      if(count==16){
        System.out.print(" "+rowCount);
        rowCount++;
        System.out.print("\r\n");
        count=0;
      }
    }
  }
  public Hashtable pullParams(byte[] data){
    //this method should save parameters from binary data streams
    Hashtable params = new Hashtable();
    String key = "";
    String value = "";
    int length = data.length;
    int offset = 0;
    for(int i=0;i<length;i++){
      if(data[i]=='='){
        key = new String(data,offset,(i-offset));
        offset = i+1;
      }
      if(data[i]=='&'){
        value = new String(data,offset,(i-offset));
        offset = i+1;
        System.out.println("Key: " + key + " Value: " + value);
        params.put(key,value);
      }
      if(i==(length-1)){
        value = new String(data,offset,(length-offset));
      }
    }
    System.out.println("Key: " + key + " Value: " + value);
    return params;
  }
  public Hashtable pullParams(ByteBuffer data){  //gotta love direct bytebuffers
    /*

     */
    Hashtable params = new Hashtable();



    return params;
  }
}
