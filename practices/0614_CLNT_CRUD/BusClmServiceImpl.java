package kr.happyjob.study.busClm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.busClm.dao.BusClmDao;
import kr.happyjob.study.busClm.model.ClntModel;


@Service
public class BusClmServiceImpl implements BusClmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	BusClmDao busClmDao;
	
	/** 고객기업 목록 조회 */
	public List<ClntModel> clntlist(Map<String, Object> paramMap) throws Exception {
		
		return busClmDao.clntlist(paramMap);
	}
	
	/** 고객기업 목록 카운트 조회 */
	public int countclntlist(Map<String, Object> paramMap) throws Exception {
				
		return busClmDao.countclntlist(paramMap);
	}
	
	/** 고객기업 한건 조회 */
	public ClntModel clntselectone(Map<String, Object> paramMap) throws Exception {
		
		return busClmDao.clntselectone(paramMap);
	}
	
	/** 고객기업 등록 */
	public int clntinsert(Map<String, Object> paramMap) throws Exception {
		return busClmDao.clntinsert(paramMap);
	}
	
	/** 고객기업 수정 */
	public int clntupdate(Map<String, Object> paramMap) throws Exception {
		return busClmDao.clntupdate(paramMap);
	}
	
	/** 고객기업 삭제 */
	public int clntdelete(Map<String, Object> paramMap) throws Exception {
		return busClmDao.clntdelete(paramMap);
	}
	
}