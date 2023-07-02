package kr.happyjob.study.busSas.controller;

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

import kr.happyjob.study.busSas.model.PerfModel;
import kr.happyjob.study.busSas.service.BusSasService;


@Controller
@RequestMapping("/busSas/")
public class BusSasController {
   
   @Autowired
   BusSasService busSasService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 영업실적 초기화면
    */
   @RequestMapping("saleSearch.do")
   public String saleSearch(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".saleSearch");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".saleSearch");

      return "busSas/perflist";
   }
   
   /**
    * 영업실적 목록 조회
    */
   @RequestMapping("perflist.do")
   public String perflist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".perflist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // 관리자(A)나 임원진(B)은 전체 데이터 조회, 영업팀(D)은 본인 데이터만 조회하도록
      String currentLoginID = (String) session.getAttribute("loginId");
      String currentuserType = (String) session.getAttribute("userType");
      
      paramMap.put("currentLoginID", currentLoginID);
      paramMap.put("currentuserType", currentuserType);
      
      logger.info("+ currentuserType : " + currentuserType);
      
      // Controller  Service  Dao  SQL
      List<PerfModel> perfsearchlist = busSasService.perflist(paramMap);
      int totalcnt = busSasService.countperflist(paramMap);
      
      model.addAttribute("perfsearchlist", perfsearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      logger.info("+ End " + className + ".perflist");

      return "busSas/perflistgrd";
   }
      
      
}