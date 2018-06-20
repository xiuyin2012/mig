<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "https://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang = "zh-CN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <%@ include file="/pages/inc/taglibs.jsp" %>
    <%@ include file="/pages/inc/common.jsp" %>
    <%@ include file="/pages/inc/header.jsp" %>
    <title></title>

</head>
<body>
<form id="initForm" name="initForm" action="<c:url value='/analysis/initPage.do'/>">
    screenX:  <input type="text" name="screenX" id="screenX" value=""/>
    screenY:  <input type="text" name="screenY" id="screenY" value=""/>

    <input type="submit" value="" id="screenSubmit" name="screenSubmit" onclick="screenSubmitClick();" style = "width:100px"/>
</form>
</body>
<script type="text/javascript">
    function screenSubmitClick(){
        $("#initForm").submit();
    }
    /*    $(document).ready(function(){
     $("#initForm").submit();
     });*/
</script>
</html>
