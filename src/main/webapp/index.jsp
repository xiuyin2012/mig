<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

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
  <script type="text/javascript">

       alert('开始后台取数据！！！！');






      $(function() {
          $.ajax({

              type:"POST",
              async:false,
              url:"<c:url value='/analysis/geTransByPro.do'/>",
              data:{},
              dataType:"json",
              success:function(data){
                  alert(data);
                  //ewJsonData = data;
              },
              error : function() {
                  //请求之后，响应不成功或者有错误执行
                  alert("异常11111111111111111！");
              }
          });
          alert('台取数据结果！' );
          $.ajax({

              type:"POST",
              async:false,
              url:"<c:url value='/analysis/ratioByGameBET.do'/>",
              data:{},
              dataType:"json",
              success:function(data){
                  alert(data);
                  //ewJsonData = data;
              },
              error : function() {
                  //请求之后，响应不成功或者有错误执行
                  alert("异常222222222222222！");
              }
          });

          $.ajax({

              type:"POST",
              async:false,
              url:"<c:url value='/analysis/getTotalBETbyScore.do'/>",
              data:{},
              dataType:"json",
              success:function(data){
                  alert(data);
                  //ewJsonData = data;
              },
              error : function() {
                  //请求之后，响应不成功或者有错误执行
                  alert("异常3333333333333！");
              }
          });

          $.ajax({

              type:"POST",
              async:false,
              url:"<c:url value='/analysis/getHallListByAmount.do'/>",
              data:{},
              dataType:"json",
              success:function(data){
                  alert(data);
                  //ewJsonData = data;
              },
              error : function() {
                  //请求之后，响应不成功或者有错误执行
                  alert("异常444444444444444！");
              }
          });

          $.ajax({

              type:"POST",
              async:false,
              url:"<c:url value='/analysis/getFinalAmount.do'/>",
              data:{},
              dataType:"json",
              success:function(data){
                  alert(data);
                  //ewJsonData = data;
              },
              error : function() {
                  //请求之后，响应不成功或者有错误执行
                  alert("异常555555555555555555！");
              }
          });

      });
  </script>
  <script type="text/javascript" language="javascript">
      //左一和右下列表
      var data=[{"uid":"1","uname":"北京","sum":274.23},{"uid":"2","uname":"上海","sum":0},{"uid":"3","uname":"广州","sum":7917.94},{"uid":"4","uname":"深圳公司","sum":41.39},{"uid":"5","uname":"福建","sum":274.23},{"uid":"6","uname":"福建","sum":274.23},{"uid":"7","uname":"福建","sum":274.23},{"uid":"8","uname":"福建","sum":274.23},{"uid":"9","uname":"福建","sum":274.23},{"uid":"10","uname":"福建","sum":274.23}]
      var data2=[{"uid":"11","uname":"北1京","sum":274.23},{"uid":"2","uname":"上1海","sum":0},{"uid":"13","uname":"广州","sum":7917.94},{"uid":"4","uname":"深圳公司","sum":41.39},{"uid":"5","uname":"福建","sum":274.23},{"uid":"6","uname":"福建","sum":274.23},{"uid":"7","uname":"福建","sum":274.23},{"uid":"8","uname":"福建","sum":274.23},{"uid":"9","uname":"福建","sum":274.23},{"uid":"10","uname":"福建","sum":274.23}]
      $(function(){
          // 动态创建表格，使用动态创建dom对象的方式
          //清空所有的子节点
          $("#div1").empty();
          for(var i=0;i<data.length;i++){
              //动态创建一个tr行标签,并且转换成jQuery对象
              var $trTemp1 = $("<tr></tr>");
              //往行里面追加 td单元格
              $trTemp1.append("<td width='92'  align='left'>"+ data[i].uid +"</td>");
              $trTemp1.append("<td width='107' align='left'>"+ data[i].uname +"</td>");
              $trTemp1.append("<td width='102' align='left'>"+ data[i].sum +"</td>");
              $trTemp1.appendTo("#div1");
          }
      });
      $(function(){
          // 动态创建表格，使用动态创建dom对象的方式
          //清空所有的子节点
          $("#div2").empty();
          for( var i = 0; i < data2.length; i++ ) {
              //动态创建一个tr行标签,并且转换成jQuery对象
              var $trTemp = $("<tr></tr>");
              //往行里面追加 td单元格
              $trTemp.append("<td width='92'  align='left'>"+ data2[i].uid +"</td>");
              $trTemp.append("<td width='107' align='left'>"+ data2[i].uname +"</td>");
              $trTemp.append("<td width='102' align='left'>"+ data2[i].sum +"</td>");
              $trTemp.appendTo("#div2");
          }
      });


  </script>


  <script type="text/javascript" language="javascript">
      //饼图
      $(document).ready(function(){





          var  date = [['趣味高尔夫', 3], ['三江风光', 7], ['deer', 2.5], ['turkeys', 6], ['moles', 5], ['ground hogs', 4]];

          var  plot1 = $.jqplot('d3', [date], {
              title:' ',//设置饼状图的标题
              grid:{
                  background:'rgba(0,0,0,0)',
                  //filter:'alpha(opacity=0)',
                  //background: '#00dd00',      // 设置整个图表区域的背景色
                  borderWidth: 0,           //设置图表的（最外侧）边框宽度
                  shadow: true,               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果
                  shadowAngle: 45,            // 设置阴影区域的角度，从x轴顺时针方向旋转
                  shadowOffset: 1.5,          // 设置阴影区域偏移出图片边框的距离
                  shadowWidth: 3,             // 设置阴影区域的宽度
                  shadowDepth: 3,             // 设置影音区域重叠阴影的数量
                  shadowAlpha: 0.07           // 设置阴影区域的透明度

              },
              seriesColors:["red", "yellow", "#EAA228", "blue", "green", "#958c12"  //设置饼图每个区域颜色
              ],
              seriesDefaults: {
                  renderer:$.jqplot.PieRenderer,
                  rendererOptions:{
                      showDataLabels: true,
                      diameter: undefined, // 设置饼的直径
                      padding: 10,        // 饼距离其分类名称框或者图表边框的距离，变相该表饼的直径
                      sliceMargin: 3,     // 饼的每个部分之间的距离
                      fill:true,         // 设置饼的每部分被填充的状态
                      shadow:true,       //为饼的每个部分的边框设置阴影，以突出其立体效果
                      showMark:true, //设置是否显示刻
                  }
              },
              legend:{
                  border: 0 ,
                  show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）
                  location: 'nw',     // 分类名称框出现位置, nw, n, ne, e, se, s, sw, w.
                  xoffset: 12,        // 分类名称框距图表区域上边框的距离（单位px）
                  yoffset: 30,        // 分类名称框距图表区域左边框的距离(单位px)
                  background:'rgba(0,0,0,0)',//分类名称框距图表区域背景色
                  textColor:'', //分类名称框距图表区域内字体颜色
              },
          });

      });

  </script>












  <script type="text/javascript">
      //柱状图
      $(document).ready(function(){
          var line1 = [['连环夺宝', 7], ['鸵鸟快跑', 29], ['连环1夺宝', 15],['连环2夺宝', 12],  ['连3环夺宝', 18]];

          $.jqplot('d4', [line1], {
              title: '',
              grid: {
                  //showMarker: false,
                  //showTickMarks: true,

                  background:'rgba(0,0,0,0)',
                  drawGridLines: true,
                  gridLineColor: '#',    // 设置整个图标区域网格背景线的颜色
                  borderColor: '',     // 设置图表的(最外侧)边框的颜色
                  borderWidth: 0,           //设置图表的（最外侧）边框宽度
                  shadow: true,               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果
              } ,
              seriesDefaults : {
                  renderer : $.jqplot.BarRenderer, //使用柱状图表示
                  rendererOptions : {
                      barMargin : 15  //柱状体组之间间隔
                  },
                  pointLabels: {  // 显示数据点，依赖于jqplot.pointLabels.min.js文件
                      show: true
                  },
                  showLabel:true
              },
              axesDefaults: {
                  //pad: 5,
                  //showMark: true,
                  // 设置是否显示刻度
                  //showTickMarks: true,
                  tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                  tickOptions: {
                      fontFamily: 'Georgia',
                      angle: -30,
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
                      // 刻度值上字体
                      fontFamily: 'Tahoma',
                      // 字体的粗细
                      fontWeight: 'normal',
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
                      max: 40,          //y轴最大值
                      labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                  }
              }
          });
      });
  </script>
</head>
<style>
  * { padding: 0; margin: 0; }
  table {
    border-collapse: collapse;
    border-spacing: 0;
    border: 0px solid #c0c0c0;
  }
  th,td {
    border: 0px solid #d0d0d0;
  //color: #404060;
    padding: 1px;//表格上下间距
  width:92px;
  }
  th {
    background-color: #09c;
    font: bold 12px "微软雅黑";
    color: #fff;
  }
  td {
    font: 12px "微软雅黑";
  }
  tbody tr {
  //background-color: #f0f0f0;
  }
  tbody tr:hover {
    cursor: pointer;
  // background-color: #fafafa;
  }
  .no{
    position: absolute;
    width: 283px;
    height: 4px;
  }
  .no1{
    left: 114px;
    top: 209px;
  }
  .no2{
    left: 989px;
    top: 552px
  }
  .no3{	left: 943px;	top: 161px		}
  .no4{	left: 85px;	top: 509px}
  .no5{	left: 649px;	top: 453px}
</style>
<body background="" text="#FFFFFF" >
<div style="background: url(/img/zc1.jpg); width: 1366px; height: 800px; box-shadow: none" >
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
  <div  class="no no4" id="d4" style="margin-top: 20px; margin-left: 20px; width: 347px; height: 238px;">
  </div>

  <span class="no no5" id="d5">888888888888</span>
</div>
</body>
</html>
