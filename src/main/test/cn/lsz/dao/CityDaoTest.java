package cn.lsz.dao;

import cn.lsz.model.City;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class CityDaoTest {

    @Test
    public void selectCityById() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        CityDao cityDao = (CityDao) ctx.getBean(CityDao.class);

        /*City city = cityDao.selectCityById(1);
        System.out.println(city.getCityname());
*/
        City city1 = cityDao.selectCityByName("福州");
        System.out.println(city1.getCityid());
    }

    @Test
    public void selectCityByName() {
    }
}