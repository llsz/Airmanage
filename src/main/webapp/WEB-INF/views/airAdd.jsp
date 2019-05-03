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
        var time = $('#time').val();
        var cityid = $('#cityid').val();
        if(time == "" || time == null){
            $("#check").html("日期不能为空");
            $("#check").css("color","red");
            return false;
        }
        if(cityid == 0){
            $("#check").html("城市不能为空");
            $("#check").css("color","red");
            return false;
        }
        $.ajax({
            url: "/checkAir",
            type: "post",
            datatype: "json",
            data: {
                time: time,
                cityid: cityid,
            },

            success: function (data) {
                if(data == "ok"){
                    $.ajax({
                        url: "/addAir",
                        type:"post",
                        //datatype:"json",
                        data:$("#myForm").serialize(),
                        success:function (data) {
                            if(data == "ok"){
                                alert("添加成功");
                                window.location.href = "/showAir";
                            }else {
                                alert("添加失败，请重试");
                            }
                        },
                        error: function (data) {
                            alert(data.message);
                        }
                    });
                }
                else{
                    alert("污染信息已存在");
                    location.reload();
                }
            },
            error: function (data) {
                alert(data.message);
            }
        });

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
                                    <input type="text" id="time" name="time" class="form-control">
                                    <script src="<%=basePath%>/resourse/js/laydate/laydate.js"></script>
                                    <script>
                                        laydate.render({
                                            elem: '#time'
                                        });

                                    </script>
                                </div>
                                <label class="col-sm-2 control-label">aqi</label>
                                <div class="col-sm-4">
                                    <input type="text" id="aqi" name="aqi" class="form-control">
                                </div>
                            </div>




                            <div class="form-group">
                                <label class="col-sm-2 control-label">PM2.5</label>
                                <div class="col-sm-4">
                                    <input type="text" id="pm2_5" name="pm2_5" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">PM10</label>
                                <div class="col-sm-4">
                                    <input type="text" id="pm10" name="pm10" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">SO2</label>
                                <div class="col-sm-4">
                                    <input type="text" id="so2" name="so2" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">CO</label>
                                <div class="col-sm-4">
                                    <input type="text" id="co" name="co" class="form-control">
                                </div>
                            </div>



                            <div class="form-group">
                                <label class="col-sm-2 control-label">NO2</label>
                                <div class="col-sm-4">
                                    <input type="text" id="no2" name="no2" class="form-control">
                                </div>
                                <label class="col-sm-2 control-label">O3</label>
                                <div class="col-sm-4">
                                    <input type="text" id="o3" name="o3" class="form-control">
                                </div>
                            </div>


                            <div class="form-group">
                                <label class="col-sm-2 control-label">城市：</label>
                                <div class="col-sm-4">
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

                                <span id="check"></span>
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
