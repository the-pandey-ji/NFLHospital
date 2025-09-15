<%@ page language="java" session="true"%>
<%@ page import="java.math.*" %>
<%@ page import="oracle.jdbc.driver.*" %>
<%@ page contentType="text/html;charset=iso-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.io.*" %>
<%@ page import="com.DB.DBConnect" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>Medical Examination for NFL Employee</title>
<style type="text/css" media="print">
.printbutton 
   {
      visibility: hidden;
      display: none;
   }
</style>
</head>
<body>
<% 
	String empn = request.getParameter("empn");
	String name = "";
	String dt = "";
	String sex = "";
	int age = 0;
	int medno=0;
	int meno =0;
	int sr1=0,sr2=0;
	
	
				
    Connection con1  = null, con = null;    
    try 
        {
           con1 = DBConnect.getConnection1(); 
           Statement stmt1=con1.createStatement();
           
           con = DBConnect.getConnection();
           Statement stmt=con.createStatement();
           
	          ResultSet rs = stmt1.executeQuery("select ename,sex,to_char(sysdate,'yyyy')-(to_char(birthdate,'yyyy')),to_char(sysdate,'dd-mm-yyyy') from employeemaster where empn="+empn);
               while(rs.next())  
                    {
                         name = rs.getString("ENAME");
                         sex = rs.getString("SEX");
                         age = rs.getInt(3);
                         dt = rs.getString(4);
                    }
              ResultSet rs1 = stmt.executeQuery("select max(meno) from MEDEXAM");
	             if(rs1 != null)
	               {
	                  while(rs1.next())
	                      {
	                        meno = rs1.getInt(1);
	                        sr2=meno;
	                        sr1=sr2+1; 
                          }
                   }
                 else
                   {
                      sr1=1;
                   }
                   
             ResultSet rs3 = stmt.executeQuery("insert into MEDEXAM(MENO, NAME, EMPN, AGE, SEX, dated) values('"+sr1+"','"+name+"','"+empn+"','"+age+"','"+sex+"',to_char(sysdate,'dd-mm-yyyy'))");
               
            
   
         } //end of try block
           catch(SQLException e) 
		    {
                   System.out.println("SQLException : "+ e.getMessage());
                   while((e = e.getNextException()) != null)
                   System.out.println(e.getMessage());
            }
            
            finally
			    {
                   if(con1 != null) 
				    {
                       try
					       {
                              con1.close();
                           }
                       catch (Exception ignored) {}
                    }
                }
 %>
  <!--alert(<%=empn%>,<%=name%>,<%=dt%>,<%=sex%>,<%=age%>,<%=meno%>);--> 
              
 <p style="line-height: 70%; margin-top: 0; margin-bottom: -10" align="left"><font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; National
 Fertilizers Limited</font></p>
 <p style="line-height: 70%; margin-bottom: -10" align="left"><font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Panipat
 Unit: Medical department</font></p>
 <p style="line-height: 70%" align="left"><b><font face="Arial">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Medical
 Examination Proforma</font></b></p>
 <div align="center" style="width: 758; height: 776">
  
  <table border="1" width="73%" height="53">
    <tr>
      <td width="67%" height="18" align="center" style="border-style: solid; border-width: 1" colspan="2">
        <p align="left">Med. Exam. Date : <%=dt%></td>
  <center>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Med.Exam. No. :<%=sr1%></font></td>
    </tr>
    <tr>
      <td width="5%" height="18" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">1.</font></td>
      <td width="62%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Name</font></td>
      <td width="50%" height="18" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=name%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">2.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.
        Code</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=empn%></font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">3.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Department</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">4.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Age&nbsp;&nbsp;</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2"><%=age%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sex&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=sex%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">5.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">Height</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">
      <font face="Arial" size="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Weight</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2"> 6.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Investigation</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)Hb.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)Urine</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Alb.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Sugar</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)Blood Group</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)X-ray Chest</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)E.C.G. above 40 years</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="22" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="22" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)Any other investigation if required</font></td>
      <td width="50%" height="22" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="20" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">7.</font></td>
      <td width="62%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Medical</font></td>
      <td width="50%" height="20" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)Pulse</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)B.P.</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)Heart</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)Lung</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">e)Abdomen</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">f)Any other Medical Problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">8.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Surgical</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)Hernia</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)Hydrocele</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)Piles</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">d)Any other surgical problem</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">9.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">.</font></td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">a)Near Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">b)Distant Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">c)Colour Vision</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">10.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">E.N. T. Check up</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">11.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Gynae &amp; Obst checkup for females</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">.</td>
    </tr>
    <tr>
      <td width="5%" height="19" align="center" style="border-style: solid; border-width: 1"><font face="Arial" size="2">12.</font></td>
      <td width="62%" height="19" style="border-style: solid; border-width: 1"><font face="Arial" size="2">Remarks</font></td>
      <td width="50%" height="19" style="border-style: solid; border-width: 1">
      <p style="margin-bottom: -3"><font face="Arial" size="2">Fit/Unfit/Need Treatment/Any other</font></td>
    </tr>
  </table>
   </center>
 </div>
 <p align="left" style="margin-top: 10; margin-bottom: 0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
 (Medical Officer)</p>
 <p style="margin-top: 0; margin-bottom: -5">&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 NFL Hospital Panipat Unit</p>
 <p style="margin-top: 0; margin-bottom: -5">&nbsp;</p>
 <p style="margin-top: 0; margin-bottom: -5">&nbsp;&nbsp;&nbsp;<i>&nbsp;&nbsp;
 Note: After completion of Med. Exam., this is to be deposited at Hospital reception/office for record.</i></p>
 <p align="center"><i><script>
document.write("<input type='button' " +
"onClick='window.print()' " +
"class='printbutton' " +
"value='Print This Page'/>");
 </script>
 </i>
</p>
</body>
</html>