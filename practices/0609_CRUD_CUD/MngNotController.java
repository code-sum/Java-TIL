package kr.happyjob.study.mngNot.controller;

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
import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.mngNot.service.MngNotService;

@Controller
@RequestMapping("/mngNot/")
public class MngNotController {
   
   @Autowired
   MngNotService mngNotService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 초기화면
    */
   @RequestMapping("notice.do")
   public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".notice");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".notice");

      return "mngNot/noticelist";
   }
       
   @RequestMapping("noticelist.do")
   public String noticelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticelist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<NoticeModel> noticesearchlist = mngNotService.noticelist(paramMap);
      int totalcnt = mngNotService.countnoticelist(paramMap);
      
      model.addAttribute("noticesearchlist", noticesearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".noticelist");

      return "mngNot/noticelistgrd";
   }
   
   @RequestMapping("noticeselectone.do")
   @ResponseBody
   public Map<String, Object> noticeselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticeselectone");
      logger.info("   - paramMap : " + paramMap);
      
      // Controller  Service  Dao  SQL
      NoticeModel noticesearch = mngNotService.noticeselectone(paramMap);
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("noticesearch", noticesearch);
      
      logger.info("+ End " + className + ".noticeselectone");

      return returnmap;
   }   
   
   @RequestMapping("noticesave.do")
   @ResponseBody
   public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".noticesave");
      logger.info("   - paramMap : " + paramMap);
      
      String action = (String) paramMap.get("action");
      
      paramMap.put("loginid", (String) session.getAttribute("loginId"));
      
      
      int returncval = 0;
      
      if("I".equals(action)) {
    	  returncval = mngNotService.noticeinsert(paramMap);
      } else if("U".equals(action)) {
    	  returncval = mngNotService.noticeupdate(paramMap);
      } else if("D".equals(action)) {
    	  returncval = mngNotService.noticedelete(paramMap);
      }      
      
      Map<String, Object> returnmap = new HashMap<String, Object>();
      
      returnmap.put("returncval", returncval);
      
      logger.info("+ End " + className + ".noticesave");

      return returnmap;
   }    
   
   
      
}