<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">     
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>
	<script type="text/javascript">

	</script>
       
  </head>
<style type="text/css">
.box{width: 1000px;height: 200px;margin: 0 auto;margin-left:110px;}
.box ul{width: 100%;height: auto;margin:0px;padding:0px;float: left;}
.box ul li{width: 180px;height: 100px;float: left;list-style:none;}
.box ul li img{width: 40%; height: 40%;}
.box ul li span{width:50%; height:40%;font-size:12px}

.t_num i {
width: 15px;
height: 23px;
display: inline-block;
background: url(<c:url value='/img/number.png' />) no-repeat;
background-position: 0 0;
text-indent: -999em;
}
</style>  
  <body>
  <div class="chart" style="margin-bottom:0px;height:480px;">
  <div id="chart_spline">
        
  </div>
  </div>
  <div class="box" style="">
  <ul>
  <li><img src="<c:url value='/img/hysj.png'/>" title="好运射击" alt="图片失效" /><span class='t_num' id="t_num"></span></li>
  <li><img src="<c:url value='/img/kxyk.png'/>" title="开心一刻" alt="图片失效" /><span class="t_num"></span></li>
  <li><img src="<c:url value='/img/lhdb.png'/>" title="连环夺宝" alt="图片失效" /><span class="t_num"></span></li>
  <li><img src="<c:url value='/img/qwgef.png'/>" title="趣味高尔夫" alt="图片失效" /><span class="t_num"></span></li>
  <li><img src="<c:url value='/img/xywc.png'/>" title="幸运五彩" alt="图片失效" /><span class="t_num"></span></li>
  <li><img src="<c:url value='/img/sjfg.png'/>" title="三江风光" alt="图片失效" /><span class="t_num"></span></li>
  <li><img src="<c:url value='/img/shwx.png'/>" title="四花五选" alt="图片失效" /><span class="t_num"></span><li>
  </ul>
  </div>
  </body>
  <script type="text/javascript">
        
      $(document).ready(function(){
          displayChart();
            
    });
    
    
      function displayChart(){
      	chart = new Highcharts.Chart({ 
        chart: { 
            renderTo: 'chart_spline', //图表放置的容器，DIV 
            type: 'spline', //图表类型为曲线图
            //backgroundColor: '#F5F5F5',
            marginRight: 10,  
            //zoomType: 'xy',
            events: {  
                    load: function() {
                    var series =this.series;
                                //used by highChart
                    var loadData = function(){
                    //alert(series[0]);
                    	$.ajax({
                        	type:"POST",
                          	async:true,
                          	url:"<c:url value='/analysis/getRechargeCount.do'/>",
                          	data:{interValTime:1},
                          	dataType:"json",
                          	success:function(data){
                          	    //alert("data"+series[0].data);
                            	series[0].addPoint([data.time,data.count],true,false);
                            	var gameVal =parseInt(100000*Math.random());
                            	
                            	//此处数组元素换成后台取到的各游戏充值数
                            	var gameVals = new Array(parseInt(100000*Math.random()),parseInt(100000*Math.random()),parseInt(100000*Math.random()),
                            	                parseInt(100000*Math.random()),parseInt(100000*Math.random()),parseInt(100000*Math.random()),parseInt(100000*Math.random()));
                            	
                            	for(var j=0;j<7;j++){
                            		show_num(gameVals[j],j);
                            	}
                            	
                         	}
           		 		}); 
        		  	};
                        loadData();
                        //alert("after load");
                        setInterval(loadData, 6000);
                    }
            }
        }, 
        title: { 
            text: ''  //图表标题 
        }, 
         xAxis: 
                          {
                              type: 'datetime',
                              tickPixelInterval: 120
                          }
                      ,
            
       yAxis: 
                         {
                              title: {
                                  text: '充值次数',
                                  style: {
                                      color: '#3E576F'
                                  },
                                   tickInterval:1000000
                              },
                              min:0,
                              max:10000000
                         }
                     ,
/*         tooltip: {//鼠标移到图形上时显示的提示框  <br /> 
                     formatter: function() {
                          return "Date："+new Date(Highcharts.dateFormat('%Y-%m-%d', this.x))+"<br/>"+"Value："+Highcharts.numberFormat(this.y, 2);
                     }
                 },    */     
        legend: { 
            enabled: false,  //设置图例不可见
            shadow: false 
        }, 
        exporting: {
         
        }, 
        credits: { 
            enabled: false 
        }, 
        
        plotOptions: {
                         spline: {
                              marker:{
                                  enabled: false,
                                  states: {
                                      hover: {
                                          enabled: true,
                                          symbol: 'circle',
                                         radius: 5,
                                          lineWidth: 1
                                      }
                                  }
                              }
                          }
                      },
/*         plotOptions:{ //绘图线条控制  
           line:{
               marker:{  
                    enabled:true,//是否显示点  
                    radius:3,//点的半径  
                    fillColor:"#888",  
                    lineColor:"#000"  
              }
           }
        }, */
        
        plotLines: [{  
                value: 0,  
                width: 1,  
                color: '#808080'  
            }],  
        
        series: [{
            //yAxis: 1,
            data: []
        }]
        
         
    });
  }
  
  </script>  
</html>
