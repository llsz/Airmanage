package cn.lsz.system;

public class Airjudge {
    /*判断空气质量预测等级*/
    public static String levelJudge(double aqi){
        String level;
        if(aqi <= 40){
            level = "优";
        }else if(aqi>40 && aqi<=70){
            level = "优-良";
        }else if(aqi>70 && aqi<=90){
            level = "良";
        }else if (aqi>90 && aqi<=120){
            level = "良-轻度污染";
        }else if(aqi>120 && aqi<=140){
            level = "轻度污染";
        }else if(aqi>140 && aqi<=170){
            level = "轻-中度污染";
        }else if(aqi>170 && aqi<=190){
            level = "中度污染";
        }else if(aqi>190 && aqi<=220){
            level = "中-重度污染";
        }else if(aqi>220 && aqi<=290){
            level = "重度污染";
        }else if(aqi>290 && aqi<=320){
            level = "重-严重污染";
        }else {
            level = "严重污染";
        }

        return level;
    }

    public static String level_Judge(double aqi){
        String level;
        if(aqi <= 50){
            level = "优";
        }else if(aqi>50 && aqi<=100){
            level = "良";
        }else if(aqi>100 && aqi<=150){
            level = "轻度污染";
        }else if(aqi>150 && aqi<=200){
            level = "中度污染";
        }else if(aqi>200 && aqi<=300){
            level = "重度污染";
        }else {
            level = "严重污染";
        }
        return level;
    }

    public static String healthJudge(double aqi){
        String health;
        if(aqi<=50){
            health = "空气质量令人满意，基本无空气污染，各类人群可正常活动。";
        }else if(aqi>50 && aqi<=100){
            health = "空气质量可接受，但某些污染物可能对极少数异常敏感人群健康有较弱影响，建议极少数异常敏感人群应减少户外活动。";
        }else if(aqi>100 && aqi<=150){
            health = "易感人群症状有轻度加剧，健康人群出现刺激症状。建议儿童、老年人及心脏病、 呼吸系统疾病患者应减少长时间、高强度的户外锻炼。";
        }else if(aqi>150 && aqi<=200){
            health = "进一步加剧易感人群症状，可能对健康人群心脏、呼吸系统有影响，建议疾病患者避免长时间、高强度的户外锻练，一般人群适量减少户外运动。";
        }else if(aqi>200 && aqi<=300){
            health = "心脏病和肺病患者症状显著加剧，运动耐受力降低，健康人群普遍出现症状，建议儿童、老年人和心脏病、肺病患者应停留在室内，停止户外运动，一般人群减少户外运动。";
        }else {
            health = "健康人群运动耐受力降低，有明显强烈症状，提前出现某些疾病，建议儿童、老年人和病人应当留在室内，避免体力消耗，一般人群应避免户外活动。";
        }

        return health;
    }

    public static long[] aqiJudge(double aqi){
        long[] d = new long[2];
        d[0] = Math.round(aqi) + 10;
        d[1] = Math.round(aqi) - 20;

        for(int i=0;i<2;i++){
            long t = d[i]%5;
            if(t<3){
                d[i] = d[i] - t;
            }else {
                d[i] = d[i] + 5 -t;
            }
            if(d[1]<0){
                d[1] = 5;
            }
        }
        return d;
    }

    /**
     * 判断城市
     */

    public static String cityJudge(int id){
        if(id == 1){
            return "福州";
        }else if(id == 2){
            return "龙岩";
        }else if(id == 3){
            return "南平";
        }else if(id == 4){
           return "宁德";
        }else if(id == 5){
            return "莆田";
        }else if(id == 6){
            return "泉州";
        }else if(id == 7){
            return "三明";
        }else if(id == 8){
            return "厦门";
        }else {
            return "漳州";
        }
    }

    public static int cityidJudge(String city){
        if(city == "福州"){
            return 1;
        }else if(city == "龙岩"){
            return 2;
        }else if(city == "南平"){
            return 3;
        }else if(city == "宁德"){
            return 4;
        }else if(city == "莆田"){
            return 5;
        }else if(city == "泉州"){
            return 6;
        }else if(city == "三明"){
            return 7;
        }else if(city == "厦门"){
            return 8;
        }else if (city == "漳州"){
            return 9;
        }else {
            return 0;
        }
    }

}
