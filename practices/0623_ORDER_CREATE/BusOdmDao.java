package kr.happyjob.study.busOdm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busOdm.model.OrderModel;
import kr.happyjob.study.busOdm.model.OrderPdModel;

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
    
    /** [추가] 버튼 클릭 시, 해당 제품 이름, 가격 조회 */
    public OrderPdModel orderadd(Map<String, Object> paramMap) throws Exception;
    
    /** [저장] 버튼 클릭 시, 주문정보 저장 */
	public int orderinsert(Map<String, Object> paramMap) throws Exception;
	
	/** [저장] 버튼 클릭 시, 주문 상세 정보 저장 */
    public int orderdetailinsert(Map<String, Object> paramMap) throws Exception;
}