package kr.happyjob.study.mngNot.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mngNot.model.NoticeModel;

public interface MngNotService {

	/**  공지사항 목록 조회  **/
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception;
	
	/**  공지사항 목록 카운트 조회  **/
	public int countnoticelist(Map<String, Object> paramMap) throws Exception;
	
}
