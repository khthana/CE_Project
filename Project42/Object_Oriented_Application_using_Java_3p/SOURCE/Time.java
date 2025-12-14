import java.util.*;

public class Time{

  public String time(){
    Date today_date = new Date();
    return msgDateFormat(today_date);
  }

  private String msgDateFormat( Date senddate) {
    String formatted = "hold";

    String Day[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
    String Month[] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    formatted = Day[senddate.getDay()] + ", ";
    formatted = formatted + String.valueOf(senddate.getDate()) + " ";
    formatted = formatted + Month[senddate.getMonth()] + " ";
    if (senddate.getYear() > 99)
      formatted = formatted + String.valueOf(senddate.getYear() + 1900) + " ";
    else
      formatted = formatted + String.valueOf(senddate.getYear()) + " ";
    if (senddate.getHours() < 10) formatted = formatted + "0";
      formatted = formatted + String.valueOf(senddate.getHours()) + ":";
    if (senddate.getMinutes() < 10) formatted = formatted + "0";
      formatted = formatted + String.valueOf(senddate.getMinutes()) + ":";
    if (senddate.getSeconds() < 10) formatted = formatted + "0";
      formatted = formatted + String.valueOf(senddate.getSeconds()) + " ";
    if (senddate.getTimezoneOffset() < 0)
      formatted = formatted + "+";
    else
      formatted = formatted + "-";
    if (Math.abs(senddate.getTimezoneOffset())/60 < 10) formatted = formatted + "0";
      formatted = formatted + String.valueOf(Math.abs(senddate.getTimezoneOffset())/60);
    if (Math.abs(senddate.getTimezoneOffset())%60 < 10) formatted = formatted + "0";
      formatted = formatted + String.valueOf(Math.abs(senddate.getTimezoneOffset())%60);

    return formatted;
  }
}
