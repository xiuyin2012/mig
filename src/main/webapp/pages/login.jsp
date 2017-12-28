<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>

<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta content="always" name="referrer">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta name="renderer" content="webkit">
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>
<title>cam</title>
<script>
//top.location.href="<c:url value='/compManage/toLogin.do'/>";
var page_status = $("#mainFrame",window.parent.document).attr("src");
if(undefined!=page_status){
     top.location.href="<c:url value='/compManage/toLogin.do'/>";
}
function r()
{

	var username=document.getElementById("username");

	var pass=document.getElementById("password");
	if(username.value=="")
	{
		alert("请输入用户名");
		username.focus();
		return;
	}
	if(pass.value=="")
	{
		alert("请输入密码");
		return;
	}
return true;
}
</script>
    <style>

    </style>
</head>
<body>

<div style="width:80%;height:100%;margin:auto;" >
<table width="100%" height="100%" >
   <tr>
     <td align="center" valign="center">
<%--       <form action="<c:url value='compManage/doLogin.do'/>" > --%>
       <table width="40%" height="10%" bgcolor="#e0e0e0" background="<c:url value='/img/55.jpg'/>">
          <tr><td style="font-size:14px;font-weight: bold;" align = "center"><font color="#f0f0f0">用户登录</font></td></tr>
       </table>
       <table width="40%" height="33%" bgcolor="#fcfcfc" background="<c:url value='/img/55.jpg'/>">
         <tr align=center>
			<td style="font-size:13px;"  width="40%"><li style="list-style-type:none"><font style="margin-left:50px" color="#f0f0f0">用户名</font></li></td><td align="left"><input type="text" name="user_id"  id="user_id" style="width:50%;margin-left:25px"></td>
		     </tr>
                     <tr align=center><td width="40%" style="font-size:13px;"><li style="list-style-type:none"><font style="margin-left:50px" color="#f0f0f0">密 码</font></li></td><td align="left"><input type="password" name="user_pwd" id="user_pwd" style="width:50%;margin-left:25px"></td></tr>
<!--                      <tr align=center><td>验证码</td><td><input type="text" name="yanzheng"></td></tr> -->
                     <tr align=center><td><input class="loginbtn" type="button" value="登 录" onclick="doLogin();" />     <input class="loginbtn" type="button" value="重 置" onclick="reSetFunc();" /></td></tr>
       </table>
       <!-- </form> -->
     </td>
   </tr>
</table>
</div>
</body>
  <script type="text/javascript">

    function doLogin(){
                 $.ajax({
                         type:"POST",
                          url:"<c:url value='/compManage/doLogin.do'/>",
                          data:{user_id:$("#user_id").val(),user_pwd:$("#user_pwd").val()},
                          dataType:"json",
                          success:function(resp){
                              if("1"==resp.success){
                                  window.location ="<c:url value='/compManage/toHome.do'/>";
                              }
                              else
                                  alert(resp.respText);
                         }
                      }); 
    }
    
    function reSetFunc(){
      $("#user_id").val('');
      $("#user_pwd").val('');
      $("#user_id").html('');
      $("#user_pwd").html('');
    }
    
    $(document).ready(function(){
            $("#user_pwd").keydown(function(event) {
                if (event.keyCode == "13") {//keyCode=13是回车键
                    doLogin();
                }
            });
    });
</script>
</html>