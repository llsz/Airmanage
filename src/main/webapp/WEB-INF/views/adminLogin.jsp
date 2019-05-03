<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>大气质量监测与预警</title>
    <link rel="stylesheet" href="<%=basePath%>/resourse/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath %>/resourse/js/jquery-3.1.0.min.js"></script>
    <script src="<%=basePath%>/resourse/js/bootstrap.min.js"></script>
    <script src="https://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>
    <%--<script type="text/javascript" src="<%=basePath%>resourse/js/jquery-3.1.0.min.js"></script>--%>
    <script type="text/javascript" src="resourse/js/login.js"></script>
    <link href="<%=basePath%>resourse/css/login2.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        /*id为空时清除下方提示栏*/
        function check_val() {
            var id = $("#u").val();
            if(id == ''){
                $("#check").html("");
            }
        }
        /**
         * 验证登录账户密码是否为空
         * 登录验证用户是否存在*/
        function check_load() {

            var id = document.getElementById("u").value;
            var passwd = document.getElementById("p").value;
            if(id == "" || id == null){
                $("#check").html("请输入账号");
                $("#check").css("color","red");
                return false;
            }
            if(passwd == "" || passwd == null){
                $("#check").html("请输入密码");
                $("#check").css("color","red");
                return false;
            }

            $.ajax({
                url: "/admin/checklogin",
                type: "post",
                datatype: "json",
                data: {
                    id: id,
                    password: passwd
                },

                success: function (data) {
                    if(data == "ok"){
                        window.location.href = "/admin/login?id="+id;
                    }
                    else if(data == "idError"){
                        alert("该用户不存在");
                        $("#u").val('');
                        $("#p").val('');
                    }else if(data == "pwdError"){
                        $("#check").html("密码错误");
                        $("#check").css("color","red");
                        $("#p").val('');
                    }
                },
                error: function (data) {
                    alert(data.message);
                }
            });


        }


    </script>
</head>
<body>
<nav class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand">大气质量监测与预警平台</a>
        </div>
        <div>
            <ul class="nav navbar-nav">
                <li><a href="/show?cityid=1">空气质量</a> </li>
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


<div class="login" style="margin-top: 50px;">
    <div class="header">
        <div class="switch" id="switch">
            <a class="switch_btn_focus" id="switch_qlogin"
               href="javascript:void(0);" tabindex="7">快速登录</a>

            <a	class="switch_btn" id="switch_login" href="javascript:void(0);"
                  tabindex="8">快速注册</a>
            <div class="switch_bottom" id="switch_bottom"
                 style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>
    <div class="web_qr_login" id="web_qr_login"
         style="display: block; height: 235px;">
        <!--登录-->
        <div class="web_login" id="web_login">
            <div class="login-box">
                <div class="login_form">
                    <%--<form action="/user/login" name="loginform"
                          accept-charset="utf-8" id="login_form" class="loginForm"
                          method="post">--%>
                    <div class="uinArea" id="uinArea">
                        <label class="input-tips" for="u">帐号：</label>
                        <div class="inputOuter" id="uArea">
                            <input type="text" id="u" name="id" class="inputstyle" required autocomplete='id' onkeyup="check_val()"/>

                        </div>
                    </div>
                    <div class="pwdArea" id="pwdArea">
                        <label class="input-tips" for="p">密码：</label>
                        <div class="inputOuter" id="pArea">
                            <input type="password" id="p"  name="password" class="inputstyle" required autocomplete='password' />
                            <span id="check"></span>
                        </div>
                    </div>
                    <div style="padding-left: 50px; margin-top: 20px;">
                        <input type="button" value="登 录" style="width: 150px;"
                               class="button_blue" onclick="return check_load()"/>
                    </div>
                    <%--</form>--%>
                </div>
            </div>
        </div>
        <!--登录end-->
    </div>

</div>
</body>

</html>