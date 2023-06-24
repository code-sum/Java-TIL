package kr.happyjob.study.busOdm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busOdm.dao.BusOdmDao;
import kr.happyjob.study.busOdm.model.OrderModel;


@Service
public class BusOdmServiceImpl implements BusOdmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BusOdmDao busOdmDao;
	
	/** 주문 목록 조회 */
	public List<OrderModel> orderlist(Map<String, Object> paramMap) throws Exception {
		
		return busOdmDao.orderlist(paramMap);
	}
	
	/** 주문 목록 카운트 조회 */
	public int countorderlist(Map<String, Object> paramMap) throws Exception {
				
		return busOdmDao.countorderlist(paramMap);
	}
	
	/** 주문 한건 조회 */
	public OrderModel orderselectone(Map<String, Object> paramMap) throws Exception {
		
		return busOdmDao.orderselectone(paramMap);
	}
	
	
	/** 주문 상세 목록 조회 */
	public List<OrderModel> detaillist(Map<String, Object> paramMap) throws Exception {
		
		return busOdmDao.detaillist(paramMap);
	}
	
	/** 주문 상세 목록 카운트 조회 */
	public int countdetaillist(Map<String, Object> paramMap) throws Exception {
				
		return busOdmDao.countdetaillist(paramMap);
	}
	
}