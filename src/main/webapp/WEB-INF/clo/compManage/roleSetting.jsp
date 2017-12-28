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
 <%--  <form id="roleSetting" name="roleSetting"  action="<c:url value='/compManage/roleRightSet.do' />" > --%>
  <div style="border:1px solid #C0C0C0;width:100%;height:100%;">
    <div class="gridtable" class="roleGridTbl" style="position:absolute;width:30%;margin-top:5%;border:1px">
     
     <table id="gridTbl"></table>
        
        <button id="roleRightSet" name="roleRightSet" style="width:20%;height:25px;margin-top:10%;float:right;FONT-SIZE: 12px;" onclick="roleRightSet();">保存设置</button>
        <button id="back" name="back" style="width:20%;height:25px;margin-top:10%;float:right;FONT-SIZE: 12px;" onclick="back();">返回</button>
   
     <!-- jqGrid 分页 div gridPager -->
 
<!--      <div id="gridPager"></div> -->
   </div>
   <div style="height:30px;background:#0B61A4;width:20%;margin-top:5%;font-weight:800;font-size:13;text-align:center;line-height:30px;border-width:2px;border-style:solid;border-color:#C0C0C0;margin-left:35%;width:25%;">
       <ul style="">菜单列表</ul>
       <ul id="menuTree" class="ztree" style=""></ul>
   </div>
 </div>
<!--  </form> -->
<input type="hidden" name = "roleIdIpt" id = "roleIdIpt" value="<c:out value='${role.role_id }' />">
<input type="hidden" name = "menuIdsIpt" id = "menuIdsIpt" value="<c:out value='${role.menu_ids }' />">
</body>
<script type="text/javascript">

//global var
var lastgridCheck;
function gridTblLoad(){
        
        $("#gridTbl").jqGrid({
        url:"<c:url value='/compManage/findRows.do'/>",
        datatype:"local", //数据来源，本地数据
        mtype:"POST",//提交方式
        height:"auto",//高度，表格高度。可为数值、百分比或'auto'
        //width:1000,//这个宽度不能为百分比
        autowidth:true,//自动宽
        autoScroll: false,
        multiselect:true,
        shrinkToFit:true,
        hidegrid:true,    //seq_id,server_id,server_name,server_desc,server_type_id from dim_cm_server_info
        colNames:['角色名称','角色名称详述','role_id'],
        colModel:[
           /*  {name:'chkbox',index:'chkbox', width:'6px',align:'center',edittype:'checkbox',formatter:'checkbox',editable:true}, */
            {name:'role_name',label:'role_name',index:'role_name', width:'15px',align:'center',editable:false},
            {name:'role_desc',label:'role_desc',index:'role_desc',width:'20px',align:'center',editable:false},
            {name:'role_id',label:'role_id',index:'role_id',hidden:true,editable:true, formatter:'integer',editrules: { edithidden: true }}
        ],
        rownumbers:false,//添加左侧行号
        //altRows:true,//设置为交替行表格,默认为false
        //sortname:'createDate',
        //sortorder:'asc',
        viewrecords: true,//是否在浏览导航栏显示记录总数
        rowNum:15,//每页显示记录数
        rowList:[15,20,25],//用于改变显示行数的下拉列表框的元素数组。
        caption: '角色列表', 
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
        //alert($("#gridTbl").jqGrid('getGridParam','records'));
         $("#gridTbl").setGridHeight('auto');
         adjust_height();
         var mySelRow = $("#roleIdIpt").val();
         var gridrecords = $("#gridTbl").jqGrid('getGridParam','records');
         for(i=1;i<gridrecords+1;i++){
             if(mySelRow==$("#gridTbl").getCell(i,"role_id")){
                 $("#gridTbl").jqGrid('setSelection',i);
             }
         }
        },
/*         pager:$('#gridPager'), */
        saveRow: function (rowid, successfunc, url, extraparam, aftersavefunc,errorfunc, afterrestorefunc){
            //alert("here11111");
            return success;
        },
        onSelectRow: function(id){
             if(lastgridCheck==id)
                 return;
             
             var gridrecords = $("#gridTbl").jqGrid('getGridParam','records');
             for(i=1;i<gridrecords+1;i++){
                 $("#gridTbl").jqGrid('resetSelection',i);
             }
             lastgridCheck = id;
             $("#gridTbl").jqGrid('setSelection',id);
            //alert("select Row");
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

 }
}); 
}
      $(document).ready(function(){
            gridTblLoad();
            gridOperDef();
            var myGrid = $("#gridTbl"); 
            $("#cb_"+myGrid[0].id).hide(); 

      
                   $("#search").click( function() {
                    });
                   $("#gridTbl").jqGrid('setGridParam',{datatype:'json'});
                   $("#gridTbl").trigger('reloadGrid');
                   menuTreeInit();
      });
    
function menuTreeInit(){
    var treeNodes;
    var zTree;
    var treeNodesObj;
    var selmenuIdsArray;
    $.ajax({
         type:"POST",
         async:false,
         url:"<c:url value='/compManage/findMenuTree.do'/>",
         dataType:"json",
         success:function(data){
             if(data.length>0){
                 var selmenuIdsStr = $("#menuIdsIpt").val();
                 treeNodes = data;
                 if(selmenuIdsStr!=undefined&&typeof selmenuIdsStr!=undefined&&selmenuIdsStr!="0"){
                     selmenuIdsArray=selmenuIdsStr.split(",");
                 }
             }
         }
    });
    
    var setting = {
       
        view:{
            selectedMulti:false,
            showIcon: false
        },
        edit: {
            enable: false,
            editNameSelectAll:true,
            removeTitle:'删除',
            renameTitle:'重命名'
        },
        
        data: {
            key: {
				children: "children",
				name: "name",
				title: "菜单导航",
				url: "url"
			},
            keep:{
                parent:true,
                leaf:true
            },
            simpleData: {
                enable: true
            }
       },
       
       check: {
           enable: true
//        chkboxType : { "Y" : "", "N" : "" }
       },
/*        callback:{
           beforeRemove:beforeRemove,//点击删除时触发，用来提示用户是否确定删除
           beforeEditName: beforeEditName,//点击编辑时触发，用来判断该节点是否能编辑
           beforeRename:beforeRename,//编辑结束时触发，用来验证输入的数据是否符合要求
           onRemove:onRemove,//删除节点后触发，用户后台操作
           onRename:onRename,//编辑后触发，用于操作后台
           beforeDrag:beforeDrag,//用户禁止拖动节点
           onClick:clickNode//点击节点触发的事件
       } */
    };
    
    //循环一级结点
    zTree = $.fn.zTree.init($("#menuTree"),setting, treeNodes);
    treeNodesObj = zTree.getNodes();
    if(selmenuIdsArray){
        for(i=0;i<selmenuIdsArray.length;i++){
            for(j=0;j<treeNodesObj.length;j++){
                if(selmenuIdsArray[i]==treeNodesObj[j].id){
                    zTree.checkNode(treeNodesObj[j],true,true);
                }
            }
        }
        
        //循环二级结点
        for(i=0;i<treeNodesObj.length;i++){
            var treeNodesObjChilds = treeNodesObj[i].children;
            if(treeNodesObjChilds){
              for(j=0;j<treeNodesObjChilds.length;j++){
                //if(treeNodesObjChilds[j]){}
                var checkFlag = false;
                for(m=0;m<selmenuIdsArray.length;m++){
                    if(treeNodesObjChilds[j].id==selmenuIdsArray[m]){
                        checkFlag = true;
                    }
                }
                if(false==checkFlag){
                    zTree.checkNode(treeNodesObjChilds[j],false,false);
                }
            }
          }
        }
    }
}
function chk(cellValue,options,rowObject){
    var chkbox = "<input type='checkbox'/>";
    return chkbox;
}


function roleRightSet(){
    var jsonReq;
    var chkNodesArray = new Array();
    var zTree = $.fn.zTree.getZTreeObj("menuTree");
    var chkNodes = zTree.getCheckedNodes(true);
    var gridSelIds = $("#gridTbl").jqGrid("getGridParam", "selrow");
    var rowDatas;
    if(chkNodes.length==0||gridSelIds.length==0){
        alert('请选择角色和菜单项');
        return;
    }
    rowDatas = $("#gridTbl").jqGrid('getRowData',gridSelIds[0]);
    for(i=0;i<chkNodes.length;i++){
        chkNodesArray.push({menuId:chkNodes[i].id});
    }
    jsonReq = {role_id:rowDatas["role_id"],role_name:rowDatas["role_name"],role_desc:rowDatas["role_desc"],menuIds:JSON.stringify(chkNodesArray)};
    $.ajax({
         type:"POST",
         async:false,
         url:"<c:url value='/compManage/roleSetting.do'/>",
         dataType:"json",
         data:jsonReq,
         success:function(data){
             alert(data.msg);
         }
    });
}
          function back(){
              window.history.back();
          }
</script>
</html>
