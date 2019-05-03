package cn.lsz.system;
import cn.lsz.model.Air;
import com.mathworks.toolbox.javabuilder.MWException;
import predict.Predict;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static cn.lsz.system.DataCount.countAir;
import static cn.lsz.system.Dateselect.getTomorrow;


/*通过前四天数据预测第五天各质量因子
* */
public class DataPredict {
     public static Air predict(List<Air> list) {
         int size = list.size();
         double[][] pm25 = new double[4][1];
         double[][] pm10 = new double[4][1];
         double[][] so2 = new double[4][1];
         double[][] co = new double[4][1];
         double[][] no2 = new double[4][1];
         double[][] o3 = new double[4][1];

         /*mat文件路径*/
         String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
         String fpm25 = file + "/matlab.mat";
         String fpm10 = file + "/matlab_pm10.mat";
         String fso2 = file + "/matlab_so2.mat";
         String fco = file + "/matlab_co.mat";
         String fno2 = file + "/matlab_no2.mat";
         String fo3 = file + "/matlab_o3.mat";

         /*各因子四天数据*/
         for (int i = 0; i < size; i++) {
             pm25[i][0] = list.get(i).getPm2_5();
             pm10[i][0] = list.get(i).getPm10();
             so2[i][0] = list.get(i).getSo2();
             co[i][0] = list.get(i).getCo();
             no2[i][0] = list.get(i).getNo2();
             o3[i][0] = list.get(i).getO3();

         }

         Air air = new Air();

         try {

             Predict predict = new Predict();
             Object[] pm251 = predict.predicePM25(1, fpm25, pm25);
             Object[] pm101 = predict.predictPM10(1, fpm10, pm10);
             Object[] so21 = predict.predictSO2(1, fso2, so2);
             Object[] co1 = predict.predictCO(1, fco, co);
             Object[] no21 = predict.predictNO2(1, fno2, no2);
             Object[] o31 = predict.predictO3(1, fo3, o3);

             Date date = getTomorrow();
             air.setTime(date);
             air.setPm2_5(toDouble(pm251));
             air.setPm10(toDouble(pm101));
             air.setSo2(toDouble(so21));
             air.setNo2(toDouble(no21));
             air.setO3(toDouble(o31));

             Air air1 = countAir(air,2);
             return air1;


         } catch (MWException e) {
             e.printStackTrace();

         }

         return null;

     }

     public static double toDouble(Object[] o){
         double data = new Double(o[0].toString());
         return data;
     }
    /*public String ttt(){
        String file = this.getClass().getClassLoader().getResource("").getPath().toString();
        return file;
    }
     public static void main(String args[]){
         try{
             Predict predict = new Predict();
             double[][] data = {{14},{21},{13},{19}};

             Object[] a =predict.predicePM25(1,"/matlab/matlab.mat",data);
             System.out.println(a[0]);
         }catch (MWException e){
             e.printStackTrace();
         }
        *//*DataPredict dataPredict = new DataPredict();

         String file = dataPredict.ttt();
         System.out.println(file);*//*
     }*/

    /*public static void main(String args[]){
        System.out.println("test");
        List<Air> list = new ArrayList<Air>();
        for(int i=0;i<4;i++){
            Air air = new Air();
            air.setTime(new Date());
            air.setPm2_5((i+1)*10);
            air.setPm10((i+1)*10);
            air.setSo2((i+1)*10);
            air.setCo((i+1)*10);
            air.setNo2((i+1)*10);
            air.setO3((i+1)*10);
            list.add(i,air);
        }
        System.out.println("222");
        Air air = predict(list);
        System.out.println("333");
        System.out.println(air.getAqi());
        System.out.println(air.getNo2());


        return ;
    }*/

}
