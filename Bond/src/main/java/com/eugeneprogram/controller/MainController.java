package com.eugeneprogram.controller;

import java.security.PublicKey;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eugeneprogram.service.BondService;
import com.eugeneprogram.service.LoginService;

@Controller
public class MainController {
    @Autowired
    private BondService bondService;
    @Autowired
    private LoginService loginService;
    
    @GetMapping(value = "financial")
    public ModelAndView getFinancial() throws Exception   {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("financial/financial_position");
        
        List<Map<String, Object>> tempList = new ArrayList<>();        
        tempList = bondService.getDebtList();
        String debtor_id = tempList.get(0).get("debtor_id").toString();
        String debt_id = tempList.get(0).get("debt_id").toString();
        String lawyer_id = tempList.get(0).get("lawyer_id").toString();
        String creditor_id = tempList.get(0).get("creditor_id").toString();
                
        mv.addObject("debtList", tempList);
        mv.addObject("debtor_id", debtor_id);
        mv.addObject("creditor_id", creditor_id);
        mv.addObject("lawyer_id", lawyer_id);
        mv.addObject("debt_id", debt_id);
        
        
        return mv;
    }
    
    @GetMapping(value = "liquidationButton")
    public String getLiquidation()  {
        return "financial/liquidation";
    }
    
    @GetMapping(value = "rentalButton")
    public String getRental()   {
        return "financial/rental";
    }
    
    /*url경로를 post방식으로 받았으므로 @PostMapping처리를 하며 이용하는 페이지에서 만든 파라미터들을 메서드의 입력값으로 받고 jsp페이지를 반환한다.*/
    @PostMapping(value = "check_info")
    public String getInfo(@RequestParam("chk_info") String chk_info, @RequestParam("interest") String interest, @RequestParam("date") String date, @RequestParam("value") String value) {
        return "financial/check_info";
    }
    
    @GetMapping(value = "find_user")    
    public String getFindUser() {
        return "login/find_user";
    }
    
    @GetMapping(value = "login_page")
    public String getLoginPage()    {
        return "login/login_page";
    }
    
    
    @PostMapping(value = "login")
    public String getLogin(@RequestParam("uID") String uID, @RequestParam("uPW") String uPW) throws Exception    {
        Map<String, Object> lawyerMap = new HashMap<String, Object>()   {{
            put("lawyer_id", uID);
            put("lawyer_pw", uPW);
        }};
        
        List<Map<String, Object>> temp = loginService.selectPw(lawyerMap);
        
        if(temp.size() != 0)    {   
            System.out.println("로그인 결과 : " + temp.get(0).get("lawyer_id"));            
            return "financial/financial_position";            
        }
        else {
            return "login/login_fail";
        }
    }
    
    
    @GetMapping(value="find_pw")
    public String find_pw() {
        return "login/find_pw";
    }
    
    @GetMapping(value="find_id")
    public String find_id() {
        return "login/find_id";
    }
    
    @PostMapping(value="checkId")
    public ModelAndView getCheckId(@RequestParam("uName") String name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3) throws Exception    {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("login/checkId");
        
        System.out.println(name);
        System.out.println(hp1 + "-" + hp2 + "-" + hp3);
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> piMap = new HashMap<String, Object>();
        piMap.put("lawyer_name", name);
        piMap.put("lawyer_hp", hp);
        
        
        String idString = loginService.checkId(piMap);
        mv.addObject("id", idString);
        System.out.println(idString);
        
        return mv;
    }
    
    @PostMapping(value = "checkPw")
    public ModelAndView getCheckPw(@RequestParam("uID") String id, @RequestParam("uNAME") String name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3)   {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("login/checkPw");
        
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> piMap = new HashMap<String, Object>();
        piMap.put("lawyer_name", name);
        piMap.put("lawyer_hp", hp);
        piMap.put("lawyer_id", id);
        
        
        return mv;
    }
}
