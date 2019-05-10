<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/8/20
  Time: 22:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>

<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <base href="<%=basePath%>">
    <title>大气质量监测与预警平台</title>

    <link rel="stylesheet" href="<%=basePath%>/resourse/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath %>/resourse/js/jquery-3.1.0.min.js"></script>
    <script src="<%=basePath%>/resourse/js/bootstrap.min.js"></script>
    <script src="<%=basePath%>/resourse/js/echarts.min.js"></script>
    <script src="<%=basePath%>/resourse/js/fujian.js"></script>
    <style type="text/css">
        body{font-family: "Microsoft Yahei"}
        span{
            color:blue;
        }

        #test{
            height: 300px;
        }
    </style>

</head>
<body>
<script language="JavaScript">
    $(document).ready(function () {
        var t1 = $('#t1').val();
        var t2 = $('#t2').val();
        var city = $('#t3').val();
        var datachart = echarts.init(document.getElementById('datachart'));
        var datachart1 = echarts.init(document.getElementById('datachart1'));
        var dataAxis = new Array();
        var data = new Array();
        var level = ['优','良','轻度污染','中度污染','重度污染','严重污染'];
        var ldata = new Array();
        var p=0;
        var max=0;

        var str1=city+t1+'至'+t2+'空气质量指数(aqi)变化趋势';
        var str2=city+t1+'至'+t2+'空气质量统计';

        <c:forEach var="item" items="${dates}" varStatus="s">
            dataAxis[p] = '<fmt:formatDate  value="${item}" pattern="yyyy-MM-dd"/>';
            p++;
        </c:forEach>
        for(var m=0;m<dataAxis.length;m++){
            data[m]=0;
            if(m<6){
                ldata[m]=0;
            }
        }

        <c:forEach var="item" items="${airs}" varStatus="s">
            var time = '<fmt:formatDate  value="${item.time}" pattern="yyyy-MM-dd"/>';

            for (var i=0;i<dataAxis.length+1;i++){
                if(dataAxis[i] == time){
                    data[i] = Math.round(parseFloat(${item.aqi}));
                    if(data[i] > max){
                        max = data[i];
                    }
                }
            }
        </c:forEach>

        <c:forEach var="item" items="${airs}" varStatus="s">
            var str = '${item.level}';
            for(var q=0;q<6;q++){
                if(level[q] == str){
                    ldata[q]++;
                }
            }
        </c:forEach>

        var pie = [];
        var selected = {};  //对象
        for(var t = 0; t < 6; t++){
            pie.push({
                name: level[t],
                value: ldata[t]
            });
            if(ldata[t] == '0'){
                selected[level[t]] = false;
            }else{
                selected[level[t]] = true;
            }
        }


        var option = {
            title: {
                text: str1,
                left: 'center',
                textStyle:{
                    fontWeight:"lighter",
                    fontSize:16
                }
            },
            tooltip: {
                trigger:"axis",
                formatter:"{b}:{c}"
            },
            xAxis: {
                type: 'category',
                data: dataAxis
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: data,
                type: 'line'
            }]
        };
        var option1 = {
            title: {
                text: str2,
                left: 'center',
                textStyle:{
                    fontWeight:"lighter",
                    fontSize:16
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: "{b}: {c}天 "
            },
            legend: {
                type: 'scroll',
                orient: 'vertical',
                right: 10,
                top: 20,
                bottom: 20,
                data:level,

                selected: selected

            },
            series:[
                {
                    type: 'pie',
                    selectedMode: 'single',   //鼠标点击
                    selectedOffset: 30,
                    center:['50%','50%'],       //圆心坐标
                    radius:[0,'45%'],           //内外半径
                    /*labelLine:{                 //指示线长度
                        normal:{
                            length:0
                        }
                    },*/
                    itemStyle:{
                        emphasis: {
                            shadowBlur: 10,
                            shadowOffsetX: 0,
                            shadowColor: 'rgba(0, 0, 0, 0.5)'
                        },

                        normal:{
                            label:{
                                show: false      //隐藏标示文字
                            },
                            borderWidth: 1,
                            borderColor: '#ffffff',
                            color:function(params) {
                                //自定义颜色
                                var colorList = [
                                    '#7fff00','#ffd700','#ff8c00','#ff0000','#b22222','#800000'
                                ];
                                return colorList[params.dataIndex]
                            }
                        },
                    },
                    name: "空气质量",
                    hoverAnimation: true,
                    minAngle: 0,
                    data: pie


                }
            ]
        };
        datachart.setOption(option);
        datachart1.setOption(option1);
    });

    function checkTime(){
        var timestart = $('#timestart').val();
        var timeend = $('#timeend').val();
        if(timestart == "" || timeend == ""){
            alert("日期不能为空");
            return false;
        }
        var arr1 = timestart.split("-");
        var arr2 = timeend.split("-");
        var date1 = new Date(parseInt(arr1[0]), parseInt(arr1[1])-1, parseInt(arr1[2]),0,0,0);
        var date2 = new Date(parseInt(arr2[0]), parseInt(arr2[1])-1, parseInt(arr2[2]),0,0,0);
        if(date1.getTime() > date2.getTime()){
            alert("结束日期不能小于开始日期");
            return false;
        }

    }
    function getValue(cityid) {
        var time1 = $('#t1').val();
        var time2 = $('#t2').val();
        var pageSize = $('#Pagesize').val();
        window.location.href = '/history?pageSize=' + pageSize + '&cityid='+cityid + '&timestart='+ time1 + '&timeend=' + time2;
    }

    function exportExcel(cityid) {
        var time1 = $('#t1').val();
        var time2 = $('#t2').val();
        window.location.href = '/export?&cityid='+cityid + '&timestart='+ time1 + '&timeend=' + time2;
    }
</script>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand">大气质量监测与预警平台</a>
        </div>
        <div>
            <input type="hidden" value="${time1}" id="t1" class="t1">
            <input type="hidden" value="${time2}" id="t2" class="t2">
            <input type="hidden" value="${city}" id="t3" class="t3">
            <ul class="nav navbar-nav">
                <li ><a href="/show?cityid=1">空气质量</a> </li>
                <li class="dropdown active">
                    <a href="/showhistory?cityid=1" class="dropdown-toggle" data-toggle="dropdown">
                        历史空气
                    </a>
                    <ul class="dropdown-menu">
                        <li><a href="/showhistory?cityid=1">福州</a> </li>
                        <li><a href="/showhistory?cityid=2">龙岩</a> </li>
                        <li><a href="/showhistory?cityid=3">南平</a> </li>
                        <li><a href="/showhistory?cityid=4">宁德</a> </li>
                        <li><a href="/showhistory?cityid=5">莆田</a> </li>
                        <li><a href="/showhistory?cityid=6">泉州</a> </li>
                        <li><a href="/showhistory?cityid=7">三明</a> </li>
                        <li><a href="/showhistory?cityid=8">厦门</a> </li>
                        <li><a href="/showhistory?cityid=9">漳州</a> </li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="/admin/toadmin"><span class="glyphicon glyphicon-user"></span> 管理员登录</a> </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <div class="main">
        <div class="row">
            <div class="col-md-12">
                <div class="panel">
                    <div class="panel-body" id="test">
                        <div id="datachart" style="position:absolute;left:0;width: 60%;height: 300px;" ></div>
                        <div id="datachart1" style="position:absolute;left:62%;width: 35%;height: 300px;" ></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">

            <div class="col-md-12">
                <div class="panel panel-default">
                    <div class="panel-heading">${time1} - ${time2}${city} 历史数据</div>
                    <div class="panel-body">
                        <form class="form-inline" action="/history?cityid=${cityid}" method="post" onsubmit="return checkTime()">
                            <div style="margin-bottom: 10px">
                                <div class="form-group">
                                    <label>起止时间：</label>
                                    <input type="text" class="form-control" id="timestart" name="timestart"/>
                                </div>
                                &nbsp;&nbsp;
                                -
                                &nbsp;&nbsp;
                                <div class="form-group">
                                    <input type="text" class="form-control" id="timeend" name="timeend"/>
                                </div>
                                <script src="<%=basePath%>/resourse/js/laydate/laydate.js"></script>
                                <script>
                                    laydate.render({
                                        elem: '#timestart'
                                    });
                                    laydate.render({
                                        elem: '#timeend'
                                    });
                                </script>
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                &nbsp;&nbsp;&nbsp;&nbsp;
                                <div class="form-group">
                                    <input type="submit" value="查询" class="form-control btn btn-info"/>
                                    &nbsp;&nbsp;
                                    <input type="reset" value="重置" class="form-control btn btn-danger"/>
                                    &nbsp;&nbsp;
                                    <input type="button" value="导出" class="form-control btn btn-primary" onclick="exportExcel(${cityid})"/>
                                </div>

                            </div>
                        </form>
                        <hr align="left" width="99%">
                        <table class="table table-responsive table-hover" align="center">
                            <thead>
                            <tr>
                                <th>日期</th>
                                <th>aqi</th>
                                <th>等级</th>
                                <th>PM2.5</th>
                                <th>PM10</th>
                                <th>SO2</th>
                                <th>NO2</th>
                                <th>CO</th>
                                <th>O3</th>

                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${pageBean.beanList}" varStatus="s">
                                <tr>
                                    <td>
                                        <fmt:formatDate  value="${item.time}" pattern="yyyy-MM-dd"/>
                                    </td>
                                    <td><fmt:formatNumber type="number" value="${item.aqi}" maxFractionDigits="0"></fmt:formatNumber> </td>
                                    <td>${item.level}</td>
                                    <td><fmt:formatNumber type="number" value="${item.pm2_5}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.pm10}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.so2}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.no2}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.co}" maxFractionDigits="1"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.o3}" maxFractionDigits="0"></fmt:formatNumber></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <form class="listForm" method="post" action="/history?cityid=${cityid}&timestart=${time1}&timeend=${time2}">
                            <div class="row">
                                <div class="form-inline">
                                    <label style="font-size:14px;margin-top:22px;">
                                        <strong>&nbsp;共<b>${pageBean.totalCount}</b>条记录，共<b>${pageBean.totalPage}</b>页</strong>
                                        &nbsp;
                                        &nbsp;
                                        <strong>每页显示</strong>
                                        <select class="form-control" id="Pagesize" name="pageSize"
                                                onchange="getValue(${cityid})">
                                            <option value="5"
                                                    <c:if test="${pageBean.pageSize == 5}">selected</c:if> >5
                                            </option>
                                            <option value="10"
                                                    <c:if test="${pageBean.pageSize == 10}">selected</c:if> >10
                                            </option>
                                            <option value="15"
                                                    <c:if test="${pageBean.pageSize == 15}">selected</c:if> >15
                                            </option>
                                            <option value="20"
                                                    <c:if test="${pageBean.pageSize == 20}">selected</c:if> >20
                                            </option>
                                        </select>
                                        <strong>条</strong>
                                        &nbsp;
                                        &nbsp;
                                        <strong>到第</strong>&nbsp;<input type="text" size="3" id="page" name="pageCode"
                                                                        class="form-control input-sm"
                                                                        style="width:11%"/>&nbsp;<strong>页</strong>
                                        &nbsp;
                                        <button type="submit" class="btn btn-sm btn-info">GO!</button>
                                    </label>
                                    <ul class="pagination" style="float:right;">
                                        <li>
                                            <a href="/history?pageCode=1&cityid=${cityid}&timestart=${time1}&timeend=${time2}"><strong>首页</strong></a>
                                        </li>
                                        <li>
                                            <c:if test="${pageBean.pageCode > 2}">
                                                <a href="/history?pageCode=${pageBean.pageCode - 1}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">&laquo;</a>
                                            </c:if>
                                        </li>

                                        <!-- 写关于分页页码的逻辑 -->
                                        <c:choose>
                                            <c:when test="${pageBean.totalPage <= 5}">
                                                <c:set var="begin" value="1"/>
                                                <c:set var="end" value="${pageBean.totalPage}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="begin" value="${pageBean.pageCode - 1}"/>
                                                <c:set var="end" value="${pageBean.pageCode + 3}"/>

                                                <!-- 头溢出 -->
                                                <c:if test="${begin < 1}">
                                                    <c:set var="begin" value="1"/>
                                                    <c:set var="end" value="5"/>
                                                </c:if>

                                                <!-- 尾溢出 -->
                                                <c:if test="${end > pageBean.totalPage}">
                                                    <c:set var="begin" value="${pageBean.totalPage -4}"/>
                                                    <c:set var="end" value="${pageBean.totalPage}"/>
                                                </c:if>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- 显示页码 -->
                                        <c:forEach var="i" begin="${begin}" end="${end}">
                                            <!-- 判断是否是当前页 -->
                                            <c:if test="${i == pageBean.pageCode}">
                                                <li class="active"><a href="javascript:void(0);">${i}</a></li>
                                            </c:if>
                                            <c:if test="${i != pageBean.pageCode}">
                                                <li>
                                                    <a href="/history?pageCode=${i}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <li>
                                            <c:if test="${pageBean.pageCode < pageBean.totalPage}">
                                                <a href="/history?pageCode=${pageBean.pageCode + 1}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">&raquo;</a>
                                            </c:if>
                                        </li>
                                        <li>
                                            <a href="/history?pageCode=${pageBean.totalPage}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}"><strong>末页</strong></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%--<!-- 右侧内容 -->
            <div class="col-md-6">



            </div>--%>
        </div>
    </div>

</div>


</body>
</html>




