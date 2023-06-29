package kr.happyjob.study.busSap.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.busSap.model.PlanModel;
import kr.happyjob.study.busSap.service.BusSapService;


@Controller
@RequestMapping("/busSap/")
public class BusSapController {
   
   @Autowired
   BusSapService busSapService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 영업계획 초기화면
    */
   @RequestMapping("salePlan.do")
   public String salePlan(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".salePlan");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".salePlan");

      return "busSap/planlist";
   }
   
   /**
    * 영업계획 목록 조회
    */
   @RequestMapping("planlist.do")
   public String planlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".planlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // 관리자가 아니면, 로그인한 사용자 본인만 영업계획 목록 조회 
      String currentLoginID = (String) session.getAttribute("loginId");
      String currentuserType = (String) session.getAttribute("userType");
      
      paramMap.put("currentLoginID", currentLoginID);
      paramMap.put("currentuserType", currentuserType);
      
      // Controller  Service  Dao  SQL
      List<PlanModel> plansearchlist = busSapService.planlist(paramMap);
      int totalcnt = busSapService.countplanlist(paramMap);
      
      model.addAttribute("plansearchlist", plansearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      logger.info("+ End " + className + ".planlist");

      return "busSap/planlistgrd";
   }
     
      
      
}