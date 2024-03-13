package com.eugeneprogram.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eugeneprogram.dao.LoginMapper;

@Service
public class LoginService implements LoginMapper {
    @Autowired
    LoginMapper loginMapper;
    
    @Override
    public List<Map<String, Object>> selectLawyer(Map<String, Object> lawyerMap) throws Exception   {
        return loginMapper.selectLawyer(lawyerMap);
    }
    
    @Override
    public String checkId(Map<String, Object> piMap) throws Exception   {
        return loginMapper.checkId(piMap);
    }
    
    @Override
    public Integer checkPw(Map<String, Object> piMap) throws Exception  {
        return loginMapper.checkPw(piMap);
    }
    
    @Override
    public List<Map<String, Object>> selectDebtor(int lawyer_id) throws Exception    {
        return loginMapper.selectDebtor(lawyer_id);
    }
}
