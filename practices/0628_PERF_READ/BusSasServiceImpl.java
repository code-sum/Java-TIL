package kr.happyjob.study.busSas.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busSas.dao.BusSasDao;
import kr.happyjob.study.busSas.model.PerfModel;


@Service
public class BusSasServiceImpl implements BusSasService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BusSasDao busSasDao;
	
	/** 영업계획 목록 조회 */
	public List<PerfModel> perflist(Map<String, Object> paramMap) throws Exception {
		return busSasDao.perflist(paramMap);
	}
	
	/** 영업계획 목록 카운트 조회 */
	public int countperflist(Map<String, Object> paramMap) throws Exception {
		return busSasDao.countperflist(paramMap);
	}
	
}