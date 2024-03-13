package com.eugeneprogram.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eugeneprogram.dao.BondMapper;

@Service
public class BondService {
    @Autowired
    BondMapper bondMapper;
    
    public List<Map<String, Object>> getDebtList(String debtor_id) throws Exception {
        return bondMapper.getDebtList(debtor_id);
    }
}
