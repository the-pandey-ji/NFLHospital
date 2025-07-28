package getDoc;

/*package getDoc;*/


import java.math.*;
import java.util.*;
import java.io.*;
import java.lang.*;
import java.sql.*;

public class getSno 
   {
      public static int count;
	  public static int count1;
      public static String[] sNo;
	  public static String[] srNo;

      public getSno()
        {
    	  int i=0;
		  int j=0;
    	  Connection conn  = null;
          try 
             {
                Class.forName("oracle.jdbc.driver.OracleDriver");
		        DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
	            conn =DriverManager.getConnection("jdbc:oracle:thin:@10.3.126.84:1521:orcl","hospital","hospital");
				Statement stmt=conn.createStatement();
                ResultSet rs = stmt.executeQuery("select code, doctor_name from DOCTOR order by code");
                 while(rs.next())
                   {
              	      i++;
					  j++;
                   }
                 count = i;
				 count1 =j;

                 sNo = new String[count];
				 srNo = new String[count1];
                 i=0;
				 j=0;

                ResultSet rsdata = stmt.executeQuery("select code, doctor_name from DOCTOR order by code");
                 while(rsdata.next())
                   {
              	      sNo[i] = rsdata.getString(1);
              	      i++;
					  srNo[j] = rsdata.getString(2);
              	      j++;
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
	//	return(srNo);
	}
	public static int getCount()
	{
		return(count);
	//	return(count1);
	}
}

