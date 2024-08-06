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
    public int checkPw(Map<String, Object> piMap) throws Exception  {
        return loginMapper.checkPw(piMap);
    }
    
    @Override
    public List<Map<String, Object>> selectDebtor(int lawyer_id) throws Exception    {
        return loginMapper.selectDebtor(lawyer_id);
    }
    
    @Override
    public int updateLawyerPw(String id, String pw, String hp, String name) throws Exception    {       
        return loginMapper.updateLawyerPw(id, pw, hp, name);
    }
    
    @Override
    public int insertLawyer(String id, String pw, String hp, String name) throws Exception  {
        int result = 0;
        result = loginMapper.insertLawyer(id, pw, hp, name);
        return result;
    }
    
    @Override
    public int duplicateId(String id) throws Exception   {
        int result = 0;
        result = loginMapper.duplicateId(id);
        return result;
    }
    
    @Override
    public int updateLawyer(String name, String hp, String id, String pk) throws Exception   {
        int result = 0;
        result = loginMapper.updateLawyer(name, hp, id, pk);
        return result;
    }
    
}
