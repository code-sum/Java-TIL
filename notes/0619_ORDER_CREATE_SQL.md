# ✅ [6/19] 주문관리 SQL Query (CREATE)



주문관리 테이블에 INSERT 하는 데이터를 회계전표 테이블에도 INSERT 하고 싶을 때, Controller 최상위 클래스에 각각의 서비스를 연결하는 방법도 있고 Impl 파일에 각각의 Dao 를 연결해주는 방법도 있음 

이렇게 연결 작업을 해주면, Mapper.xml 에는 하나의 `<INSERT>` 만 작성해도 2개의 서로 다른 테이블에 데이터 동시 입력하게 됨 

