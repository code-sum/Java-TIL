package kr.happyjob.study.busOdm.model;

public class OrderPdModel {
	
	// 제품정보 테이블 (tb_product)
	private int product_no;  // 제품번호
	private int product_price;  // 판매가
	private String product_name;  // 제품명
	private int pro_cd;  // 제품분류코드(대분류)
	private int splr_no;  // 납품기업번호(중분류)
	
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
	public String getProduct_name() {
		return product_name;
	}
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
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
	
}
