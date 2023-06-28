package kr.happyjob.study.busOdm.controller;

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
import kr.happyjob.study.busOdm.model.OrderModel;
import kr.happyjob.study.busOdm.model.OrderPdModel;
import kr.happyjob.study.busOdm.service.BusOdmService;


@Controller
@RequestMapping("/busOdm/")
public class BusOdmController {
   
   @Autowired
   BusOdmService busOdmService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 주문 관리 초기화면
    */
   @RequestMapping("orderManagement.do")
   public String orderManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".orderManagement");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".orderManagement");

      return "busOdm/orderlist";
   }
   
   /**
    * 주문 관리 목록 조회
    */
   @RequestMapping("orderlist.do")
   public String orderlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".orderlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<OrderModel> ordersearchlist = busOdmService.orderlist(paramMap);
      int totalcnt = busOdmService.countorderlist(paramMap);
      
      model.addAttribute("ordersearchlist", ordersearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".orderlist");

      return "busOdm/orderlistgrd";
   }
   
   /**
    * 주문 관리 한건 조회
    */
   @RequestMapping("orderselectone.do")
   //  @ResponseBody
   public String orderselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                              HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".orderselectone");
       logger.info("   - paramMap : " + paramMap);

       // Controller  Service  Dao  SQL
       OrderModel ordersearch = busOdmService.orderselectone(paramMap);  // 주문 한건 조회

       List<OrderModel> orderdetaillist = busOdmService.detaillist(paramMap);  // 주문 한건 조회(상세목록)
       int totalcnt = busOdmService.countdetaillist(paramMap);  // 상세 주문 건수
       
       model.addAttribute("ordersearch", ordersearch);
       model.addAttribute("orderdetaillist", orderdetaillist);
       model.addAttribute("totalcnt", totalcnt);

       logger.info("+ End " + className + ".orderselectone");

       return "busOdm/orderdetailpop";
   }
   
   /**
    * [추가] 버튼 클릭 시, 해당 제품 이름, 가격 조회
    */
   @RequestMapping("orderadd.do")
   @ResponseBody
   public Map<String, Object> orderadd(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
           HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".orderadd");
		logger.info("   - paramMap : " + paramMap);
		
		// Controller  Service  Dao  SQL
		OrderPdModel orderadd = busOdmService.orderadd(paramMap);
		
		Map<String, Object> returnmap = new HashMap<String, Object>();
		
		returnmap.put("orderadd", orderadd);
		
		logger.info("+ End " + className + ".orderadd");
		
		return returnmap;
}
   
   /**
    * [저장] 버튼 클릭 시, 주문정보 저장
    */
   @RequestMapping("ordersave.do")
   @ResponseBody
   public Map<String, Object> ordersave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                         HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".ordersave");
       logger.info("   - paramMap : " + paramMap);

       paramMap.put("loginid", (String) session.getAttribute("loginId"));
       
       String orderitemstr = (String) paramMap.get("orderItems");
       String orderitemarr[] = orderitemstr.split("/");
       
       long order_tot_price = Long.parseLong((String)paramMap.get("order_tot_price"));	
       paramMap.put("order_tot_price", order_tot_price);
       
       int returncval = busOdmService.orderinsert(paramMap);
       int acntreval = busOdmService.accountinsert(paramMap);

       for(String item :orderitemarr) {
    	   String itemorderinfo[] = item.split(",");
    	      	   
    	   Map<String, Object> itemmap = new HashMap<String, Object>();
    	   
    	   int product_no = Integer.parseInt(itemorderinfo[1]);	
    	   int product_price = Integer.parseInt(itemorderinfo[3]);
    	   int order_dt_amt = Integer.parseInt(itemorderinfo[4]);
    	   long order_dt_price = Long.parseLong(itemorderinfo[5]);
           
    	   itemmap.put("product_no", product_no );
    	   itemmap.put("clnt_no", paramMap.get("clnt_no") );
    	   itemmap.put("product_price", product_price );
    	   itemmap.put("order_dt_amt", order_dt_amt );
    	   itemmap.put("order_dt_price", order_dt_price );
    	   
    	   busOdmService.orderdetailinsert(itemmap);    	   
       }
       
       Map<String, Object> returnmap = new HashMap<String, Object>();
       returnmap.put("returncval", returncval);
       returnmap.put("acntreval", acntreval);

       logger.info("+ End " + className + ".ordersave");

       return returnmap;
   }
   
   
      
      
}