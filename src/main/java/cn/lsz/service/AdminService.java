package cn.lsz.service;

import cn.lsz.model.Admin;

public interface AdminService {
    Admin selectAdminById(String id);
    Admin selectAdmin(String id,String pwd);
}
