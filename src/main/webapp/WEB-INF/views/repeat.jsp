<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/22
  Time: 18:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table class="table table-responsive table-hover" align="center">
    <thead>
    <tr>
        <th>城市</th>
        <th>aqi</th>
        <th>等级</th>
        <th>首要污染物</th>
        <th>健康提醒</th>


    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <c:choose>
                <c:when test="${air.cityid == 1}">
                    福州
                </c:when>
                <c:when test="${air.cityid == 2}">
                    龙岩
                </c:when>
                <c:when test="${air.cityid == 3}">
                    南平
                </c:when>
                <c:when test="${air.cityid == 4}">
                    宁德
                </c:when>
                <c:when test="${air.cityid == 5}">
                    莆田
                </c:when>
                <c:when test="${air.cityid == 6}">
                    泉州
                </c:when>
                <c:when test="${air.cityid == 7}">
                    三明
                </c:when>
                <c:when test="${air.cityid == 8}">
                    厦门
                </c:when>
                <c:otherwise>
                    漳州
                </c:otherwise>
            </c:choose>
        </td>
        <td>${min}-${max} </td>
        <td>
            <c:choose>
                <c:when test="${air.aqi<=40}">
                    优
                </c:when>
                <c:when test="${air.aqi >40 && air.aqi<=70}">
                    优-良
                </c:when>
                <c:when test="${air.aqi>70 && air.aqi<=90}">
                    良
                </c:when>
                <c:when test="${air.aqi >90 && air.aqi<=120}">
                    良-轻度污染
                </c:when>
                <c:when test="${air.aqi >120 && air.aqi<=140}">
                    轻度污染
                </c:when>
                <c:when test="${air.aqi >140 && air.aqi<=170}">
                    轻-中度污染
                </c:when>
                <c:when test="${air.aqi>170 && air.aqi<=190}">
                    中度污染
                </c:when>
                <c:when test="${air.aqi >190 && air.aqi<=220}">
                    中-重度污染
                </c:when>
                <c:when test="${air.aqi >220 && air.aqi<=290}">
                    重度污染
                </c:when>
                <c:when test="${air.aqi >290 && air.aqi<=320}">
                    重-严重污染
                </c:when>
                <c:otherwise>
                    严重污染
                </c:otherwise>
            </c:choose>
        </td>
        <td>
          ${air.pollution}
        </td>
        <td>
            <c:choose>
                <c:when test="${air.aqi<=50}">
                    <span class="glyphicon glyphicon-exclamation-sign"
                         title="空气质量令人满意，基本无空气污染，各类人群可正常活动。"></span>
                </c:when>
                <c:when test="${air.aqi >50 && air.aqi<=100}">
                     <span class="glyphicon glyphicon-exclamation-sign"
                           title="空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响
                               ，建议极少数异常敏感人群应减少户外活动。"></span>
                </c:when>
                <c:when test="${air.aqi>100 && air.aqi<=150}">
                     <span class="glyphicon glyphicon-exclamation-sign"
                           title="易感人群症状有轻度加剧，健康人群出现刺激症状。建议儿童、老年人及心脏病、
                           呼吸系统疾病患者应减少长时间、高强度的户外锻炼。"></span>
                </c:when>
                <c:when test="${air.aqi >150 && air.aqi<=200}">
                     <span class="glyphicon glyphicon-exclamation-sign"
                           title="进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响，建议疾病患者避免
                           长时间、高强度的户外锻练，一般人群适量减少户外运动。"></span>
                </c:when>
                <c:when test="${air.aqi >200 && air.aqi<=300}">
                     <span class="glyphicon glyphicon-exclamation-sign"
                           title="心脏病和肺病患者症状显著加剧，运动耐受力降低，健康人群普遍出现症状，建议儿童、老年人
                           和心脏病、肺病患者应停留在室内，停止户外运动，一般人群减少户外运动。"></span>
                </c:when>
                <c:otherwise>
                    <span class="glyphicon glyphicon-exclamation-sign"
                          title="健康人群运动耐受力降低，有明显强烈症状，提前出现某些疾病，建议儿
                          童、老年人和病人应当留在室内，避免体力消耗，一般人群应避免户外活动。"></span>
                </c:otherwise>
            </c:choose>
        </td>

        <%--<td><fmt:formatNumber type="number" value="${fz.pm2_5}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${fz.pm10}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${fz.so2}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${fz.no2}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${fz.o3}" maxFractionDigits="0"></fmt:formatNumber></td>--%>

    </tr>

    </tbody>
</table>
<div style="height:2px;width:100%;border-top:1px solid #ccc;float:left;margin-top:15px;"></div>
<table class="table table-responsive table-hover" align="center">
    <thead>
    <tr>
        <th>PM2.5</th>
        <th>PM10</th>
        <th>SO2</th>
        <th>NO2</th>
        <th>O3</th>


    </tr>
    </thead>
    <tbody>
    <tr>
        <td>
            <c:choose>
                <c:when test="${air.pm2_5-5 > 0}">
                    <fmt:formatNumber type="number" value="${air.pm2_5-5}" maxFractionDigits="0"></fmt:formatNumber>
                    -
                    <fmt:formatNumber type="number" value="${air.pm2_5+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:when>
                <c:otherwise>
                    0-<fmt:formatNumber type="number" value="${air.pm2_5+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${air.pm10-10 > 0}">
                    <fmt:formatNumber type="number" value="${air.pm10-10}" maxFractionDigits="0"></fmt:formatNumber>
                    -
                    <fmt:formatNumber type="number" value="${air.pm10+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:when>
                <c:otherwise>
                    0-<fmt:formatNumber type="number" value="${air.pm10+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${air.so2-0.5 > 0}">
                    <fmt:formatNumber type="number" value="${air.so2-0.5}" maxFractionDigits="0"></fmt:formatNumber>
                    -
                    <fmt:formatNumber type="number" value="${air.so2+0.5}" maxFractionDigits="0"></fmt:formatNumber>
                </c:when>
                <c:otherwise>
                    0-<fmt:formatNumber type="number" value="${air.so2+0.5}" maxFractionDigits="0"></fmt:formatNumber>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${air.no2-10 > 0}">
                    <fmt:formatNumber type="number" value="${air.no2-10}" maxFractionDigits="0"></fmt:formatNumber>
                    -
                    <fmt:formatNumber type="number" value="${air.no2+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:when>
                <c:otherwise>
                    0-<fmt:formatNumber type="number" value="${air.no2+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:otherwise>
            </c:choose>
        </td>
        <td>
            <c:choose>
                <c:when test="${air.o3-20 > 0}">
                    <fmt:formatNumber type="number" value="${air.o3-20}" maxFractionDigits="0"></fmt:formatNumber>
                    -
                    <fmt:formatNumber type="number" value="${air.o3+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:when>
                <c:otherwise>
                    0-<fmt:formatNumber type="number" value="${air.o3+10}" maxFractionDigits="0"></fmt:formatNumber>
                </c:otherwise>
            </c:choose>
        </td>
        <%--<td><fmt:formatNumber type="number" value="${air.pm2_5}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${air.pm10}" maxFractionDigits="0"></fmt:formatNumber></td>--%>
        <%--<td><fmt:formatNumber type="number" value="${air.so2}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${air.no2}" maxFractionDigits="0"></fmt:formatNumber></td>
        <td><fmt:formatNumber type="number" value="${air.o3}" maxFractionDigits="0"></fmt:formatNumber></td>--%>
    </tr>
    </tbody>
</table>
</body>
</html>
