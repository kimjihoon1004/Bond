package com.eugeneprogram.controller;

import java.util.Date;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
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

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
    @Autowired
    private BondService bondService;
    @Autowired
    private LoginService loginService;
    
    @PostMapping(value = "financial")
    public ModelAndView getFinancial(@RequestParam("lawyer_id") String lawyer_id, @RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id, @RequestParam("debtor_name") String debtor_name) throws Exception   {
        ModelAndView mv = new ModelAndView();
        
        System.out.println("lawyer_id : " + lawyer_id);
        System.out.println("debtor_id : " + debtor_id);
        System.out.println("creditor_id : " + creditor_id);
        System.out.println("debtor_name : " + debtor_name);
        mv.setViewName("financial/financial_position");
        
        List<Map<String, Object>> tempList = new ArrayList<>();        
        tempList = bondService.getDebtList(debtor_id);
        String debtorName = bondService.selectDebtorName(debtor_id);
        System.out.println("채무자 이름 : " + debtorName);
        mv.addObject("debtList", tempList);
        mv.addObject("debtor_name", debtorName);
        mv.addObject("creditor_id", creditor_id);
        mv.addObject("debtor_id", debtor_id);
        /*
         * String debtor_id = tempList.get(0).get("debtor_id").toString();
        String debt_id = tempList.get(0).get("debt_id").toString();
        String lawyer_id = tempList.get(0).get("lawyer_id").toString();
        String creditor_id = tempList.get(0).get("creditor_id").toString();
                
        
        mv.addObject("debtor_id", debtor_id);
        mv.addObject("creditor_id", creditor_id);
        mv.addObject("lawyer_id", lawyer_id);
        mv.addObject("debt_id", debt_id);*/
        
        
        return mv;
    }
    
    @PostMapping(value = "liquidation")
    public ModelAndView getLiquidation(@RequestParam("date") String date, @RequestParam("value") String value,
            @RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id,
            @RequestParam("lawyer_id") String lawyer_id) throws Exception  {
        
        List<Map<String, Object>> debtList = bondService.getDebtList(debtor_id);
        ModelAndView mv = new ModelAndView();
        NumberFormat numberFormat = NumberFormat.getInstance();
        mv.setViewName("financial/liquidation");
        mv.addObject("debtList_size", debtList.size());
        String debtorName= bondService.selectDebtorName(debtor_id);
        mv.addObject("debtor_name", debtorName);
        
        if(debtList.size() != 0)    {
            // 이자를 환산할 날짜를 계산하는 코드
            long days_int = 0;
            String last_date = (String) debtList.get(debtList.size()-1).get("debt_date");
            //System.out.println(last_date + " " + date);
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = (Date) sdf.parse(last_date);
                Date endDate = (Date) sdf.parse(date);
                
                long difference = endDate.getTime() - startDate.getTime();
                
                days_int = difference / (24 * 60 * 60 * 1000);
            } catch(Exception e)    {
                System.out.println(e);
            }
            
            //System.out.println(days_int);
            // 아래에서 변제금액와 연산한 결과를 저장할 변수들
            String last_after30interest = (String) debtList.get(debtList.size()-1).get("debt_after30interest");
            String last_after18interest = (String) debtList.get(debtList.size()-1).get("debt_after18interest");
            String last_after12interest = (String) debtList.get(debtList.size()-1).get("debt_after12interest");
            
            String last_after30rental = (String) debtList.get(debtList.size()-1).get("debt_after30rental");
            String last_after18rental = (String) debtList.get(debtList.size()-1).get("debt_after18rental");
            String last_after12rental = (String) debtList.get(debtList.size()-1).get("debt_after12rental");
            
            /*
            System.out.println("-------------문자열-------------");
            System.out.println(last_after30rental);
            System.out.println(last_after12rental);
            System.out.println(last_after18rental);
            System.out.println(last_after30interest);
            System.out.println(last_after12interest);
            System.out.println(last_after18interest); 
            */
            
            Map<String, Object> debtMap = new HashMap<String, Object>();
            debtMap.put("debt_rental", 0);
            debtMap.put("debt_condition", "liquidation");
            debtMap.put("debt_liquidation", value);
            debtMap.put("creditor_id", creditor_id);
            debtMap.put("debtor_id", debtor_id);
            debtMap.put("lawyer_id", lawyer_id);
            debtMap.put("debt_date", date);
            
            // 변제금액 그리고 변제금액과 연산할 변수들의 쉼표를 없애고 정수로 바꾼다.
            value = value.replace(",", "");
            int liquidation_value = Integer.valueOf(value);
            last_after12interest = last_after12interest.replace(",", "");
            int last_after12interest_int = Integer.valueOf(last_after12interest);
            last_after18interest = last_after18interest.replace(",", "");
            int last_after18interest_int = Integer.valueOf(last_after18interest);
            last_after30interest = last_after30interest.replace(",", "");
            int last_after30interest_int = Integer.valueOf(last_after30interest);
            
            String last_after12rental_string = last_after12rental.replace(",", "");
            int last_after12rental_int = Integer.valueOf(last_after12rental_string);
            String last_after18rental_string = last_after18rental.replace(",", "");
            int last_after18rental_int = Integer.valueOf(last_after18rental_string);
            String last_after30rental_string = last_after30rental.replace(",", "");
            int last_after30rental_int = Integer.valueOf(last_after30rental_string);
         
            // 이자계산 후 출력 2009-04-15에서 2009-04-24 됐을때 각 이자들
            // 바로 전에 저장된 값의 원금과 날짜가 계산된 이자 합계액
            int time_30interest_int = (int) (last_after30rental_int * 0.30 / 365 * days_int) + last_after30interest_int;
            String time_30interest_string = numberFormat.format(time_30interest_int);
            int time_18interest_int = (int) (last_after18rental_int * 0.18 / 365 * days_int) + last_after18interest_int;
            String time_18interest_string = numberFormat.format(time_18interest_int);
            int time_12interest_int = (int) (last_after12rental_int * 0.12 / 365 * days_int) + last_after12interest_int;
            String time_12interest_string = numberFormat.format(time_12interest_int);
            
            /*
            System.out.println("30%이자 합계액 : " + time_30interest_string + " " + time_30interest_int);
            System.out.println("18%이자 합계액 : " + time_18interest_string + " " + time_18interest_int);
            System.out.println("12%이자 합계액 : " + time_12interest_string + " " + time_12interest_int);
            
            
            System.out.println("-------------정수화-------------");
            System.out.println("last_after30rental_int : " + last_after30rental_int);
            System.out.println("last_after18rental_int : " + last_after18rental_int);
            System.out.println("last_after12rental_int : " + last_after12rental_int);
            System.out.println("last_after30interest_int : " + last_after30interest_int);
            System.out.println("last_after18interest_int : " + last_after18interest_int);
            System.out.println("last_after12interest_int : " + last_after12interest_int);
            */
            
            // lsat_afterNinterest_int에 각각 맞는 N값에 이자 합계액 대입
            last_after30interest_int = time_30interest_int;
            last_after18interest_int = time_18interest_int;
            last_after12interest_int = time_12interest_int;
            last_after30interest = time_30interest_string;
            last_after18interest = time_18interest_string;
            last_after12interest = time_12interest_string;
            
            String[] beforeListStrings = {"debt_30interest", "debt_18interest", "debt_12interest", "debt_30rental", "debt_18rental", "debt_12rental"};
            String[] lastValueLiStrings = {last_after30interest, last_after18interest, last_after12interest, last_after30rental, last_after18rental, last_after12rental};
            for(int i = 0; i < lastValueLiStrings.length; i++)  {
                debtMap.put(beforeListStrings[i], lastValueLiStrings[i]);
            }
            
            if(liquidation_value >= last_after30rental_int + last_after18rental_int + last_after12rental_int + last_after30interest_int + last_after18interest_int + last_after12interest_int) {
                debtMap.put("debt_after30interest", 0);
                debtMap.put("debt_after18interest", 0);
                debtMap.put("debt_after12interest", 0);
                debtMap.put("debt_after30rental", 0);
                debtMap.put("debt_after18rental", 0);
                debtMap.put("debt_after12rental", 0);
                debtMap.put("debt_defendant", liquidation_value - (last_after30rental_int + last_after18rental_int + last_after12rental_int + last_after30interest_int + last_after18interest_int + last_after12interest_int));
                int success = bondService.insertDebt(debtMap);
                mv.addObject("success" , success);  
                return mv;
            }
            
            // 배열안에 값은 계산해야 될 순서대로 값이 저장되어 있으므로 순서를 수정해서는 안된다.
            String[] afterListStrings = {"debt_after30interest", "debt_after18interest", "debt_after12interest", "debt_after30rental", "debt_after18rental", "debt_after12rental"};
            int[] beforeList = {last_after30interest_int, last_after18interest_int, last_after12interest_int, last_after30rental_int, last_after18rental_int, last_after12rental_int};                    
            
            /*
            for(int i = 0; i < beforeList.length; i++)    {
                String comma = numberFormat.format(beforeList[i]);
                System.out.print(comma + " ");
            }
            System.out.println();
            
            System.out.println("-------------변제금액과 계산-------------");
            */
            
            /* 변제금액이 들어오면 누적된 이자 및 원금들과 계산하여 리스트에 저장 */
            for(int i = 0; i < beforeList.length; i++ )   {
                if(liquidation_value == 0)  {
                    break;
                }
                if(beforeList[i] != 0)    {
                    if(liquidation_value > beforeList[i]) {
                        liquidation_value -= beforeList[i];
                        beforeList[i] = 0;
                    }
                    else if(liquidation_value == beforeList[i])   {
                        liquidation_value = 0;
                        beforeList[i] = 0;
                    }
                    else if(liquidation_value < beforeList[i])    {
                        beforeList[i] -= liquidation_value;
                        liquidation_value = 0;
                    }
                }
            }
            
            for(int i = 0; i < beforeList.length; i++)    {
                String comma = numberFormat.format(beforeList[i]);
                debtMap.put(afterListStrings[i], comma);
                //System.out.println(afterListStrings[i]+ " : " + comma + " / ");
                
            }
            debtMap.put("debt_defendant", 0);
            
            
            int success = bondService.insertDebt(debtMap);
            mv.addObject("success" , success);            
        }
        
        return mv;
    }
    
    @PostMapping(value = "rental")
    public ModelAndView getRental(@RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id, @RequestParam("lawyer_id") String lawyer_id, @RequestParam("date") String date, @RequestParam("rental") String rental, @RequestParam("interest") String interest) throws Exception   {
        System.out.println("=================================rental=================================");
        ModelAndView mv = new ModelAndView();
        mv.setViewName("financial/rental");
        String debtorName= bondService.selectDebtorName(debtor_id);
        mv.addObject("debtor_name", debtorName);
        
        NumberFormat numberFormat = NumberFormat.getInstance();
        List<Map<String, Object>> debtList = bondService.getDebtList(debtor_id);
        Map<String, Object> debtMap = new HashMap<String, Object>();
        debtMap.put("debt_condition", "rental");
        debtMap.put("debtor_id", debtor_id);
        debtMap.put("creditor_id", creditor_id);
        debtMap.put("lawyer_id", lawyer_id);
        debtMap.put("debt_interest", interest + "%");
        debtMap.put("debt_rental", rental);
        debtMap.put("debt_date", date);
            
        if(debtList.size() != 0)    {
            System.out.println("!");
            long days_int = 0;
            String last_date = (String) debtList.get(debtList.size()-1).get("debt_date");
            System.out.println(last_date);
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = (Date) sdf.parse(last_date);
                Date endDate = (Date) sdf.parse(date);
                
                long difference = endDate.getTime() - startDate.getTime();
                
                days_int = difference / (24 * 60 * 60 * 1000);
            } catch(Exception e)    {
                System.out.println(e);
            }
            System.out.println("#");
            
            String last_after12rental_string = (String) debtList.get(debtList.size()-1).get("debt_after12rental");
            String last_after18rental_string = (String) debtList.get(debtList.size()-1).get("debt_after18rental");
            String last_after30rental_string = (String) debtList.get(debtList.size()-1).get("debt_after30rental");        
            String last_after12interest_string = (String) debtList.get(debtList.size()-1).get("debt_after12interest");
            String last_after18interest_string = (String) debtList.get(debtList.size()-1).get("debt_after18interest");
            String last_after30interest_string = (String) debtList.get(debtList.size()-1).get("debt_after30interest");        
            
            // 2,000,000에서 2000000으로 변환
            String last_after12rental = last_after12rental_string.replace(",", "");
            int last_after12rental_int = Integer.valueOf(last_after12rental);
            String last_after18rental = last_after18rental_string.replace(",", "");
            int last_after18rental_int = Integer.valueOf(last_after18rental);
            String last_after30rental = last_after30rental_string.replace(",", "");
            int last_after30rental_int = Integer.valueOf(last_after30rental);
            String last_after12interest = last_after12interest_string.replace(",", "");
            int last_after12interest_int = Integer.valueOf(last_after12interest);
            String last_after18interest = last_after18interest_string.replace(",", "");
            int last_after18interest_int = Integer.valueOf(last_after18interest);
            String last_after30interest = last_after30interest_string.replace(",", "");
            int last_after30interest_int = Integer.valueOf(last_after30interest);
            String rental_string = rental.replace(",", "");
            int rental_int = Integer.valueOf(rental_string);            
            // 이자가 12%인 경우, 
            System.out.println("if");
            if(interest.equals("12")) {
                System.out.println(12);
                String comma12 = numberFormat.format(rental_int + last_after12rental_int);
                String comma18 = numberFormat.format(last_after18rental_int);
                String comma30 = numberFormat.format(last_after30rental_int);
                debtMap.put("debt_12rental", comma12);
                debtMap.put("debt_18rental", comma18);
                debtMap.put("debt_30rental", comma30);
                debtMap.put("debt_after12rental", comma12);
                debtMap.put("debt_after18rental", comma18);
                debtMap.put("debt_after30rental", comma30);
            }
            // 이자가 18%인 경우
            else if(interest.equals("18"))    {
                System.out.println(18);
                String comma12 = numberFormat.format(last_after12rental_int);
                String comma18 = numberFormat.format(rental_int + last_after18rental_int);
                String comma30 = numberFormat.format(last_after30rental_int);
                debtMap.put("debt_12rental", comma12);
                debtMap.put("debt_18rental", comma18);
                debtMap.put("debt_30rental", comma30);
                debtMap.put("debt_after12rental", comma12);
                debtMap.put("debt_after18rental", comma18);
                debtMap.put("debt_after30rental", comma30);
            }
            // 이자가 30%인 경우
            else if(interest.equals("30"))    {
                System.out.println(30);
                String comma12 = numberFormat.format(last_after12rental_int);
                String comma18 = numberFormat.format(last_after18rental_int);
                String comma30 = numberFormat.format(rental_int + last_after30rental_int);
                debtMap.put("debt_12rental", comma12);
                debtMap.put("debt_18rental", comma18);
                debtMap.put("debt_30rental", comma30);
                debtMap.put("debt_after12rental", comma12);
                debtMap.put("debt_after18rental", comma18);
                debtMap.put("debt_after30rental", comma30);
            }
            
            int time_12interest_int = (int) ((last_after12rental_int * 0.12 / 365 * days_int) + last_after12interest_int);
            int time_18interest_int = (int) ((last_after18rental_int * 0.18 / 365 * days_int) + last_after18interest_int);
            int time_30interest_int = (int) ((last_after30rental_int * 0.30 / 365 * days_int) + last_after30interest_int);
            debtMap.put("debt_30interest", numberFormat.format(time_30interest_int));
            debtMap.put("debt_18interest", numberFormat.format(time_18interest_int));
            debtMap.put("debt_12interest", numberFormat.format(time_12interest_int));
            
            
            debtMap.put("debt_after30interest", numberFormat.format(time_30interest_int));
            debtMap.put("debt_after18interest", numberFormat.format(time_18interest_int));
            debtMap.put("debt_after12interest", numberFormat.format(time_12interest_int));
            debtMap.put("debt_defendant", 0);
            debtMap.put("debt_liquidation", 0);
            System.out.println(debtMap);
            System.out.println(debtMap.size());
            
        }
        else {
            System.out.println("@");
            debtMap.put("debt_date", date);
            debtMap.put("debt_12interest", 0);
            debtMap.put("debt_18interest", 0);
            debtMap.put("debt_30interest", 0);
            debtMap.put("debt_liquidation", 0);
            debtMap.put("debt_after30interest", 0);
            debtMap.put("debt_after18interest", 0);
            debtMap.put("debt_after12interest", 0);
            debtMap.put("debt_defendant", 0);
            if(interest.equals("12"))   {
                debtMap.put("debt_12rental", rental);
                debtMap.put("debt_after12rental", rental);
                debtMap.put("debt_18rental", 0);
                debtMap.put("debt_after18rental", 0);
                debtMap.put("debt_30rental", 0);
                debtMap.put("debt_after30rental", 0);
            }
            else if(interest.equals("18"))  {
                debtMap.put("debt_18rental", rental);
                debtMap.put("debt_after18rental", rental);
                debtMap.put("debt_12rental", 0);
                debtMap.put("debt_after12rental", 0);
                debtMap.put("debt_30rental", 0);
                debtMap.put("debt_after30rental", 0);
            }
            else if(interest.equals("30"))  {
                debtMap.put("debt_30rental", rental);
                debtMap.put("debt_after30rental", rental);
                debtMap.put("debt_18rental", 0);
                debtMap.put("debt_after18rental", 0);
                debtMap.put("debt_12rental", 0);
                debtMap.put("debt_after12rental", 0);
            }
        }
        
        int success = bondService.insertDebt(debtMap);
        mv.addObject("success", success);
        
        return mv;
    }
    
    @GetMapping(value="insertDebtor")
    public String getInsertDebtor() {
        return "financial/insertDebtor";
    }
    
    @GetMapping(value="nullSession")
    public String getNullSession()  {
        return "nullSession";
    }
    
    /*url경로를 post방식으로 받았으므로 @PostMapping처리를 하며 이용하는 페이지에서 만든 파라미터들을 메서드의 입력값으로 받고 jsp페이지를 반환한다.*/
    @PostMapping(value = "check_info")
    public String getInfo(@RequestParam("chk_info") String chk_info,@RequestParam("interest") String interest, @RequestParam("date") String date, @RequestParam("value") String value,@RequestParam("debtorId") String debtor_id, @RequestParam("creditorId") String creditor_id) {
        return "financial/check_info";
    }
    
    @GetMapping(value = "find_user")    
    public String getFindUser() {
        return "login/find_user";
    }
    
    @GetMapping(value = "login_page")
    public String getLoginPage()    {
        System.out.println("login_page");
        return "login/login_page";
    }
    
    @GetMapping(value="login_error")
    public String getLoginError()   {
        return "login/login_error";
    }
    
    @PostMapping(value="updateDebtorActivate")
    public String updateDebtorActivate(Map<String, Object> model, @RequestParam("creditorList") String creditor_id ,@RequestParam("debtor_email") String debtor_email ,@RequestParam("debtor_name") String debtor_name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3, @RequestParam("debtor_id") String debtor_id) throws Exception    {
        String debtor_hp = hp1 + "-" + hp2 + "-" + hp3;
        System.out.println(debtor_hp + "\n" + debtor_id + "\n" + debtor_name + "\n" + debtor_email + "\n" + creditor_id);
        
        Map<String, Object> debtorMap = new HashMap<String, Object>();
        debtorMap.put("creditor_id", creditor_id);
        debtorMap.put("debtor_id", debtor_email);
        debtorMap.put("id", debtor_id);
        debtorMap.put("debtor_hp", debtor_hp);
        debtorMap.put("debtor_name", debtor_name);
        
        int success = bondService.updateDebtor(debtorMap);
        
        model.put("success", success);
        
        return "financial/updateDebtorActivate";
    }
    
    @GetMapping(value="updateDebtor")
    public String getUpdateDebtor(@RequestParam("id") String id, Map<String, Object> model) throws Exception {
        //System.out.println("아이디 : "  + id);
        Map<String, Object> debtorMap = new HashMap<String, Object>();
        debtorMap = bondService.selectDebtor(id);
        
        String hp_string = (String) debtorMap.get("debtor_hp");
        String hp[] = hp_string.split("-");
        String hp1 = hp[0];
        String hp2 = hp[1];
        String hp3 = hp[2];
        
        model.put("creditor_id", debtorMap.get("creditorId"));
        model.put("debtor_id", debtorMap.get("debtor_id"));        
        model.put("hp1", hp1);
        model.put("hp2", hp2);
        model.put("hp3", hp3);
        model.put("debtor_name", debtorMap.get("debtor_name"));
        
        List<Map<String, Object>> creditorMap = bondService.selectCreditor();
        
        model.put("creditorList", creditorMap);
        
        return "financial/updateDebtor";
    }
    
    @GetMapping(value="selectDebtor")
    public ModelAndView getSelectDebtor(HttpServletRequest httpServletRequest) throws Exception   {
        ModelAndView mv = new ModelAndView();
        HttpSession session = httpServletRequest.getSession(false);
        
        String id = (String) session.getAttribute("uID");
        String pw = (String) session.getAttribute("uPW");
        
        Map<String, Object> lawyerMap = new HashMap<String, Object>()   {{
            put("lawyer_id", id);
            put("lawyer_pw", pw);
        }};
        
        List<Map<String, Object>> lawyerList = loginService.selectLawyer(lawyerMap);
        
        int lawyer_id = (int) lawyerList.get(0).get("id");
        String lawyer_name = (String) lawyerList.get(0).get("lawyer_name");
        
        mv.setViewName("financial/selectDebtor");
        mv.addObject("lawyer_id", lawyer_id);
        mv.addObject("lawyer_name", lawyer_name);
        
        List<Map<String, Object>> debtorList = loginService.selectDebtor(lawyer_id);
        
        mv.addObject("debtorList", debtorList);
        return mv;
    }
    
    
    @PostMapping(value = "login")
    public ModelAndView getLogin(HttpServletRequest httpServletRequest, @RequestParam("uID") String uID, @RequestParam("uPW") String uPW) throws Exception    {
        /*로그인 시 아이디와 패스워드를 세션에 둔다*/
        HttpSession session = httpServletRequest.getSession(false);
        session.setAttribute("uID", uID);
        session.setAttribute("uPW", uPW);
        session.setMaxInactiveInterval(1800);
        
        ModelAndView mv = new ModelAndView();
        System.out.println("pass login");
        Map<String, Object> lawyerMap = new HashMap<String, Object>()   {{
            put("lawyer_id", uID);
            put("lawyer_pw", uPW);
        }};
        
        List<Map<String, Object>> temp = loginService.selectLawyer(lawyerMap);
        if(temp.size() != 0)    {   
            System.out.println("로그인 결과 : " + temp.get(0).get("lawyer_id"));
            session.setAttribute("lawyerId", temp.get(0).get("id"));
        
            mv.setViewName("redirect:/selectDebtor");         
        }
        else {
            mv.setViewName("login/login_fail");            
        }
        return mv;
    }
    @GetMapping(value="logout")
    public String getLogout(HttpServletRequest httpServletRequest)   {
        HttpSession session = httpServletRequest.getSession(false);
        session.invalidate();
        return "login/login_page";
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
