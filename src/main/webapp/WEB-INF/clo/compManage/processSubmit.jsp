<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>My JSP 'processSubmit.jsp' starting page</title>
<!--     <style>
        .dateFont {
	        display:inline;
	        font-weight:bold;
	        font-size:13px;
        }
    </style> -->
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	<script type="text/javascript">
	
	

	</script>

  </head>
  
  <body>
<!--      <form id="searchForm" name="searchForm" action="" method="post">
         <input type="hidden" id="fromDate" name="fromDate" value=""/>
         <input type="hidden" id="toDate" name="toDate" value=""/>
     </form> -->
     <div class="search">
                            <div class="dateFont1">日期</div>
                            <div class="dateInput"><input class="cal" id="fromDateString" name="fromDateString" type="text" /></div><div class="dateFont2"> 至   <input class="cal" id="toDateString" name="toDateString" type="text" /></div>
              
        <!-- <input type="hidden" name="action" value="getUser"/>  -->
        <div class="searchBtn"><input class="btn" type="button" value = "查询" id = "search"/></div>
     </div>
     <div class="gridtable"style="width:98%">
     
     <table id="gridTbl"></table>
     <!-- jqGrid 分页 div gridPager -->
 
     <div id="gridPager"></div>
   </div>
   <div class="center" style="display:none;height:10px;margin-top:30px;width:20%;" id="viewSelectDiv">
<!--         <div class= "font" style="vertical-align:middle;margin-top:3px;">请选择查看视图</div> -->
   <div class='select' style="vertical-align:middle;margin-top:3px;">
   <select  id = "viewSelect" name="viewSelect" onchange = "selectViewOnChange()">
        <option value="cpu1_avg" selected = "selected" >CPU1(8:00-10:00) AVG(%)</option>
        <option value="cpu1_max">CPU1(8:00-10:00) MAX(%)</option>
        <option value="cpu2_avg">CPU2(10:00-22:00) AVG(%)</option>
        <option value="cpu2_max">CPU2(10:00-22:00) MAX(%)</option>
        <option value="cpu3_avg">CPU3(22:00-次日7:50) AVG(%)</option>
        <option value="cpu3_max">CPU3(22:00-次日7:50) MAX(%)</option>
        <option value="diskbusy_avg">DISK IO AVG(%)</option>
        <option value="diskbuy_max">DISK IO MAX(%)</option>
        <option value="jfsfile_max">文件系统空间(%)MAX</option>
        <option value="mem_avg">MEM Used(%) AVG</option>
        <option value="mem_max">MEM Used(%) MAX</option>
        <option value="net_avg">网络流量:en9(KB/s) AVG</option>
        <option value="net_max">网络流量:en9(KB/s) MAX</option>
<!--         <option value="game_num_avg">游戏服务连接数(个) AVG</option>
        <option value="game_num_max">游戏服务连接数(个) MAX</option>
        <option value="manager_num_avg">管理服务连接数(个)AVG</option>
        <option value="manager_num_max">管理服务连接数(个)MAX</option> -->
   </select>
   </div>
   </div>
   
   <div class="chart">
   <div id="chart_spline">
        
   </div>
   </div>
   
   <input type="hidden" name="serverType" id = "serverType" value="1"/>   
   <input type="hidden" name="serverId" id="serverId" value="<c:out value= ${'serverId' } />" />         
  </body>
<%--   <%@ include file="cpuChart.jsp" %> --%>
  <script type="text/javascript">
     
     //global var
     var chartData = new Array();
  //   var ewData = new Array();
     var chartRows;
     var ycat;
     var xcat;
     var chart;
     var ewJsonData;
     var xAxisArray = new Array();
     var kpiMap = new Map();
     
     function splitByLine(str){
          var strtmp;
          strtmp = str.split(/_(?![^_]*_)/).toString();
/*           var a= "a,b,c";
          a.split(",") */
          return strtmp.split(",");
          
     }
     function initKpiMap(kpiMap){
      kpiMap.set("cpu1","CPU_ALL1");
      kpiMap.set("cpu2","CPU_ALL2");
      kpiMap.set("cpu3", "CPU_ALL3");
      kpiMap.set("diskbusy", "DISKBUSY");
      kpiMap.set("jfsfile", "JFSFILE");
      kpiMap.set("mem", "MEM");
      kpiMap.set("net", "NET");
      kpiMap.set("game_num", "GAME_NUM");
      kpiMap.set("manager_num","MANAGER_NUM");
     }
             function addCellAttr(rowId, val, rawObject, cm, rdata) {
/*                 alert("rowId"+rowId);
                alert(rawObject);
                alert(cm["name"]);
                alert(rdata); */
                    var celllbl = cm["label"];
                    var norVal = null;
                    var alaVal = null;
                    var norRule = null;
                    var alaRule = null;
                    
                   // alert(celllbl);
                    if(celllbl=="day"){
                        return "style='background:#F5F5F5'";
                    }
                    $.each(ewJsonData,function(i){
                        
                        if(ewJsonData[i]["kpiName"]+"_"+ewJsonData[i]["measName"] == celllbl){
                            if(ewJsonData[i]["kpiName"]!="GAME_NUM"&&ewJsonData[i]["kpiName"]!="NET"&&ewJsonData[i]["kpiName"]!="MANAGER_NUM"){
                                val = val*100;
                            }
                            
                            norVal = ewJsonData[i]["norValue"];
                            alaVal = ewJsonData[i]["alaValue"];
                            
                            norRule = ewJsonData[i]["norRule"];
                            alaRule = ewJsonData[i]["alaRule"];
                            /* alert("norVal"+norVal);
                            alert("alaVal"+alaVal); */
                        }
                    });
                       
                    //0代表<= ,正常阀值规则:norRule,告警阀值规则:alaRule,理论上norRule = 0时，alaRule必为1 ,反之norRule = 1时 alaRule必为0,故:
                    if(norRule==0){
                      if(alaRule==1){  
                        if(val>norVal){
                           
                           //关注
                           if(val<alaVal){
                               return "style='background:#FFA500 '";
                           }
                           //告警
                           if(val>=alaVal){
                               return "style='background:#FF0000 '";
                           } 
                           
                        }
                      
                        //正常
                        if(val<=norVal){
                            return "style='background:#006400 '";
                        }
                      }
                      
                      //理论上是没有预警功能
                      if(alaRule==0){
                           return;
                      }
                    }
                    
                    if(norRule==1){
                      if(alaRule==0){
                        if(val<norVal){
                            
                            //关注
                            if(val>alaVal){
                                return "style='background:#FFA500 '";
                            }
                            //告警
                            if(val<=alaVal){
                                return "style='background:#FF0000 '";
                            }
                        }
                        
                        if(val>=norVal){
                            return "style='background:#006400 '";
                        }
                      }
                      
                      if(alaRule==1){
                          return;
                      }    
                    }
               }
     //grid load       
     function gridTblLoad(fromDate,toDate){
        
        var fromDate = $("#fromDateString").datepicker('getDate').format('yyyyMMdd');
        var toDate = $("#toDateString").datepicker('getDate').format('yyyyMMdd');            
        $("#gridTbl").jqGrid({
        url:"<c:url value='/compManage/getAppServerMonitors.do'/>",
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        shrinkToFit:true,
        colNames:['日期', 'CPU1(8:00-10:00) AVG(%)', 'CPU1(8:00-10:00) MAX(%)','CPU2(10:00-22:00) AVG(%)','CPU2(10:00-22:00) MAX(%)','CPU3(22:00-次日7:50) AVG(%)','CPU3(22:00-次日7:50) MAX(%)','DISK IO AVG(%)',
                  'DISK IO MAX(%)','文件系统空间(%)MAX','MEM Used(%) AVG','MEM Used(%) MAX','网络流量:en9(KB/s) AVG','网络流量:en9(KB/s) MAX'],
/*                   '游戏服务连接数(个) AVG','游戏服务连接数(个) MAX',
                  '管理服务连接数(个)AVG','管理服务连接数(个)MAX'], */
        colModel:[
            //{name:'id',index:'id', width:'10%', align:'center' },
            {name:'day',label:'day',index:'day',classes:'gridTd', width:'50px',padding:'2px 2px 2px 2px',align:'center',cellattr: addCellAttr},
            {name:'cpu1_avg',label:'CPU_ALL1_AVG',index:'cpu1_avg', width:'40px',align:'center', formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'cpu1_max',label:'CPU_ALL1_MAX',index:'cpu1_max', width:'40px',align:'center',cellattr: addCellAttr},
            {name:'cpu2_avg',label:'CPU_ALL2_AVG',index:'cpu2_avg', width:'40px',align:'center',formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'cpu2_max',label:'CPU_ALL2_MAX',index:'cpu2_max', width:'40px',align:'center',cellattr: addCellAttr},
            {name:'cpu3_avg',label:'CPU_ALL3_AVG',index:'cpu3_avg', width:'40px',align:'center', formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'cpu3_max',label:'CPU_ALL3_MAX',index:'cpu3_max', width:'40px',align:'center',cellattr: addCellAttr},
            {name:'diskbusy_avg',label:'DISKBUSY_AVG',index:'diskbusy_avg', width:'30px',align:'center', formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'diskbuy_max',label:'DISKBUSY_MAX',index:'diskbuy_max', width:'30px',align:'center',cellattr: addCellAttr},
            {name:'jfsfile_max',label:'JFSFILE_MAX',index:'jfsfile_max', width:'30px',align:'center',cellattr: addCellAttr},
            {name:'mem_avg',label:'MEM_AVG',index:'mem_avg', width:'40px',align:'center',formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'mem_max',label:'MEM_MAX',index:'mem_max', width:'40px',align:'center',cellattr: addCellAttr},
            {name:'net_avg',label:'NET_AVG',index:'net_avg', width:'50px',align:'center',formatter:'number',formatoptions:{decimalPlaces:2,thousandsSeparator:""},cellattr: addCellAttr},
            {name:'net_max',label:'NET_MAX',index:'net_max', width:'40px',align:'center',cellattr: addCellAttr},
/*             {name:'game_num_avg',label:'GAME_NUM_AVG',index:'game_num_avg', width:'50px',align:'center', formatter:'number',formatoptions:{decimalPlaces:2,thousandsSeparator:""},cellattr: addCellAttr},
            {name:'game_num_max',label:'GAME_NUM_MAX',index:'game_num_max', width:'40px',align:'center',cellattr: addCellAttr},
            {name:'manager_num_avg',label:'MANAGER_NUM_AVG',index:'manager_num_avg', width:'40px',align:'center',formatter:'number',formatoptions:{decimalPlaces:2},cellattr: addCellAttr},
            {name:'manager_num_max',label:'MANAGER_NUM_MAX',index:'manager_num_max', width:'30px',align:'center',cellattr: addCellAttr} */
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: 'APP_Server1', 
         prmNames : { 

             page:"page",    // 表示请求页码的参数名称 

             rows:"rows"
             
         },
         
         postData:{
           
            serverId:$("#serverId").val(),
            fromDate:fromDate,
            
            toDate:toDate
            
            
         },
         
        jsonReader:{
            root: "rows",   // json中代表实际模型数据的入口 
            repeatitems : false,
            records:"records",
            total:"total"
        },
        
        gridComplete: function() { 

                   var outData = $("#gridTbl").jqGrid('getRowData');
                   var currentPage;
                  // $("#chart_spline").html('');
                   
                   $("#viewSelectDiv").hide();
                   if(0!=outData.length){
                   $("#viewSelectDiv").show();
                   
                  
                  currentPage = $("#gridTbl").jqGrid('getGridParam', 'page');

                            //initChartData(outData);
                            //displayChart();
                                    
                  }
            
        },
        onPaging: function(pgButton) {
          var toPage;
         if("user"!=pgButton){
        
          if("next_gridPager" == pgButton){
              toPage = $("#gridTbl").jqGrid('getGridParam','page')+1;
          }
          if("prev_gridPager" == pgButton){
              toPage = $("#gridTbl").jqGrid('getGridParam','page')-1;
          }
          if("first_gridPager" == pgButton){
              toPage = 1;
          }
          if("last_gridPager" == pgButton){
              
              toPage = $("#gridTbl").jqGrid('getGridParam', 'lastpage');
          }
              
        //  alert(toPage);
                 var fromDate = $("#fromDateString").datepicker('getDate').format('yyyyMMdd');
                 var toDate = $("#toDateString").datepicker('getDate').format('yyyyMMdd');
                      $("#gridTbl").jqGrid('setGridParam',{   
                                                              datatype:"json",
                                                              postData:{
                                                                     fromDate:$("#fromDateString").datepicker('getDate').format('yyyyMMdd'), 
                                                                     toDate:$("#toDateString").datepicker('getDate').format('yyyyMMdd'),
                                                                     serverId:$("#serverId").val()
                                                              },
                                                              
                                                              page:toPage
                                                              }).trigger('reloadGrid');
                     
          }
          //next_gridPager,user,prev_gridPager,last_gridPager,first_gridPager
        },
        pager:$('#gridPager')
    });
 }
            

      $(document).ready(function(){
            

            initKpiMap(kpiMap);
            $("#fromDateString").datepicker({ dateFormat: 'yy-mm-dd' });
            $("#toDateString").datepicker({ dateFormat: 'yy-mm-dd' });
            
            $( "#fromDateString" ).datepicker( 'setDate' , new Date());
            $( "#toDateString" ).datepicker( 'setDate' , new Date());
            
            var fromDate = $("#fromDateString").datepicker('getDate').format('yyyyMMdd');
            var toDate = $("#toDateString").datepicker('getDate').format('yyyyMMdd');
         
            gridTblLoad();
           
           

      
                   $("#search").click( function() {
                      
                      var fromDate = $("#fromDateString").datepicker('getDate').format('yyyyMMdd');
                      var toDate = $("#toDateString").datepicker('getDate').format('yyyyMMdd');
                      
                      $.ajax({
                          
                          type:"POST",
                          url:"<c:url value='/compManage/getews.do'/>",
                          data:{serverType:$("#serverType").val()},
                          dataType:"json",
                          success:function(data){
                              ewJsonData = data;
/*                               $.each(data,function(i){

                                  if("1"==data[i]["kpiName"]){

                                      if("2"==data[i]["measId"]){
                                           $("#cpu1_max_ala").val(data[i]["alaValue"]);
                                           $("#cpu1_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("2"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#cpu2_max_ala").val(data[i]["alaValue"]);
                                          $("#cpu2_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("3"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#cpu3_max_ala").val(data[i]["alaValue"]);
                                          $("#cpu3_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("4"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#diskbuy_max_ala").val(data[i]["norValue"]);
                                          $("#diskbuy_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("5"==data[i]["kpiSeq"]){
                                      if("1"==data[i]["measId"]){
                                          $("#jfsfile_max_ala").val(data[i]["alaValue"]);
                                          $("#jfsfile_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("6"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#mem_max_ala").val(data[i]["alaValue"]);
                                          $("#mem_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("7"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#net_max_ala").val(data[i]["alaValue"]);
                                          $("#net_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("8"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#game_num_max_ala").val(data[i]["alaValue"]);
                                          $("#game_num_max_nor").val(data[i]["norValue"]);
                                      }
                                  }
                                  
                                  if("9"==data[i]["kpiSeq"]){
                                      if("2"==data[i]["measId"]){
                                          $("#manager_num_max_nor").val(data[i]["alaValue"]);
                                          $("#manager_num_max_ala").val(data[i]["norValue"]);
                                      }
                                    }  
                                  }) */
                         
                         }
                      }); 
                      
                      $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
                      $("#gridTbl").jqGrid('setPostData',{fromDate:fromDate, toDate:toDate,serverId:$("#serverId").val()});
                      $("#gridTbl").trigger('reloadGrid');
            
            $.ajax({

             type: "POST",

             url: "<c:url value='/compManage/getAppServerMonitors.do'/>",

             data: {fromDate:fromDate, toDate:toDate, serverId:$("#serverId").val()},

             dataType: "json",

             success: function(data){
                            chartRows = data["rows"];
                            initChartData(chartRows);
                            displayChart();

                      }

         });
         
                    })
  
    });
               


    function initChartData(outData){
/*          var isHave;
         var chartDataY;
         
         //相隔18天取一个日期做横坐标点
         alert(outData.length);
         alert(outData[0].day);
         alert(outData[outData.length-1].day);
         var interDate = 18;
         var beginDate = toDate(outData[0].day);
         var endDate   = toDate(outData[outData.length-1].day);
         var incrDate = beginDate;
         
         while (incrDate<endDate)
         {
             xAxisArray.push(incrDate);
             alert(incrDate);
             incrDate = incrDate.setDate(incrDate.getDate() + interDate);
         } 
             xAxisArray.push(endDate); */
         
         
         $.each(outData,function(i){

         //chart坐标
           
         /* 原来的按日取的算法
           isHave = false;
           for(var j=0;j<xAxisArray.length;j++){
               if(xAxisArray[j]==outData[i].day){
                  //alert("isHave");
                   isHave = true;
               }
           }
                               
           if(isHave==false){
                xAxisArray.push(outData[i].day);
                //alert(outData[i].day);
           } */

           
           chartDataY = outData[i][$("#viewSelect").val()];
           
           chartData.push({ 
              x: toDate(outData[i].day),  
              y: parseFloat(chartDataY) 
           });

        });
        
    }
    
    
    
    
    function displayChart(){
      var returnArray = getkpiEwVal();
/*       alert("len"+returnArray.length);
      alert(returnArray[0]["kpiEwVal"]);
      alert(returnArray[0]["zoomY"]); */
/*       alert("chart"+chartData.length); */
      var ewY;
      var ewData = new Array();
      
     /*  alert("return"+returnArray[0]["kpiEwVal"]); */
      if(null!=returnArray[0]["kpiEwVal"]||undefined!=returnArray[0]["kpiEwVal"]){
           ewY = returnArray[0]["kpiEwVal"]/returnArray[0]["zoomY"];
           ewData.push({
                 x:chartData[0]["x"],
                 y:ewY   
           });
           ewData.push({
                 x:chartData[chartData.length-1]["x"],
                 y:ewY   
           });
          
/*           alert("ewY"+ewY); */
     

      }
      var chartDataLen = chartData.length;
      chart = new Highcharts.Chart({ 
        chart: { 
            renderTo: 'chart_spline', //图表放置的容器，DIV 
            defaultSeriesType: 'line', //图表类型为曲线图
            backgroundColor: '#F5F5F5',
            zoomType: 'xy'
        }, 
        title: { 
            text: ''  //图表标题 
        }, 
        xAxis: { //设置X轴 
              //X轴为日期时间类型 
           // tickPixelInterval: 150,  //X轴标签间隔
            //categories: [2,3]
            type:'datetime',
            tickInterval: 18 * 24 * 3600 * 1000 ,
            lineWidth: 1, 
            gridLineWidth: 0, 
            lineColor: '#000000',
            labels: {  

                        rotation:-45,
                        formatter: function () {  
                           
                            return Highcharts.dateFormat('%Y%m%d', this.value);  
                        } 
            }          
                        
             
        }, 
        yAxis: { //设置Y轴
           
           title: {  
            text: $("#viewSelect option[selected]").text(),
            gridLineWidth: 0  
            //max: 100, //Y轴最大值 
            //min: 0,  //Y轴最小值

            },
          /*   min:0.0,
            max:12.0, */
            //minorTickInterval: 'auto',
            min:0,
            allowDecimals: true, 
            startOnTick: true,
            lineWidth: 1, 
            gridLineWidth:0, 
            gridLineColor: '#d3d3d3', 
            lineColor: '#000000', 
            tickColor: '#000000',
            tickPosition: 'outside',
/*             tickInterval:4.0, */
            tickLength:4,
            tickWidth:1
/*             labels: {  
               formatter: function () {  
                           return this.value + '.00';
                        } 
            } */
                         
        },
        legend: { 
            enabled: false,  //设置图例不可见
            shadow: false 
        }, 
        exporting: { 
            enabled: true  //设置导出按钮不可用 
        }, 
        credits: { 
            enabled: false 
        }, 
        
        
        plotOptions:{ //绘图线条控制  
           line:{
               marker:{  
                    enabled:true,//是否显示点  
                    radius:1,//点的半径  
                    fillColor:"#888",  
                    lineColor:"#000"  
              }
           }
        },
        
        plotLines: [{  
                value: 0,  
                width: 1,  
                color: '#808080'  
            }],  
        
        series: [{ 
            data: chartData,
            visible: true, //默认不显示
            turboThreshold:0//不限制数据点个数
           // color:'#d3d3d3'
        },
        {
            data:ewData,
            visible: true,
            color: "red"
            
        }]
        
         
    }//,function(chart){




      /* alert(kpiEwVal); */
  //获得序列列表
  /*  var seriesList = chart.series; */
  //遍历每一条序列的每一个数据点
   
   //决定Y轴与预警值之前的缩放比例
          
  /*  for(var i = 0;i<seriesList.length;i++)
   {
       var pointList = seriesList[i].points;
     //遍历当前序列的每一个数据点
      for(var j = 0;j<pointList.length;j++)
      { */
     //判断数据点的y值是否大于警戒值
/*           alert(pointList[j].y);
          alert(returnArray["kpiEwVal"]); */
       /*    if((pointList[j].y)*returnArray[0]["zoomY"] > returnArray[0]["kpiEwVal"]) {

              chart.series[i].points[j].update({
                  color:"red"
             });  
          }
       }
   }
 } */); 
        chartData.splice(0,chartData.length);
/*         ewData.splice(0,ewData.length); */
  } 
         
         function selectViewOnChange(){
             initChartData(chartRows);
             displayChart();

         }
         
     function getkpiEwVal(){
       var kpiEwVal;
       var yaxisKpi;
       var viewSelectArrayVal = new Array();
       var zoomY = 1;
       var returnArray = new Array();
       viewSelectArrayVal = splitByLine($("#viewSelect").val());
       var viewSelectVal = kpiMap.get(viewSelectArrayVal[0])+"_"+viewSelectArrayVal[1].toUpperCase();
       /* alert(viewSelectVal); */
       $.each(ewJsonData,function(i){

           var kpiEwNm = ewJsonData[i]["kpiName"]+"_"+ewJsonData[i]["measName"];
          
/*            alert("viewSelectArrayVal[0]"+viewSelectArrayVal[0]); */
        
           //kpiMap.get($("#viewSelect").val());splitByLine
/*            alert("kpiEwNm"+kpiEwNm);
           alert("viewSelectVal"+viewSelectVal); */
/*            alert("kpiEwNm"+kpiEwNm);
           alert("viewSelectVal"+viewSelectVal); */
           if(kpiEwNm==viewSelectVal){
/*                alert(kpiEwNm);
               alert(viewSelectVal); */
    
               kpiEwVal=ewJsonData[i]["alaValue"];
               yaxisKpi = ewJsonData[i]["measName"];
              /*  alert("kpi"+kpiEwVal); */
           }
       });
       
       //决定kpi缩放比例
       if(yaxisKpi!="GAME_NUM"&&yaxisKpi!="NET"&&yaxisKpi!="MANAGER_NUM"){
           zoomY =  100;         
       }
/*        alert("ZOOMy"+zoomY);
       alert("kpiEwVal"+kpiEwVal); */
       returnArray.push({
           zoomY:zoomY,
           kpiEwVal:kpiEwVal   
       });
       
       return returnArray;   
       
     }

  </script>
</html>
