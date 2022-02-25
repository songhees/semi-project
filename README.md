# nadri Project

팀 프로젝트로 진행한 **인터넷 쇼핑몰**입니다.   

기간 : **2021/11/25 ~ 2021/12/09** (약 2주)  
인원 : 4명

</br>

#### 맡은 역할(My Role)
+ 회원 정보 페이지
+ 장바구니
</br>

#### stack

|front|back   |
|-----|-------|
|Html 5 |java   |
|css 3 |SQL Developer |
|jsp  |oracle|
|javascript|
|BootStrap|

</br>
  
  

## 화면설명
#### gif를 클릭하시면 화면이 커집니다!

</br>

| 일부 사진은 저작권으로 인하여 삭제했습니다.
  
### 회원가입
![회원가입1](https://user-images.githubusercontent.com/92537000/155652380-38bfea67-6c5b-415c-b74c-9fa211fd1e26.gif) 

![회원가입2](https://user-images.githubusercontent.com/92537000/155652385-0d37367b-7dfd-4723-aedc-53fd3f4ec35c.gif)

![회원가입3](https://user-images.githubusercontent.com/92537000/155652389-53b2e659-7771-4c37-96fc-40fecee2b7fa.gif)

+ 자바스크립트로 유효성 검사를 진행했습니다.
+ 아이디/비밀번호/전화번호양식을 맞추지 않으면 경고 문구가 뜨도록 했습니다.
+ 아이디/핸드폰/이메일이 이미 존재하는 회원이 존재하는 경고 경고창을 띄웁니다.
  
  
</br>
  

### 로그인
![로그인](https://user-images.githubusercontent.com/92537000/155653014-3da5a0ec-03d8-4d55-b115-dc2eee3de7c8.gif)

+ 자바스크립트로 유효성 검사를 진행했습니다.
+ **[에러]** 아이디가 존재하지 않는 회원의 경우
+ **[에러]** 틀린비밀번호 입력시

</br>
  
### 포인트

![신규포인트](https://user-images.githubusercontent.com/92537000/155653223-39aeef88-1311-4092-a7ce-505f2001944c.gif)

+ 신규 회원 가입시 2000포인트가 미리 적립되도록 했습니다.
+ 제품구매시 1%의 포인트가 자동 적립됩니다.

</br>
  
### 배송지등록/수정

![배송지등록](https://user-images.githubusercontent.com/92537000/155653393-b06a0448-2327-4634-a108-ed35cb0e5aea.gif)

+ 다음 주소 api로 주소검색이 가능합니다.
+ 배송지 목록
    + 기본 주소 행에서 기본배송지 설정을 할 수 있습니다.
    + 기본 주소로 정해진 배송지는 회원정보 수정과 결제 창에 자동 입력됩니다.
    + checkbox로 선택된 배송지들을 삭제할 수 있습니다.
+ 자바스크립트로 유효성 검사를 진행했습니다.
+ 배송지 등록버튼
    + 새로운 배송지를 등록할 수 있습니다.
    + 기본배송지로 저장 클릭시 본래있던 주소들의 기본 주소 설정이 해제됩니다.
+ 수정 버튼
    + 배송지를 수정하실 수 있습니다.

</br>
  
### 회원정보 수정

![회원정보 수정](https://user-images.githubusercontent.com/92537000/155653807-dee43421-a732-41e7-885d-fa938921d3ec.gif)

+ 회원가입과 동일한 유효성 검사를 설정했습니다.
+ 회원정보수정 버튼
    + 입력된 회원정보로 수정이 완료됩니다.

</br>

### 회원탈퇴
  
![회원탈퇴](https://user-images.githubusercontent.com/92537000/155653813-eacfb943-e22c-4734-bd50-569ecf5dae93.gif)

+ 회원정보 수정 페이지에서 회원 탈퇴버튼을 누르면 뜨는 모달창 입니다.
+ 동의하는 checkbox버튼을 클릭하고 아이디를 입력하면 회원탈퇴가 완료됩니다.
  
</br>
  
### 게시물관리

![게시물관리](https://user-images.githubusercontent.com/92537000/155654139-23e29d55-8430-44af-8ae6-88ecc240bde0.gif)

+ 사용자가 쓴 리뷰목록을 볼 수 있습니다.
+ 리뷰길이가 박스를 넘어가면 생략됩니다.
+ 삭제버튼을 통해 리뷰를 삭제하실 수 있습니다.
  
</br>
  
### 주문목록
![주문목록](https://user-images.githubusercontent.com/92537000/155737830-1cf9a421-5709-4881-96c8-2ac828967947.gif)

+ 사용자 메뉴의 나의 주문처리 현황
    + 클릭시 주문/취소/반품한 상품목록을 볼 수 있습니다
+ 주문내역조회/취소반품교환내역 메뉴
    + 현재날짜로 부터 오늘/1개월/3개월/6개월 전으로 검색할 수 있습니다.
+ 과거 주문내역 메뉴
    + 년도별로 검색할 수 있습니다.
+ 주문번호 클릭시 주문상세정보로 이동할 수 있습니다. 

</br>
  
### 주문상세정보

![주문상세정보](https://user-images.githubusercontent.com/92537000/155654286-c1a99f75-fc8e-423e-a7b7-10c2f1daa692.gif)

+ 주문목록의 주문번호를 클릭하면 번호에 해당하는 주문 상세내역을 보실 수 있습니다.
+ 상세내역
    + 금액
    + 주소
    + 주문자 정보
    + 주문상태
    + 결제수단
    + 상품정보

</br>
  

### 장바구니

![장바구니](https://user-images.githubusercontent.com/92537000/155654515-c5fa7309-1c93-48f4-962e-490d448d917d.gif)

+ 상품상세정보/코디목록 에서 상품을 장바구니에 담을 수 있습니다.
+ 수량버튼
    + 올린 수량에 해당하는 가격정보를 확인할 수 있습니다.
    + 5만원이 넘어가면 배송비가 0원이 됩니다.
+ 주문버튼
    + 단일주문
    + 전체상품주문
    + 선택상품주문이 가능합니다.
+ 삭제버튼
    + 장바구니의 상품을 삭제할 수 있습니다.

#### 감사합니다
