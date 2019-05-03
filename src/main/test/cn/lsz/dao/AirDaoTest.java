package cn.lsz.dao;

import cn.lsz.model.Air;
import cn.lsz.model.Datelimit;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Date;
import java.util.List;

import static cn.lsz.system.DataPredict.predict;
import static cn.lsz.system.Dateselect.getNDate;
import static cn.lsz.system.Dateselect.getNight;
import static cn.lsz.system.Dateselect.getZero;
import static org.junit.Assert.*;

public class AirDaoTest {

    @Test
    public void selectAir() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AirDao airDao = (AirDao) ctx.getBean(AirDao.class);

        List<Air> airs = airDao.selectAir();
        System.out.println(airs.size());
    }

    @Test
    public void selectAirByDate() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AirDao airDao = (AirDao) ctx.getBean(AirDao.class);
        Datelimit datelimit = new Datelimit();
        datelimit.setTimeend(new Date());
        datelimit.setTimestart(getNDate(-3));
        datelimit.setCityid(1);
        List<Air> list = airDao.selectAirByDate(datelimit);
        /*System.out.println(list.get(0).getTime().toString());
        System.out.println(list.get(1).getTime().toString());
        System.out.println(list.get(2).getTime().toString());
        System.out.println(list.get(3).getTime().toString());*/
        Air air = predict(list);
        System.out.println(air.getAqi());
    }

    @Test
    public void delAir() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AirDao airDao = (AirDao) ctx.getBean(AirDao.class);

        Date date = new Date();
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(date));
        datelimit.setTimeend(getNight(date));
        datelimit.setCityid(1);
        System.out.println(airDao.delAir(datelimit));

    }

    @Test
    public void addAir(){
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AirDao airDao = (AirDao) ctx.getBean(AirDao.class);
        Datelimit datelimit = new Datelimit();
        datelimit.setTimestart(getZero(new Date()));
        datelimit.setTimeend(new Date());
        datelimit.setCityid(1);
        List<Air> airs = airDao.selectAirByDate(datelimit);
        Date date = airs.get(0).getTime();
        Air air = new Air();
        air.setTime(date);
        air.setO3(1);
        air.setSo2(3);
        air.setCityid(1);
        air.setAqi(234);
        System.out.println(airDao.updateAir(air));
    }


}