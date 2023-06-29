package kr.happyjob.study.busSap.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busSap.model.PlanModel;

public interface BusSapService {

	/** 영업계획 목록 조회 */
	public List<PlanModel> planlist(Map<String, Object> paramMap) throws Exception;
	
	/** 영업계획 목록 카운트 조회 */
	public int countplanlist(Map<String, Object> paramMap) throws Exception;

}