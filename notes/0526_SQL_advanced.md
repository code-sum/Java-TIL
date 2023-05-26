# ✅ [5/26] SQL 심화 - 통계쿼리 작성

> - SCM 시스템에 활용된 테이블정의서, ERD, 사용자메뉴얼을 참조하여 각 화면에 던져지고 있는 SQL 쿼리문 작성해보기
> - Toad for MySQL, eXERD 프로그램 활용



```sql
-- PPT 22page

SELECT ll.loginID -- '구매기업ID'
      ,ui.name
      ,(SUM(ll.saleat) - SUM(ll.rfsaleamt)) AS totalsaleamt
      ,(SUM(ll.wongaamt) - SUM(ll.rfwongaamt)) AS totalwongaamt
      ,(SUM(ll.beneamt) - SUM(ll.rfbeneamt)) AS totalbeneamt
      -- ,SUM(ll.saleat) AS saleat -- '판매금액'
      -- ,SUM(ll.wongaamt) AS wongaamt -- '판매원가'
      -- ,SUM(ll.beneamt) AS beneamt -- '판매이익'
      -- ,SUM(ll.rfsaleamt) AS rfsaleamt -- '반품금액'
      -- ,SUM(ll.rfwongaamt) AS rfwongaamt -- '반품원가'
      -- ,SUM(ll.rfbeneamt) AS rfbeneamt -- '반품이익'
  FROM (
          SELECT -- od.order_no
              -- ,od.pro_no
              -- ,od.order_qty
              -- ,od.order_date
              od.loginID
              -- ,pd.pro_price  -- 판매금액
              -- ,pd.pro_deli_price  -- 단가(납품금액)
              ,(pd.pro_price*od.order_qty) AS saleat  -- 주문 건에 대한 매출금액
              ,(pd.pro_deli_price*od.order_qty) AS wongaamt  -- 주문 건에 대한 원가금액
              ,( (pd.pro_price*od.order_qty) - (pd.pro_deli_price*od.order_qty) ) AS beneamt  -- 주문 건에 대한 순수익
              -- ,IFNULL(rf.refund_qty,0) AS refund_qty  -- 반품수량
              ,(IFNULL(rf.refund_qty,0)*pd.pro_price) AS rfsaleamt
              ,(IFNULL(rf.refund_qty,0)*pd.pro_deli_price) AS rfwongaamt
              ,((IFNULL(rf.refund_qty,0)*pd.pro_price)-(IFNULL(rf.refund_qty,0)*pd.pro_deli_price)) AS rfbeneamt
          FROM tb_order od
              INNER JOIN tb_product pd ON pd.pro_no = od.pro_no
              LEFT OUTER JOIN tb_refund rf ON rf.pro_no = od.pro_no AND rf.order_no = od.order_no
         -- WHERE od.order_date >= STR_TO_DATE('2022-06-01', '%Y-%m-%d')
           -- AND od.order_date <= STR_TO_DATE('2022-07-01', '%Y-%m-%d')  -- 거래일자별로 WHERE 조건걸기 (6월 데이터 조회)
        ) ll
  INNER JOIN tb_userinfo ui ON  ui.loginID = ll.loginID
GROUP BY ll.loginID
ORDER BY ll.loginID
;


-- PPT 23page

SELECT ll2.name
      ,ll2.totalsaleamt
      ,ll2.totalwongaamt
      ,ll2.totalbeneamt
  FROM (
        SELECT ll.loginID -- '구매기업ID'
      ,ui.name
      ,(SUM(ll.saleat) - SUM(ll.rfsaleamt)) AS totalsaleamt
      ,(SUM(ll.wongaamt) - SUM(ll.rfwongaamt)) AS totalwongaamt
      ,(SUM(ll.beneamt) - SUM(ll.rfbeneamt)) AS totalbeneamt
  FROM (
          SELECT od.loginID
              ,(pd.pro_price*od.order_qty) AS saleat  -- 주문 건에 대한 매출금액
              ,(pd.pro_deli_price*od.order_qty) AS wongaamt  -- 주문 건에 대한 원가금액
              ,( (pd.pro_price*od.order_qty) - (pd.pro_deli_price*od.order_qty) ) AS beneamt  -- 주문 건에 대한 순수익
              ,(IFNULL(rf.refund_qty,0)*pd.pro_price) AS rfsaleamt
              ,(IFNULL(rf.refund_qty,0)*pd.pro_deli_price) AS rfwongaamt
              ,((IFNULL(rf.refund_qty,0)*pd.pro_price)-(IFNULL(rf.refund_qty,0)*pd.pro_deli_price)) AS rfbeneamt
          FROM tb_order od
              INNER JOIN tb_product pd ON pd.pro_no = od.pro_no
              LEFT OUTER JOIN tb_refund rf ON rf.pro_no = od.pro_no AND rf.order_no = od.order_no
        ) ll
  INNER JOIN tb_userinfo ui ON  ui.loginID = ll.loginID
GROUP BY ll.loginID
ORDER BY ll.loginID
        ) ll2
ORDER BY ll2.totalbeneamt DESC
limit 0,10  -- 상위 10개만 뽑기

```

