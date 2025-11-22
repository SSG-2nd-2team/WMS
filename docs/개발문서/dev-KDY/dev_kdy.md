# Branch dev/KDY
### 구현 패키지
- 공통 패키지(advice, common)
- 권한별 패키지(admin, manager, member)
- 고객센터(announcement, inquiry, reply)
- 거래처(partner)

### 설계
###### ERD
[//]: # (ERD 첨부)

사용자(총관리자, 창고관리자, 일반회원)에 대한 설계:

사용자가 갖는 공통속성에 따라 테이블을 구분하였습니다. <br>
- WMS 서비스의 직원, 서비스를 이용하는 고객으로 분류 
  -> 직원(총관리자, 창고관리자), 고객(일반회원)
<br>

직원 : Staff, 고객 : Member <br>

사용자 각각의 권한(role)은 ADMIN, MANAGER, MEMBER로 분류하여, 
권한별 접근 제어가 가능하도록 설계하였습니다. <br>





```
├── 
│ ├── 
│ │ ├── 
│ │ │ ├── 
│ │ │ ├── 
│ │ │ ├── 
│ │ │ └── 
│ │ └── 
│ └── 
├── 
└── 
```

