<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
    <meta charset="utf-8" />
    <%@ include file="/pages/inc/taglibs.jsp" %>
    <%@ include file="/pages/inc/common.jsp" %>
    <%@ include file="/pages/inc/header.jsp" %>
    <title></title>

</head>
<body>
<form id="initForm" name="initForm" action="<c:url value='/analysis/initData.do'/>" method="post">
    province path: <input type="text" name="provinceD" id="provinceD" value=""/><br>
    hall path: <input type="text" name="hallD" id="hallD" value=""/><br>
    game path: <input type="text" name="gameD" id="gameD" value=""/><br>
</form>
</br>
<input type="button" id="initDataButton" value="初始化"/><br>
<br>
注意：游戏、大厅、省份需要配置指定linux绝对路径，文件类型是txt,一旦初始化成功以后，以免异常不要再初始化
</body>
<script type="text/javascript">
    $(document).ready(function(){
        $("#initDataButton").click(function(){
            $.ajax({
                type: "POST",
                async: false,
                url:"<c:url value='/analysis/initData.do'/>",
                data:{provinceD:$("#provinceD").val(),hallD:$("#hallD").val(),gameD:$("#gameD").val()},
                dataType: "json",
                success: function (respData) {
                    if("1"==respData)alert("初始化成功");
                    else
                        alert("初始化失败");
                },
                error: function () {
                    //请求之后，响应不成功或者有错误执行
                }
            });
            //$("#initForm").submit();
        })
    });


</script>
</html>