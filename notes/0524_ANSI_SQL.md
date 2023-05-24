# ✅ [5/24] SQL 작성

> - SCM 시스템에 활용된 테이블정의서, ERD, 사용자메뉴얼을 참조하여 각 화면에 던져지고 있는 SQL 쿼리문 작성해보기
> - Toad for MySQL, eXERD 프로그램 활용



```SQL
-- 1. PPT 2page [사용자관리] 조회
-- A:SCM관리자 B:배송담당자 C:기업고객 D:구매담당자 E:회사임원
-- MySQL 문자열 합치는 함수 : CONCAT()
SELECT CASE WHEN user_type = 'C' THEN '외부'
            ELSE '내부직원'
       END AS usertypename
      ,loginID
      ,name
      ,user_type
      ,CASE WHEN user_type = 'A' THEN 'SCM관리자'
            WHEN user_type = 'B' THEN '배송담당자'
            WHEN user_type = 'C' THEN '기업고객'
            WHEN user_type = 'D' THEN '구매담당자'
            WHEN user_type = 'E' THEN '회사임원'
       END AS worktype
      ,CONCAT(user_tel1,'-',user_tel2,'-',user_tel3) AS user_tel
  FROM tb_userinfo;
  

-- 2. PPT 3page [공지사항] 조회
-- MySQL 날짜 출력 바꾸기 : DATE_FORMAT()
-- 다른 테이블과 조인할 때, 테이블에 이니셜 줘야함 
SELECT no.notice_no
      ,no.notice_title
      ,DATE_FORMAT(no.notice_regdate, '%Y-%m-%d') AS notice_regdate
      ,no.loginID
      ,ui.name
      ,no.notice_hit
  FROM tb_notice no
       INNER JOIN tb_userinfo ui ON ui.loginID = no.loginID
 WHERE no.notice_regdate >= STR_TO_DATE('2020-12-01', '%Y-%m-%d')
   AND no.notice_regdate <= DATE_ADD(STR_TO_DATE('2020-12-31', '%Y-%m-%d'), INTERVAL 1 DAY)   -- DATE_ADD 활용해서 2020-12-31 14시에 작성된 글도 빠짐없이 출력되게 만듬 
   ;
    
       
-- 3. PPT 4page [공통코드]-[그룹코드] 조회
SELECT group_code
      ,group_name
      ,note
      ,use_yn
  FROM tb_group_code;
  
  
-- 4. PPT 4page [공통코드]-[상세코드] 조회
SELECT group_code
      ,detail_code
      ,detail_name
      ,use_yn
  FROM tb_detail_code
 WHERE group_code = 'genderCD';
  
  
-- 5. PPT 5page [납품 업체 정보] 조회
-- 제품 : tb_product, 납품업체 : tb_delivery
SELECT deli_company
      ,deli_id
      ,deli_password
      ,deli_name
      ,deli_phone
      ,deli_email
  FROM tb_delivery;
  

-- 6. PPT 5page [납품 업체 정보]-[제품 정보] 조회
-- MySQL 1000단위마다 ,(쉼표) 찍기 : FORMAT(, 0)
SELECT pro_no
      ,pro_name
      ,FORMAT(pro_price, 0) AS pro_price
  FROM tb_product
 WHERE deli_no = 1;
  
  
-- 7. PPT 6page [제품정보 관리] 조회
SELECT pd.pro_model_name
      ,pd.pro_no
      ,pd.pro_name
      ,pd.pro_manu_name
      ,FORMAT(pd.pro_price, 0) AS pro_price
      ,pd.deli_no
      ,dl.deli_name
      ,FORMAT(pd.pro_deli_price, 0) AS pro_deli_price
  FROM tb_product pd
       INNER JOIN tb_delivery dl ON dl.deli_no = pd.deli_no;


-- 8. PPT 7page [창고 정보 관리] 조회
SELECT wh.ware_no
      ,wh.ware_name
      ,wh.loginID
      ,ui.name
      ,ui.user_email
      ,wh.ware_zipcode
      ,CONCAT(wh.ware_address,' ',wh.ware_dt_address) AS address
  FROM tb_warehouse wh
       INNER JOIN tb_userinfo ui ON ui.loginID = wh.loginID;
       
       
-- 9. PPT 8page [1:1 문의 답변] 조회
SELECT iq.inq_no
      ,iq.inq_title
      ,DATE_FORMAT(iq.inq_regdate, '%Y-%m-%d %H %i') AS inq_regdate
      ,CONCAT(
              DATE_FORMAT(iq.inq_regdate, '%Y'),'년 '
              ,DATE_FORMAT(iq.inq_regdate, '%m'),'월 '
              ,DATE_FORMAT(iq.inq_regdate, '%d'),'일 '
              ,DATE_FORMAT(iq.inq_regdate, '%H'),'시 '
              ,DATE_FORMAT(iq.inq_regdate, '%i'),'분'
              ) AS inq_regdate2
      ,iq.loginID
      ,ui.name
      ,iq.answer_cd  -- 0: 미답변, 1: 답변완료, -1: 삭제
  FROM tb_inquiry iq
        INNER JOIN tb_userinfo ui ON ui.loginID = iq.loginID
 WHERE answer_cd <> -1;
 
 
-- 10. PPT 9page [일별 수주 내역] 조회
SELECT od.order_no
      ,od.order_date
      ,od.loginID
      ,od.pro_no    -- 재고건수 
      ,IFNULL(ll.pro_ware_qty, 0) AS pro_ware_qty
      ,FORMAT(pd.pro_price, 0) AS pro_price    -- 공급가(판매금액)
      ,od.order_qty    
      ,FORMAT((od.order_qty * pd.pro_price), 0) AS selamt   -- 판매금액(공급가*갯수)
      ,CASE WHEN od.order_cd = 'order' THEN '주문'   -- order: 주문, refund: 반품, complete: 완료
            WHEN od.order_cd = 'refund' THEN '반품'
            ELSE '완료'
       END AS ordertype
      ,od.order_expdate
      ,CASE WHEN od.deposit_cd = '0' THEN '입금확인'    -- 0: 입금확인, 1: 미입금
            WHEN od.deposit_cd = '1' THEN '미입금'
            ELSE '미입금'
       END AS deposit_cd
  FROM tb_order od
    INNER JOIN tb_product pd ON pd.pro_no = od.pro_no
    LEFT OUTER JOIN (
                      SELECT pw.pro_no
                            ,sum(pw.pro_ware_qty) AS pro_ware_qty
                        FROM tb_product_warehouse pw
                       group by pw.pro_no
                     ) ll ON ll.pro_no = od.pro_no
;


-- 11. PPT 10page [창고별 재고 현황] 조회
-- 예를 들어 제품 1~5번 등록, 창고에 1~3번만 재고가 있을 때 이를 조회하는 것
-- tb_product_warehouse : 창고별 재고 정보
-- tb_product : 제품 정보
SELECT pw.ware_no
      ,wh.ware_name
      ,pw.pro_no   
      ,pd.pro_name    -- 제품명
      ,pw.pro_ware_qty
      ,CONCAT(wh.ware_address,' ',wh.ware_dt_address) AS address
  FROM tb_product_warehouse pw
      INNER JOIN tb_product pd ON pd.pro_no = pw.pro_no
      INNER JOIN tb_warehouse wh ON wh.ware_no = pw.ware_no
ORDER BY pw.ware_no, pw.pro_no
  ;


-- 12. PPT 10page [창고별 재고 현황]-[입출고 내역] 조회
SELECT DATE_FORMAT(piw.pro_io_date, '%Y-%m-%d') AS '날짜'
      ,CASE WHEN piw.pro_io_cd = 'in_pre' THEN '입고예정'    -- in_pre:입고예정 in_done:입고완료 out_pre:출고예정 out_done:출고완료
            WHEN piw.pro_io_cd = 'in_done' THEN '입고완료'
            WHEN piw.pro_io_cd = 'out_pre' THEN '출고예정'
            WHEN piw.pro_io_cd = 'out_done' THEN '출고완료'
      END AS '입고/출고'
      ,piw.pro_no AS '제품번호'  
      ,pd.pro_name AS '제품명'
      ,piw.pro_io_qty AS '수량'
      ,piw.pro_io_memo AS '비고'
  FROM tb_product_io_warehouse piw
      INNER JOIN tb_product pd ON pd.pro_no = piw.pro_no;


-- 13. (번외) 전체 제품 목록에서, 제품코드, 제품명, 이에 대한 재고건수 3개 칼럼만 조회
SELECT pd.pro_no
      ,pd.pro_name
      ,IFNULL(pw.pro_ware_qty, 0) AS pro_ware_qty
  FROM tb_product pd
      LEFT OUTER JOIN (
                        SELECT pro_no
                        ,sum(pro_ware_qty) AS pro_ware_qty
                    FROM tb_product_warehouse
                   GROUP BY pro_no
                      ) pw on pw.pro_no = pd.pro_no
;


-- 14. PPT 11page [반품신청 목록] 조회
SELECT ui.user_company   -- 기업명
     ,rf.refund_cd  -- 반품코드
     ,DATE_FORMAT(od.order_date, '%Y-%m-%d')
     ,od.pro_no  
     ,pd.pro_name   -- 제품명
     ,rf.refund_qty   -- 금액 = 판매금액 * 수량
     ,FORMAT((pd.pro_price * rf.refund_qty),0) AS refamt
  FROM tb_order od
      INNER JOIN tb_userinfo ui ON ui.loginID = od.loginID
      INNER JOIN tb_product pd ON pd.pro_no = od.pro_no
      INNER JOIN tb_refund rf ON rf.pro_no = od.pro_no AND rf.order_no = od.order_no
 WHERE od.order_cd = 'refund'
;
```

