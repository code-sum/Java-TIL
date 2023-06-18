package kr.happyjob.study.busSpm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busSpm.dao.BusSpmDao;
import kr.happyjob.study.busSpm.model.SplrModel;


@Service
public class BusSpmServiceImpl implements BusSpmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BusSpmDao busSpmDao;
	
	/** 납품기업 목록 조회 */
	public List<SplrModel> splrlist(Map<String, Object> paramMap) throws Exception {
		
		return busSpmDao.splrlist(paramMap);
	}
	
	/** 납품기업 목록 카운트 조회 */
	public int countsplrlist(Map<String, Object> paramMap) throws Exception {
				
		return busSpmDao.countsplrlist(paramMap);
	}
	
}