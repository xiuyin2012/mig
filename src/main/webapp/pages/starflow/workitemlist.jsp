<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'workitemlist.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <form action="starflow/workitem"> 
        <input type="text" name="action" value="workitemList"> 
        <input type="text" name="personUuid" value="4089eb9217bf2f9d0117bf48c431000c">
        <input type="submit" name="submit">
     </form>
getworkitem:
     <form action="starflow/workitem"> 
        <input type="text" name="action" value="getWorkitem"> 
        <input type="text" name="personUuid" value="4089eb9217bf2f9d0117bf48c431000c">
        <input type="text" name="id" value="40890f8d42211df20142211df3c50002">
        <input type="text" name="commentScope" value="all">
        <input type="submit" name="submit">
     </form>
commitworkitem:
     <form action="starflow/workitem"> 
        <input type="text" name="action" value="complete"> 
        <input type="text" name="personUuid" value="4089eb9217bf2f9d0117bf48c431000c">
        <input type="text" name="id" value="40890f8d42211df20142211df3c50002">
        <input type="submit" name="submit">
     </form>  
delegateworkitem:
     <form action="starflow/workitem"> 
        <input type="text" name="action" value="delegate"> 
        <input type="text" name="personUuid" value="4089eb9217bf2f9d0117bf48c431000c">
        <input type="text" name="id" value="40890f8d42211df20142211df3c50002">
        <input type="submit" name="submit">
     </form>  
  </body>
</html>
