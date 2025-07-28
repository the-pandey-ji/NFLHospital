/**
 * @(#)getDate.java
 *
 *
 * @author 
 * @version 1.00 2008/9/24
 */
package getDate;

import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
public class getDate {

private static String day;
private static String month;
private static int year;
private static String todayDate;

public static String months[] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
       
    public getDate() {
    	Calendar calendar = Calendar.getInstance();
    	day=Integer.toString(calendar.get(Calendar.DATE));
      	if(day.length() == 1)
    		day = "0"+day; 
    	month=months[calendar.get(Calendar.MONTH)];
    	year=calendar.get(Calendar.YEAR);
    	todayDate = day + "-" + month + "-" + Integer.toString(year);
    }
    
    public static String getDay()
    {
    	return day;
    }
    public static String getMonth()
    {
    	return month;
    }
    public static int getYear()
    {
    	return year;
    }
    public static String getTodayDate()
    {
    	return todayDate;
    }
}