package com.eugeneprogram.dao;

import java.util.List;
import java.util.Map;

public interface BondMapper {
    public List<Map<String, Object>> getDebtList(String debtor_id) throws Exception;
    public int insertDebt(Map<String, Object> debtMap) throws Exception;
    public String selectDebtorName(String debtor_id) throws Exception;
}
