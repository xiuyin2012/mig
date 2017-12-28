<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>HOME</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta content="always" name="referrer">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
    <%@ include file="/pages/inc/taglibs.jsp" %>
    <%@ include file="/pages/inc/common.jsp" %>
    <%@ include file="/pages/inc/header.jsp" %>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  <script type="text/javascript">
/*   if(""==document.referrer){
     var user_id = "sys_home";
     var user_pwd = "sys_home";
   
                    $.ajax({
                         type:"POST",
                         async:false,
                          url:"<c:url value='/compManage/doLogin.do'/>",
                          data:{user_id:user_id,user_pwd:user_pwd},
                          dataType:"json",
                          success:function(resp){
                              if("1"==resp.success){
                                  window.location ="<c:url value='/compManage/toLogin.do'/>";
                              }
                              else{
                                  alert(resp.respText);
                                  window.location ="<c:url value='/compManage/toHome.do'/>";
                                  }
                         }
                      });
   } */
  </script>
  </head>
  <frameset cols="18%,*">
      <frame name="menu" src="<c:url value='/pages/menuTmp.jsp'/>" />
      <frame name="mainFrame" id="mainFrame" src="" style="background:#fcfcfc"/>
  </frameset>
<%--   <body>
  <%@ include file="/pages/menu.jsp" %>

  </body> --%>
</html>
