<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/30
  Time: 16:30
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

        a.exit:link{text-decoration: none;}
        a.exit:visited{text-decoration: none;}
        a.exit:hover {text-decoration: underline;}
        a.exit:active {text-decoration: underline;}
        a.exit{
            position:relative;
            left:1240px;
            bottom:20px;
        }
        .h.jumbotron{
            padding: 20px;
        }
    </style>

</head>
<body>
<script>
    function checkTime(){
        var timestart = $('#timestart').val();
        var timeend = $('#timeend').val();

        if(timestart != null && timeend != null){
            var arr1 = timestart.split("-");
            var arr2 = timeend.split("-");
            var date1 = new Date(parseInt(arr1[0]), parseInt(arr1[1])-1, parseInt(arr1[2]),0,0,0);
            var date2 = new Date(parseInt(arr2[0]), parseInt(arr2[1])-1, parseInt(arr2[2]),0,0,0);
            if(date1.getTime() > date2.getTime()){
                alert("结束日期不能小于开始日期");
                return false;
            }
        }


    }
    function getValue(cityid) {
        var time1 = $('#t1').val();
        var time2 = $('#t2').val();
        var pageSize = $('#Pagesize').val();
        window.location.href = '/showAir?pageSize=' + pageSize + '&cityid='+cityid + '&timestart='+ time1 + '&timeend=' + time2;
    }


    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
        return [year, month, day].join('-');
    }

    function del(time,id) {
        /*var date = formatDate(time);*/
        /*alert(time+'</br>'+date+'</br>'+id);*/
        var answer = confirm("确定要删除数据吗?");
        if(answer){
            $.ajax({
                url: "/delAir",
                type:"post",
                datatype:"json",
                data:{
                    time: time,
                    cityid: id
                },
                success:function (data) {
                    if(data == "ok"){
                        alert("删除成功");
                        location.reload();
                    }else {
                        alert("删除失败，请重试");
                    }
                },
                error: function (data) {
                    alert(data.message);
                }
            });
        }

        /*$.ajax({
            url: "/delAir",
            type:"post",
            datatype:"json",
            data:{
                time: time,
                cityid: id
            },
            success:function (data) {
                if(data == "ok"){
                    alert("删除成功");
                }else {
                    alert("删除失败，请重试");
                }
            },
            error: function (data) {
                alert(data.message);
            }
        });*/

    }
</script>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand">大气质量监测与预警平台</a>
        </div>
        <div>
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="/show?cityid=1" class="dropdown-toggle" data-toggle="dropdown">
                        <span class="glyphicon glyphicon-user"></span> 管理员
                    </a>
                    <ul class="dropdown-menu">
                        <%--<li><a href="#">修改密码</a> </li>--%>
                        <li><a href="/show?cityid=1">退出</a> </li>

                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="main">
        <div class="row">
            <!--左侧导航栏 -->
            <div class="col-md-3">
                <div class="list-group">
                    <a href="/showAir" class="list-group-item text-center active">数据管理</a>
                    <a href="/addview" class="list-group-item text-center">数据添加</a>
                </div>
            </div>

            <!-- 右侧内容 -->
            <div class="col-md-9">
                <input type="hidden" value="${time1}" id="t1" class="t1">
                <input type="hidden" value="${time2}" id="t2" class="t2">
                <input type="hidden" value="${cityid}" id="t3" class="t3">
                <div class="panel panel-default">
                    <div class="panel-heading">${time1} - ${time2}数据</div>
                    <div class="panel-body">
                        <form class="form-inline" action="/showAir" method="post" onsubmit="return checkTime()">
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
                                    <label>城市：</label>
                                    <select class="selectpicker show-tick form-control" data-live-search="true" id="cityid" name="cityid" >
                                        <option value="0">请选择</option>
                                        <option value="1">福州</option>
                                        <option value="2">龙岩</option>
                                        <option value="3">南平</option>
                                        <option value="4">宁德</option>
                                        <option value="5">莆田</option>
                                        <option value="6">泉州</option>
                                        <option value="7">三明</option>
                                        <option value="8">厦门</option>
                                        <option value="9">漳州</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <input type="submit" value="查询" class="form-control btn btn-info"/>
                                    &nbsp;&nbsp;
                                    <input type="reset" value="重置" class="form-control btn btn-danger"/>
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
                                <th>城市</th>
                                <th>操作</th>

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
                                    <td>
                                        <span class="glyphicon glyphicon-trash" onclick="del('${item.time}','${item.cityid}')"></span>
                                        <a href="/getAir?time=${item.time}&cityid=${item.cityid}"><span class="glyphicon glyphicon-edit" ></span></a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>

                        <form class="listForm" method="post" action="/showAir?cityid=${cityid}&timestart=${time1}&timeend=${time2}">
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
                                            <a href="/showAir?pageCode=1&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}"><strong>首页</strong></a>
                                        </li>
                                        <li>
                                            <c:if test="${pageBean.pageCode > 2}">
                                                <a href="/showAir?pageCode=${pageBean.pageCode - 1}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">&laquo;</a>
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
                                                    <a href="/showAir?pageCode=${i}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">${i}</a>
                                                </li>
                                            </c:if>
                                        </c:forEach>

                                        <li>
                                            <c:if test="${pageBean.pageCode < pageBean.totalPage}">
                                                <a href="/showAir?pageCode=${pageBean.pageCode + 1}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}">&raquo;</a>
                                            </c:if>
                                        </li>
                                        <li>
                                            <a href="/showAir?pageCode=${pageBean.totalPage}&pageSize=${pageBean.pageSize}&cityid=${cityid}&timestart=${time1}&timeend=${time2}"><strong>末页</strong></a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
