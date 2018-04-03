<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <meta charset="utf-8" />
    <%@ include file="/pages/inc/taglibs.jsp" %>
    <%@ include file="/pages/inc/common.jsp" %>
    <%@ include file="/pages/inc/header.jsp" %>
    <title>中彩在线</title>

</head>
<body>
<form id="initForm" name="initForm" action="<c:url value='/analysis/initPage.do'/>">
</form>
</body>
<script type="text/javascript">
    $(document).ready(function(){
        $("#initForm").submit();
    });
</script>
</html>
