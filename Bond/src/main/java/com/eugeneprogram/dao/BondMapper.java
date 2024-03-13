package com.eugeneprogram.dao;

import java.util.List;
import java.util.Map;

public interface BondMapper {
    public List<Map<String, Object>> getDebtList(String debtor_id) throws Exception;
}
