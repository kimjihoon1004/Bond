package com.eugeneprogram.service;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eugeneprogram.dao.BondMapper;

@Service
public class BondService implements BondMapper{
    @Autowired
    BondMapper bondMapper;
    
    
    @Override
    public List<Map<String, Object>> getDebtList(String debtor_id) throws Exception {
        return bondMapper.getDebtList(debtor_id);
    }
    
    @Override
    public int insertDebt(Map<String, Object> debtMap) throws Exception {
        int success = 0;
        success = bondMapper.insertDebt(debtMap);
        return success;
    }
    
    @Override
    public String selectDebtorName(String debtor_id) throws Exception   {
        return bondMapper.selectDebtorName(debtor_id);
    }
    
    @Override
    public Map<String, Object> selectDebtor(String debtor_id) throws Exception {
        return bondMapper.selectDebtor(debtor_id);
    }
    
    public List<Map<String, Object>> selectCreditor() throws Exception    {
        return bondMapper.selectCreditor();
    }
    
    public int updateDebtor(Map<String, Object> debtorMap) throws Exception  {
        int success = 0;
        success = bondMapper.updateDebtor(debtorMap);        
        return success;
    }
   
}
