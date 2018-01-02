<html>
<head>
    <meta charset="utf-8">
    <title>中彩在线 </title>
    <script type="text/javascript" src="http://i1.sinaimg.cn/jslib/jquery-1.4.2.min.js"></script>
    <style>
        body {padding:0; margin:0;}
        #coverpage{ width: 100%; height: 100%; z-index: 9999; background: #000; overflow: hidden; position: absolute;}
        #onepics{ width: 100%; height: 100%; overflow: hidden; position: relative;}
        .onepic_wrap{ width: 100%; height: 100%; overflow: hidden; display: block; position: relative; cursor: pointer;}

        .onepic_bg{ position: absolute; left: 0; bottom: 0; height: 45px;width: 100%;color:#fff;background:rgba(0,0,0, 0.5); filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#7f000000', EndColorStr='#7f000000');*zoom:1;}
        :root .onepic_bg{filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#00000000', EndColorStr='#00000000'); }
        .onepic_bg p{ height: 45px; line-height: 45px; padding-left: 95px; font-size: 13px; color: #fff; text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}

    </style>
</head>
<body>
<!-- cover begin -->
<div id="coverpage">
    <div id="onepics"><div class="onepic_wrap"><img src="\src\main\webapp\img\zc.jpg" class="wrap_pic"></div></div>
    <!-- 文字介绍 start -->
    <div class="onepic_bg">
        <p id="onepic_sum"></p>
    </div>
    <!-- 文字介绍 end -->
</div>

<script type="text/javascript">
    var win_height; //浏览器当前窗口可视区域高度
    var win_width; //浏览器当前窗口可视区域宽度
    var original_width = 1920; //图片原始尺寸，编辑可手填
    var original_height = 800; //图片原始尺寸，编辑可手填

    var pic_width, pic_height, pic_left ,pic_top; //裁剪适配后的图片显示尺寸和左边距、上边距

    OnePicAction();

    function OnePicAction(){
        win_height = $(window).height(); //浏览器当前窗口可视区域高度
        win_width = $(window).width(); //浏览器当前窗口可视区域宽度

        //裁剪图片
        if(Math.ceil(win_height * original_width / original_height) < win_width ){
            pic_width = win_width ;
            pic_height = Math.ceil(win_width * original_height / original_width);
            pic_left = 0;
            pic_top = - Math.ceil((pic_height - win_height) / 2);
        }else{
            pic_height = win_height;
            pic_width = Math.ceil(win_height * original_width / original_height);
            pic_left = - Math.ceil((pic_width - win_width) / 2);
            pic_top = 0;
        }
        $("#onepics .wrap_pic").css("width",pic_width+"px").css("height",pic_height+"px").css("margin-top",pic_top+"px").css("margin-left",pic_left+"px");

    }
    //浏览器大小变化时壹图处理
    window.onresize = function(){
        OnePicAction();
    }
</script>
</body>
</html>
