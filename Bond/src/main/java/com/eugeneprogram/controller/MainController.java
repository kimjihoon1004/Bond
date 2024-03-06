package com.eugeneprogram.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.eugeneprogram.service.BondService;

@Controller
public class MainController {
    @Autowired
    BondService bondService;
    
    @GetMapping(value = "financial")
    public ModelAndView getFinancial() throws Exception   {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("financial/financial_position");
        
        List<Map<String, Object>> tempList = new ArrayList<>();        
        tempList = bondService.getDebtList();
        mv.addObject("debtList", tempList);
        
        return mv;
    }
    
    @GetMapping(value = "login")
    public String getLogin()    {
        return "login/login_page";
    }
}
