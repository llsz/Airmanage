package cn.lsz.dao;

import cn.lsz.model.Admin;

import org.apache.ibatis.annotations.Param;

public interface AdminDao {
    Admin selectAdminById(String id);
    Admin selectAdmin(@Param("id") String id,@Param("password") String pwd);
}
