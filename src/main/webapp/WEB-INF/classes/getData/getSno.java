/**
 * @(#)getSno.java
 *
 *
 * @author
 * @version 1.00 2008/8/21
 */
package getData;

import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.sql.*;

public class getSno {
    public static int count;
    public static String[] sNo;

    public getSno()
    {
    	int i=0;
    	Connection conn  = null;
        try {

              Class.forName("oracle.jdbc.driver.OracleDriver");
		      DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	          conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:orcl","production","prod");
              Statement stmt=conn.createStatement();

              ResultSet rs = stmt.executeQuery("select COMNO from COMMITTEE order by COMNO DESC");
              while(rs.next())
              {
              	i++;
              }
              count = i;

              sNo = new String[count];
              i=0;

              ResultSet rsdata = stmt.executeQuery("select COMNO from COMMITTEE order by COMNO DESC");
              while(rsdata.next())
              {
              	sNo[i] = rsdata.getString("COMNO");
              	i++;
              }
        }
        catch(SQLException e) {
                   System.out.println("SQLException : "+ e.getMessage());
                   while((e = e.getNextException()) != null)
                   System.out.println(e.getMessage());
                 }

            catch(ClassNotFoundException e) {
                   System.out.println("ClassNotFoundexception :" + e.getMessage());
                 }

            finally{
              if(conn != null) {
                try{
                     conn.close();
                   }
                catch (Exception ignored) {}
                }
             }
    }

	public static String[] getSerialNo()
	{
		return(sNo);
	}
	public static int getCount()
	{
		return(count);
	}
}

