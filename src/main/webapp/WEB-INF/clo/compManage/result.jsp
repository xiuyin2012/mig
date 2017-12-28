<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'processSubmit.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">

	</script>

  </head>
  
  <body>
       <div align="left">
        here  
          <form action="clo/user"> 
             <input type="text" name="action" value="getUser"> 
             <input type="submit" name="submit"> 
          </form>
     </div>
     
     <table>
         <tr>
             <th>ID</th>
             <th>NAME</th>
         </tr>
        <c:if test="${null!=users}" > 
        <c:forEach var = "user" items="${users}" varStatus = "count">
         <tr>    
             
             <td><c:out value="${user.id }"/></td>
             <td><c:out value="${user.name}"/></td>
             <td><c:out value="${info }"/></td>
         </tr>
         </c:forEach>
        </c:if>
     </table>
  </body>
</html>