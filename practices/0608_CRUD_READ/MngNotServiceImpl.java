package kr.happyjob.study.mngNot.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.mngNot.dao.MngNotDao;
import kr.happyjob.study.mngNot.model.NoticeModel;


@Service
public class MngNotServiceImpl implements MngNotService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	MngNotDao mngNotDao;
	
	/** 목록 조회 */
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception {
		
		return mngNotDao.noticelist(paramMap);
	}
	
	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception {
				
		return mngNotDao.countnoticelist(paramMap);
	}
	
}
