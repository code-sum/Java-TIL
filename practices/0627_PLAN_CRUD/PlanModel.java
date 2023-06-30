package kr.happyjob.study.busSap.model;

public class PlanModel {
	
	// 영업계획 테이블(tb_planning)
	private int pln_no;  // 계획번호
	private String loginID;  // 사번
	private int clnt_no;  // 고객기업번호
	private String pln_date;  // 계획등록일자
	private int product_no;  // 제품번호
	private int pln_amt;  // 목표수량
	private int per_amt;  // 실적수량
	private int pln_achv;  // 달성률
	private String pln_memo;  // 비고
	
	// 고객기업관리 테이블(tb_clnt)
	private String clnt_name;  // 고객기업명
	
	// 제품정보 테이블(tb_product)
	private int pro_cd;  // 제품분류코드
	private int splr_no;  // 납품기업번호
	private String product_name;  // 제품명
	
	// 제품분류 테이블(tb_pro)
	private String pro_name;  // 제품분류명
	
	// 납품기업 테이블(tb_splr)
	private String splr_name;  // 납품기업명
	

	
	public int getPln_no() {
		return pln_no;
	}
	public void setPln_no(int pln_no) {
		this.pln_no = pln_no;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getPln_date() {
		return pln_date;
	}
	public void setPln_date(String pln_date) {
		this.pln_date = pln_date;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getPln_amt() {
		return pln_amt;
	}
	public void setPln_amt(int pln_amt) {
		this.pln_amt = pln_amt;
	}
	public int getPer_amt() {
		return per_amt;
	}
	public void setPer_amt(int per_amt) {
		this.per_amt = per_amt;
	}
	public int getPln_achv() {
		return pln_achv;
	}
	public void setPln_achv(int pln_achv) {
		this.pln_achv = pln_achv;
	}
	public String getPln_memo() {
		return pln_memo;
	}
	public void setPln_memo(String pln_memo) {
		this.pln_memo = pln_memo;
	}
	public int getClnt_no() {
		return clnt_no;
	}
	public void setClnt_no(int clnt_no) {
		this.clnt_no = clnt_no;
	}
	public String getClnt_name() {
		return clnt_name;
	}
	public void setClnt_name(String clnt_name) {
		this.clnt_name = clnt_name;
	}
	public int getPro_cd() {
		return pro_cd;
	}
	public void setPro_cd(int pro_cd) {
		this.pro_cd = pro_cd;
	}
	public int getSplr_no() {
		return splr_no;
	}
	public void setSplr_no(int splr_no) {
		this.splr_no = splr_no;
	}
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getSplr_name() {
		return splr_name;
	}
	public void setSplr_name(String splr_name) {
		this.splr_name = splr_name;
	}
	
	
}
