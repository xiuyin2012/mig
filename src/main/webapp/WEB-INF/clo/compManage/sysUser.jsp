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
     <div class="gridtableSingle" style="width:60%">
     
     <table id="gridTbl"></table>
     <!-- jqGrid 分页 div gridPager -->
 
     <div id="gridPager"></div>
   </div>
   
   <div class="chart">
   <div id="chart_spline">
        
   </div>
   </div>
   <c:if test="${sessionScope.userLogin.is_super!='1'}">
   <input type="hidden" name="user_id" id="user_id" value="<c:out value='${sessionScope.userLogin.user_id }'/>"/>
   </c:if>
<%--    <input type="hidden" name="serverType" id = "serverType" value="2"/>   
   <input type="hidden" name="serverId" id="serverId" value="<c:out value='${serverId }' />" />  --%>  
                                                               
  </body>
<%--   <%@ include file="cpuChart.jsp" %> --%>
  <script type="text/javascript">
     
     //global var
     var lastSel = "";
     
     //grid load       
     function gridTblLoad(){
        
        $("#gridTbl").jqGrid({
        url:"<c:url value='/compManage/getSysUsers.do'/>",
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        shrinkToFit:true,
        hidegrid:true,    //seq_id,server_id,server_name,server_desc,server_type_id from dim_cm_server_info
        colNames:['Action','用户名','密码','是否配置管理员','my_oper','update_user_id'],
        colModel:[
            {name:'action',index:'action',sortable:false, width:'30px',formatter: displayButtons,align:'center'},
            {name:'user_id',label:'user_id',index:'user_id', width:'10px',align:'center',editable:true},
            {name:'user_pwd',label:'user_pwd',index:'user_pwd',width:'35px',align:'center',editable:true,formatter:displayPwd,edittype:'password'},
            {name:'is_super',label:'is_super',index:'is_super',width:'10px',align:'center',editable:true},
            {name:'my_oper',label:'my_oper',index:'my_oper',hidden:true,editable:true, editrules: { edithidden: true }},
            <c:if test="${sessionScope.userLogin.is_super!='1'}">
            {name:'user_id',label:'user_id',index:'user_id', width:'10px',align:'center',editable:true,hidden:true}
            </c:if>
            <c:if test="${sessionScope.userLogin.is_super=='1'}">
            {name:'',label:'',index:'', width:'10px',align:'center',editable:true,hidden:true}
            </c:if>
/*             {name:'is_super',label:'is_super',indexis_super'server_desc', width:'10px',align:'center',editable:true,edittype:'select',formatter:'select',editoptions:{value:"1:是;0:否;"}}, */
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: '用户配置表', 
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
           //adjust_height();
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
        <c:if test="${sessionScope.userLogin.is_super=='1'}">
        pager:$('#gridPager'),
        </c:if>
        saveRow: function (rowid, successfunc, url, extraparam, aftersavefunc,errorfunc, afterrestorefunc){
            //alert("here11111");
            return success;
        },
       afterInsertRow:function(rowId,rowData,rowElem){
           /* $("#gridTbl").setCell(rowId,"user_pwd","******************************"); */
       },
     onSelectRow: function(id){
     if(lastEditRow){
         jQuery('#gridTbl').restoreRow(lastEditRow); 
     }
     if(id && id!==lastSel){
            jQuery('#gridTbl').restoreRow(lastSel);
            lastSel=id;
     }
     //$("#gridTbl").setCell(id,"user_pwd",null);
     $('#gridTbl').jqGrid('editRow',id,true);
     $($("input[name=user_pwd]")[0]).val('');
  
     //$("#gridTbl").setCell(id,"user_pwd",);
   }
    }); 
}
            
      $(document).ready(function(){
            gridTblLoad();
            gridOperDef();
            <c:if test="${sessionScope.userLogin.is_super!='1'}">
            $("#gridTbl").jqGrid('getGridParam','colModel')[1].editable = false;
            $("#gridTbl").jqGrid('getGridParam','colModel')[3].editable = false;
            </c:if>
/*            
           

      
                   $("#search").click( function() {
                    }); */
                    
                    
                   $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
                   $("#gridTbl").jqGrid('setPostData',{user_id:$("#user_id").val()});
                   initdata = {"my_oper":"add"}; 
                   $("#gridTbl").trigger('reloadGrid');
  
                      
                      
    });

function displayButtons(cellvalue, options, rowObject)
    {
           
           var rowObjStr = JSON.stringify(rowObject);
     //   alert(rowObjStr["seqId"]);
       
        var edit = "<input style='...'  class='cellbtn' type='button' id = 'Edit' value='Edit' onclick=\"jqGridEditRow('" + options.rowId + "');\"  />",
             save = "<input style='...' class='cellbtn' type='button' id = 'Save' style='margin-right:10px;' value='Save' onclick=\"jqGridSaveRow('"+rowObject+"','"+ options.rowId +"');\" />";
        var     deleteR = "";
             <c:if test="${sessionScope.userLogin.is_super=='1'}">
             deleteR = "<input style='...' class='cellbtn' type='button' value='Del' onclick=\"jqGriddelRowData('"+rowObject+"','"+ options.rowId +"');\" />";
             </c:if>
             
             <c:if test="${sessionScope.userLogin.is_super!='1'}">
             deleteR = "<input style='...' class='cellbtn' type='button' value='  ' />";
             </c:if>
             restore = "<input style='...' class='cellbtn' type='button' value='Cancel' onclick=\"jQuery('#gridTbl').restoreRow('" + options.rowId + "');\" />";

        return edit+save+deleteR+restore;
    }

function displayPwd(cellvalue,options,rowObject){
    if("add"==rowObject.my_oper) return "";
    return "******************************";
}
var lastEditRow;
function jqGridEditRow(rowId){
    if(rowId!==lastEditRow){
        jQuery('#gridTbl').restoreRow(lastEditRow); 
        lastEditRow = rowId;
    }
   // $("#gridTbl").setCell(rowId,"user_pwd",null);
    //alert($($("input[name=user_pwd]")[0]).val());
    $("#gridTbl").editRow(rowId);
    $($("input[name=user_pwd]")[0]).val('');
}

function jqGriddelRowData(rowObject,rowId){
    
 var seqId = $("#gridTbl").getCell(rowId,"user_id");
 if(confirm("确定要删除吗？")){
   
    var isSuccess = $("#gridTbl").jqGrid('delRowData', rowId);
    if(isSuccess){
             $.ajax({
                      type:"POST",
                      async:false,
                      url:"<c:url value='/compManage/delSysUser.do'/>",
                      data:{user_id:seqId},
                      dataType:"json",
                      success:function(data){
                         alert(data.msg);
                      }
             }); 
    }
 }
}

 function saveRowCall(){
   

 }
 function jqGridSaveRow(rowObject,rowId){
     $("#gridTbl").jqGrid('saveRow', rowId,{
         url: "<c:url value='/compManage/updateSysUser.do'/>",
         mtype: "POST",
         extraparam:  rowObject,
         aftersavefunc: function( rowid, response){
            
           if("0"==response.responseJSON.status){
               $("#gridTbl").jqGrid('delRowData', rowId);
               alert(response.responseJSON.msg);
           }
           if("1"==response.responseJSON.status){
               $("#gridTbl").setCell(rowId,"my_oper","");
               $("#gridTbl").setCell(rowId,"user_pwd","******************************");
               alert("保存成功!");
           }
           return true;
         }
     });
}
  </script>
</html>