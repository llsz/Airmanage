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
    </style>

</head>
<body>
<script>

    function formatDate(date) {
        var d = new Date(date),
            month = '' + (d.getMonth() + 1),
            day = '' + d.getDate(),
            year = d.getFullYear();

        if (month.length < 2) month = '0' + month;
        if (day.length < 2) day = '0' + day;
        return [year, month, day].join('-');
    }

    function editAjax() {
        var cityid = $('#cityid').val();
        if(cityid == "福州"){
            $('#cityid').val(1);
        }else if(cityid == "龙岩"){
            $('#cityid').val(2);
        }else if(cityid == "南平"){
            $('#cityid').val(3);
        }else if(cityid == "宁德"){
            $('#cityid').val(4);
        }else if(cityid == "莆田"){
            $('#cityid').val(5);
        }else if(cityid == "泉州"){
            $('#cityid').val(6);
        }else if(cityid == "三明"){
            $('#cityid').val(7);
        }else if(cityid == "厦门"){
            $('#cityid').val(8);
        }else {
            $('#cityid').val(9);
        }

        $.ajax({
            url: "/editAir",
            type:"post",
            //datatype:"json",
            data:$("#myForm").serialize(),
            success:function (data) {
                if(data == "ok"){
                    alert("修改成功");
                    window.location.href = "/showAir";
                }else {
                    alert("修改失败，请重试");
                    location.reload();
                }
            },
            error: function (data) {
                alert(data.message);
            }
        })
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
                <div class="panel panel-default">
                    <div class="panel-heading">数据修改</div>
                    <div class="panel-body">
                        <form id="myForm" method="post" class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">日期</label>
                                <div class="col-sm-4">
                                    <input type="text" name="time" value="<fmt:formatDate  value="${air.time}" pattern="yyyy-MM-dd"/>"
                                           readonly="readonly" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">aqi</label>
                                <div class="col-sm-4">
                                    <input type="text" name="aqi" value="${air.aqi}" class="form-control">
                                </div>
                            </div>




                            <div class="form-group">
                                <label class="col-sm-2 control-label">等级</label>
                                <div class="col-sm-4">
                                    <input type="text" name="level" value="${air.level}" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">PM2.5</label>
                                <div class="col-sm-4">
                                    <input type="text" name="pm2_5" value="${air.pm2_5}" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">PM10</label>
                                <div class="col-sm-4">
                                    <input type="text" name="pm10" value="${air.pm10}" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">SO2</label>
                                <div class="col-sm-4">
                                    <input type="text" name="so2" value="${air.so2}" class="form-control">
                                </div>

                            </div>



                            <div class="form-group">
                                <label class="col-sm-2 control-label">CO</label>
                                <div class="col-sm-4">
                                    <input type="text" name="co" value="${air.co}" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">NO2</label>
                                <div class="col-sm-4">
                                    <input type="text" name="no2" value="${air.no2}" class="form-control">
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label">O3</label>
                                <div class="col-sm-4">
                                    <input type="text" name="o3" value="${air.o3}" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">城市</label>
                                <div class="col-sm-4">
                                    <c:choose>
                                        <c:when test="${air.cityid == 1}">
                                            <input type='text' id="cityid" name="cityid" data-value="1" value="福州" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 2}">
                                            <input type='text' id="cityid" name="cityid" data-value="2" value="龙岩" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 3}">
                                            <input type='text' id="cityid" name="cityid" data-value="3" value="南平" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 4}">
                                            <input type='text' id="cityid" name="cityid" data-value="4" value="宁德" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 5}">
                                            <input type='text' id="cityid" name="cityid" data-value="5" value="莆田" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 6}">
                                            <input type='text' id="cityid" name="cityid" data-value="6" value="泉州" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 7}">
                                            <input type='text' id="cityid" name="cityid" data-value="7" value="三明" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:when test="${air.cityid == 8}">
                                            <input type='text' id="cityid" name="cityid" data-value="8" value="厦门" readonly="readonly" class="form-control"/>
                                        </c:when>
                                        <c:otherwise>
                                            <input type='text' id="cityid" name="cityid" data-value="9" value="漳州" readonly="readonly" class="form-control"/>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button type="button" class="btn btn-primary" onclick="editAjax()">提交</button>
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
