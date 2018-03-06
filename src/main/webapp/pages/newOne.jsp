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

    </script>
    <style>
        .onepic_wrap img{ width: 100%; height: 100%;}

    </style>
</head>
<body>

        <div class="onepic_wrap">
            <img src="<c:url value='/img/zc.jpg'/>"/>

        </div>

</body>
<script type="text/javascript">
    $(function() {
        $.ajax({

            type:"POST",
            async:false,
            url:"<c:url value='/analysis/geTransByPro.do'/>",
            data:{},
            dataType:"json",
            success:function(data){
                //ewJsonData = data;
            }
        });

        $.ajax({

            type:"POST",
            async:false,
            url:"<c:url value='/analysis/ratioByGameBET.do'/>",
            data:{},
            dataType:"json",
            success:function(data){
                //ewJsonData = data;
            }
        });

        $.ajax({

            type:"POST",
            async:false,
            url:"<c:url value='/analysis/getTotalBETbyScore.do'/>",
            data:{},
            dataType:"json",
            success:function(data){
                //ewJsonData = data;
            }
        });

        $.ajax({

            type:"POST",
            async:false,
            url:"<c:url value='/analysis/getHallListByAmount.do'/>",
            data:{},
            dataType:"json",
            success:function(data){
                //ewJsonData = data;
            }
        });

        $.ajax({

            type:"POST",
            async:false,
            url:"<c:url value='/analysis/getFinalAmount.do'/>",
            data:{},
            dataType:"json",
            success:function(data){
                //ewJsonData = data;
            }
        });

    });
</script>
</html>
