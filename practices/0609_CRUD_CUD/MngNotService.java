package kr.happyjob.study.mngNot.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface MngNotService {

	/**  목록 조회 */
	public List<NoticeModel> noticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception;
	
	/** 한건 조회 */
	public NoticeModel noticeselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 등록 */
	public int noticeinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 수정 */
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 삭제 */
	public int noticedelete(Map<String, Object> paramMap) throws Exception;
	
}
