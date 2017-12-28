<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>
<%@ page isELIgnored="false"%>
 <script type="text/javascript">
/*    if(""==document.referrer){
      var user_id = "sys_menu";
     var user_pwd = "sys_menu";
   
                    $.ajax({
                         type:"POST",
                         async:false,
                          url:"<c:url value='/compManage/doLogin.do'/>",
                          data:{user_id:user_id,user_pwd:user_pwd},
                          dataType:"json",
                          success:function(resp){
                              if("1"==resp.success){
                                  window.location ="<c:url value='/compManage/toHome.do'/>";
                              }
                              else{
                                  alert(resp.respText);
                                  window.location ="<c:url value='/compManage/toLogin.do'/>";
                                  }
                         }
                      });
  } */
 </script>
<style type="text/css">
.ztree li a.level0 {width:100%;height: 28px; text-align: center; display:block; background-color: #0B61A4; border:1px silver solid;}
.ztree li a.level0.cur {background-color: #66A3D2; }
.ztree li a.level0 span {display: block; color: white; padding-top:3px; font-size:15px; font-weight: bold;word-spacing: 2px;}
.ztree li a.level0 span.button {	float:right; margin-left: 10px; visibility: visible;display:none;}
.ztree li span.button.switch.level0 {display:none;}
.ztree li a.level1 {width:100%;height: 20px; text-align: center; display:block;}
.ztree li a.level1 span {display: block; font-size:12px;word-spacing: 2px;}
</style>
 <body style="overflow-x:hidden;background:white;">
    <div id = "lmenu" class="lmenu">  
    <ul id="ult">
                <li id="lit" style="background:white;" aid="analysis/getAnalysisTender.do?"> 
                <em id="emt" class="iconleaf"></em> 
                <span id="spant" style ="border:1px solid white; background:#4682B4;color: white;"> <em class="icoopen"></em>   
                                                       充值累计统计及趋势
                </span>
                </li>
    </ul>
    <ul>
                <li style="background:white;" aid="<c:out value='${childmenu.menu_url }'/>"  para_nm="<c:out value='${childmenu.menu_para_nm }'/>" para="<c:out value='${childmenu.menu_para }'/>"> 
                <em class="iconleaf"></em>
                <span style ="border:1px solid white; background:#4682B4;color: white;"> <em class="icoopen"></em>  
                                                       实时在线人数
                </span>
                </li>
    </ul>
    <ul>
                <li style="background:white;" aid="<c:out value='${childmenu.menu_url }'/>"  para_nm="<c:out value='${childmenu.menu_para_nm }'/>" para="<c:out value='${childmenu.menu_para }'/>"> 
                <em class="iconleaf"></em>  
                <span style ="border:1px solid white; background:#4682B4;color: white;"> <em class="icoopen"></em>                                       
                                                       终端投注
                </span>
                </li>
    </ul>
    <ul>
                <li style="background:white;" aid="<c:out value='${childmenu.menu_url }'/>"  para_nm="<c:out value='${childmenu.menu_para_nm }'/>" para="<c:out value='${childmenu.menu_para }'/>"> 
                <em class="iconleaf"></em>
                <span style ="border:1px solid white; background:#4682B4;color: white;"> <em class="icoopen"></em>  
                                                       游戏投注
                </span>
                </li>
    </ul>
</div>
</body>
<!-- <script type="text/javascript" src="jquery-1.4.2.js"></script>   -->
<script> 

//local var
var lastobj;
var lastobjhtml;
$(function() {  
            loadMenu(function (obj){
                $(window.parent.document).find("#mainFrame").attr("src", "<c:url value='"+contextPath+obj+"'/>"+"&date=Date().getTime()");
                
                //window.location= "<c:url value='"+contextPath+id+".do'/>";  
            });  
            $('li[aid=]').css('background',"#F5F5F5");  
  
  
        });  
  
  
    /*传入一个函数参数为 id 即li上的属性 aid*/  
    function loadMenu (fun_clickAction) {  
        /*事件回调函数*/  
        clickAction = fun_clickAction;  
        /*一级菜单的样式*/  
        $(".lmenu > ul > li > span").prepend('<em class="icoclose"></em>');  
        /*二级菜单的样式*/  
        $(".lmenu > ul > li > ul > li").each(function(){  
            /*检查是否有节点*/  
            span = $(this).find("span");   
            if ( span.length ){  
                //有节点的话  
                span.prepend('<em class="icoclose2"></em>');  
            }else{  
                //无节点的话,绑定事件  
                $(this).prepend('<em class="iconleaf"></em>')  
                       .click(function(){
                            clickAction($(this));  
                            //obj.attr("style","background:#DDDDDD;");
                       });  
            }  
        });  
        /*三级菜单的样式*/  
        $("li")  
            .prepend('<em class="iconleaf2"></em>')  
            .click(function(){
              
                clickAction($(this).attr('aid'));  
            });  
  
        $(".lmenu ul li span").click(function(){  
            var ye = $(this).find('em');  
            classNama = ye.attr("class");  
            if( classNama == 'icoclose'){ye.attr('class','icoopen');}  
            else if( classNama == 'icoopen' ){ye.attr('class','icoclose');}  
            else if( classNama == 'icoclose2'){ye.attr('class','icoopen2');}  
            else if( classNama == 'icoopen2' ){ye.attr('class','icoclose2');}  
            $(this).siblings("ul").slideToggle("normal","swing");  
        });  
    }  
  
</script>  

