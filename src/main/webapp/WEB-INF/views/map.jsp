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
<div class="map" id="main" style="position:absolute;left:2.5%;width: 95%;height: 750px;" ></div>

<script type="text/javascript">
    var da = new Array();
    var p = 0;
    var str = '<fmt:formatDate  value="${yestoday}" pattern="yyyy-MM-dd"/>'+'环境空气质量日报';
    for(var m=0;m<9;m++){
        da[m] = 0;
    }
    <c:forEach var="item" items="${airs}" varStatus="s">
        da[p] = '<fmt:formatNumber type="number" value="${item.aqi}" maxFractionDigits="0"/>';
        p++;
    </c:forEach>


    var mydata = [
        {name: '厦门市',value: da[7] },{name: '漳州市',value: da[8] },
        {name: '福州市',value: da[0] },{name: '龙岩市',value: da[1] },
        {name: '南平市',value: da[2] },{name: '莆田市',value: da[4] },
        {name: '宁德市',value: da[3] },{name: '三明市',value: da[6] },
        {name: '泉州市',value: da[5] }
    ];

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    option = {
        title: {
            text: str,

            left: 'left'
        },
        tooltip: {
            trigger: 'item',
            formatter: '{b}<br\>aqi:{c}'
        },
        visualMap: {
            show : true,
            top:"5%",
            left:"left"

            //categories:['严重污染','重度污染','中度污染','轻度污染','良','']
            /*x: 'left',
            y: 'center'*/,
            splitList: [
                {start: 300, end:600,label:'严重污染'},{start: 200, end: 300,label:'重度污染'},
                {start: 150, end: 200,label:'中度污染'},{start: 100, end: 150,label:'轻度污染'},
                {start: 50, end: 100,label:'良'},{start: 0, end: 50,label:'优'},
            ],
            /*color: ['#5475f5', '#9feaa5', '#85daef','#74e2ca', '#e6ac53', '#9fb5ea']*/
            color:['#800000','#b22222','#ff0000','#ff8c00','#ffd700','#7fff00']
        },
        series: [
            {
                name: '福建',
                type: 'map',
                mapType: '福建',
                roam:false,
                selectedMode : 'multiple',
                label: {
                    normal: {
                        show: true
                    },
                    emphasis: {
                        show: true
                    }
                },
                data:mydata
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>
