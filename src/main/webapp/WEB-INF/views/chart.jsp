<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/29
  Time: 15:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>chart</title>
</head>
<body>
<div id="datachart" style="position:absolute;left:0;width: 50%;height: 390px;" ></div>
<div id="datachart1" style="position:absolute;left:50%;width: 50%;height: 390px;" ></div>

<script>
    var datachart = echarts.init(document.getElementById('datachart'));
    var datachart1 = echarts.init(document.getElementById('datachart1'));
    var dataAxis = new Array();
    var data = new Array();
    var level = new Array();
    var ll = ['优','良','轻度污染','中度污染','重度污染','严重污染'];
    var p=0;
    var max=0;

    <c:forEach var="item" items="${dates}" varStatus="s">
        dataAxis[p]="<fmt:formatDate  value="${item}" pattern="yyyy-MM-dd"/>";
        console.log(dataAxis[p]);
        p++;
    </c:forEach>
    for(var m=0; m<dataAxis.length; m++){
        data[m]=0;
        console.log(dataAxis[m]);
    }

    for(var j=0;j<6;j++){
        level[j]=0;
    }
    <c:forEach var="item" items="${pageBean.beanList}" varStatus="s">
        var time = '<fmt:formatDate  value="${item.time}" pattern="yyyy-MM-dd"/>';
        for(var i=0;i<6;i++){
            if(ll[i] == ${item.level}){
                level[i]++;
                break;
            }
        }
        for(var n=0;n<dataAxis.length+1;n++){
            if(dataAxis[n] == time){
                data[n] = Math.round(item.aqi);
                if(data[n] > max){
                    max = data[n];
                }
            }
        }
    </c:forEach>

    max = max+10;
    var count = Math.ceil(dataAxis.length/30);

    var pie = [];
    var selected = {};
    for(var t=0;t<dataAxis.length;t++){
        pie.push({
            name:ll[t],
            value:level[t]
        });
        if(level[t]=='0'){
            selected[ll[t]] = false;
        }else {
            selected[ll[t]] = true;
        }
    }

    var option = {
        title:{
            text:'折线图',
            x:'center'
        },
        legend:{
            orient: 'horizontal',
            x:'left',
            y:'top',
            data:'aqi'
        },
        grid:{
            top:'16%',
            left:'3%',
            right:'8%',
            bottom:'3%',
            containLabel:true
        },
        tooltip:{
            trigger:'item'
        },
        xAxis:{
            name:"日期",
            type:'category',
            axisLabel:{
                rotate:45,   //旋转角度
                interval:count
            },
            boundaryGap: false,
            data:dataAxis
        },

        yAxis:{
            name:'aqi',
            type:'value',
            min:0,
            max:max,

        },
        series:[{
            name:'aqi',
            data:data,
            type:'line',
            smooth:0.5
        }]



    };

    var option1 = {
        title: {
            text: '空气质量比例图',
            left: 'center',
            textStyle:{
                fontWeight:"lighter",
                fontSize:16
            }
        },
        tooltip:{
            trigger:'item',
            formatter:"{a}:{b}"
        },
        legend:{
            type:'scroll',
            orient:'vertical',
            right:10,
            top: 20,
            bottom: 20,
            data: ll,
            selected:selected

        },
        series:[{
            type:'pie',
            selectedMode:'single',
            selectedOffset:30,
            center:['50%','50%'],
            radius:[0,'45%'],
            itemStyle:{
                normal:{
                    label:{
                        show: false      //隐藏标示文字
                    },

                    normal:{
                        color:function(params) {
                            //自定义颜色
                            var colorList = [
                                /*'#800000','#b22222','#ff0000','#ff8c00','#ffd700','#7fff00'*/
                                '#7fff00','#ffd700','#ff8c00','#ff0000','#b22222','#800000'
                            ];
                            return colorList[params.dataIndex]
                        }
                    },
                    borderWidth: 1.5,
                    borderColor: '#ffffff'

                }
            },
            name:"空气质量",
            hoverAnimation: true,
            minAngle: 0,
            data: pie
        }]
    };
    datachart.setOption(option);
    datachart1.setOption(option1);
    setTimeout(function () {
        window.onresize = function () {
            datachart.resize();
            datachart1.resize();
        }
    },200)




</script>
</body>
</html>
