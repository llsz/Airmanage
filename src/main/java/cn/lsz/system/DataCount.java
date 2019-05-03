package cn.lsz.system;

import cn.lsz.model.Air;

import java.text.DecimalFormat;

public class DataCount {
    /**
     * 计算aqi并找出首要污染物
     * @param air
     * @param n
     * @return
     */
    public static Air countAir(Air air, int n){
        double[] a = new double[6];
        String[] s = {"PM2.5","PM10","SO2","NO2","O3","CO" };
        if(air.getPm2_5() <= 35){
            a[0] = air.getPm2_5()*50/35;
        }else if(air.getPm2_5()>35 && air.getPm2_5()<=75){
            a[0] = (air.getPm2_5()-35)*50/40+50;
        }else{
            a[0] = (air.getPm2_5()-75)*50/40+100;
        }

        if(air.getPm10()<= 50){
            a[1] = air.getPm10();
        }else if(air.getPm10() > 50 && air.getPm10() <= 150){
            a[1] = (air.getPm10()-50)*50/100 + 50;
        }else{
            a[1] = (air.getPm10()-150)*50/100 + 100;
        }

        if(air.getSo2()<=50){
            a[2] = air.getSo2();
        }else if(air.getSo2()>50 && air.getSo2()<=150){
            a[2] = (air.getSo2()-50)*50/100 +50;
        }else{
            a[2] = (air.getSo2()-150)*50/325 +100;
        }

        if(air.getNo2()<=40){
            a[3] = air.getNo2()*50/40;
        }else if(air.getNo2()>40 && air.getNo2()<=80){
            a[3] = (air.getNo2()-40)*50/40 + 50;
        }else {
            a[3] = (air.getNo2()-80)*50/100 + 100;
        }

        if(air.getO3()<=160){
            a[4] = air.getO3()*50/160;
        }else if(air.getO3()>160 && air.getO3()<=200){
            a[4] = (air.getO3()-160)*50/40 + 50;
        }else {
            a[4] = (air.getO3()-200)*50/100 +100;
        }

        if(air.getCo()<=2){
            a[5] = air.getCo()*50/2;
        }else if(air.getCo()>2 && air.getCo()<=4){
            a[5] = (air.getCo()-2)*50/2 + 50;
        }else {
            a[5] = (air.getCo()-4)*50/10 + 100;
        }

        double max = 0;
        int t=0;
        for(int i=0;i<6;i++){
            if(max < a[i]){
                max = a[i];
                t = i;
            }
        }

        if(n==1){
            air.setPollution(s[t]);
        }else{
            air.setAqi(max);
            if(max <50){
                air.setPollution("-");
            }else {
                air.setPollution(s[t]);
            }

        }



        return air;

    }

    /**
     * 污染物预测值上下限
     * @param t
     * @param min
     * @param max
     * @return
     */
    public static String dataLimit(double t, long min, long max){
        String s = "";
        long x = Math.round(t);
        if(x-min >=0){
            min = x-min;
            max = x+max;
            s = s + min + "-" + max;
        }else {
            max = x+max;
            s = s + "0-" + max;
        }

        return s;
    }

    public static String dataLimit(double t, double min, double max){

        String s = "";
        if(t-min >=0){
            min = t-min;
            max = t+max;
            s = s + String.format("%.1f", min) + "-" + String.format("%.1f", max);
        }else {
            max = t+max;
            s = s + "0-" + String.format("%.1f", max);
        }

        return s;
    }



    /*public static void main(String args[]){
        String s = dataLimit(0.34,0.5,0.5);
        System.out.println(s);

        System.out.println(String.format("%.2f", 0.556));
    }*/



    /*public static void main(String args[]){
        Air air = new Air();
        air.setPm2_5(58);
        air.setPm10(98);
        air.setSo2(11);
        air.setNo2(30);
        air.setO3(138);

        countAir(air);
        //System.out.println(air.getAqi()+' '+air.getPollution());
    }*/
}
