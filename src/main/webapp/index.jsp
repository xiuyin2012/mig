<html>
<head>
    <meta charset="utf-8" />
    <title>中彩在线</title>
    <link href="jqplot/jquery.jqplot.min.css" rel="stylesheet" />
    <script type="text/javascript" src="jQuery.js"></script>
    <script type="text/javascript" src="jqplot.js"></script>
    <script language="javascript" type="text/javascript" src="jqplot/plugins/jqplot.pieRenderer.js"></script>
    <script src="jqplot/plugins/jqplot.canvasAxisTickRenderer.min.js"></script>
    <script src="jqplot/plugins/jqplot.canvasTextRenderer.js"></script>
    <script src="jqplot/plugins/jqplot.canvasAxisLabelRenderer.js"></script>
    <script src="jqplot/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script src="jqplot/plugins/jqplot.barRenderer.min.js"></script>
    
    
    
    
  <script type="text/javascript" language="javascript">
  
  $(document).ready(function(){
   
 	date = [['趣味高尔夫', 3], ['三江风光', 7], ['deer', 2.5], ['turkeys', 6], ['moles', 5], ['ground hogs', 4]];

    plot1 = $.jqplot('d3', [date], {
       	 	title:' ',//设置饼状图的标题
        	seriesDefaults: {
				renderer:$.jqplot.PieRenderer,
				rendererOptions:{
				showDataLabels: true,
				diameter: undefined, // 设置饼的直径
				padding: 10,        // 饼距离其分类名称框或者图表边框的距离，变相该表饼的直径
				sliceMargin: 3,     // 饼的每个部分之间的距离
				fill:true,         // 设置饼的每部分被填充的状态
				shadow:true,       //为饼的每个部分的边框设置阴影，以突出其立体效果
				showMark:true, //设置是否显示刻度
				shadowOffset: 1,    //设置阴影区域偏移出饼的每部分边框的距离
				shadowDepth: 5,     // 设置阴影区域的深度
				shadowAlpha: 0.07 ,  // 设置阴影区域的透明度
				drawGridLines: true,        // wether to draw lines across the grid or not.
                           // gridLineColor: '#ff0000' ,   // 设置整个图标区域网格背景线的颜色
                            //background: 'fffdf6',      // 设置整个图表区域的背景色
                           // borderColor: '#999999',     // 设置图表的(最外侧)边框的颜色
                            borderWidth: 2.0,           //设置图表的（最外侧）边框宽度
                            shadowAngle: 45,            // 设置阴影区域的角度，从x轴顺时针方向旋转
                            shadowOffset: 1.5,          // 设置阴影区域偏移出图片边框的距离
                            shadowWidth: 3,             // 设置阴影区域的宽度
                            shadowDepth: 3 ,           // 设置影音区域重叠阴影的数量
                            ackground:'rgba(0,255,0,0) !important',//火狐下div背景透明
                            filter:'alpha(opacity=0)',
                           
          }
         },
        legend:{
         show: true,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）
         location: 'nw',     // 分类名称框出现位置, nw, n, ne, e, se, s, sw, w.
         xoffset: 12,        // 分类名称框距图表区域上边框的距离（单位px）
         yoffset: 30,        // 分类名称框距图表区域左边框的距离(单位px)
		 background:'ccffcc', //分类名称框距图表区域背景色
		 textColor:'', //分类名称框距图表区域内字体颜色
        },
        
		grid:{
							ackground:'rgba(0,0,0,0) !important',//火狐下div背景透明
                            filter:'alpha(opacity=0)',
                            drawGridLines: true,        // wether to draw lines across the grid or not.
                            gridLineColor: '#' ,   // 设置整个图标区域网格背景线的颜色
                            background: '#ff0000',      // 设置整个图表区域的背景色
                            borderColor: '#',     // 设置图表的(最外侧)边框的颜色
                            borderWidth: 2.0,           //设置图表的（最外侧）边框宽度
                            shadow: true,               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果
                            shadowAngle: 45,            // 设置阴影区域的角度，从x轴顺时针方向旋转
                            shadowOffset: 1.5,          // 设置阴影区域偏移出图片边框的距离
                            shadowWidth: 3,             // 设置阴影区域的宽度
                            shadowDepth: 3,             // 设置影音区域重叠阴影的数量
                            shadowAlpha: 0.07   ,        // 设置阴影区域的透明度
                            renderer: $.jqplot.CanvasGridRenderer, // renderer to use to draw the grid.
                            rendererOptions: {}
}
		
		
		
    });

  });
  
  
  
  </script>
</head>


<style>
    /*定位最外层盒子宽度与布局居中（margin:0 auto css布局居中功能）*/
   
    /*设置装业务标题盒子距离下一个盒子距离为24px*/
    #divcss5 .divcss5{ position:relative; background:url(process.gif) no-repeat 0 0; height:361px;}
    /*position:relative声明绝对定位父级，设置高度361px，宽度默认继承其父级862宽度，将整个流程图作为图片设置为背景*/
    .no{
	position: absolute;
	width: 367px;
	height: 20px
}
    /*公用六个内容class设置宽度、高度、定位子级*/
     
    .no1{
	left: 49px;
	top: 191px
}
	/*定位第一个“服务定义”内容距离父级左边距离50px、距离上为0距离*/
    .no2{
	left: 895px;
	top: 521px
}
    /*定位第二个“卡种定义”内容距离父级左边距离18px、距离上为137px距离*/
    .no3{
	left: 894px;
	top: 144px
}
    /*定位第三个“结算方式定义”内容距离父级左边距离60px、距离上为268px距离*/
    .no4{	left: 86px;	top: 484px}
    /*定位第四个“结算成功”内容距离父级右边距离49px、距离上为0距离*/
    .no5{
	left: 623px;
	top: 452px
}
    /*定位第四个“结算成功”内容距离父级右边距离49px、距离上为0距离*/
</style>
<style>
        table {
	text-align: left;
	font-size: 12px;
	font-family: verdana;	
        }
        table thead  {
            cursor: pointer;
        }
        table thead tr,        
        td, th {
	border: 0px ;	
        }
    .no.no4 {
	left: 86px;
	top: 484px;
}
</style>
<body background="../zc1.jpg" text="#FFFFFF"  style="background-image: url(../zc1.jpg); background-size: 100%; width:1366px;heigh:auto">
<div class="no no1" id="d1">
  <table width="367" height="219"  cellpadding="2" cellspacing="1" class="" id="t1">
    <tbody>
      <tr class="r1">
        <td width="140" align="center" class="c1">1
          </th>
        <td width="98" align="left" class="c2">北京
          </th>
        <td width="116" align="left" class="c3">11130
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">2
          </th>
        <td align="left" class="c2">上海
          </th>
        <td align="left" class="c3">312223232
          </th>
      </tr>
      <tr class="r1">
        <td height="21" align="center" class="c1">3
          </th>
        <td align="left" class="c2">广州
          </th>
        <td align="left" class="c3">3222212
          </th>
      </tr>
      <tr class="r2">
        <td height="22" align="center" class="c1">4
          </th>
        <td align="left" class="c2">深圳
          </th>
        <td align="left" class="c3">323123123
          </th>
      </tr>
      <tr class="r1">
        <td align="center" class="c1">5
          </th>
        <td align="left" class="c2">辽宁
          </th>
        <td align="left" class="c3">33123124
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">6
          </th>
        <td align="left" class="c2">黑龙江
          </th>
        <td align="left" class="c3">33224345
          </th>
      </tr>
      <tr class="r1">
        <td align="center" class="c1">7
          </th>
        <td align="left" class="c2">吉林
          </th>
        <td align="left" class="c3">333455111
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">8
          </th>
        <td align="left" class="c2">云南
        <td align="left" class="c3">89781231231
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">9
          </th>
        <td align="left" class="c2">山西
          </th>
        <td align="left" class="c3">6666666666666
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">10
          </th>
        <td align="left" class="c2">西安
          </th>
        <td align="left" class="c3">333333333
          </th>
      </tr>
    </tbody>
  </table>
</div>
<div class="no no2" id="d2">
  <table cellspacing="1" cellpadding="2" class="" id="t2" width="367">
   
    <tbody>
      <tr class="r1">
        <td width="140" align="center" class="c1">1
          </th>
        <td width="98" align="left" class="c2">北京
          </th>
        <td width="116" align="left" class="c3">5555550
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">2
          </th>
        <td align="left" class="c2">上海
          </th>
        <td align="left" class="c3">6666223232
          </th>
      </tr>
      <tr class="r1">
        <td height="21" align="center" class="c1">3
          </th>
        <td align="left" class="c2">广州
          </th>
        <td align="left" class="c3">777722212
          </th>
      </tr>
      <tr class="r2">
        <td height="22" align="center" class="c1">4
          </th>
        <td align="left" class="c2">深圳
          </th>
        <td align="left" class="c3">8888123123
          </th>
      </tr>
      <tr class="r1">
        <td align="center" class="c1">5
          </th>
        <td align="left" class="c2">辽宁
          </th>
        <td align="left" class="c3">33123124
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">6
          </th>
        <td align="left" class="c2">黑龙江
          </th>
        <td align="left" class="c3">33224345
          </th>
      </tr>
      <tr class="r1">
        <td align="center" class="c1">7
          </th>
        <td align="left" class="c2">吉林
          </th>
        <td align="left" class="c3">333455111
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">8
          </th>
        <td align="left" class="c2">云南
        <td align="left" class="c3">89781231231
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">9
          </th>
        <td align="left" class="c2">山西
          </th>
        <td align="left" class="c3">66666666666
          </th>
      </tr>
      <tr class="r2">
        <td align="center" class="c1">10
          </th>
        <td align="left" class="c2">西安
          </th>
        <td align="left" class="c3">333333333
          </th>
      </tr>
    </tbody>
 </table>
        	
</div>

  
  	  <div  class="no no3" id="d3" style="margin-top:20px; margin-left:20px; width:320px; height:220px;">     </div>
      <div  class="no no4" id="d4" style="margin-top:20px; margin-left:20px; width:320px; height:220px;">
      	
        <script type="text/javascript">
		
		var line1 = [['连环夺宝', 7], ['鸵鸟快跑', 9], ['连环1夺宝', 15],['连环2夺宝', 12],  ['连3环夺宝', 18]];

        $.jqplot('d4', [line1], {
            title: '',
            series: [{ renderer: $.jqplot.BarRenderer }],
            axesDefaults: {
				// 设置是否显示刻度
        	showTickMarks: true,
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
					showGridline: true, 
					// 每个刻度线顶点距刻度线在坐标轴上点距离（像素为单位)如果mark值为 'cross', 
					// 那么每个刻度线都有上顶点和下顶点，刻度线与坐标轴在刻度线中间交叉，那么这时这个距离×2
					markSize: 4,        
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
					label: '',  
					labelRenderer: $.jqplot.CanvasAxisLabelRenderer   
            },   
            yaxis: {   
                //min: 0,           //y轴最小值   
                //max: 20,          //y轴最大值   
                //numberTicks:2,           //网格线条数   
                //tickInterval: 20,        //网格线间隔大小
				//angle: 0,   
                label: '',   
                labelRenderer: $.jqplot.CanvasAxisLabelRenderer   
            }  ,
			legend: {    
				show: false,//设置是否出现分类名称框（即所有分类的名称出现在图的某个位置）    
				location: 'ne',     // 分类名称框出现位置, nw, n, ne, e, se, s, sw, w.    
				xoffset: 12,        // 分类名称框距图表区域上边框的距离（单位px）    
				yoffset: 12,        // 分类名称框距图表区域左边框的距离(单位px)    
				background:'ff0000',        //分类名称框距图表区域背景色    
				textColor:''          //分类名称框距图表区域内字体颜色    
			    
    			} ,
			grid: {    
				drawGridLines: true,        // wether to draw lines across the grid or not.    
				gridLineColor: '#cccccc',    // 设置整个图标区域网格背景线的颜色    
				background: '#fffdf6',      // 设置整个图表区域的背景色    
				borderColor: '#999999',     // 设置图表的(最外侧)边框的颜色    
				borderWidth: 2.0,           //设置图表的（最外侧）边框宽度    
				shadow: true,               // 为整个图标（最外侧）边框设置阴影，以突出其立体效果    
				shadowAngle: 45,            // 设置阴影区域的角度，从x轴顺时针方向旋转    
				shadowOffset: 1.5,          // 设置阴影区域偏移出图片边框的距离    
				shadowWidth: 3,             // 设置阴影区域的宽度    
				shadowDepth: 3,             // 设置影音区域重叠阴影的数量    
				shadowAlpha: 0.07  ,         // 设置阴影区域的透明度    
				renderer: $.jqplot.CanvasGridRenderer,  // renderer to use to draw the grid.    
				rendererOptions: {}         // options to pass to the renderer.  Note, the default    
                                    // CanvasGridRenderer takes no additional options.    
    } 
        }   
        });
			
			
			
        </script>
     </div>    

<span class="no no5" id="d5">888888888888</span>
</body>
</html>
