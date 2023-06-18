package kr.happyjob.study.busSpm.controller;

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

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.busSpm.model.SplrModel;
import kr.happyjob.study.busSpm.service.BusSpmService;


@Controller
@RequestMapping("/busSpm/")
public class BusSpmController {
   
   @Autowired
   BusSpmService busSpmService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 납품기업 관리 초기화면
    */
   @RequestMapping("splrManagement.do")
   public String splrManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".splrManagement");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".splrManagement");

      return "busSpm/splrlist";
   }
   
   @RequestMapping("splrlist.do")
   public String splrlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".splrlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<SplrModel> splrsearchlist = busSpmService.splrlist(paramMap);
      int totalcnt = busSpmService.countsplrlist(paramMap);
      
      model.addAttribute("splrsearchlist", splrsearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".splrlist");

      return "busSpm/splrlistgrd";
   }
     
      
      
}