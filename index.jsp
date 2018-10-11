<%!
String P ="";
String TC ="";
String NR ="";
String VR="";
String start="";
String end="";
String F="";
String WK="";

%>

<html>
<head>

<style>
html { 
  background: url(Trans_bg.jpg) no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}

.table1 {
background: rgba(102,45,145,0.5);
}
</style>

<link href="style.css" rel="stylesheet" type="text/css" />
<link  href="css/st.css" rel="stylesheet" type="text/css">
<%@page import="javax.mail.*"%>
<script type="text/javascript">
function testResults(form){
var TestVar=form.submit();
}
function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}
function isNumberKey(evt)
       {
          var charCode = (evt.which) ? evt.which : evt.keyCode;
          if (charCode != 46 && charCode > 31 
            && (charCode < 49 || charCode > 57))
             return false;

          return true;
       }
</script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
<SCRIPT type=”text/javascript” src=”http://lfov.net/loopfuse-ext/required/required.js”>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
 <link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css"/>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script>
  
  <script>
  $(document).ready(function() {
    $("#datepicker,#datepicker1").datepicker();
  });
  </script>
<title>InstaPlan</title>
</head>

<body background=Trans_bg1.jpg topmargin=0 leftmargin=0 rightmargin=0>

<div id="topdiv">
	<div id="fields">
	 <font face=arial size=2 color=#FFFFFF> | &nbsp; &nbsp; <a href="#"><font face=arial size=2 color=#FFFFFF>About </font></a>&nbsp; &nbsp; | &nbsp; &nbsp; <b><a href="#" style="text-decoration: none;"> <font face=arial size=2 color=#FFFFFF>Connect</font> </a></b>&nbsp; &nbsp; | &nbsp; &nbsp; <a href="#" style="text-decoration: none;"><font face=arial size=2 color=#FFFFFF>Help</font></a> &nbsp; &nbsp; |&nbsp; &nbsp; </font>
	</div>
</div>
<div id="imag">
</div>




<center style="  padding: 90px 0;"> <br><br><br>
<%
 P = (String) request.getParameter("P");
if(P==null ){
P="";
}
 TC = (String) request.getParameter("TC");
if(TC==null ){
TC="";
}
NR = (String) request.getParameter("NR");
if(NR==null ){
NR="";
}
VR = (String) request.getParameter("VR");
if(VR==null ){
VR="";
}
start = (String) request.getParameter("start");
if(start==null ){
start="";
}
 end = (String) request.getParameter("end");
if(end==null ){
end="";
}
 F = (String) request.getParameter("F");
if(F==null ){
F="";
}
WK = (String) request.getParameter("WK");
if(WK==null ){
WK="";
}

%>
<form id="form" action="./Add.jsp">
<table style="background: rgba(125,92,72,0.5);border-radius:10px;-moz-border-radius:10px;-webkit-border-radius:10px;" width=870 height=270 cellpadding=10 cellspacing=10>
 <tr>
  <td valign=top>
    <table bgcolor=#FFFFFF width=100% style="border-radius:10px;-moz-border-radius:10px;-webkit-border-radius:10px;">
	<tr>
	  <td width=100% valign=middle> 

<div class="plan_wraper"> 
  <div class="plan_inr">
    <div class="plan-main">
      <div class="plan-form"> 
        <div class="plan-right">
          <div class="plan-right-input">
<table width=100%>
  <tr>
    <td width=25%> <font face="open Sans" size=2> Test Phase  <input type="text" name="P" value="<%=P%>" required="required" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> Pending Test Cases <input type="text" name="TC" value="<%=TC%>" required="required"  onkeypress="return isNumber(event)" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> Total Resources <input type="text" name="NR" value="<%=NR%>" required="required"  onkeypress="return isNumber(event)" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> Resource Velocity <input type="text" name="VR" value="<%=VR%>" required="required" onkeypress="returnisNumberKey(event)" placeholder=""/> </font> </td>
  </tr>
  <tr>
    <td width=25%> <font face="open Sans" size=2> Start Date <input id="datepicker1" name="start" value="<%=start%>" required="required" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> End Date <input id="datepicker" name="end" value="<%=end%>" required="required" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> Failure% <input type="text" name="F" value="<%=F%>" required="required"  onkeypress="return isNumber(event)" placeholder=""/> </font> </td>
    <td width=25%> <font face="open Sans" size=2> #Weekends to include <input type="text" name="WK" required="required"  onkeypress="return isNumber(event)" value="<%=WK%>" placeholder=""/> </font> </td>
  </tr>
</table> 
          </div>
        </div>
      </div>
    </div>
  </div>
</div>


	  </td> 
        </tr>

    </table>
  </td>
 </tr>
<tr align=center>
<td><input type=submit value="Generate" class="styled-button-5">&nbsp;&nbsp;<a href='index.jsp' class="styled-button-5" style="text-decoration: none;"><center>Reset</center></a></td> </tr>
</table>
<form>
</center>

  <!-- Footter Part Starts -->
  <div class="footer">
    <div class="ftr_lft">
      <p>©  CSC 2015.  All Rights Reserved.</p>
    </div>
    <div class="ftr_rht"><img src="csc_logo.gif" width=36 height=20 alt="" /></div>
  </div>
<br>  <!-- Footter Part Ends --> 
</body>
</html>