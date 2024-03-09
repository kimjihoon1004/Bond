package com.eugeneprogram.dao;

import java.util.List;
import java.util.Map;

public interface LoginMapper {
    public List<Map<String, Object>> selectPw(Map<String, Object> lawyerMap) throws Exception;
    public String checkId(Map<String, Object> piMap) throws Exception;
    public Integer checkPw(Map<String, Object> piMap) throws Exception;
}
