package kr.happyjob.study.mngNot.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mngNot.model.NoticeModel;

public interface MngNotDao {

	/**  목록 조회 */
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception;
	
}
