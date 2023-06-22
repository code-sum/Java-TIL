package kr.happyjob.study.busClm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busClm.model.ClntModel;

public interface BusClmDao {

	/** 고객기업 목록 조회 */
	public List<ClntModel> clntlist(Map<String, Object> paramMap) throws Exception;
	
	/** 고객기업 목록 카운트 조회 */
	public int countclntlist(Map<String, Object> paramMap) throws Exception;
	
	/** 고객기업 한건 조회 */
	public ClntModel clntselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 고객기업 등록 */
	public int clntinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 고객기업 수정 */
	public int clntupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 고객기업 삭제 */
	public int clntdelete(Map<String, Object> paramMap) throws Exception;
   
}