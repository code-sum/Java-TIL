package kr.happyjob.study.busOdm.model;

public class OrderModel {
	
	// 주문관리 테이블(tb_order)
	private int order_no;  // 주문번호
	private int clnt_no;  // 고객기업번호
	private String clnt_name;  // 고객기업명
	private String clnt_tel;  // 고객기업전화
	private String loginID;  // 사번
	private String name;  // 영업담당자(이름)
	private int order_tot_price;  // 총주문금액
	private String order_cancel;  // 취소여부
	private String order_date;  // 주문날짜
	private String order_req;  // 요청사항
	
	// 주문상세관리 테이블 (tb_order_dt)
	private int product_no;  // 제품번호
	private int product_price;  // 판매가
	private int order_dt_amt;  // 주문수량
	
	public int getOrder_no() {
		return order_no;
	}
	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getOrder_tot_price() {
		return order_tot_price;
	}
	public void setOrder_tot_price(int order_tot_price) {
		this.order_tot_price = order_tot_price;
	}
	public String getOrder_cancel() {
		return order_cancel;
	}
	public void setOrder_cancel(String order_cancel) {
		this.order_cancel = order_cancel;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_req() {
		return order_req;
	}
	public void setOrder_req(String order_req) {
		this.order_req = order_req;
	}
	public int getProduct_no() {
		return product_no;
	}
	public void setProduct_no(int product_no) {
		this.product_no = product_no;
	}
	public int getProduct_price() {
		return product_price;
	}
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}
	public int getOrder_dt_amt() {
		return order_dt_amt;
	}
	public void setOrder_dt_amt(int order_dt_amt) {
		this.order_dt_amt = order_dt_amt;
	}
	public String getClnt_tel() {
		return clnt_tel;
	}
	public void setClnt_tel(String clnt_tel) {
		this.clnt_tel = clnt_tel;
	}
	
}
