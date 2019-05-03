package cn.lsz.system;

import cn.lsz.model.Air;
import com.mathworks.toolbox.javabuilder.MWException;
import elmanCity.Elman;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static cn.lsz.system.DataCount.countAir;
import static cn.lsz.system.Dateselect.getTomorrow;

public class ElmanPredict {
    /*福州预测*/
    public static Air predictElman(List<Air> list) {
        int size = list.size();
        double[][] pm25 = new double[4][1];
        double[][] pm10 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] co = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/elmanPm25.mat";
        String fpm10 = file + "/elmanPm10.mat";
        String fso2 = file + "/elmanSo2.mat";
        String fco = file + "/elmanCo.mat";
        String fno2 = file + "/elmanNo2.mat";
        String fo3 = file + "/elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            co[i][0] = list.get(i).getCo();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
            }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.elmanSo2(1, fso2, so2);

            Object[] no21 = predict.elmanNo2(1, fno2, no2);
            Object[] o31 = predict.elmanO3(1, fo3, o3);

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
            return null;
        }
    }
    /*龙岩*/
    public static Air ly_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] co = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/ly_elmanPm25.mat";
        String fpm10 = file + "/ly_elmanPm10.mat";
        String fso2 = file + "/ly_elmanSo2.mat";
        String fno2 = file + "/ly_elmanNo2.mat";
        String fo3 = file + "/ly_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();

            Object[] pm251 = predict.ly_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.ly_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.ly_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.ly_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.ly_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air np_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/np_elmanPm25.mat";
        String fpm10 = file + "/np_elmanPm10.mat";
        String fso2 = file + "/np_elmanSo2.mat";
        String fno2 = file + "/np_elmanNo2.mat";
        String fo3 = file + "/np_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.np_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.np_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.np_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.np_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.np_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air nd_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/nd_elmanPm25.mat";
        String fpm10 = file + "/nd_elmanPm10.mat";
        String fso2 = file + "/nd_elmanSo2.mat";
        String fno2 = file + "/nd_elmanNo2.mat";
        String fo3 = file + "/nd_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.nd_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.nd_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.nd_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.nd_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.nd_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air pt_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/pt_elmanPm25.mat";
        String fpm10 = file + "/pt_elmanPm10.mat";
        String fso2 = file + "/pt_elmanSo2.mat";
        String fno2 = file + "/pt_elmanNo2.mat";
        String fo3 = file + "/pt_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.pt_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.pt_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.pt_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.pt_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.pt_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air qz_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/qz_elmanPm25.mat";
        String fpm10 = file + "/qz_elmanPm10.mat";
        String fso2 = file + "/qz_elmanSo2.mat";
        String fno2 = file + "/qz_elmanNo2.mat";
        String fo3 = file + "/qz_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.qz_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.qz_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.qz_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.qz_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.qz_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air sm_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/sm_elmanPm25.mat";
        String fpm10 = file + "/sm_elmanPm10.mat";
        String fso2 = file + "/sm_elmanSo2.mat";
        String fno2 = file + "/sm_elmanNo2.mat";
        String fo3 = file + "/sm_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.sm_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.sm_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.sm_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.sm_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.sm_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air xm_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/xm_elmanPm25.mat";
        String fpm10 = file + "/xm_elmanPm10.mat";
        String fso2 = file + "/xm_elmanSo2.mat";
        String fno2 = file + "/xm_elmanNo2.mat";
        String fo3 = file + "/xm_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.xm_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.xm_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.xm_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.xm_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.xm_elmanO3(1, fo3, o3);

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
            return null;
        }
    }

    public static Air zz_Elman(List<Air> list) {
        int size = list.size();
        double[][] pm10 = new double[4][1];
        double[][] pm25 = new double[4][1];
        double[][] so2 = new double[4][1];
        double[][] no2 = new double[4][1];
        double[][] o3 = new double[4][1];

        /*mat文件路径*/
        String file = "D:/Program Files/MatLab2016A/Matlab/bin/";
        String fpm25 = file + "/zz_elmanPm25.mat";
        String fpm10 = file + "/zz_elmanPm10.mat";
        String fso2 = file + "/zz_elmanSo2.mat";
        String fno2 = file + "/zz_elmanNo2.mat";
        String fo3 = file + "/zz_elmanO3.mat";

        /*各因子四天数据*/
        for (int i = 0; i < size; i++) {
            pm25[i][0] = list.get(i).getPm2_5();
            pm10[i][0] = list.get(i).getPm10();
            so2[i][0] = list.get(i).getSo2();
            o3[i][0] = list.get(i).getO3();
            no2[i][0] = list.get(i).getNo2();
        }

        Air air = new Air();

        try {

            Elman predict = new Elman();
            Object[] pm251 = predict.zz_elmanPm25(1, fpm25, pm25);
            Object[] pm101 = predict.zz_elmanPm10(1, fpm10, pm10);
            Object[] so21 = predict.zz_elmanSo2(1, fso2, so2);
            Object[] no21 = predict.zz_elmanNo2(1, fno2, no2);
            Object[] o31 = predict.zz_elmanO3(1, fo3, o3);

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
            return null;
        }
    }
    public static double toDouble(Object[] o){
        double data = new Double(o[0].toString());
        return data;
    }


}
