<%@ page import="java.sql.*" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page language="java"%> 
<%@page import="java.util.StringTokenizer" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.*"%>
<%@page import="java.io.*, java.util.Date, java.util.Enumeration" %>
<%!
 int year=0;
 int month=0;
 int day=0;
int a=0;
int y=0;
int d1=0;
int m=0;
Date date1=new Date();
Date date2=new Date();
%>
<!DOCTYPE html>
<html>
<head>
<link  href="css/st.css" rel="stylesheet" type="text/css">
<link  href="css/ta.css" rel="stylesheet" type="text/css">
<link href="style.css" rel="stylesheet" type="text/css" />
<title>InstaPlan</title>
</head>


<body>
<%! 
public boolean mydate(int y,int m,int d){
Date myDate = new Date();
myDate.setYear(y);
myDate.setMonth(m-1);
myDate.setDate(d-1);
if(myDate.getDay() == 6 || myDate.getDay() == 0)
	return true;
else
	return false;

}
%>
<%!
public int comp(int y,int m,int d,int y1,int m1,int d1)
{

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
try{
        	date1 = sdf.parse(y+"-"+m+"-"+d);
    		date2 = sdf.parse(y1+"-"+m1+"-"+d1);
	}
catch(Exception e){}
System.out.println(date1);
System.out.println(date2);
return ((date1.compareTo(date2)));
}
%>
<%!
public boolean holiday(int y,int m,int d){
String td=d+"/"+m+"/"+y;
String[] holidays={"1/1/2015","26/1/2015","1/5/2015","15/8/2015","2/10/2015","25/12/2015","15/1/2015","11/11/2015","25/12/2014","2/6/2015","1/1/2016","15/1/2016","26/1/2016","8/4/2016","1/5/2016","2/6/2016","8/7/2016","15/8/2016"};
for(int j=0;j<=17;j++)
{
	if(holidays[j].equals(td))
		return true;
}
return false;	
}
%>
<%!
public boolean edate(int y,int m,int d,int y1,int m1,int d1){
String date=d+"/"+m+"/"+y;
String date1=d1+"/"+m1+"/"+y1;
if(date.equals(date1))
		return true;
return false;
}
%>
<%!
public void inc(){
if((month==1||month==3||month==5||month==7||month==8||month==10)&&(day==31))
			{
				day=1;
				month++;
			}
			else if((month==4||month==6||month==9||month==11)&&(day==30))
			{
				day=1;
				month++;
			}
			else if((month==12)&&(day==31))
			{
				day=1;
				month=1;
				year++;
			}
			else if((month==2)&&(day>=28))
			{
				if(year%4==0 && day==29)
				{
					day=1;
					month++;	
				}
				else if(year%4==0 && day==28)
				{
					day++;
				}
				else
				{
					day=1;
					month++;
				}
			}
			else
			{
				day++;
			}
}
%>
<%!
public void inc1(){
if((m==1||m==3||m==5||m==7||m==8||m==10)&&(d1==31))
			{
				d1=1;
				m++;
			}
			else if((m==4||m==6||m==9||m==11)&&(d1==30))
			{
				d1=1;
				m++;
			}
			else if((m==12)&&(d1==31))
			{
				d1=1;
				m=1;
				y++;
			}
			else if((m==2)&&(d1>=28))
			{
				if(y%4==0 && d1==29)
				{
					d1=1;
					m++;	
				}
				else if(y%4==0 && d1==28)
				{
					d1++;
				}
				else
				{
					d1=1;
					m++;
				}
			}
			else
			{
				d1++;
			}
}
%>
<%
        String exportToExcel = request.getParameter("exportToExcel");
        if (exportToExcel != null
                && exportToExcel.toString().equalsIgnoreCase("YES")) {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "inline; filename="
                    + "Instaplanar.xls");
 
        }
    %>

<%String p=(request.getParameter("P"));
float tc=(Float.parseFloat(request.getParameter("TC")));
float r=(Float.parseFloat(request.getParameter("NR")));
float vel=(Float.parseFloat(request.getParameter("VR")));
float f=(Float.parseFloat(request.getParameter("F")));
int w=(Integer.parseInt(request.getParameter("WK")));
String start=(request.getParameter("start"));
String end=(request.getParameter("end"));
String[] tokens=new String[10];
StringTokenizer stkn=new StringTokenizer(start,"/");
int i=0;
while(stkn.hasMoreTokens())
	tokens[i++]=stkn.nextToken();
 month=(Integer.parseInt(tokens[0]));
 day=(Integer.parseInt(tokens[1]));
year=(Integer.parseInt(tokens[2]));

m=month;
 d1=day;
y=year;
StringTokenizer stkn1=new StringTokenizer(end,"/");
int q=0;
while(stkn1.hasMoreTokens())
	tokens[q++]=stkn1.nextToken();
int month1=(Integer.parseInt(tokens[0]));
int day1=(Integer.parseInt(tokens[1]));
int year1=(Integer.parseInt(tokens[2]));

float tf=Math.round((f*tc)/100);
float ttc=tc+tf;
float tt=Math.round((tc+tf)/(r*vel));
float dum=ttc;
float d=(r*vel);
int h=0;
int w1=w;
int s=comp(year,month,day,year1,month1,day1);
float tt1=tt;
%>

<%
for(h=1;comp(y,m,d1,year1,month1,day1)<=0||dum>0;h++)
{
	if(comp(y,m,d1,year1,month1,day1)<0)
	{	
		if(holiday(y,m,d1)){
			h--;
			inc1();
		}
		else if((mydate(year,month,day))&& w1>0)
		{
			inc1();
			dum=dum-d;
		}
		else if((mydate(year,month,day))&& w1==0)
		{
			inc1();
			h--;
		}
		else
		{
			dum=dum-d;
			inc1();
		}
	}
	else if(dum>0)
		{
			++tt1;
			h--;
			break;
		}
	else	
		break;
}
%>
<div id="topdiv">
	<div id="fields">
	 <font face=arial size=2 color=#FFFFFF> | &nbsp; &nbsp; <a href="#"><font face=arial size=2 color=#FFFFFF>About </font></a>&nbsp; &nbsp; | &nbsp; &nbsp; <b><a href="#" style="text-decoration: none;"> <font face=arial size=2 color=#FFFFFF>Connect</font> </a></b>&nbsp; &nbsp; | &nbsp; &nbsp; <a href="index.jsp?P=<%=request.getParameter("P")%>&TC=<%=((request.getParameter("TC")))%>&NR=<%=((request.getParameter("NR")))%>&VR=<%=((request.getParameter("VR")))%>&start=<%=(request.getParameter("start"))%>&end=<%=(request.getParameter("end"))%>&F=<%=((request.getParameter("F")))%>&WK=<%=((request.getParameter("WK")))%>" style="text-decoration: none;"><font face=arial size=2 color=#FFFFFF>Back</font></a></b>&nbsp; &nbsp; |&nbsp; &nbsp; <b><a href="Add.jsp?exportToExcel=YES&P=<%=request.getParameter("P")%>&TC=<%=(Float.parseFloat(request.getParameter("TC")))%>&NR=<%=(Float.parseFloat(request.getParameter("NR")))%>&VR=<%=(Float.parseFloat(request.getParameter("VR")))%>&start=<%=(request.getParameter("start"))%>&end=<%=(request.getParameter("end"))%>&F=<%=(Float.parseFloat(request.getParameter("F")))%>&WK=<%=(Integer.parseInt(request.getParameter("WK")))%>" style="text-decoration: none;"><font face=arial size=2 color=#FFFFFF>Export to Excel</font> </a></b> &nbsp; &nbsp; |&nbsp; &nbsp; </font>
	</div>
</div>
<div id="imag">
</div>
<div id="middle">
<font size="4"><font face="open Sans" >
<h5>Test Cycle Phase:<%=p%></h5><hr>
</font>
<font size="2"><font face="open Sans">
<table style="display:inline-block; border:0px" >
<col width="300">
<col width="100">
<caption >Summary:</caption>
    <tr bgcolor="AliceBlue">		
    <td>Total Test Cases with <%=f%>% Failure Rate:</td>
    <td><%=ttc%></td>
    </tr>
  <tr>
    <td >Number of Resources:</td>
    <td><%=r%></td>
  </tr>
    <tr bgcolor="AliceBlue">		
    <td>Velocity Per Day Per Resource:</td>
    <td><%=vel%></td>
  </tr>

<tr>
   		
    <td>Daily Count with <%=r%> Resources:</td>
    <td><%=r*vel%></td>
  </tr>


    <tr bgcolor="AliceBlue">		                       
    <td>Start Date:</td>
    <td><%=day%>-<%=month%>-<%=year%></td>
  </tr>
<tr>	                       
    <td>End Date:</td>
    <td><%=day1%>-<%=month1%>-<%=year1%></td>
  </tr>

   <tr bgcolor="AliceBlue">	
    <td> Number of weekends to include:</td>
    <td><%=w%></td>
  </tr>

</table>
<table style="width:30%; float:right;display:inline-block; border:0px">
<caption><p align="left">Legends:</p></caption>
    <tr bgcolor="#696969">		
    <td >Planned End Date</td>
    </tr>
  <tr bgcolor="#FF0000">
    <td >Actual Date if goes beyound End date</td>
  </tr>
  <tr bgcolor="#7FFF00">
    <td >Actual Date if Completed Prior to End date</td>
  </tr>
  <tr bgcolor="#FFA500">
    <td >Weekend</td>
  </tr>
 </tr>
  <tr bgcolor="#663300">
    <td >Public Holiday</td>
  </tr>
</table>
<hr>
<table style="width:35%">
<caption>Velocity Plan:</caption>
<col width="80">
<col width="120">
<col width="120">
<col width="120">
<tr><th>Day</th><th>Date</th><th>To Execute</th><th>Daily Plan</th></tr>
<%
for(;comp(year,month,day,year1,month1,day1)<=0||ttc>0;)
{
if(ttc>0){
for(a=1;a<=tt||ttc>0;a++)
{
	if(holiday(year,month,day))
	{
		if(comp(year,month,day,year1,month1,day1)==0 && ttc>0 && a<tt)
		{
			%>
			<tr bgcolor="#663300"><td bgcolor="#663300">Holiday</td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
			<%
			--a;
			inc();
		}
		else if(comp(year,month,day,year1,month1,day1)<0 && a>=tt)
		{
			%>
			<tr bgcolor="#663300"><td bgcolor="#663300">Holiday</td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
			<%
			--a;
			inc();
		}
		else if((comp(year,month,day,year1,month1,day1)==0) && a==tt)
		{
				%>
				<tr bgcolor="#663300"><td bgcolor="#663300">Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%
				--a;
				inc();
		}
		else
		{
			%>
			<tr bgcolor="#663300"><td>Holiday</td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
			<%
			--a;
			inc();
		}
	}
	else
	{

		if((mydate(year,month,day))&& w!=0)
		{
			if(comp(year,month,day,year1,month1,day1)==0 && ttc>0 && a<tt)
			{
				%>
				<tr bgcolor="#FF0000"><td>Day<%=a%>(WK)</td><td><%=day%>-<%=month%>-<%=year%></td><td ><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%w--;
				ttc=ttc-d;
			}
			
			else if(comp(year,month,day,year1,month1,day1)<0 && ttc<=d)
			{
				%>
				<tr bgcolor="#7FFF00"><td>Day<%=a%>(WK)</td><td><%=day%>-<%=month%>-<%=year%></td><td ><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%w--;
				ttc=ttc-d;
			}
			else if((comp(year,month,day,year1,month1,day1)==0) && a==tt)
			{
				%>
				<tr bgcolor="#696969"><td>Day<%=a%>(WK)</td><td><%=day%>-<%=month%>-<%=year%></td><td ><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%w--;
				ttc=ttc-d;
			}
			else
			{	
				%>
				<tr bgcolor="#FFA500"><td>Day<%=a%>(WK)</td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%w--;
				ttc=ttc-d;
			}
		}
		else if((mydate(year,month,day))&& w==0)
		{
			if((comp(year,month,day,year1,month1,day1)==0) && ttc>0 )
			{
				%>
				<tr bgcolor="#FF0000"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>N/A</td><td>N/A</td></tr>
				<%
				a--;
			}
			else if((comp(year,month,day,year1,month1,day1)<0) && ttc<=d && w!=0)
			{
				%>
				<tr bgcolor="#7FFF00"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>N/A</td><td>N/A</td></tr>
				<%
				a--;
			}
			else  if((comp(year,month,day,year1,month1,day1)==0) && ttc<=d && w!=0)
			{
				%>
				<tr bgcolor="#696969"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>N/A</td><td>N/A</td></tr>
				<%
				a--;
			}
			else
			{
				%>
				<tr bgcolor="#FFA500"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>N/A</td><td>N/A</td></tr>
				<%
				a--;
			}		
		}
		else
		{
			if((comp(year,month,day,year1,month1,day1)==0) && ttc>0 && a<tt)
			{
				%>
				<tr bgcolor="#FF0000"><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%
			}
			else if((comp(year,month,day,year1,month1,day1)<0) && ttc<=d)
			{
				%>
				<tr bgcolor="#7FFF00"><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%
			}
			else if((comp(year,month,day,year1,month1,day1)==0))
			{
				%>
				<tr bgcolor="#696969"><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%
			}
			else
			{
				%>
				<tr><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td><%=String.format("%.2f", ttc)%></td><td><%=String.format("%.2f", r*vel)%></td></tr>
				<%
			}
			ttc=ttc-d;
		}
		inc();
	}


}
}
else
{
	if(holiday(year,month,day))
	{
		%>
		<tr bgcolor="#663300"><td>Holiday</td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
		<%
		inc();
		
	}
	else if((mydate(year,month,day)))
	{
		if((comp(year,month,day,year1,month1,day1)==0))
		{
			%>
			<tr bgcolor="#696969"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
			<%
			inc();
		}
		else
		{
		
			%>
			<tr bgcolor="#FFA500"><td>Weekend</td><td><%=day%>-<%=month%>-<%=year%></td><td>N/A</td><td>N/A</td></tr>
			<%
			inc();
		}
	}
	else if((comp(year,month,day,year1,month1,day1)==0))
	{
		%>
		<tr bgcolor="#696969"><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
		<%
		inc();
		break;
	}
	else
	{
		%>
		<tr><td>Day<%=a%></td><td><%=day%>-<%=month%>-<%=year%></td><td>NA</td><td>NA</td></tr>
		<%
		inc();
	}
	a++;
}
}

%>
</table>
</font></font>
<%
        if (exportToExcel == null) {
    %>
 <%-- <center>  <a href="index.jsp?P=<%=request.getParameter("P")%>&TC=<%=((request.getParameter("TC")))%>&NR=<%=((request.getParameter("NR")))%>&VR=<%=((request.getParameter("VR")))%>&start=<%=(request.getParameter("start"))%>&end=<%=(request.getParameter("end"))%>&F=<%=((request.getParameter("F")))%>&WK=<%=((request.getParameter("WK")))%>" class="styled-button-5"  style="text-decoration: none;"><center>Back</center></a>&nbsp;&nbsp;&nbsp;<a class="styled-button-5" href="Add.jsp?exportToExcel=YES&P=<%=request.getParameter("P")%>&TC=<%=(Float.parseFloat(request.getParameter("TC")))%>&NR=<%=(Float.parseFloat(request.getParameter("NR")))%>&VR=<%=(Float.parseFloat(request.getParameter("VR")))%>&start=<%=(request.getParameter("start"))%>&end=<%=(request.getParameter("end"))%>&F=<%=(Float.parseFloat(request.getParameter("F")))%>&WK=<%=(Integer.parseInt(request.getParameter("WK")))%>" style="text-decoration: none;"><center>Export to Excel</center></a>&nbsp;&nbsp;&nbsp;</center>--%>
    <%
        }

    %>
</div>
  <!-- Footter Part Starts -->
  <div class="foote">
    <div class="ft_lft">
      <p>©  CSC 2015.  All Rights Reserved.</p>
    </div>
    <div class="ft_rht"><img src="csc_logo.gif" width=36 height=20 alt="" /></div>
  </div>
<br>  <!-- Footter Part Ends --> 
</body>
</html>