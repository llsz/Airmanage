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
    <title>管理界面</title>

    <link rel="stylesheet" href="<%=basePath%>/resourse/css/bootstrap.min.css">
    <script type="text/javascript" src="<%=basePath %>/resourse/js/jquery-3.1.0.min.js"></script>
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

    <script type="text/javascript">
        function del(id) {
            var answer = confirm("确定要删除商品吗？");
            if(answer){
                window.location.href = '/delete?id='+id;
            }
        }
    </script>
</head>
<body>
<div class="h jumbotron">


    <div class="container">
        <h1 class="title">商品信息管理系统</h1>
    </div>
</div>

<div class="container">
    <div class="main">
        <div class="row">
            <!-- 左侧内容 -->
            <div class="col-md-3">
                <div class="list-group">
                    <a href="" class="list-group-item text-center active">商品管理</a>
                    <a href="/addview" class="list-group-item text-center">增加商品</a>
                    <a href="/selectPage" class="list-group-item text-center">分页展示</a>
                    <a href="" class="list-group-item text-center">数据分析</a>
                    <a href="" class="list-group-item text-center">layui</a>
                </div>
            </div>

            <!-- 右侧内容 -->
            <div class="col-md-9">
                <div class="panel panel-default">
                    <div class="panel-heading">商品</div>
                    <div class="panel-body">
                        <table class="table table-responsive table-hover">
                            <thead>
                            <tr>
                                <th>日期</th>
                                <th>aqi</th>
                                <th>质量等级</th>

                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${airs}" varStatus="s">
                                <tr>
                                    <td><fmt:formatDate  value="${item.time}" pattern="yyyy-MM-dd"/> </td>
                                    <td>${item.aqi}</td>
                                    <td>${item.level}</td>

                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="panel-body">
                    <table class="table table-responsive table-hover">
                        <thead>
                        <tr>
                            <th>日期</th>
                            <th>aqi</th>
                            <th>质量等级</th>

                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="item" items="${air}" varStatus="s">
                            <tr>
                                <td><fmt:formatDate  value="${item.time}" pattern="yyyy-MM-dd"/> </td>
                                <td>${item.aqi}</td>
                                <td>${item.level}</td>

                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </div>
</div>
<%-- <a href="/addview">添加商品</a>
 <div style="left: 200px">
     <a href="/index.jsp">退出</a>
 </div>
 <table border="1">
     <tr>
         <th>编号</th>
         <th>商品名</th>
         <th>单价</th>
         <th>库存</th>
         <th>描述</th>
         <th>操作</th>
     </tr>

     <c:forEach var="item" items="${proInfo}" varStatus="s">
         <tr>
             <td>${item.pro_id}</td>
             <td>${item.pro_name}</td>
             <td>${item.pro_price}</td>
             <td>${item.pro_stock}</td>
             <td>${item.pro_description}</td>
             <td><a href="/getPro?id=${item.pro_id}">编辑</a>
                 <a href="/delete?id=${item.pro_id}">删除</a>
             </td>
         </tr>
     </c:forEach>
 </table>--%>

</body>
</html>




