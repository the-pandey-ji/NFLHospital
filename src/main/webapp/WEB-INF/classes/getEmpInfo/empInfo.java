/**
 * @(#)empInfo.java
 *
 *
 * @author
 * @version 1.00 2008/10/14
 */
package getEmpInfo;

import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.sql.*;

public class empInfo {

    private static String empDept;
    private static String empName;
    private static String empDesg;

    public empInfo() {
    }

    public static void sqlq(String empno)
    {
    	Connection conn  = null;
        try {

              Class.forName("oracle.jdbc.driver.OracleDriver");
		          DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	            conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.111.107:1521:orcl2","production","prod");
              Statement stmt=conn.createStatement();

              ResultSet rs =stmt.executeQuery("select * from W_PERSONAL where EMPN = '"+empno+"' and status = 'A'");
              if(rs.next())
              {
              	empDept = rs.getString("DEPT");
		            empName = rs.getString("NAME");
              	empDesg = rs.getString("DESG");

              }
              else
              {
              	empDept = "NA";
		            empName = "NA";
              	empDesg = "NA";
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
    public static String getEmpDept()
    {
    	return(empDept);
    }

    public static String getEmpName()
    {
    	return(empName);
    }
    public static String getEmpDesg()
    {
    	return(empDesg);
    }

}