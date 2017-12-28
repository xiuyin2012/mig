<%@ page language="java" import="java.util.*" pageEncoding="UTF8"%>
<%@ include file="/pages/inc/taglibs.jsp" %>
<%@ include file="/pages/inc/common.jsp" %>
<%@ include file="/pages/inc/header.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 
<html> 
<head> 
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <title>Highcharts 柱状图-www.jbxue.com</title> 
    <script type="text/javascript" src="Lib/Scripts/jquery-1.7.2.min.js"></script> 
    <script type="text/javascript"> 
        $(function () { 
            var chart; 
            $(document).ready(function () {
                chart = new Highcharts.Chart({ 
                    chart: { 
                        renderTo: 'container', 
                        type: 'column', 
                        margin: [35, 10, 40, 50], 
                        plotBorderWidth: 1, 
                        plotBorderColor: '#625f5f', 
                        animation: false, 
                        style: 
                        { 
                            fontFamily: 'Microsoft YaHei', 
                            fontSize: '12px', 
                            color: '#262626' 
                        } 
                    }, 
                    colors: [ 
 
                           '#7bd5f3', 
                           '#fbe659', 
                             "#fca108", 
 
                            ], 
                    title: { 
                        text: '柱状图', 
                        x: 60, 
                        y: 9, 
                        style: { 
                            // display: 'none', 
                            fontFamily: 'Microsoft YaHei', 
                            fontSize: '20px', 
                            fontWeight: 'Bold', 
                            color: '#262626' 
                        } 
                    }, 
                    subtitle: { 
                        style: { 
                            display: 'none' 
                        } 
                    }, 
                    xAxis: { 
                        //lineWidth: 1, 
                        // lineColor: '#625f5f', 
                        labels: 
                        { 
                            style: { 
                                color: '#262626', 
                                fontSize: '12px', 
                                marginTop: 5 
                            } 
 
                        }, 
                        categories: ['口', '一', '二', '三', '四', '五', '六', '七', '八'] 
                    }, 
                    yAxis: { 
                        allowDecimals: false, 
                        min: 0, 
                        max: 100, 
                        alternateGridColor: '#f6f6f6', 
 
                        // lineWidth: 1, 
                        gridLineWidth: 1, 
                        //tickPosition: 'inside', 
                        gridLineColor: '#c5c5c5', 
                        //offset: -3, 
                        //  lineColor: '#625f5f', 
                        plotLines: [{ 
                            value: 30, 
                            color: '#439c07', 
                            dashStyle: 'solid', 
                            width: 2, 
                            label: { 
                                text: '倾向', 
                                align: 'left', 
                                x: -25, 
                                style: { 
                                    color: '#439c07' 
                                } 
                            } 
                        }, { 
                            value: 40, 
                            color: '#dd0202', 
                            dashStyle: 'solid', 
                            width: 2, 
                            label: { 
                                text: '判定', 
                                align: 'left', 
                                x: -25, 
                                style: { 
                                    color: '#dd0202' 
                                } 
                            } 
                        }], 
                        title: { 
                            text: '分数', 
                            style: { 
                                display: 'none' 
 
                            } 
                        }, 
                        labels: { 
                            enabled: false 
                        } 
                    }, 
                    legend: { 
                        layout: 'horizontal', 
                        backgroundColor: '#FFFFFF', 
                        align: 'right', 
                        verticalAlign: 'top', 
                        x: 0, 
                        y: -10, 
                        floating: true, 
                        shadow: false, 
                        enabled: false 
                    }, 
                    tooltip: { 
                        formatter: function () { 
                            return '' + 
                        this.x + ': ' + this.y + '分'; 
                        } 
                    }, 
                    plotOptions: { 
                        column: { 
                            pointPadding: 0.001, 
                            borderWidth: 0, 
                            shadow: false, 
                             animation: false 
                        } 
                    }, 
                    series: [{ 
                        name: '我的主要体质', 
 
                        data: [{ y: 10, color: 'red', name: '5' }, { y: 23, color: '#7bd5f3', name: '5' }, { y:45, color: '#7bd5f3', name: '5' }, { y:  
 
70, color: '#fbe659', name: '5' }, { y: 55, color: '#7bd5f3', name: '5' }, { y: 60, color: '#fca108', name: '5' }, { y: 32, color: '#7bd5f3',  
 
name: '5' }, { y: 65, color: '#7bd5f3', name: '9' }, { y: 24, color: '#7bd5f3', name: '5'}], 
                        dataLabels: { 
                            enabled: true, 
                            rotation: 0, 
                            color: '#262626', 
                            align: 'center', 
                            x: -3, 
                            y: 15, 
                            formatter: function () { 
 
                                if (this.y != 0) { 
                                    return this.y  + "分"; 
                                } 
                            }, 
                            style: { 
                                fontSize: '13px', 
                                fontFamily: 'Microsoft YaHei' 
 
                            } 
                        } 
 
                    }] 
                }); 
            }); 
 
        }); 
    </script> 
</head> 
<body> 
    <script src="Lib/Highcharts-2.2.5/js/highcharts.js" type="text/javascript"></script> 
    <!-- <script src="../../js/modules/exporting.js"></script>--> 
    <div id="container" style="width: 800px; height: 475px; margin: 0 auto"> 
    </div> 
</body> 
</html>
