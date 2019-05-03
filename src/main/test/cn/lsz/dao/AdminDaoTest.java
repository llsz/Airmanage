package cn.lsz.dao;

import cn.lsz.model.Admin;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

public class AdminDaoTest {

    @Test
    public void selectAdminById() {
        ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mybatis.xml");
        AdminDao dao = (AdminDao) ctx.getBean(AdminDao.class);

        String id = "admin";
        String pwd = "123456";
        Admin admin = dao.selectAdminById(id);
        System.out.println(admin.getName()+' '+admin.getPassword());
        Admin admin1 = dao.selectAdmin(id,pwd);
        System.out.println(admin1.getName());
    }
}