package getComNo;

import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.sql.*;

public class getComNo {
    public static int comno;

    public getComNo()
    {
    }
    public static void sqlq()
	{
		Connection conn  = null;
		  try
		  {
              Class.forName("oracle.jdbc.driver.OracleDriver");
		      DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	          conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:orcl2","production","prod");
              Statement stmt=conn.createStatement();

              ResultSet rs = stmt.executeQuery("select nvl(max(COMMITTEENUMBER),0)+1 comn from OVERVIEWER");
              if(rs.next())
              {
              	comno = rs.getInt("comn");
              }
              else
              {
              	comno = 1;
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

	public static int getInput()
	{
		return(comno);
	}
}
