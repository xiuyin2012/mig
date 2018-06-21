<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML>

<html>
<head>
    <meta charset="utf-8" />
    <%@ include file="/pages/inc/taglibs.jsp" %>
    <%@ include file="/pages/inc/common.jsp" %>
    <%@ include file="/pages/inc/header.jsp" %>
    <title>中彩在线</title>

    <link rel="stylesheet" type="text/css" href="<c:url value='/js/jqplot/jquery.jqplot.min.css'/>"/>
    <script type="text/javascript" src="<c:url value='/js/jqplot/jQuery.js'/>"></script>


    <script type="text/javascript" src="<c:url value='/js/jqplot/jquery.jqplot.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.pieRenderer.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.canvasTextRenderer.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.canvasAxisLabelRenderer.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.categoryAxisRenderer.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.barRenderer.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.pieRenderer.min.js'/>"></script>
    <script type="text/javascript" src="<c:url value='/js/jqplot/plugins/jqplot.donutRenderer.min.js'/>"></script>
    <style>
        * { padding: 0; margin: 0; }
        table {
            border-collapse: collapse;
            border-spacing: 0;
            border: 0px solid #ffffff;
        }
        th,td {
            border: 0px solid #ffffff;
        //color: #404060;
            padding: 1px;//表格上下间距
        width:92px;
        }
        th {
            background-color: #ffffff;
            font: bold 12px "微软雅黑";
            color: #ffffff;
        }
        td {
            font: 12px "微软雅黑";
        }
        tbody tr {
        //background-color: #ffffff;
        }
        tbody tr:hover {
            cursor: pointer;
        // background-color: #fafafa;
        }

        body {

            /* 加载背景图 */

            background-image: url(<c:url value='/img/star.jpg'/>);

        }

        .no{
            position: absolute;
            width:283px;
            height: 4px;
        }
        .no1{
            left: 114px;
            top: 209px;
        }
        .no2{
            left: 989px;
            top: 552px;
        }
        .no3{	left: 943px;	top: 161px		}
        .no4{	left: 85px;	top: 509px}
        .no5{	left: 547px;	top: 415px ;font: bold 36px "微软雅黑";color: #ffff00;
        //text-shadow: 5px -2px 4px #000000;
        //text-shadow: 5px -2px 4px #000000;
        }
        .no6{
            left: 1064px;
            top: 70px;
            font: bold 18px "微软雅黑";
        }
        .ellipsis_div{
            max-width:137px;
            overflow:hidden;
            text-overflow:ellipsis;
            white-space:nowrap;
            -o-text-overflow: ellipsis; /* for Opera */
        }
    </style>
    <script type="text/javascript">
        //左一表格
        var zhu_temp;
        var plot1;
        var data=[],data2=[];
        var screenVarWidth = 1920;
        var screenVarHeight = 1080;

        var leftRatio = Math.floor(screenVarWidth*10000/1366)/10000;
        var topRatio = Math.floor(screenVarHeight*10000/800)/10000;



        function leftOne() {
            $.ajax({
                type: "POST",
                async: false,
                url:"<c:url value='/analysis/geTransByPro.do'/>",
                data:{},
                dataType: "json",
                success: function (respData) {
                    data = respData;
                    leftOneRender();
                },
                error: function () {
                    //请求之后，响应不成功或者有错误执行
                    leftOneRender();
                }
            });
        }

        //右二饼图
        function pieDataRender(){
            //("右二");
            var chartData = [{"name":"","id":"","ratio":""}];
            /*            var tempJson=[{"name":"四花选五","id":"13","ratio":"3"},{"name":"开心一刻","id":"12","ratio":"7"},
             {"name":"幸运五彩","id":"11","ratio":"2.5"},{"name":"三江风光","id":"21","ratio":"6"},
             {"name":"好运射击","id":"25","ratio":"5"},{"name":"趣味高尔夫","id":"26","ratio":"4"},
             {"name":"连环夺宝","id":"24","ratio":"5"}];*/
            $.ajax({
                type:"POST",
                async:false,
                url:"<c:url value='/analysis/ratioByGameBET.do'/>",
                data:{},
                dataType:"json",
                success:function(dataResp){
                    /*                    var tempJson=[{"name":"四花选五","id":"13","ratio":"3"},{"name":"开心一刻","id":"12","ratio":"7"},
                     {"name":"幸运五彩","id":"11","ratio":"2.5"},{"name":"三江风光","id":"21","ratio":"6"},
                     {"name":"好运射击","id":"25","ratio":"5"},{"name":"趣味高尔夫","id":"26","ratio":"4"},
                     {"name":"连环夺宝","id":"24","ratio":"5"}];*/
                    if(plot1){
                        plot1.destroy();
                    }
                    if(null!=dataResp&&dataResp.length>0){
                        chartData.splice(0,chartData.length);
                        $.each(dataResp,function(index,value){
                            chartData.push([dataResp[index].name,parseFloat(dataResp[index].ratio)]);
                        });
                    }
                },
                error : function() {
                    //请求之后，响应不成功或者有错误执行
                    var tempJson=[{"name":"四花选五","id":"13","ratio":"3"},{"name":"开心一刻","id":"12","ratio":"7"},
                        {"name":"幸运五彩","id":"11","ratio":"2.5"},{"name":"三江风光","id":"21","ratio":"6"},
                        {"name":"好运射击","id":"25","ratio":"5"},{"name":"趣味高尔夫","id":"26","ratio":"4"},
                        {"name":"连环夺宝","id":"24","ratio":"5"}];
                    /*                                        if(null!=tempJson&&tempJson.length>0){
                     chartData.splice(0,chartData.length);
                     $.each(tempJson,function(index,value){
                     chartData.push([tempJson[index].name,parseFloat(tempJson[index].ratio)]);
                     });
                     }*/
                }
            });
            return [chartData];
        }
        //左三柱状图
        var respData= new Array();
        for(j=1;j<21;j++){
            var tempArray = new Array();
            tempArray.push((j*10).toString());
            tempArray.push(0);
            respData.push(tempArray);
        }
        function barRender(){
            //var testData = [{"score":"30","amount":"30"},{"score":"10","amount":"50"},{"score":"20","amount":"20"}];
            $.ajax({
                type:"POST",
                async:false,
                url:"<c:url value='/analysis/getTotalBETbyScore.do'/>",
                data:{},
                dataType:"json",
                success:function(dataResp){
                    if(zhu_temp){
                        zhu_temp.destroy();
                    }
                    for(o=0;o<20;o++){
                        respData[o][1]=0;
                    }
                    if(null!=dataResp&&dataResp.length>0){
                        //respData.splice(0,respData.length);
                        $.each(dataResp,function(index,value){
                            for(i=0;i<respData.length;i++){
                                if(respData[i][0]==dataResp[index]["score"]){
                                    respData[i][1]=parseFloat(dataResp[index]["amount"]);
                                }
                            }
                        });
                    }
                },
                error : function() {
                    /*                   if(null!=testData&&testData.length>0){
                     //respData.splice(0,respData.length);
                     $.each(testData,function(index,value){
                     for(i=0;i<respData.length;i++){
                     if(respData[i][0]==testData[index]["score"]){
                     respData[i][1]=parseFloat(testData[index]["amount"]);
                     }
                     }
                     });
                     }*/
                    //请求之后，响应不成功或者有错误执行
                }
            });
            return [respData];
        }

        //右四表格
        function rightFour() {
            $.ajax({
                type:"POST",
                async:false,
                url:"<c:url value='/analysis/getHallListByAmount.do'/>",
                data:{},
                dataType:"json",
                success:function(dataResp){
                    data2=dataResp;
                    rightFourRender();
                },
                error : function() {
                    //请求之后，响应不成功或者有错误执行
                    rightFourRender();
                }
            });
        }
        //中间统计数据
        function middleData() {
            $.ajax({
                type:"POST",
                async:false,
                url:"<c:url value='/analysis/getFinalAmount.do'/>",
                data:{},
                dataType:"json",
                success:function(dataResp2){
                    //$("#d5").html("<font size='6' color='yellow'>"+dataResp2+"元</font>");
                    $("#d5").html(dataResp2+"元");

                },
                error : function() {
                    //请求之后，响应不成功或者有错误执行
                    // $("#d5").html(18500+"元");
                }
            });
        }
        //$(function() {
        //width,height ratio
        $(document).ready(function(){
            //rendor entirelys

            if($("#screenX").val()==1920&&$("#screenY").val()==1080){
                /*                $("#total").css("background");
                 $("#total").css("width","1920px");
                 $("#total").css("height","1080px");*/
                $(".no1").css("left","190px");
                $(".no2").css("left","1070px");
                $(".no3").css("left","1010px");
                $(".no5").css("left","620px");
                $(".no4").css("left","150px");
                $(".no4").css("top","500px");
            }

            leftOne();//左一表格
            bingtu();//右二饼图
            zhuzhuangtu();//左三柱状图
            rightFour();//右四表格
            middleData();//中间统计数据
            setInterval("leftOne()",4000);
            setInterval("bingtu()",4000);
            setInterval("zhuzhuangtu()",4000);
            setInterval("rightFour()",4000);
            setInterval("middleData()",4000);

        });
    </script>
    <script type="text/javascript" language="javascript">
        //左一和右下列表
        function leftOneRender() {
            // 动态创建表格，使用动态创建dom对象的方式
            //清空所有的子节点
            $("#div1").empty();
            var intlen = 10;
            //data=[{"name":"beijing","amount":1900},{"name":"shanghai","amount":1500}];
            if(null!=data&&data.length<10)intlen = data.length;
            for (var i = 0; i < intlen; i++) {
                //动态创建一个tr行标签,并且转换成jQuery对象
                var $trTemp1 = $("<tr></tr>");
                //往行里面追加 td单元格
                var localInt = i + 1;
                $trTemp1.append("<td width='92'  align='left'>" + localInt + "</td>");
                $trTemp1.append("<td width='107' align='left'>" + data[i].name + "</td>");
                $trTemp1.append("<td width='102' align='left'>" + data[i].amount + "</td>");
                $trTemp1.appendTo("#div1");
                //data=[{"name":beijing,"amount":1900},{"name":shanghai,"amount":1500}];
            }
        }
        function rightFourRender() {
            // 动态创建表格，使用动态创建dom对象的方式
            //清空所有的子节点
            //data2=[{"hallNm":"beijing","amount":1900},{"hallNm":"shanghai","amount":1500}];
            $("#div2").empty();
            var intlen = 10;
            if(null!=data2&&data2.length<10)intlen = data2.length;
            for (var i = 0; i < intlen; i++) {
                //动态创建一个tr行标签,并且转换成jQuery对象
                var $trTemp = $("<tr></tr>");
                //往行里面追加 td单元格
                var localInt = i+1
                $trTemp.append("<td width='62'  align='left'>"+ localInt +"</td>");
                $trTemp.append("<td width='137' align='left' class='ellipsis_div' title='"+data2[i].hallNm+"'>"+ data2[i].hallNm +"</td>");
                $trTemp.append("<td width='102' align='left'>"+ data2[i].amount +"</td>");
                $trTemp.appendTo("#div2");
            }
        }
    </script>

    <script type="text/javascript" language="javascript">
        //饼图
        function bingtu() {
            //$(document).ready(function(){
            var dataN=[['四花选五',3],['开心一刻',7],['幸运五彩',2.5],['三江风光',6],['好运射击',5],['趣味高尔夫',4],['连环夺宝',5]];
            //alert(dataN);
            plot1 = $.jqplot('d3', [dataN], {
                title:' ',//设置饼状图的标题
                dataRenderer:pieDataRender,
                grid:{
                    background:'rgba(0,0,0,0)',
                    //background: '#00dd00',      // 设置整个图表区域的背景色
                    borderWidth: 0,           //设置图表的（最外侧）边框宽度
                    shadow: true,               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果
                    shadowAngle: 45,            // 设置阴影区域的角度，从x轴顺时针方向旋转
                    shadowOffset: 0,          // 设置阴影区域偏移出图片边框的距离
                    shadowWidth: 0,             // 设置阴影区域的宽度
                    shadowDepth: 0,             // 设置影音区域重叠阴影的数量
                    shadowAlpha: 0.07           // 设置阴影区域的透明度

                },
                //seriesColors:["#1566c3", "#1976d6", "#2e90e6", "#41a6f3", "#66b5f3", "#88c4f6","#9bd2fc" ], //设置饼图每个区域颜色

                seriesColors:["#9a7de6","#ff628c", "#71dec4", "#b5dcb4", "#ffd8a3", "#ff9b97", "#78b0ed"],  //设置饼图每个区域颜色

                seriesDefaults: {
                    renderer:$.jqplot.PieRenderer,
                    rendererOptions:{
                        showDataLabels: true,
                        diameter: undefined, // 设置饼的直径
                        padding: 10,        // 饼距离其分类名称框或者图表边框的距离，变相该表饼的直径
                        sliceMargin: 0,     // 饼的每个部分之间的距离
                        fill:true,         // 设置饼的每部分被填充的状态
                        shadow:false,       //为饼的每个部分的边框设置阴影，以突出其立体效果
                        showMark:true //设置是否显示刻
                    }
                },
                legend:{
                    border: '0px' ,
                    show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）
                    location: 'nw',     // 分类名称框出现位置, nw, n, ne, e, se, s, sw, w.
                    xoffset: 10,        // 分类名称框距图表区域上边框的距离（单位px）
                    yoffset: 30,        // 分类名称框距图表区域左边框的距离(单位px)
                    background:'rgba(0,0,0,0)',//分类名称框距图表区域背景色
                    textColor:'ffffff' //分类名称框距图表区域内字体颜色
                }
            });

        }

    </script>

    <script type="text/javascript">

        function zhuzhuangtu() {
            zhu_temp=$.jqplot('d4', [{"score":"0","amount":"0"}], {
                title: '',
                dataRenderer: barRender,
                grid: {
                    background:'rgba(0,0,0,0)',
                    drawGridLines: true,
                    gridLineColor: '#',    // 设置整个图标区域网格背景线的颜色
                    borderColor: '',     // 设置图表的(最外侧)边框的颜色
                    borderWidth: 0,           //设置图表的（最外侧）边框宽度
                    shadow: false               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果
                } ,
                seriesDefaults : {
                    renderer : $.jqplot.BarRenderer, //使用柱状图表示
                    rendererOptions : {
                        barMargin : 11  //柱状体组之间间隔
                    },
                    pointLabels: {  // 显示数据点，依赖于jqplot.pointLabels.min.js文件
                        show: true
                    },
                    showLabel:true
                },
                axesDefaults: {
                    tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                    tickOptions: {
                        // fontFamily: 'Georgia',
                        angle: -45,
                        fontSize: '10pt',
                        // 设置刻度在坐标轴上的显示方式：分为:坐标轴外显示，内显示，和穿过显示;其值分别为 'outside', 'inside' or 'cross'
                        mark: 'inside',
                        // 设置是否显示刻度
                        showMark: true,
                        // 是否在图表区域显示刻度值方向的网格
                        showGridline: false,
                        // 每个刻度线顶点距刻度线在坐标轴上点距离（像素为单位)如果mark值为 'cross',
                        // 那么每个刻度线都有上顶点和下顶点，刻度线与坐标轴在刻度线中间交叉，那么这时这个距离×2
                        markSize: 1,
                        // 是否显示刻度线，与刻度线同方向的网格线，以及坐标轴上的刻度值
                        show: true,
                        // 是否显示刻度线以及坐标轴上的刻度值
                        showLabel: true,
                        // 设置坐标轴上刻度值显示格式，例:'%b %#d, %Y'表示格式"月 日，年"，"AUG 30,2008"
                        formatString: '',
                        // 刻度值的字体大小
                        fontSize: '10px',
                        textColor:'#FFFFFF',
                        // 刻度值上字体
                        //fontFamily: 'Tahoma',
                        // 字体的粗细
                        //fontWeight: 'normal',
                        // 刻度值在所在方向（坐标轴外）上的伸展(拉伸)度
                        fontStretch: 1
                    },
                    showTicks: true,        /// 是否显示刻度线以及坐标轴上的刻度值
                    showTickMarks: true,    //设置是否显示刻度
                    useSeriesColor: true     //如果有多个纵（横）坐标轴，通过该属性设置这些坐标轴是否以不同颜色显示
                },

                axes: {
                    xaxis: {
                        renderer: $.jqplot.CategoryAxisRenderer, //x轴绘制方式
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                    },
                    yaxis: {
                        //min: 0,           //y轴最小值
                        //max: 40,          //y轴最大值
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                    }
                }
            });
        }
    </script>

</head>

<body background="" text="#FFFFFF">
<center>
    <frame name="menu" src="<c:url value='/pages/menuTmp.jsp'/>" />
    <div id="total" style="background: url(<c:url value='/img/zc1.jpg'/>);top: 0px; bottom: 0px; width: 1366px; height: 800px; box-shadow: none;background-size:cover;" >
        <div class="no no1" id="d1">
            <table width="306"  cellpadding="2" cellspacing="1"  id="t1">
                <tbody id="div1"> </tbody>
            </table>
        </div>
        <div class="no no2" id="d2">
            <table  width="306" cellspacing="1" cellpadding="2"  id="t2">
                <tbody id="div2"> </tbody>
            </table>
        </div>
        <div  class="no no3" id="d3" style="margin-top: 20px; margin-left: 20px; width: 320px; height: 220px; ">     </div>
        <div  class="no no4" id="d4" style="margin-top: 20px; margin-left: 20px; width: 347px; height: 238px;">    </div>
        <div align="center"><span class="no no5" id="d5"></span></div>
        <div  class="no no6" id="d6" style="margin-top: 20px; margin-left: 20px; width: 320px; height: 220px; ">


            <script>
                function Appendzero(obj)
                {
                    if(obj<10) return "0" +""+ obj;
                    else return obj;
                }

                setInterval("d6.innerHTML=new Date().getFullYear()+'/'+Appendzero( new Date().getMonth()+1)+'/'+Appendzero(new Date().getDate())+'&nbsp'+Appendzero(new Date().getHours()) + ':' +Appendzero(new Date(). getMinutes())  ;",1000);
            </script>



        </div>
    </div>
</center>
<form>
    <input type="hidden" name="screenX" id="screenX" value="<c:out value='${screenX }'/>"/>
    <input type="hidden" name="screenY" id="screenY" value="<c:out value='${screenY }'/>"/>
</form>
</body>
</html>
