package kr.happyjob.study.busOdm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busOdm.model.OrderModel;

public interface BusOdmDao {

	/** 주문 목록 조회 */
	public List<OrderModel> orderlist(Map<String, Object> paramMap) throws Exception;
	
	/** 주문 목록 카운트 조회 */
	public int countorderlist(Map<String, Object> paramMap) throws Exception;
	
	/** 주문 한건 조회 */
	public OrderModel orderselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 주문 상세 목록 조회 */
    public List<OrderModel> detaillist(Map<String, Object> paramMap) throws Exception;
    
    /** 주문 상세 목록 카운트 조회 */
    public int countdetaillist(Map<String, Object> paramMap) throws Exception;
   
}