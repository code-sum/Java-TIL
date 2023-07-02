package kr.happyjob.study.busSas.service;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.busSas.model.PerfModel;

public interface BusSasService {

	/** 영업실적 목록 조회 */
	public List<PerfModel> perflist(Map<String, Object> paramMap) throws Exception;
	
	/** 영업실적 목록 카운트 조회 */
	public int countperflist(Map<String, Object> paramMap) throws Exception;

}