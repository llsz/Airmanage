package cn.lsz.service.impl;

import cn.lsz.dao.AdminDao;
import cn.lsz.model.Air;
import cn.lsz.service.AirService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

import static org.junit.Assert.*;

public class AirServiceImplTest {


    @Test
    public void selectAir() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AirService service = (AirService) ctx.getBean(AirService.class);

        List<Air> air = service.selectAir();
        System.out.println(air.size());

    }

    @Test
    public void addAir() {
    }

    @Test
    public void delAir() {
    }
}