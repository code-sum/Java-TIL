package kr.happyjob.study.busSpm.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busSpm.model.SplrModel;

public interface BusSpmService {

	/** 납품기업 목록 조회 */
	public List<SplrModel> splrlist(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 목록 카운트 조회 */
	public int countsplrlist(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 한건 조회 */
    public SplrModel splrselectone(Map<String, Object> paramMap) throws Exception;
    
    /** 납품기업 등록 */
	public int splrinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 수정 */
	public int splrupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 삭제 */
	public int splrdelete(Map<String, Object> paramMap) throws Exception;

}