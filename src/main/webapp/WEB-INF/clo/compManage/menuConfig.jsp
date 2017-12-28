<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title>My JSP 'processSubmit.jsp' starting page</title>
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
     <!-- <div class="search">
                            <div class="dateFont1">服务器类别</div>
                            <div class="ipt" ><select class="serverSel" id="serverTypeIpt" name="serverTypeIpt" onChange="serverTypeChange()"></select></div>
                            <div class="dateFont1">指标</div>
                            <div class="ipt"><select class="kpiSel" id="kpiIpt" name="kpiIpt"></select></div>
              
        <input type="hidden" name="action" value="getUser"/> 
        <div class="searchBtn"><input class="btn" type="button" value = "查询" id = "search"/></div>
     </div> -->
     <div class="gridtableSingle" style="width:95%;">
     
     <table id="gridTbl"></table>
     <!-- jqGrid 分页 div gridPager -->
 
     <div id="gridPager"></div>
   </div>
   
   <div class="chart">
   <div id="chart_spline">
        
   </div>
   </div>
   <input type="hidden" name="serverType" id = "serverType" value="2"/>   
   <input type="hidden" name="serverId" id="serverId" value="<c:out value='${serverId }' />" />   
                                                               
  </body>
<%--   <%@ include file="cpuChart.jsp" %> --%>
  <script type="text/javascript">
     
     //global var
     var lastSel = "";
          
     function superMenus(){
           var str = "0:ROOT";
           $.ajax({
                   type:"POST",
                   async:false,
                   url:"<c:url value='/compManage/findSuperMenus.do'/>",
                   dataType:"json",
                   success:function(data){
                        if (data.length!= 0) {
                               str+=";";
                               var jsonobj=data;
                               var length=jsonobj.length;
                               for(var i=0;i<length;i++){
                                    if(i!=length-1){
                                         str+=jsonobj[i].menu_id+":"+jsonobj[i].menu_name+";";
                                    }else{
                                         str+=jsonobj[i].menu_id+":"+jsonobj[i].menu_name;
                                    }
                               }   
                       }
                       
                   }
                });
                return str;
     }
     
     //grid load       
     function gridTblLoad(){
        
        $("#gridTbl").jqGrid({
        url:"<c:url value='/compManage/findMenus.do'/>",
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        shrinkToFit:true,
        hidegrid:true,    //menu_name,level_status,super_level
        colNames:['Action','菜单名称','菜单级别', '父菜单名称', '服务地址','参数名称','参数值','menuId'],
        colModel:[
            {name:'action',index:'action',sortable:false, width:'51px',formatter: displayButtons,align:'center'},
            {name:'menu_name',label:'menu_name',index:'menu_name', width:'30px',align:'center',editable:true},
            {name:'level_status',label:'level_status',index:'level_status',edittype:'select',formatter:'select',editoptions:{value: {'1':'一级菜单','2':'二级菜单'}}, width:'20px',align:'center',editable:true},
            {name:'super_level',label:'super_level',index:'super_level', align:'center',width:'35px',editable:true,edittype:'select',formatter:'select',editoptions:{value:superMenus()}},
            {name:'menu_url',label:'menu_url',index:'menu_url', width:'50px',align:'center',editable:true},
            {name:'menu_para_nm',label:'menu_para_nm',index:'menu_para_nm', width:'35px',align:'center',editable:true},
            {name:'menu_para',label:'menu_para',index:'menu_para', width:'15px',align:'center',editable:true},
            {name:'menu_id',label:'menu_id',index:'menu_id',hidden:true,editable:true, formatter:'integer',editrules: { edithidden: true }}
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: '菜单配置表', 
         prmNames : { 

             page:"page",    // 表示请求页码的参数名称 

             rows:"rows",
             
             search : "search",
                
             id : "id"
             
         },
         
         postData:{
         },
         
        jsonReader:{
            root: "rows",   // json中代表实际模型数据的入口 
            repeatitems : false,
            records:"records",
            total:"total"
        },
                
        gridComplete: function() {
         $("#gridTbl").setGridHeight('auto');
         adjust_height();
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
          
                      $("#gridTbl").jqGrid('setGridParam',{   
                                                              datatype:"json",
                                                              postData:{},
                                                              page:toPage
                                                              }).trigger('reloadGrid');
                     
          }
          //next_gridPager,user,prev_gridPager,last_gridPager,first_gridPager
        },
        pager:$('#gridPager'),
        saveRow: function (rowid, successfunc, url, extraparam, aftersavefunc,errorfunc, afterrestorefunc){
            //alert("here11111");
            return success;
        },
        
           addRowData: function (rowid, rdata, pos, src) {
  // alert("addRowData");
   if (pos === 'afterSelected' || pos === 'beforeSelected') {
    if (typeof src === 'undefined' && this[0].p.selrow !== null) {
     src = this[0].p.selrow;
     pos = (pos === "afterSelected") ? 'after' : 'before';
    } else {
     pos = (pos === "afterSelected") ? 'last' : 'first';
    }
   }
   return oldAddRowData.call(this, rowid, rdata, pos, src);
  },
         
         
         
         
 afterInsertRow:function(rowId,rowData,rowElem){

 },        
         
         
 onSelectRow: function(id){
     if(lastEditRow){
         jQuery('#gridTbl').restoreRow(lastEditRow); 
     }
     if(id && id!==lastSel){
            
            
            jQuery('#gridTbl').restoreRow(lastSel); 
           
            lastSel=id;
     }
     
     $('#gridTbl').jqGrid('editRow',id,true);

   }
  }); 
}
            
      $(document).ready(function(){
            gridTblLoad();
            gridOperDef();
           
           

      
                   $("#search").click( function() {
                    });
                    
                    
                   $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
                   $("#gridTbl").trigger('reloadGrid');
                      
                      
                      
    });

function displayButtons(cellvalue, options, rowObject)
    {
           
           var rowObjStr = JSON.stringify(rowObject);
     //   alert(rowObjStr["seqId"]);
       
        var edit = "<input style='...'  class='cellbtn' type='button' id = 'Edit' value='Edit' onclick=\"jqGridEditRow('" + options.rowId + "');\"  />",
             save = "<input style='...' class='cellbtn' type='button' id = 'Save' style='margin-right:10px;' value='Save' onclick=\"jqGridSaveRow('"+rowObject+"','"+ options.rowId +"');\" />",
             deleteR = "<input style='...' class='cellbtn' type='button' value='Del' onclick=\"jqGriddelRowData('"+rowObject+"','"+ options.rowId +"');\" />",
             restore = "<input style='...' class='cellbtn' type='button' value='Cancel' onclick=\"jQuery('#gridTbl').restoreRow('" + options.rowId + "');\" />";
        return edit+save+deleteR+restore;
    }

var lastEditRow;
function jqGridEditRow(rowId){
    
    var menu_id = $("#gridTbl").getCell(rowId,"menu_id");
    if(rowId!==lastEditRow){
        jQuery('#gridTbl').restoreRow(lastEditRow); 
        lastEditRow = rowId;
    }
    $("#gridTbl").editRow(rowId);
}

function jqGriddelRowData(rowObject,rowId){
    
 var menu_id = $("#gridTbl").getCell(rowId,"menu_id");
 if(confirm("确定要删除吗？")){
   
    var isSuccess = $("#gridTbl").jqGrid('delRowData', rowId);
    if(isSuccess){
             $.ajax({
                      type:"POST",
                      async:false,
                      url:"<c:url value='/compManage/deleteMenu.do'/>",
                      data:{menu_id:menu_id},
                      dataType:"json",
                      success:function(data){
                         if("1"==data.status){
                               alert("成功删除！");
                         }
                      }
             }); 
    }
 }
}

 function saveRowCall(){
   

 }
 function jqGridSaveRow(rowObject,rowId){
     $("#gridTbl").jqGrid('saveRow', rowId,{
         url: "<c:url value='/compManage/upateMenu.do'/>",
         mtype: "POST",
         extraparam:  rowObject,
         aftersavefunc: function( rowid, response){
            
           if("0"==response.responseJSON.status){
               $("#gridTbl").jqGrid('delRowData', rowId);
               alert(response.responseJSON.msg);
           }
           if("1"==response.responseJSON.status){
               $("#gridTbl").jqGrid().setCell(rowId,7,response.responseJSON.menu_id);
               alert("保存成功!");
           }
           return true;
         }
     });
}

function gridOperDef(){
             //定义按键   gridPager 
             
            $("#gridTbl").jqGrid('navGrid', '#gridPager', {edit:false,add:false,del:false,refresh:false,search:false});
            $("#gridTbl").jqGrid('inlineNav','#gridPager', {edit:false,add:false,del:false,refresh:false,search:false
                
           
            
            
            
            }).navButtonAdd('#gridPager',{      
    
   caption:"",       
    
   buttonicon:"ui-icon-plus",
   
   onClickButton : function (){
       $("#gridTbl").jqGrid('addRow');       
   },
   position:"last"      
    
});      
}
  </script>
</html>