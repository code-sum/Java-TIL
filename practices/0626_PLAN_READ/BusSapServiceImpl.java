package kr.happyjob.study.busSap.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busSap.dao.BusSapDao;
import kr.happyjob.study.busSap.model.PlanModel;


@Service
public class BusSapServiceImpl implements BusSapService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BusSapDao busSapDao;
	
	/** 영업계획 목록 조회 */
	public List<PlanModel> planlist(Map<String, Object> paramMap) throws Exception {
		return busSapDao.planlist(paramMap);
	}
	
	/** 영업계획 목록 카운트 조회 */
	public int countplanlist(Map<String, Object> paramMap) throws Exception {
		return busSapDao.countplanlist(paramMap);
	}
	
}