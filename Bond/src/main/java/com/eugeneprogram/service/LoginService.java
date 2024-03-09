package com.eugeneprogram.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eugeneprogram.dao.LoginMapper;

@Service
public class LoginService {
    @Autowired
    LoginMapper loginMapper;
    
    public List<Map<String, Object>> selectPw(Map<String, Object> lawyerMap) throws Exception   {
        return loginMapper.selectPw(lawyerMap);
    }
    
    public String checkId(Map<String, Object> piMap) throws Exception   {
        return loginMapper.checkId(piMap);
    }
    
    public Integer checkPw(Map<String, Object> piMap) throws Exception  {
        return loginMapper.checkPw(piMap);
    }
}
