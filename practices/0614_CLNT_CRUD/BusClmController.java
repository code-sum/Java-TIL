package kr.happyjob.study.busClm.controller;

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
import kr.happyjob.study.busClm.model.ClntModel;
import kr.happyjob.study.busClm.service.BusClmService;


@Controller
@RequestMapping("/busClm/")
public class BusClmController {
   
   @Autowired
   BusClmService busClmService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 고객기업 관리 초기화면
    */
   @RequestMapping("clntManagement.do")
   public String clntManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".clntManagement");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".clntManagement");

      return "busClm/clntlist";
   }
   
   /**
    * 고객기업 관리 목록 조회
    */
   @RequestMapping("clntlist.do")
   public String clntlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".clntlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<ClntModel> clntsearchlist = busClmService.clntlist(paramMap);
      int totalcnt = busClmService.countclntlist(paramMap);
      
      model.addAttribute("clntsearchlist", clntsearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".clntlist");

      return "busClm/clntlistgrd";
   }
   
   /**
    * 고객기업 관리 한건 조회
    */
   @RequestMapping("clntselectone.do")
   @ResponseBody
   public Map<String, Object> clntselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                              HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".clntselectone");
       logger.info("   - paramMap : " + paramMap);

       // Controller  Service  Dao  SQL
       ClntModel clntsearch = busClmService.clntselectone(paramMap);

       Map<String, Object> returnmap = new HashMap<String, Object>();

       returnmap.put("clntsearch", clntsearch);

       logger.info("+ End " + className + ".clntselectone");

       return returnmap;
   }
   
   /**
    * 고객기업 관리 생성, 수정, 삭제
    */
   @RequestMapping("clntsave.do")
   @ResponseBody
   public Map<String, Object> clntsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                         HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".clntsave");
       logger.info("   - paramMap : " + paramMap);

       String action = (String) paramMap.get("action");

       paramMap.put("loginid", (String) session.getAttribute("loginId"));


       int returncval = 0;

       if("I".equals(action)) {
           returncval = busClmService.clntinsert(paramMap);
       } else if("U".equals(action)) {
           returncval = busClmService.clntupdate(paramMap);
       } else if("D".equals(action)) {
           returncval = busClmService.clntdelete(paramMap);
       }      

       Map<String, Object> returnmap = new HashMap<String, Object>();

       returnmap.put("returncval", returncval);

       logger.info("+ End " + className + ".clntsave");

       return returnmap;
   }    
     
      
      
}