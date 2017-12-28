// common.js
// version : 1.0.0

function toDate(dateString){
  var d = new Date();
  d.setFullYear(parseInt(dateString.substr(0,4)),parseInt(dateString.substr(4,2))-1,parseInt(dateString.substr(6,2)));
  return d;
}


Date.prototype.format =function(format)
{
var o = {
"M+" : this.getMonth()+1, //month
"d+" : this.getDate(), //day
"h+" : this.getHours(), //hour
"m+" : this.getMinutes(), //minute
"s+" : this.getSeconds(), //second
"q+" : Math.floor((this.getMonth()+3)/3), //quarter
"S" : this.getMilliseconds() //millisecond
}
if(/(y+)/.test(format)) format=format.replace(RegExp.$1,
(this.getFullYear()+"").substr(4- RegExp.$1.length));
for(var k in o)if(new RegExp("("+ k +")").test(format))
format = format.replace(RegExp.$1,
RegExp.$1.length==1? o[k] :
("00"+ o[k]).substr((""+ o[k]).length));
return format;
}

function Map() {
	this.keys = new Array();
	this.data = new Array();
	//添加键值对
	this.set = function (key, value) {
	if (this.data[key] == null) {//如键不存在则身【键】数组添加键名
	this.keys.push(value);
	}
	this.data[key] = value;//给键赋值
	};
	//获取键对应的值
	this.get = function (key) {
	return this.data[key];
	};
	//去除键值，(去除键数据中的键名及对应的值)
	this.remove = function (key) {
	this.keys.remove(key);
	this.data[key] = null;
	};
	//判断键值元素是否为空
	this.isEmpty = function () {
	return this.keys.length == 0;
	};
	//获取键值元素大小
	this.size = function () {
	return this.keys.length;
	};
	}

function splitByLine(str){
    var strtmp;
    strtmp = str.split(/_(?![^_]*_)/).toString();
/*           var a= "a,b,c";
    a.split(",") */
    return strtmp.split(",");
    
}

function splitByLineByFlag(str,flag){
    var strtmp;
    strtmp = str.split(/_(?![^_]*_)/).toString();
/*           var a= "a,b,c";
    a.split(",") */
    return strtmp.split(flag);
    
}

function gettypes(){

	//动态生成select内容

	var str = "";

	$.ajax({

	type:"post",

	async:false,

	url:"<c:url value='/compManage/findServerType'/>"+".do",

	success:function(data){

	if (data != null) {

	        var jsonobj=data;

	        var length=jsonobj.length;

	        for(var i=0;i<length;i++){

	            if(i!=length-1){

	            	str+=jsonobj[i].server_type_id+":"+jsonobj[i].server_type_desc+";";

	            }else{

	              	str+=jsonobj[i].server_type_id+":"+jsonobj[i].server_type_desc;

	            }

	         }   

	                //$.each(jsonobj, function(i){

	                	//str+="personType:"+jsonobj[i].personType+";"

	       	//$("<option value='" + jsonobj[i].personType + "'>" + jsonobj[i].personType+ "</option>").appendTo(typeselect);

	     	 	//});
	     	 	  //value: '1:事务;2:非事务'
	            
	     }

	           

	}

	});
	return str;
}

var initdata;

function gridOperDef(){
    //定义按键   gridPager 
    
   $("#gridTbl").jqGrid('navGrid', '#gridPager', {edit:false,add:false,del:false,refresh:false,search:false});
   $("#gridTbl").jqGrid('inlineNav','#gridPager', {edit:false,add:false,del:false,refresh:false,search:false
       
  
   
   
   
   }).navButtonAdd('#gridPager',{      

caption:"",       

buttonicon:"ui-icon-plus",

onClickButton : function (){
$("#gridTbl").jqGrid('addRow',{
    initdata : initdata,
    position :"first"
});       
},
position:"last"      

});      
}

function adjust_height(){
    $("table th").css("height",30);
    $("table td").css("white-space","nowrap");
}

function beforeShowUrlSubmit(rowId,target_cellval){
    var colNames=$("#gridTbl").jqGrid('getGridParam','colNames');
    var colModel=$("#gridTbl").jqGrid('getGridParam','colModel');
    var rowCtx=null;
    var cellval,bgColor;
    rowCtx=new Array();
    for(i=1;i<colModel.length;i++){
        cellval = $("#gridTbl").getCell(rowId,colModel[i].name);
        bgColor = addCellAttr(null, cellval, null, colModel[i], null);
        //bgColor = colModel[i].cellattr;
        if(undefined==bgColor) bgColor = "";
        rowCtx.push({kpi_name:colNames[i],meas_data:cellval,bgColor:bgColor});
    }
    $("#rowCtx").val(JSON.stringify(rowCtx));	
}
function toDetail(rowId,target_cellval){
 
    if($("#targetParaNm").val()!== undefined)$("#"+$("#targetParaNm").val()).val(target_cellval);	
    $("#day").val(target_cellval);
    beforeShowUrlSubmit(rowId);
    deleteCache();
    $("#toDetailForm").submit();
}


function deleteCache(){}
function showlink(cellval, opts, rowObject)
{   
    var op = {baseLinkUrl: opts.baseLinkUrl,showAction:opts.showAction, addParam: opts.addParam || "", target: opts.target, idName: opts.idName},
	target = "", idUrl,reqUrl,url_style;
	if(opts.colModel !== undefined && opts.colModel.formatoptions !== undefined) {
		op = $.extend({},op,opts.colModel.formatoption);
	}
	if(op.target) {target = 'target=' + op.target;}
	idUrl = "javascript:toDetail("+opts.rowId+","+cellval+")";
	url_style = "text-decoration:none";
	if($.fmatter.isString(cellval) || $.fmatter.isNumber(cellval)) {
		return "<a "+target+" href=\"" + idUrl+"\" style=\""+url_style + "\">" + cellval + "</a>";
		return "<a "+target+" href=\"" + idUrl + "\">" + cellval + "</a>";
	}
	return $.fn.fmatter.defaultFormat(cellval,opts);
	
    //$("#gridTbl").jqGrid('getGridParam','colModel').formatoptions.addParam = rowObject.seq_id; 
	
}

function getNowFormatDate(){
    var day = new Date();
    var Year = 0;
    var Month = 0;
    var Day = 0;
    var CurrentDate = "";
    Year= day.getFullYear();//支持IE和火狐浏览器.
    Month= day.getMonth()+1;
    Day = day.getDate();
    CurrentDate += Year;
    if (Month >= 10 ){
     CurrentDate += Month;
    }
    else{
     CurrentDate += "0" + Month;
    }
    if (Day >= 10 ){
     CurrentDate += Day ;
    }
    else{
     CurrentDate += "0" + Day ;
    }
    return CurrentDate;
 }
/**
 * 获取当前月的第一天
 */
function getCurrentMonthFirst(){
 var date=new Date();
 date.setDate(1);
 return date;
}
/**
 * 获取当前月的最后一天
 */
function getCurrentMonthLast(){
 var date=new Date();
 var currentMonth=date.getMonth();
 var nextMonth=++currentMonth;
 var nextMonthFirstDay=new Date(date.getFullYear(),nextMonth,1);
 var oneDay=1000*60*60*24;
 return new Date(nextMonthFirstDay-oneDay);
} 

//将字符串转换为日期
String.prototype.toDate = function(format) {
	if(typeof format == "undefined") format = "yyyyMMdd";
    pattern = format.replace("yyyy", "(\\~1{4})").replace("yy", "(\\~1{2})")
.replace("MM", "(\\~1{2})").replace("M", "(\\~1{1,2})")
.replace("dd", "(\\~1{2})").replace("d", "(\\~1{1,2})").replace(/~1/g, "d");

    var returnDate;
    if (new RegExp(pattern).test(this)) {
        var yPos = format.indexOf("yyyy");
        var mPos = format.indexOf("MM");
        var dPos = format.indexOf("dd");
        if (mPos == -1) mPos = format.indexOf("M");
        if (yPos == -1) yPos = format.indexOf("yy");
        if (dPos == -1) dPos = format.indexOf("d");
        var pos = new Array(yPos + "y", mPos + "m", dPos + "d").sort();
        var data = { y: 0, m: 0, d: 0 };
        var m = this.match(pattern);
        for (var i = 1; i < m.length; i++) {

            if (i == 0) return;
            var flag = pos[i - 1].split('')[1];
            data[flag] = m[i];
        };

        if (data.y.toString().length == 2) {
            data.y = parseInt("20" + data.y);
        }
        data.m = data.m - 1;
        returnDate = new Date(data.y, data.m, data.d);
    }
    if (returnDate == null || isNaN(returnDate)) returnDate = new Date();
    return returnDate;
}

$(function($){
    $.datepicker.regional['zh-CN'] = {  
        closeText: '关闭',  
        prevText: '<上月',  
        nextText: '下月>',  
        currentText: '今天',  
        monthNames: ['一月','二月','三月','四月','五月','六月',  
        '七月','八月','九月','十月','十一月','十二月'],  
        monthNamesShort: ['一','二','三','四','五','六',  
        '七','八','九','十','十一','十二'],  
        dayNames: ['星期日','星期一','星期二','星期三','星期四','星期五','星期六'],  
        dayNamesShort: ['周日','周一','周二','周三','周四','周五','周六'],  
        dayNamesMin: ['日','一','二','三','四','五','六'],  
        weekHeader: '周',  
        dateFormat: 'yy-mm-dd',  
        firstDay: 1,  
        isRTL: false,  
        showMonthAfterYear: true,  
        yearSuffix: ' 年 '};  
    $.datepicker.setDefaults($.datepicker.regional['zh-CN']);  
});

function timeConvertToSnp(serverType,timeVal,typeFlag,increased){
    //startTimeFlag
    //typeFlag 1:concreteTime,2:interValTime
	//notice: 中国和Date控件标准时间存在8个小时的时差
        var snpIdVal;
        var loopInt;
        //var startTimeMin = null;
        var startTime = null;
        var timeValTime = null;
        var twentyFourTime = null;
        var snpIdValArray = null;
        var arrayHourMin = splitByLineByFlag(timeVal,":");
       
        if("1"==typeFlag){
        	var twentyFourTime = new Date();
        	timeValTime = new Date();
        	//arrayHourMin = splitByLineByFlag(timeVal,":");
        	twentyFourTime.setHours(24+8,0,0,0);
        	timeValTime.setHours(parseInt(arrayHourMin[0])+8, parseInt(arrayHourMin[1]), 0,0);
        	//startTimeMin = splitByLineByFlag(getStartTimeForStr(serverType),":");
        	startTime = getStartTime(serverType);
        	
            if(timeValTime.getTime()<startTime.getTime()){
        	    snpIdVal = twentyFourTime.getTime() - startTime.getTime() + timeValTime.getTime();
            }
            //snpIdVal=(24-startTimeFlag+parseInt(arrayHourMin[0]))*60+parseInt(arrayHourMin[1]);
        //if(parseInt(arrayHourMin[0])>=8)
            else
        	    snpIdVal = timeValTime.getTime() - startTime.getTime();
            //snpIdVal=(arrayHourMin[0]-8)*60+parseInt(arrayHourMin[1]);
        //snpIdVal = snpIdVal.toString();
            snpIdVal = Highcharts.dateFormat('%H:%M', snpIdVal);
            snpIdValArray = splitByLineByFlag(snpIdVal,":");
            snpIdVal=parseInt(snpIdValArray[0])*60+parseInt(snpIdValArray[1]);
            //increased时间上的加减数
            if(typeof increased != "undefined"){
            	snpIdVal = snpIdVal+increased;
            }
            loopInt = snpIdVal.toString().length;
                if(loopInt<4){
                    for(i=0;i<4-loopInt;i++){
                        snpIdVal = "0"+snpIdVal;
                    }
                }
            }
        if("2"==typeFlag){
        	snpIdVal=parseInt(arrayHourMin[0])*60+parseInt(arrayHourMin[1]);
        }
        return snpIdVal;
    }

function initTimeControl(controlNm,defjson){
    var fromnow=0,placement='bottom',align='left',donetext='',autoclose=true,twelvehour=false,vibrate=true;
    if(defjson.fromnow !== undefined)fromnow=defjson.fromnow;
    if(defjson.placement !== undefined)placement=defjson.placement;
    if(defjson.align !== undefined)align=defjson.align;
    if(defjson.donetext !== undefined)donetext=defjson.donetext;
    if(defjson.autoclose !== undefined)autoclose=defjson.autoclose;
    if(defjson.twelvehour !== undefined)twelvehour=defjson.twelvehour;
    if(defjson.vibrate !== undefined)vibrate=defjson.vibrate;            
    $("#"+controlNm).clockpicker({
        		//'default': '08:00',       // default time, 'now' or '13:14' e.g.
                 fromnow: fromnow,          // set default time to * milliseconds from now (using with default = 'now')
                 placement: placement, // clock popover placement
                 align: align,       // popover arrow align
                 donetext: donetext,    // done button text
                 autoclose: autoclose,    // auto close when minute is selected
                 twelvehour: twelvehour, // change to 12 hour AM/PM clock from 24 hour
                 vibrate: vibrate     
    });
}

function getStartTime(serverTypeId){
    var execDate = new Date();
    
    if("1"==serverTypeId)execDate.setHours(16,0,0,0);
    if("2"==serverTypeId)execDate.setHours(16,30,0,0);
    if("3"==serverTypeId)execDate.setHours(16,30,0,0);
    if("4"==serverTypeId)execDate.setHours(17,0,0,0);
    if("5"==serverTypeId)execDate.setHours(17,0,0,0);
    
    return execDate;
}
function getStartTimeForStr(serverTypeId){
	var timeStr = "";
    if("1"==serverTypeId)timeStr="08:00";
    if("2"==serverTypeId)timeStr="08:30";
    if("3"==serverTypeId)timeStr="08:30";
    if("4"==serverTypeId)timeStr="09:00";
    if("5"==serverTypeId)timeStr="09:00";
    return timeStr;
}

function getStopTimeForStr(serverTypeId){
	var timeStr = "";
    if("1"==serverTypeId)timeStr="07:50";
    if("2"==serverTypeId)timeStr="08:20";
    if("3"==serverTypeId)timeStr="08:20";
    if("4"==serverTypeId)timeStr="08:50";
    if("5"==serverTypeId)timeStr="08:50";
    return timeStr;
}

function splitByLastFlag(str,flag){
    var arr=str.split('_');
    var lastStr=null;
    var beforeStr=arr[0];
    var rtnArray = new Array();
    lastStr = arr[arr.length - 1];
    for(i=1;i<arr.length-1;i++){
        beforeStr+="_"+arr[i];
    }
     rtnArray.push(beforeStr);
     rtnArray.push(lastStr);
     return rtnArray;
    
}

function init(){ 
	 windowHeight=$(window).height(); 
	 windowWidth=$(window).width(); 
	 popHeight=$(".window").height(); 
	 popWidth=$(".window").width(); 
}
 
function closeWindow(){
	
}

function show_num(n,idx){
	var par = $(".t_num");
    var it = $(par[idx]).children("i");
    
    var len = String(n).length; 
    for(var i=0;i<len;i++){ 
        if(it.length<=i){
            $($(".t_num")[idx]).append("<i></i>"); 
        } 
        var num=String(n).charAt(i); 
        var y = -parseInt(num)*30; //y轴位置 
        var obj = it.eq(i); 
        obj.animate({ //滚动动画 
            backgroundPosition :'(0 '+String(y)+'px)'  
            }, 'slow','swing',function(){} 
        ); 
    }
}