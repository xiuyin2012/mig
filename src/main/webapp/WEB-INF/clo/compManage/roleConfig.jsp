<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>
<%@ page isELIgnored="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    
    <title></title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	<script type="text/javascript">
	
	

	</script>

  </head>
  
  <body>
     <form id="roleConfigForm" name="roleConfigForm" action="" method="post">
         <input type="hidden" id="role_id" name="role_id" />
         <input type="hidden" id="role_name" name="role_name" />
     </form>
     
     <!-- <div class="search">
                            <div class="dateFont1">服务器类别</div>
                            <div class="ipt" ><select class="serverSel" id="serverTypeIpt" name="serverTypeIpt" onChange="serverTypeChange()"></select></div>
                            <div class="dateFont1">指标</div>
                            <div class="ipt"><select class="kpiSel" id="kpiIpt" name="kpiIpt"></select></div>
              
        <input type="hidden" name="action" value="getUser"/> 
        <div class="searchBtn"><input class="btn" type="button" value = "查询" id = "search"/></div>
     </div> -->
     <div class="gridtableSingle" style="width:70%">
     
     <table id="gridTbl"></table>
          
     <!-- jqGrid 分页 div gridPager -->
 
     <div id="gridPager"></div>
   </div>
<%--    <input type="hidden" name="serverType" id = "serverType" value="2"/>   
   <input type="hidden" name="serverId" id="serverId" value="<c:out value='${serverId }' />" />  --%>  
                                                               
  </body>
<%--   <%@ include file="cpuChart.jsp" %> --%>
  <script type="text/javascript">
     
     //grid load
     var lastSel = "";
          
     function gridTblLoad(){
        
        $("#gridTbl").jqGrid({
        url:"<c:url value='/compManage/findRows.do'/>",
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        shrinkToFit:true,
        hidegrid:true,    //seq_id,server_id,server_name,server_desc,server_type_id from dim_cm_server_info
        colNames:['Action','角色名称','角色名称详述','角色分配', '权限分配','role_id'],
        colModel:[
            {name:'action',index:'action',sortable:false, width:'41px',formatter: displayButtons,align:'center'},
            {name:'role_name',label:'role_name',index:'role_name', width:'15px',align:'center',editable:true},
            {name:'role_desc',label:'role_desc',index:'role_desc',width:'20px',align:'center',editable:true},
            {name:'p_config',label:'p_config',index:'p_config',width:'10px',align:'center',formatter:displayConfig},
            {name:'role_config',label:'role_config',index:'role_config',width:'10px',align:'center',formatter:displayConfig},
            {name:'role_id',label:'role_id',index:'role_id',hidden:true,editable:true, formatter:'integer',editrules: { edithidden: true }}
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: '角色权限配置表', 
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
            initdata = {"menu_ids":""};
           

      
                   $("#search").click( function() {
                    });
                    
                    
                   $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
                   $("#gridTbl").trigger('reloadGrid');
                      
                      
                      
    });

function displayButtons(cellvalue, options, rowObject)
    {
           
     //   alert(rowObjStr["seqId"]);
       
        var edit = "<input style='...'  class='cellbtn' type='button' id = 'Edit' value='Edit' onclick=\"jqGridEditRow('" + options.rowId + "');\"  />",
             save = "<input style='...' class='cellbtn' type='button' id = 'Save'  value='Save' onclick=\"jqGridSaveRow('"+rowObject+"','"+ options.rowId +"','"+rowObject.role_id+"');\" />",
             deleteR = "<input style='...' class='cellbtn' type='button' value='Del' onclick=\"jqGriddelRowData('"+rowObject+"','"+ options.rowId +"');\" />",
             restore = "<input style='...' class='cellbtn' type='button' value='Cancel' onclick=\"jQuery('#gridTbl').restoreRow('" + options.rowId + "');\" />";
        return edit+save+deleteR+restore;
    }
    
function displayConfig(cellValue,options,rowObject){
    var config = "<input style='...' class='cellbtnall' type='button' id = 'Save'  value='配置' onclick=\"jqGridConfig('"+ options.rowId+"','"+options.colModel.label+"');\" />";
    return config;
}

var lastEditRow;
function jqGridEditRow(rowId){
    if(rowId!==lastEditRow){
        jQuery('#gridTbl').restoreRow(lastEditRow); 
        lastEditRow = rowId;
    }
    $("#gridTbl").editRow(rowId);
}

function jqGriddelRowData(rowObject,rowId){
 var roleId = $("#gridTbl").getCell(rowId,"role_id");
    if(!getSysUsers(roleId)){
         jQuery('#gridTbl').restoreRow(rowId);
         return false;
     }
 if(confirm("确定要删除吗？")){
   
    var isSuccess = $("#gridTbl").jqGrid('delRowData', rowId);
    if(isSuccess){
             $.ajax({
                      type:"POST",
                      async:false,
                      url:"<c:url value='/compManage/deleteRole.do'/>",
                      data:{role_id:roleId},
                      dataType:"json",
                      success:function(data){
                         if("1"==data.status){
                               alert("成功删除！");
                         }
                         if("0"==data.status){
                             alert(data.msg);
                         }
                      }
             }); 
    }
 }
}

 function saveRowCall(){
   

 }
 
function jqGridConfig(rowId,action){
    var roleId = $("#gridTbl").getCell(rowId,"role_id");
    if(roleId==undefined){
        alert("配置角色不存在，请保存后配置");
        return;
    }
    jQuery('#gridTbl').restoreRow(rowId);
    $("#role_id").val(roleId);
    $("#role_name").val($("#gridTbl").jqGrid('getRowData',rowId)["role_name"]);
    if(action=="role_config"){
        $("#roleConfigForm").attr("action","<c:url value='/compManage/configRole.do'/>");
    }
    if(action=="p_config"){
        $("#roleConfigForm").attr("action","<c:url value='/compManage/configPRole.do'/>");
    }
    $("#roleConfigForm").submit();
}
 
 function getSysUsers(roleId){
     var isOk = true;
     if(roleId == 'undefined'){
         return true;
     }
     $.ajax({
         type:"POST",
         async:false,
         url:"<c:url value='/compManage/getSysUsers.do'/>",
         data:{role_id:roleId},
         dataType:"json",
         success:function(data){
             if(data.length>0){
                 alert("角色已经分配到人员,不可以修改或删除");
                 isOk = false;
             }
         }
    });
    return isOk; 
 }
 function jqGridSaveRow(rowObject,rowId,roleId){
     if(!getSysUsers(roleId)){
         jQuery('#gridTbl').restoreRow(rowId);
         return false;
     }
     $("#gridTbl").jqGrid('saveRow', rowId,{
         url: "<c:url value='/compManage/updateRole.do'/>",
         mtype: "POST",
         extraparam:  rowObject,
         aftersavefunc: function( rowid, response){
           if("0"==response.responseJSON.status){
               $("#gridTbl").jqGrid('delRowData', rowId);
               alert(response.responseJSON.msg);
           }
           if("1"==response.responseJSON.status){
               $("#gridTbl").jqGrid().setCell(rowId,5,response.responseJSON.role_id);
               alert("保存成功!");
           }
           return true;
         }
     });
}
</script>
</html> 