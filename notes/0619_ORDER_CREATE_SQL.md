# ✅ [6/19] 주문관리 SQL Query (CREATE)



주문관리 테이블에 INSERT 하는 데이터를 회계전표 테이블에도 INSERT 하고 싶을 때, Controller 최상위 클래스에 각각의 서비스를 연결하는 방법도 있고 Impl 파일에 각각의 Dao 를 연결해주는 방법도 있음 

이렇게 연결 작업을 해주면, Mapper.xml 에는 하나의 `<INSERT>` 만 작성해도 2개의 서로 다른 테이블에 데이터 동시 입력하게 됨 

```sql
-- [저장] 버튼 클릭 시, 주문정보 저장 

INSERT INTO tb_order 
		          (
		           order_no
		          ,clnt_no
		          ,order_tot_price
		          ,order_cancel
		          ,order_date
		          ,order_req
		          ,loginID
		          )
		  VALUES (
		           #{no}
		          ,#{clnt_no}
		          ,#{order_tot_price}
		          ,'N'
		          ,#{order_date}
		          ,#{order_req}
		          ,#{loginid}
		          );
```

```SQL
-- [저장] 버튼 클릭 시, 주문 상세 정보 저장

INSERT INTO tb_order_dt 
	    	   	  (
	    		    order_no
	    		   ,product_no
	    		   ,clnt_no
	    		   ,product_price
	    		   ,order_dt_amt
	    		   ,order_dt_price
	    		   )
	       VALUES (
	       		     (SELECT ifnull(max(order_no),0) FROM tb_order)
	       		   , #{product_no}
	       		   , #{clnt_no}
	       		   , #{product_price}
	       		   , #{order_dt_amt}
	       		   , #{order_dt_price}
	       		   );
```

```SQL
-- [저장] 버튼 클릭 시, 회계전표 저장

INSERT INTO tb_budget 
		          (
		           budget_no
		          ,acnt_sbject_cd
		          ,acnt_dt_sbject_cd
		          ,order_no
		          )
		  VALUES (
		           #{no}
		          ,'1111'
		          ,'1000'
		          ,(SELECT ifnull(max(order_no),0) + 1 FROM tb_order)
		          );
```

