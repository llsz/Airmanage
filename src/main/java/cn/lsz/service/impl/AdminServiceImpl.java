package cn.lsz.service.impl;

import cn.lsz.dao.AdminDao;
import cn.lsz.model.Admin;
import cn.lsz.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminServiceImpl implements AdminService{
    @Resource
    private AdminDao adminDao;

    public Admin selectAdminById(String id){
        return this.adminDao.selectAdminById(id);
    }
    public Admin selectAdmin(String id,String pwd){
        return this.adminDao.selectAdmin(id,pwd);
    }

}
