package kr.happyjob.study.busSpm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busSpm.model.SplrModel;

public interface BusSpmDao {

	/** 납품기업 목록 조회 */
	public List<SplrModel> splrlist(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 목록 카운트 조회 */
	public int countsplrlist(Map<String, Object> paramMap) throws Exception;
   
}