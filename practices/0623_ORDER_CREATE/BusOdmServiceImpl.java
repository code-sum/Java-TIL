package kr.happyjob.study.busOdm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busOdm.dao.BusOdmDao;
import kr.happyjob.study.busOdm.model.OrderModel;
import kr.happyjob.study.busOdm.model.OrderPdModel;


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
	
	/** [추가] 버튼 클릭 시, 해당 제품 이름, 가격 조회 */
	public OrderPdModel orderadd(Map<String, Object> paramMap) throws Exception {
		return busOdmDao.orderadd(paramMap);
	}
	
	/** [저장] 버튼 클릭 시, 주문정보 저장 */
	public int orderinsert(Map<String, Object> paramMap) throws Exception {
		return busOdmDao.orderinsert(paramMap);
	}
	
	/** [저장] 버튼 클릭 시, 주문 상세 정보 저장 */
    @Override
    public int orderdetailinsert(Map<String, Object> paramMap) throws Exception {
        return busOdmDao.orderdetailinsert(paramMap);
    }
	
	
}