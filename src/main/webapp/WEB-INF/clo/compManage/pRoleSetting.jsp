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
     </form>
     <input type="hidden" name="role_name" id="role_name" value="<c:out value='${role.role_name }'/>"/>
     <!-- <div class="search">                               
                            <div class="dateFont1">服务器类别</div>
                            <div class="ipt" ><select class="serverSel" id="serverTypeIpt" name="serverTypeIpt" onChange="serverTypeChange()"></select></div>
                            <div class="dateFont1">指标</div>
                            <div class="ipt"><select class="kpiSel" id="kpiIpt" name="kpiIpt"></select></div>
              
        <input type="hidden" name="action" value="getUser"/> 
        <div class="searchBtn"><input class="btn" type="button" value = "查询" id = "search"/></div>
     </div> -->
     <div class="gridtableSingle"style="width:55%">
     
     <table id="gridTbl"></table>
     <button id="back" name="back" style="width:10%;height:25px;margin-top:5%;float:top;FONT-SIZE: 12px;" onclick="back();">返回</button>
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
        url:"<c:url value='/compManage/findPRoles.do'/>",
        async:false,
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        shrinkToFit:true,
        hidegrid:true,    //seq_id,server_id,server_name,server_desc,server_type_id from dim_cm_server_info
        colNames:['Action','角色','用户ID','role_id','my_oper'],
        colModel:[
            {name:'action',index:'action',sortable:false, width:'35px',formatter: displayButtons,align:'center'},
            {name:'role_name',label:'role_name',index:'role_name', width:'15px',align:'center',editable:false},
            {name:'user_id',label:'user_id',index:'user_id',width:'35px',align:'center',editable:true,edittype:'select',formatter:'select',editoptions:{value:getUser()}},
            {name:'role_id',label:'role_id',index:'role_id',hidden:true,editable:true, formatter:'integer',editrules: { edithidden: true }},
            {name:'my_oper',label:'my_oper',index:'my_oper',hidden:true,editable:true, editrules: { edithidden: true }}
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: '角色配置表', 
         prmNames : { 

             page:"page",    // 表示请求页码的参数名称 

             rows:"rows",
             
             search : "search",
                
             id : "id"
             
         },
         
         postData:{
         role_id:"<c:out value='${role.role_id }' />"
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
            var records = $("#gridTbl").jqGrid('getGridParam','records');
            for(i=1;i<records+1;i++){
                $("#gridTbl").setCell(i,"role_name",$("#role_name").val());
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
     $("#gridTbl").setCell(rowId,"role_name",$("#role_name").val());
     $("#gridTbl").setCell(rowId,"role_id","<c:out value='${role.role_id }' />");
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
            initdata = {"my_oper":"add"};   //$("#gridTbl").setCell(rowId,"my_oper","add");
            $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
            $("#gridTbl").trigger('reloadGrid');
      });

function displayButtons(cellvalue, options, rowObject)
    {
       rowObjectGlobal = rowObject;
        var edit = "<input style='...'  class='cellbtn' type='button' id = 'Edit' value='Edit' onclick=\"jqGridEditRow('" + options.rowId + "');\"  />",
             save = "<input style='...' class='cellbtn' type='button' id = 'Save'  value='Save' onclick=\"jqGridSaveRow('"+rowObject+"','"+ options.rowId +"');\" />",
             deleteR = "<input style='...' class='cellbtn' type='button' value='Del' onclick=\"jqGriddelRowData('"+rowObject+"','"+ options.rowId +"');\" />",
             restore = "<input style='...' class='cellbtn' type='button' value='Cancel' onclick=\"jQuery('#gridTbl').restoreRow('" + options.rowId + "');\" />";
        return edit+save+deleteR+restore;
    }
    
function displayConfig(cellValue,options,rowObject){
    var config = "<input style='...' class='cellbtnall' type='button' id = 'Save'  value='配置' onclick=\"jqGridConfig("+rowObject.role_id+",'"+ options.rowId+"','"+options.colModel.label+"');\" />";
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
 var userId = $("#gridTbl").getCell(rowId,"user_id");
 if(confirm("确定要删除吗？")){
   
    var isSuccess = $("#gridTbl").jqGrid('delRowData', rowId);
    if(isSuccess){
             $.ajax({
                      type:"POST",
                      async:false,
                      url:"<c:url value='/compManage/updateUser.do'/>",
                      data:{user_id:userId,role_id:"0"},
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
 
function jqGridConfig(roleId,rowId,action){
    if(roleId==undefined){
        alert("配置角色不存在，请保存后配置");
        return;
    }
    $("#role_id").val(roleId);
    if(action=="role_config"){
        $("#roleConfigForm").attr("action","<c:url value='/compManage/configRole.do'/>");
    }
    if(action=="p_config"){
        $("#roleConfigForm").attr("action","<c:url value='/compManage/configRole.do'/>");
    }
    $("#roleConfigForm").submit();
}

 function jqGridSaveRow(rowObject,rowId){
    
     var userIdSel = $("select[name=user_id]")[0];
     var userId = $(userIdSel).val();
     var gridrecords = $("#gridTbl").jqGrid('getGridParam','records');
     for(i=1;i<gridrecords+1;i++){
         if(i!=rowId){
             if(userId==$("#gridTbl").getCell(i,"user_id")){
                 alert("已存在相同配置");
                 
                 $('#gridTbl').restoreRow(rowId);
                 return false;
             }
         }
     }
     $("#gridTbl").jqGrid('saveRow', rowId,{
         url: "<c:url value='/compManage/updateUser.do'/>",
         mtype: "POST",
         extraparam:  rowObject,
         aftersavefunc: function( rowid, response){
           if("0"==response.responseJSON.status){
               $("#gridTbl").jqGrid('delRowData', rowId);
               alert(response.responseJSON.msg);
           }
           if("1"==response.responseJSON.status){
               $("#gridTbl").setCell(rowId,"my_oper","");
               alert("保存成功!");
           }
           return true;
         }
     });
}

    function getUser(){
    //动态生成select内容
        var str = "";
        $.ajax({
            type:"post",
            url:"<c:url value='/compManage/getSysUsers.do'/>",
            async:false,
            success:function(data){
                if (data != null) {
                    var jsonobj=data;
                    var length=jsonobj.length;
                    for(var i=0;i<length;i++){
                        if(i!=length-1){
                            str+=jsonobj[i].user_id+":"+jsonobj[i].user_id+";";
                        }else{
                            str+=jsonobj[i].user_id+":"+jsonobj[i].user_id;
                        }
                    }   
                }
            }
         });       
         return str;
     }
     
          function back(){
              window.history.back();
          }
</script>
</html>