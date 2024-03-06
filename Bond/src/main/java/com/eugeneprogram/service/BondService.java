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
    
    public List<Map<String, Object>> getDebtList() throws Exception {
        return bondMapper.getDebtList();
    }
}
