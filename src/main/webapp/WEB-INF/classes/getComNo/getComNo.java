package getComNo;

import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.sql.*;

public class getComNo 
{
    private String comno;

    public getComNo()
    {
    }
    public void sqlq()
	{
		Connection conn  = null;    
     try {
          Class.forName("oracle.jdbc.driver.OracleDriver");
            DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());	
	          conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:orcl","production","prod");
	             Statement stmt=conn.createStatement();
	               stmt=conn.createStatement();
                     					 
					 ResultSet rs = stmt.executeQuery("select nvl(max(COMNO),0)+1 comn from COMMITTEE");
	                           if(rs.next())
	                              {
                                   comno=rs.getString("comn");
                                  } 
                                else
                                  {
              	                   comno = "1";
                                  }
                                                        
         }//end of try block
              
                 catch(SQLException e) 
                  {
                   System.out.println("SQLException : "+ e.getMessage() + "<BR>");
                   while((e = e.getNextException()) != null)
                   System.out.println(e.getMessage() + "<BR>");
                  }
                catch(ClassNotFoundException e) 
                  {
                   System.out.println("ClassNotFoundexception :" + e.getMessage() + "<BR>");
                  }
               finally
                {
                  if(conn != null)
                   {
                      try
                         {
                           conn.close();
                         }
                     catch (Exception ignored) {}
                   }
                }//end of finally
	}

	public String getInput()
	{
		return(comno);
	}
}
