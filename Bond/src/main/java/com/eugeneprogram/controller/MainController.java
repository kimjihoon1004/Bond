package com.eugeneprogram.controller;

import java.util.Date;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// 엑셀화에 추가됨
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFCreationHelper;

import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.eugeneprogram.dao.LoginMapper;
import com.eugeneprogram.service.BondService;
import com.eugeneprogram.service.LoginService;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {
    @Autowired
    private BondService bondService;
    @Autowired
    private LoginService loginService;
    
    @PostMapping(value = "updateFinancial")
    public String getUpdateFinancial(Map<String, Object> model, @RequestParam("debtor_id") String debtor_id, @RequestParam("debt_id") String debt_id, @RequestParam("debt_interest") String debt_interest, @RequestParam("lawyer_id") String lawyer_id, @RequestParam("creditor_id") String creditor_id) throws Exception  {        
        model.put("debtor_id", debtor_id);
        model.put("debt_id", debt_id);      
        
        Map<String, Object> tempMap = new HashMap<String, Object>();
        tempMap.put("debt_id", debt_id);
        tempMap.put("debtor_id", debtor_id);
        Map<String, Object> debtMap = bondService.selectDebtById(tempMap);
        
        model.put("debtMap", debtMap);
        String debtor_name = bondService.selectDebtorName(debtor_id);
        model.put("debtor_name", debtor_name);
        model.put("debt_interest", debt_interest);
        model.put("creditor_id", creditor_id);
        model.put("lawyer_id", lawyer_id);        
        
        
        
        
        return "financial/updateFinancial";
    }
    
    @PostMapping(value = "updateFinancialActivate")
    public String updateFinancialActivate(Map<String, Object> debtMap, @RequestParam("debt_interest") String debt_interest, @RequestParam("debt_condition") String debt_condition, @RequestParam("debtor_id") String debtor_id, @RequestParam("value") String debt_value, @RequestParam("debt_id") String debt_id, @RequestParam("debt_date") String debt_date, @RequestParam("debtor_name") String debtor_name, @RequestParam("lawyer_id") String lawyer_id, @RequestParam("creditor_id") String creditor_id) throws Exception {
        NumberFormat numberFormat = NumberFormat.getInstance();
        
        //debt_value가 대여금 or 변제금의 금액
        // 수정할 값들을 파라미터로 받는다.
        List<Map<String, Object>> allDebtList = bondService.selectAllDebtById(debtor_id);
        
        if(debt_condition.equals("rental")) {
            for(int i = 0; i < allDebtList.size(); i++) {
                String tempString = String.valueOf(allDebtList.get(i).get("debt_id"));
                if(tempString.equals(debt_id)) {
                    if(i == 0)  {
                        // 모든 이자들은 0, 이율과 대여금과 충당후 원금의 값 수정
                        debtMap.put("debt_condition", debt_condition);
                        debtMap.put("debt_liquidation", 0);
                        debtMap.put("debt_interest", debt_interest);
                        debtMap.put("debt_id", debt_id);
                        debtMap.put("debt_date", debt_date);
                        debtMap.put("debt_rental", debt_value);
                        if(debt_interest.equals("12%")) {
                            debtMap.put("debt_after12rental", debt_value);
                            debtMap.put("debt_12rental", debt_value);
                        }
                        else if(debt_interest.equals("18%"))    {
                            debtMap.put("debt_after18rental", debt_value);
                            debtMap.put("debt_18rental", debt_value);
                        }
                        else if(debt_interest.equals("30%"))    {
                            debtMap.put("debt_after30rental", debt_value);
                            debtMap.put("debt_30rental", debt_value);
                        }
                    }
                    else {
                        // debt_id를 이용하여 이전 이자와 원금값들과 계산후 update한다. 
                        
                        // (i-1)번째의 값(=allDebtList.get(i-1).get(...)) 충당후 원금 및 이자들을 가져와서 다시 계산하여 충당전 이자들과 원금들을 다시 업로드 한다.
                        String last_after12rental = (String) allDebtList.get(i-1).get("debt_after12rental");
                        String last_after18rental = (String) allDebtList.get(i-1).get("debt_after18rental");
                        String last_after30rental = (String) allDebtList.get(i-1).get("debt_after30rental");
                        String last_after12interest = (String) allDebtList.get(i-1).get("debt_after12interest");
                        String last_after18interest = (String) allDebtList.get(i-1).get("debt_after18interest");
                        String last_after30interest = (String) allDebtList.get(i-1).get("debt_after30interest");
                        
                        String last_after12rental_noComma = last_after12rental.replace(",","");
                        String last_after18rental_noComma = last_after18rental.replace(",","");
                        String last_after30rental_noComma = last_after30rental.replace(",","");
                        int last_after12rental_int = Integer.valueOf(last_after12rental_noComma);
                        int last_after18rental_int = Integer.valueOf(last_after18rental_noComma);
                        int last_after30rental_int = Integer.valueOf(last_after30rental_noComma);
                        
                        String last_after12interest_noComma = last_after12interest.replace(",","");
                        String last_after18interest_noComma = last_after18interest.replace(",","");
                        String last_after30interest_noComma = last_after30interest.replace(",","");
                        int last_after12interest_int = Integer.valueOf(last_after12interest_noComma);
                        int last_after18interest_int = Integer.valueOf(last_after18interest_noComma);
                        int last_after30interest_int = Integer.valueOf(last_after30interest_noComma);
                        
                        String last_date = (String) allDebtList.get(i-1).get("debt_date");
                        long days_int = 0;
                        try {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date startDate = (Date) sdf.parse(last_date);
                            Date endDate = (Date) sdf.parse(debt_date);
                            
                            long difference = endDate.getTime() - startDate.getTime();
                            
                            days_int = difference / (24 * 60 * 60 * 1000);
                        } catch(Exception e)    {
                            System.out.println(e);
                        }
                        
                        
                        debtMap.put("debt_condition", debt_condition);
                        debtMap.put("debt_liquidation", 0);
                        debtMap.put("debt_id", debt_id);
                        debtMap.put("debt_rental", debt_value);
                        debtMap.put("debt_date", debt_date);
                        debtMap.put("debt_interest", debt_interest);
                        debt_value = debt_value.replace(",", ""); 
                        if(debt_interest.equals("12%")) {
                            debtMap.put("debt_12rental",  numberFormat.format(last_after12rental_int + Integer.valueOf(debt_value)));
                            debtMap.put("debt_18rental", numberFormat.format(last_after18rental_int));
                            debtMap.put("debt_30rental", numberFormat.format(last_after30rental_int));
                            debtMap.put("debt_after12rental", numberFormat.format(last_after12rental_int + Integer.valueOf(debt_value)));
                            debtMap.put("debt_after18rental", numberFormat.format(last_after18rental_int));
                            debtMap.put("debt_after30rental", numberFormat.format(last_after30rental_int));
                        }
                        else if(debt_interest.equals("18%"))    {
                            debtMap.put("debt_12rental", numberFormat.format(last_after12rental_int));
                            debtMap.put("debt_18rental", numberFormat.format(last_after18rental_int + Integer.valueOf(debt_value)));
                            debtMap.put("debt_30rental", numberFormat.format(last_after30rental_int ));
                            debtMap.put("debt_after12rental", numberFormat.format(last_after12rental_int));
                            debtMap.put("debt_after18rental", numberFormat.format(last_after18rental_int + Integer.valueOf(debt_value)));
                            debtMap.put("debt_after30rental", numberFormat.format(last_after30rental_int));
                        }
                        else if(debt_interest.equals("30%"))    {
                            debtMap.put("debt_12rental", numberFormat.format(last_after12rental_int));
                            debtMap.put("debt_18rental", numberFormat.format(last_after18rental_int));
                            debtMap.put("debt_30rental", numberFormat.format(last_after30rental_int + Integer.valueOf(debt_value)));
                            debtMap.put("debt_after12rental", numberFormat.format(last_after12rental_int));
                            debtMap.put("debt_after18rental", numberFormat.format(last_after18rental_int));
                            debtMap.put("debt_after30rental", numberFormat.format(last_after30rental_int + Integer.valueOf(debt_value)));
                        }
                        
                        int temp = (int) ((last_after12rental_int * 0.12 / 365 * days_int) + last_after12interest_int);
                        String temp_str = numberFormat.format(temp);
                        debtMap.put("debt_12interest", temp_str);
                        debtMap.put("debt_after12interest", temp_str);
                        // 나머지 이자들도 날짜가 바뀌었을 수도 있으니 다시 계산
                        temp = (int) ((last_after18rental_int * 0.18 / 365 * days_int) + last_after18interest_int);
                        temp_str = numberFormat.format(temp);
                        debtMap.put("debt_18interest", temp_str);
                        debtMap.put("debt_after18interest", temp_str);
                        temp = (int) ((last_after30rental_int * 0.30 / 365 * days_int) + last_after30interest_int);
                        temp_str = numberFormat.format(temp);
                        debtMap.put("debt_30interest", temp_str);
                        debtMap.put("debt_after30interest", temp_str);
                        
                    }
                }
            }
        }
        else if(debt_condition.equals("liquidation"))   {
            for(int i = 0; i < allDebtList.size(); i++)    {
                String tempId = String.valueOf(allDebtList.get(i).get("debt_id"));
                if(tempId.equals(debt_id))   {
                    debtMap.put("debt_condition", "liquidation");
                    debtMap.put("debt_date", debt_date);
                    debtMap.put("lawyer_id", lawyer_id);
                    debtMap.put("creditor_id", creditor_id);
                    debtMap.put("debt_id", debt_id);
                    debtMap.put("debtor_id", debtor_id);
                    debtMap.put("debt_interest", "");
                    debtMap.put("debt_rental", 0);
                    String last_after30interest_str = String.valueOf(allDebtList.get(i-1).get("debt_after30interest"));
                    last_after30interest_str = last_after30interest_str.replace(",", "");
                    int last_after30interest_int = Integer.valueOf(last_after30interest_str);
                    String last_after18interest_str = String.valueOf(allDebtList.get(i-1).get("debt_after18interest"));
                    last_after18interest_str = last_after18interest_str.replace(",", "");
                    int last_after18interest_int = Integer.valueOf(last_after18interest_str);
                    String last_after12interest_str = String.valueOf(allDebtList.get(i-1).get("debt_after12interest"));
                    last_after12interest_str = last_after12interest_str.replace(",", "");
                    int last_after12interest_int = Integer.valueOf(last_after12interest_str);
                    
                    // last_afterNrental == debt_Nrental
                    String last_after30rental = String.valueOf(allDebtList.get(i-1).get("debt_after30rental"));
                    String last_after30rental_str = last_after30rental.replace(",", "");
                    int last_after30rental_int = Integer.valueOf(last_after30rental_str);
                    String last_after18rental = String.valueOf(allDebtList.get(i-1).get("debt_after18rental"));
                    String last_after18rental_str = last_after18rental.replace(",", "");
                    int last_after18rental_int = Integer.valueOf(last_after18rental_str);
                    String last_after12rental = String.valueOf(allDebtList.get(i-1).get("debt_after12rental"));
                    String last_after12rental_str = last_after12rental.replace(",", "");
                    int last_after12rental_int = Integer.valueOf(last_after12rental_str);
                    
                    // 변제 충당전의 원금들
                    debtMap.put("debt_30rental", last_after30rental);
                    debtMap.put("debt_18rental", last_after18rental);
                    debtMap.put("debt_12rental", last_after12rental);
                    
                    String last_date = (String) allDebtList.get(i-1).get("debt_date");
                    long days_int = 0;
                    try {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                        Date startDate = (Date) sdf.parse(last_date);
                        Date endDate = (Date) sdf.parse(debt_date);
                        
                        long difference = endDate.getTime() - startDate.getTime();
                        
                        days_int = difference / (24 * 60 * 60 * 1000);
                    } catch(Exception e)    {
                        System.out.println(e);
                    }
                    
                    int debt_30interest = (int) (last_after30rental_int * 0.30 / 365 * days_int) + last_after30interest_int;
                    int debt_18interest = (int) (last_after18rental_int * 0.18 / 365 * days_int) + last_after18interest_int;
                    int debt_12interest = (int) (last_after12rental_int * 0.12 / 365 * days_int) + last_after12interest_int;
                    
                    // 변제 충당전의 이자들
                    debtMap.put("debt_30interest", numberFormat.format(debt_30interest));
                    debtMap.put("debt_18interest", numberFormat.format(debt_18interest));
                    debtMap.put("debt_12interest", numberFormat.format(debt_12interest));
                    
                    int liquidation = Integer.valueOf(debt_value.replace(",", ""));
                    debtMap.put("debt_liquidation", debt_value);
                    
                    if(liquidation >= debt_30interest + debt_18interest + debt_12interest + last_after30rental_int + last_after18rental_int + last_after12rental_int)    {
                        String[] keyNameList = {"debt_after30interest", "debt_after18interest", "debt_after12interest", "debt_after30rental", "debt_after18rental", "debt_after12rental"};
                        for(int j = 0; j < keyNameList.length; j++)  {
                            debtMap.put(keyNameList[j], 0);
                        }
                        liquidation -= debt_30interest + debt_18interest + debt_12interest + last_after30rental_int + last_after18rental_int + last_after12rental_int;
                        debtMap.put("debt_defendant", numberFormat.format(liquidation));                        
                    }
                    else    {
                        debtMap.put("debt_defendant", 0);
                        String[] keyNameList = {"debt_after30interest", "debt_after18interest", "debt_after12interest", "debt_after30rental", "debt_after18rental", "debt_after12rental"};
                        int[] beforeList = {debt_30interest, debt_18interest, debt_12interest, last_after30rental_int, last_after18rental_int, last_after12rental_int};                    
                        
                        /* 변제금액이 들어오면 누적된 이자 및 원금들과 계산하여 리스트에 저장 */
                        for(int j = 0; j < beforeList.length; j++ )   {
                            if(liquidation == 0)  {
                                break;
                            }
                            if(beforeList[j] != 0)    {
                                if(liquidation > beforeList[j]) {
                                    liquidation -= beforeList[j];
                                    beforeList[j] = 0;
                                }
                                else if(liquidation == beforeList[j])   {
                                    liquidation = 0;
                                    beforeList[j] = 0;
                                }
                                else if(liquidation < beforeList[j])    {
                                    beforeList[j] -= liquidation;
                                    liquidation = 0;
                                }
                            }
                        }
                        
                        // 변제 충당 후의 이자와 원금들
                        for(int j = 0; j < beforeList.length; j++)  {
                            debtMap.put(keyNameList[j], numberFormat.format(beforeList[j]));
                        }
                    }                   
                }
            }
            
        }
        
        int success = bondService.updateDebt(debtMap);
        debtMap.put("success", success);
        
        return "financial/updateFinancialActivate";
    }
    
    @PostMapping(value = "financial")
    public ModelAndView getFinancial(@RequestParam("lawyer_id") String lawyer_id, @RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id, @RequestParam("debtor_name") String debtor_name) throws Exception   {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("financial/financial_position");
        
        List<Map<String, Object>> tempList = new ArrayList<>();        
        tempList = bondService.getDebtList(debtor_id);
        int tempListSize = tempList.size();
        String debtorName = bondService.selectDebtorName(debtor_id);
        mv.addObject("debtList", tempList);
        mv.addObject("debtListSize", tempListSize);
        mv.addObject("debtor_name", debtorName);
        mv.addObject("creditor_id", creditor_id);
        mv.addObject("debtor_id", debtor_id);
        
        
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
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = (Date) sdf.parse(last_date);
                Date endDate = (Date) sdf.parse(date);
                
                long difference = endDate.getTime() - startDate.getTime();
                
                days_int = difference / (24 * 60 * 60 * 1000);
            } catch(Exception e)    {
                System.out.println(e);
            }
           
            // 아래에서 변제금액와 연산한 결과를 저장할 변수들
            String last_after30interest = (String) debtList.get(debtList.size()-1).get("debt_after30interest");
            String last_after18interest = (String) debtList.get(debtList.size()-1).get("debt_after18interest");
            String last_after12interest = (String) debtList.get(debtList.size()-1).get("debt_after12interest");
            
            String last_after30rental = (String) debtList.get(debtList.size()-1).get("debt_after30rental");
            String last_after18rental = (String) debtList.get(debtList.size()-1).get("debt_after18rental");
            String last_after12rental = (String) debtList.get(debtList.size()-1).get("debt_after12rental");
            
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
                
            }
            debtMap.put("debt_defendant", 0);
            
            
            int success = bondService.insertDebt(debtMap);
            mv.addObject("success" , success);            
        }
        
        return mv;
    }
    
    @PostMapping(value = "rental")
    public ModelAndView getRental(@RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id, @RequestParam("lawyer_id") String lawyer_id, @RequestParam("date") String date, @RequestParam("rental") String rental, @RequestParam("interest") String interest) throws Exception   {
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
            long days_int = 0;
            String last_date = (String) debtList.get(debtList.size()-1).get("debt_date");
            try {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = (Date) sdf.parse(last_date);
                Date endDate = (Date) sdf.parse(date);
                
                long difference = endDate.getTime() - startDate.getTime();
                
                days_int = difference / (24 * 60 * 60 * 1000);
            } catch(Exception e)    {
                System.out.println(e);
            }
            
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
            if(interest.equals("12")) {
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
            
        }
        else {
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
    public String getInsertDebtor(Map<String, Object> model) throws Exception {
        List<Map<String, Object>> creditorList = bondService.selectCreditor();
        model.put("creditorList", creditorList);
        return "financial/insertDebtor";
    }
    
    @PostMapping(value = "insertDebtorActivate")
    public String insertDebtorActivate(Map<String, Object> model, @RequestParam("lawyerId") String lawyer_id, @RequestParam("debtor_id") String debtor_id, @RequestParam("debtor_name") String debtor_name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3, @RequestParam("creditorList") String creditor_id) throws Exception    {
        String debtor_hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> debtorMap = new HashMap<String, Object>();
        debtorMap.put("debtor_name", debtor_name);
        debtorMap.put("debtor_hp", debtor_hp);
        debtorMap.put("debtor_id", debtor_id);
        debtorMap.put("creditorId", creditor_id);
        debtorMap.put("lawyerId", lawyer_id);
        
        int success = bondService.insertDebtor(debtorMap);
        model.put("success", success);
        
        return "financial/insertDebtorActivate";
    }
    
    @GetMapping(value="insertCreditor")
    public String getInsertCreditor()   {
        return "financial/insertCreditor";
    }
    
    @PostMapping(value="insertCreditorActivate")
    public String insertCreditorActivate(Map<String, Object> model, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3, @RequestParam("creditor_name") String creditor_name, @RequestParam("creditor_id") String creditor_id) throws Exception  {
        String creditor_hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> creditorMap = new HashMap<String, Object>();
        creditorMap.put("creditor_name", creditor_name);
        creditorMap.put("creditor_hp", creditor_hp);
        creditorMap.put("creditor_id", creditor_id);
        
        int success = bondService.insertCreditor(creditorMap);
        model.put("success", success);
        
        return "financial/insertCreditorActivate";
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
    
    @GetMapping(value = "/")
    public String getLoginPage()    {
        return "login/login_page";
    }
    
    @PostMapping(value="lawyerInserting")
    public String lawyerInserting(String uID, String uPW, String uNAME, String hp1, String hp2, String hp3) throws Exception {
        int temp = 0;
        temp = loginService.duplicateId(uID);
        
        if(temp > 0)    {
            return "/login/duplicateId";
        }
        
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        int result = 0;
        result = loginService.insertLawyer(uID, uPW, hp, uNAME);
        
        if(result > 0)  {
            return "/login/lawyerInserting_success";
        }
        else    {
            return "/login/lawyerInserting_fail";
        }
    }
    
    @GetMapping(value="insertLawyer")
    public String insertLaywer()  {
        return "/login/insertLawyer";
    }
    
    @GetMapping(value="login_error")
    public String getLoginError()   {
        return "login/login_error";
    }
    
    @PostMapping(value="updateDebtorActivate")
    public String updateDebtorActivate(Map<String, Object> model, @RequestParam("creditorList") String creditor_id ,@RequestParam("debtor_email") String debtor_email ,@RequestParam("debtor_name") String debtor_name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3, @RequestParam("debtor_id") String debtor_id) throws Exception    {
        String debtor_hp = hp1 + "-" + hp2 + "-" + hp3;
        
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
    
    @GetMapping(value="updateLawyer")
    public ModelAndView updateLawyer(HttpServletRequest httpServletRequest) throws Exception  {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/financial/updateLawyer");
        
        HttpSession session = httpServletRequest.getSession(false);        
        String id = (String) session.getAttribute("uID");
        String pw = (String) session.getAttribute("uPW");
        
        Map<String, Object> lawyerMap = new HashMap<String, Object>()   {{
            put("lawyer_id", id);
            put("lawyer_pw", pw);
        }};
        
        List<Map<String, Object>> lawyerList = loginService.selectLawyer(lawyerMap);
        
        mv.addObject("pk", lawyerList.get(0).get("id"));
        mv.addObject("id", lawyerList.get(0).get("lawyer_id"));
        mv.addObject("name", lawyerList.get(0).get("lawyer_name"));
        mv.addObject("hp", lawyerList.get(0).get("lawyer_hp"));
        
        return mv;
    }
    
    @PostMapping(value="lawyerUpdating")
    public ModelAndView lawyerUpdating(String uNAME, String uID, String hp1, String hp2, String hp3, String pk) throws Exception  {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/financial/updatingLawyer");
        
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        String id = uID;
        String name = uNAME;
        
        int result = 0;
        result = loginService.updateLawyer(name, hp, id, pk);
        
        mv.addObject("result", result);
        
        return mv;
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
        
        ModelAndView mv = new ModelAndView();
        Map<String, Object> lawyerMap = new HashMap<String, Object>()   {{
            put("lawyer_id", uID);
            put("lawyer_pw", uPW);
        }};
        
        List<Map<String, Object>> temp = loginService.selectLawyer(lawyerMap);
        if(temp.size() != 0)    {   
            System.out.println("login success!");
            session.setAttribute("lawyerId", temp.get(0).get("id"));
        
            mv.setViewName("redirect:/selectDebtor");         
        }
        else {
            mv.setViewName("/login/login_fail");            
        }
        return mv;
    }
    @GetMapping(value="logout")
    public void getLogout(HttpServletRequest httpServletRequest, HttpServletResponse response) throws IOException   {
        HttpSession session = httpServletRequest.getSession(false);
        session.invalidate();
        response.sendRedirect("/");
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
        mv.setViewName("/login/checkId");
        
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> piMap = new HashMap<String, Object>();
        piMap.put("lawyer_name", name);
        piMap.put("lawyer_hp", hp);
        
        
        String idString = loginService.checkId(piMap);
        mv.addObject("id", idString);
        
        return mv;
    }
    
    @PostMapping(value = "checkPw")
    public ModelAndView getCheckPw(@RequestParam("uID") String id, @RequestParam("uNAME") String name, @RequestParam("hp1") String hp1, @RequestParam("hp2") String hp2, @RequestParam("hp3") String hp3) throws Exception   {
        ModelAndView mv = new ModelAndView();
        
        String hp = hp1 + "-" + hp2 + "-" + hp3;
        
        Map<String, Object> piMap = new HashMap<String, Object>();
        piMap.put("lawyer_name", name);
        piMap.put("lawyer_hp", hp);
        piMap.put("lawyer_id", id);
        
        int success = loginService.checkPw(piMap);
        if(success > 0)  {            
            mv.setViewName("/login/checkPw");
        }
        else    {
            mv.setViewName("/login/checkPwFail");
        }
        return mv;
    }
    
    @PostMapping(value="updateLawyer_Pw")
    public ModelAndView updateLawyerPw(String id, String pw, String hp, String name) throws Exception    {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("/login/updateLawyerPw");
        
        int temp = loginService.updateLawyerPw(id, pw, hp, name);
        
        mv.addObject("result", temp);
        return mv;
    }
    
    
    @PostMapping(value = "excel")
    public void getExcel(HttpServletResponse response, @RequestParam("fileName") String fileName, @RequestParam("category") List<String> category, @RequestParam("excelStatus") String excelStatus, @RequestParam("debtor_id") String debtor_id, @RequestParam("creditor_id") String creditor_id, @RequestParam("lawyer_id") String lawyer_id, @RequestParam("debtor_name") String debtor_name, @RequestParam("num1") String num1, @RequestParam("num2") String num2) throws IOException   {        
        LocalDate now = LocalDate.now();
        
        XSSFWorkbook wb = new XSSFWorkbook();
        XSSFSheet sheet = null;
        Row row = null;
        Cell cell = null;
        sheet = wb.createSheet(debtor_name + "_" + now);
        
        Map<String, String> tempCategory = new HashMap<String, String>();
        tempCategory.put("날짜", "debt_date");
        tempCategory.put("대여금", "debt_rental");
        tempCategory.put("적용이율", "debt_interest");
        tempCategory.put("30%원금(충당전)", "debt_30rental");
        tempCategory.put("18%원금(충당전)", "debt_18rental");
        tempCategory.put("12%원금(충당전)", "debt_12rental");
        tempCategory.put("30%이자(충당전)", "debt_30interest");
        tempCategory.put("18%이자(충당전)", "debt_18interest");
        tempCategory.put("12%이자(충당전)", "debt_12interest");
        tempCategory.put("변제금액", "debt_liquidation");
        tempCategory.put("30%원금(충당후)", "debt_after30rental");
        tempCategory.put("18%원금(충당후)", "debt_after18rental");
        tempCategory.put("12%원금(충당후)", "debt_after12rental");
        tempCategory.put("30%이자(충당후)", "debt_after30interest");
        tempCategory.put("18%이자(충당후)", "debt_after18interest");
        tempCategory.put("12%이자(충당후)", "debt_after12interest");
        tempCategory.put("피고채권", "debt_defendant");
        
        
        // 배경색 설정 (노란색)
        XSSFCellStyle headerStyle = wb.createCellStyle();
        headerStyle.setFillForegroundColor(IndexedColors.YELLOW.getIndex());
        headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        // 배경색 흰색으로 설정후 정수의 3자리마다 쉼표 추가
        XSSFCellStyle regularCommaStyle = wb.createCellStyle();
        regularCommaStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());
        regularCommaStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);       
        XSSFCreationHelper format = wb.getCreationHelper();
        regularCommaStyle.setDataFormat(format.createDataFormat().getFormat("#,##0"));
        
        // 배경색 설정 (흰색)
        XSSFCellStyle regularStyle = wb.createCellStyle();
        regularStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());
        regularStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        
        row = sheet.createRow(0);
        cell = row.createCell(0);
        cell.setCellValue("순번");
        cell.setCellStyle(headerStyle);
        for(int i = 0; i < category.size(); i++)    {
            cell = row.createCell(i+1);
            cell.setCellValue(category.get(i));
            cell.setCellStyle(headerStyle);
            if(tempCategory.containsKey(category.get(i)))   {
                category.set(i, tempCategory.get(category.get(i)));
            }
        }
        
        List<Map<String, Object>> debtList = new ArrayList<Map<String, Object>>();
        try {
            debtList = bondService.getDebtList(debtor_id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        if(num1 != "" && num2 != "") {
            //부분 엑셀화
            System.out.println("부분 엑셀화");
            int start = Integer.valueOf(num1);
            int end = Integer.valueOf(num2);
            int tempRow = 1; 
            for(int i = start-1; i < end; i++)    {
                row = sheet.createRow(tempRow);
                cell = row.createCell(0);
                cell.setCellValue(tempRow++);
                cell.setCellStyle(regularStyle);
                int tempCell = 1;
                for(int j = 0; j < category.size(); j++)    {
                    cell = row.createCell(tempCell++);
                    if(category.get(j).equals("debt_date") || category.get(j).equals("debt_interest")) {
                        cell.setCellValue((String) debtList.get(i).get(category.get(j)));
                        cell.setCellStyle(regularStyle);
                    }
                    else    {
                        String temp = (String) debtList.get(i).get(category.get(j));
                        temp = temp.replace(",", "");
                        cell.setCellValue(Integer.valueOf(temp));
                        cell.setCellStyle(regularCommaStyle);
                    }
                }
            }
            
        }
        else if(num1 == "" && num2 == "")    {
            //전체 엑셀화
            System.out.println("전체 엑셀화");
            int tempRow = 1;
            for(int i = 0; i < debtList.size(); i++)    {
                row = sheet.createRow(tempRow);
                cell = row.createCell(0);
                cell.setCellValue(tempRow++);
                cell.setCellStyle(regularStyle);
                int tempCell = 1;
                for(int j = 0; j < category.size(); j++)    {
                    cell = row.createCell(tempCell++);
                    if(category.get(j).equals("debt_date") || category.get(j).equals("debt_interest")) {
                        cell.setCellValue((String) debtList.get(i).get(category.get(j)));
                        cell.setCellStyle(regularStyle);
                    }
                    else    {
                        String temp = (String) debtList.get(i).get(category.get(j));
                        temp = temp.replace(",", "");
                        cell.setCellValue(Integer.valueOf(temp));
                        cell.setCellStyle(regularCommaStyle);
                    }
                }
            }
        }
        for(int i = 1; i <= category.size(); i++)    {
                sheet.autoSizeColumn(i, true);
                sheet.setColumnWidth(i, (sheet.getColumnWidth(i))+1024);
        }
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String tempFileName = fileName + ".xlsx";
        String encodedFileName = URLEncoder.encode(tempFileName, "UTF-8").replaceAll("\\+", "%20"); // 공백 처리
        response.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + encodedFileName);
        
        // 사용자에게 파일 전송
        ServletOutputStream outputStream = response.getOutputStream();
        wb.write(outputStream);
        outputStream.close();
        
        // 워크북 자원 해제
        wb.close();
        
    }
}
