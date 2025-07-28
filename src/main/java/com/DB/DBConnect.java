package com.DB;

import java.sql.Connection;

public class DBConnect {
	
	private static Connection con;
	private static Connection con1;
	
	public static Connection getConnection() {
		
		  try { Class.forName("oracle.jdbc.driver.OracleDriver"); 
		  String url =
		  "jdbc:oracle:thin:@10.3.126.84:1521:ORCL"; 
		  con =
		  java.sql.DriverManager.getConnection(url,"HOSPITAL","HOSPITAL");

		 
		  } catch (Exception e) { e.printStackTrace(); }
		 

		
		
		return con;
	}
	public static Connection getConnection1() {
		
		  try { Class.forName("oracle.jdbc.driver.OracleDriver"); 
		  String url =
		  "jdbc:oracle:thin:@10.3.126.84:1521:ORCL"; 
	
		  con1 =
				  java.sql.DriverManager.getConnection(url,"PERSONNEL","PERSONNEL");
		 System.out.println("Connection Established Successfully");
		 
		  } catch (Exception e) { e.printStackTrace(); }
		 

		
		
		return con1;
	}

}
