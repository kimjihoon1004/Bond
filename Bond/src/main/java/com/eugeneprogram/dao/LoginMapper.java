package com.eugeneprogram.dao;

import java.util.List;
import java.util.Map;

public interface LoginMapper {
    public List<Map<String, Object>> selectLawyer(Map<String, Object> lawyerMap) throws Exception;
    public String checkId(Map<String, Object> piMap) throws Exception;
    public int checkPw(Map<String, Object> piMap) throws Exception;
    public List<Map<String, Object>> selectDebtor(int lawyer_id) throws Exception;
    public int insertLawyer(String id, String pw, String hp, String name) throws Exception;
    public int duplicateId(String id) throws Exception;
    public int updateLawyerPw(String id, String pw, String hp, String name) throws Exception;
    public int updateLawyer(String name, String hp, String id, String pk) throws Exception;
}
