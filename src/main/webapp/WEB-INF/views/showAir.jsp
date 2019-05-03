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

        #map{
            border: 1px solid gainsboro;
            position:absolute;
            left:2.5%;
            width: 95%;
            height: 785px;
            border-radius: 5px;
        }
        #content{
            height: 200px;
        }
    </style>

</head>
<body>
<script language="JavaScript">
    function predict(url) {
        $("#content").html("加载中...");
        $.get(url,function (data,status) {
            $("#content").html("");
            $("#content").html('<table class="table table-responsive table-hover" align="center"><thead><tr><td>城市</td><td>aqi</td><td>等级</td><td>首要污染物</td><td>健康提示</td></tr></thead>' +
            '<tbody><tr><td>'+data.cityname+'</td><td>'+data.min +'-'+ data.max+'</td><td>'+data.air.level+'</td><td>'+data.air.pollution+'</td><td><span class="glyphicon glyphicon-exclamation-sign" title="'+
            data.health+'"></span></td></tr></tbody></table>'+'<div style="height:2px;width:100%;border-top:1px solid #ccc;float:left;margin-top:15px;"></div>'+'<table class="table table-responsive table-hover" align="center"><thead><tr><td>PM2.5</td><td>PM10</td><td>SO2</td><td>NO2</td><td>O3</td></tr></thead>' +
                '<tbody><tr><td>'+data.pm25+'</td><td>'+data.pm10+'</td><td>'+data.so2+'</td><td>'+data.no2+'</td><td>'+data.o3+'</td></tr></tbody></table>');
        });
    }

</script>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand">大气质量监测与预警平台</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li class="active"><a href="/show?cityid=1">空气质量</a> </li>
                <li class="dropdown">
                    <a href="/showhistory?cityid=1" class="dropdown-toggle" data-toggle="dropdown">
                        历史天气
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
            <!-- 左侧内容 -->
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading"><fmt:formatDate  value="${yestoday}" pattern="yyyy-MM-dd"/>空气质量展示</div>
                    <div class="panel-body">
                        <table class="table table-responsive table-hover" align="center">
                            <thead>
                            <tr>
                                <th>城市</th>
                                <th>aqi</th>
                                <th>等级</th>
                                <th>首要污染物</th>
                                <th>PM2.5</th>
                                <th>PM10</th>
                                <th>SO2</th>
                                <th>NO2</th>
                                <th>O3</th>

                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${airs}" varStatus="s">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${item.cityid == 1}">
                                                福州
                                            </c:when>
                                            <c:when test="${item.cityid == 2}">
                                                龙岩
                                            </c:when>
                                            <c:when test="${item.cityid == 3}">
                                                南平
                                            </c:when>
                                            <c:when test="${item.cityid == 4}">
                                                宁德
                                            </c:when>
                                            <c:when test="${item.cityid == 5}">
                                                莆田
                                            </c:when>
                                            <c:when test="${item.cityid == 6}">
                                                泉州
                                            </c:when>
                                            <c:when test="${item.cityid == 7}">
                                                三明
                                            </c:when>
                                            <c:when test="${item.cityid == 8}">
                                                厦门
                                            </c:when>
                                            <c:otherwise>
                                                漳州
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatNumber type="number" value="${item.aqi}" maxFractionDigits="0"></fmt:formatNumber> </td>
                                    <td>${item.level}</td>
                                    <td>${item.pollution}</td>
                                    <td><fmt:formatNumber type="number" value="${item.pm2_5}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.pm10}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.so2}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.no2}" maxFractionDigits="0"></fmt:formatNumber></td>
                                    <td><fmt:formatNumber type="number" value="${item.o3}" maxFractionDigits="0"></fmt:formatNumber></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading"><fmt:formatDate  value="${today}" pattern="yyyy-MM-dd"/>空气质量预测</div>
                    <div class="panel-body">
                        <div class="btn-group">
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=1')">福州</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=2')">龙岩</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=3')">南平</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=4')">宁德</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=5')">莆田</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=6')">泉州</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=7')">三明</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=8')">厦门</button>
                            <button type="button" class="btn btn-default" onclick="predict('/predict?cityid=9')">漳州</button>
                        </div>
                        <div id="content"><%@include file="repeat.jsp"%></div>

                    </div>


                </div>

            </div>
            <!-- 右侧内容 -->
            <div class="col-md-6">

                <div id="map"><%@include file="map.jsp"%></div>

            </div>
        </div>
    </div>

</div>


</body>
</html>




