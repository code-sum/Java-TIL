package kr.happyjob.study.busSap.model;

public class PlanModel {
	
	private int pln_no;  // 계획번호
	private String loginID;  // 사번
	private String pln_date;  // 계획등록일자
	private int product_no;  // 제품번호
	private int pln_amt;  // 목표수량
	private int per_amt;  // 실적수량
	private int pln_achv;  // 달성률
	private String pln_memo;  // 비고
	
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
	
	
}
