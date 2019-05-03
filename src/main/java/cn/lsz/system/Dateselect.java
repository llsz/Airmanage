package cn.lsz.system;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 获取某时间段内的每一天
 */
public class Dateselect {
    public static List<Date> findDates(Date dBegin, Date dEnd){
        List<Date> lDate = new ArrayList<Date>();
        lDate.add(dBegin);
        Calendar calBegin = Calendar.getInstance();
        calBegin.setTime(dBegin);
        Calendar calEnd = Calendar.getInstance();
        dEnd = getxDateend(-1,dEnd);
        calEnd.setTime(dEnd);
        while (dEnd.after(calBegin.getTime())){
            //根据日历的规则，为给定的日历字段添加或减去指定的时间量
            calBegin.add(Calendar.DAY_OF_MONTH, 1);
            lDate.add(calBegin.getTime());
        }
        return lDate;
    }


    /**
     * 某天前n天23:59:59
     * */
    public static Date getxDateend(int n,Date date){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY,23);
        calendar.set(Calendar.MINUTE,59);
        calendar.set(Calendar.SECOND,59);
        calendar.set(Calendar.MILLISECOND,999);
        calendar.add(calendar.DATE,n);
        date = calendar.getTime();
        return date;
    }

    /**
     * 当月第一天0:00:00
     * @return Date
     */
    public static Date getFirstDay(Date date) {
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        Date theDate = calendar.getTime();

        GregorianCalendar gcLast = (GregorianCalendar) Calendar.getInstance();
        gcLast.setTime(theDate);
        gcLast.set(Calendar.DAY_OF_MONTH, 1);
        gcLast.set(Calendar.HOUR_OF_DAY,0);
        gcLast.set(Calendar.MINUTE,0);
        gcLast.set(Calendar.SECOND,0);
        gcLast.set(Calendar.MILLISECOND,0);
        String day_first = df.format(gcLast.getTime());
        StringBuffer str = new StringBuffer().append(day_first);
        System.out.println(str.toString());
        return gcLast.getTime();
    }

    /*public static void main(String args[]){
        Date date0 = new Date();
        Date date = getFirstDay(date0);
    }*/
    /**
     * 明天
     * */
    public static Date getTomorrow(){
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE,1);
        date = calendar.getTime();

        return date;
    }

    /**
     * 前n天
     * */
    public static Date getNDate(int n){
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.add(calendar.DATE,n);
        date = calendar.getTime();

        return date;
    }

    /**
    * 某天00:00:00
    * */
    public static Date getZero(Date date){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY,0);
        calendar.set(Calendar.MINUTE,0);
        calendar.set(Calendar.SECOND,0);
        calendar.set(Calendar.MILLISECOND,0);
        date = calendar.getTime();
        return date;
    }

    /**
     * 某天23:59:59
     * */

    public static Date getNight(Date date){
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY,23);
        calendar.set(Calendar.MINUTE,59);
        calendar.set(Calendar.SECOND,59);
        calendar.set(Calendar.MILLISECOND,999);
        date = calendar.getTime();
        return date;
    }

    /**
     * 前n天00：00:00
     * */
    public static Date getNDatestart(int n){
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY,0);
        calendar.set(Calendar.MINUTE,0);
        calendar.set(Calendar.SECOND,0);
        calendar.set(Calendar.MILLISECOND,0);
        calendar.add(calendar.DATE,n);
        date = calendar.getTime();
        return date;
    }

    /**
    * 前n天23:59:59
    * */
    public static Date getNDateend(int n){
        Date date = new Date();
        Calendar calendar = new GregorianCalendar();
        calendar.setTime(date);
        calendar.set(Calendar.HOUR_OF_DAY,23);
        calendar.set(Calendar.MINUTE,59);
        calendar.set(Calendar.SECOND,59);
        calendar.set(Calendar.MILLISECOND,999);
        calendar.add(calendar.DATE,n);
        date = calendar.getTime();
        return date;
    }

    /**
     * 字符串转日期
     * */
    public static Date toDate(String da){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            Date date = sdf.parse(da);
            return date;
        }catch (ParseException e){
            e.printStackTrace();
            return null;
        }
    }

   /*public static void main(String args[]){
        Date date = toDate("2019-02-01");

        System.out.println(date);
        //System.out.println(getNight(new Date()));
    }*/

    public static Date dateToDate(String time){

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", java.util.Locale.US);
            Date date = sdf.parse(time);
            return date;
        }catch (ParseException e){
            e.printStackTrace();
            return null;
        }


    }

    public static String dateToString(Date date){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        return sdf.format(date);
    }

   /* public static void main(String args[]){
        Date date = new Date();
        System.out.println(dateToString(date));
        System.out.println(getNight(date));
        Date da = dateToDate("Mon Oct 24 00:00:00 CST 2016");
        System.out.println(da);
    }*/
}