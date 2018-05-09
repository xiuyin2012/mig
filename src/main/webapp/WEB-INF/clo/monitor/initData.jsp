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
注意：按指定文本数据结构导入linux下的文件绝对路径,一旦初始化成功后避免异常关闭开关
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
                    if("0"==respData)alert("redis初始化开关没打开");
                    if("1"==respData)alert("初始化成功");
                    if("2"==respData)alert("redis connection failure");

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