const String workJson = """
[
  {
    "code": "000001",
    "parent": "",
    "tier": 1,
    "title": "레슨"
  },
  {
    "code": "000002",
    "parent": "000001",
    "tier": 2,
    "title": "학업"
  },
  {
    "code": "000003",
    "parent": "000002",
    "tier": 3,
    "title": "영어 과외"
  },
  {
    "code": "000004",
    "parent": "000002",
    "tier": 3,
    "title": "수학 과외"
  },
  {
    "code": "000005",
    "parent": "000002",
    "tier": 3,
    "title": "국어 과외"
  },
  {
    "code": "000006",
    "parent": "000002",
    "tier": 3,
    "title": "과학 과외"
  },
  {
    "code": "000007",
    "parent": "000002",
    "tier": 3,
    "title": "사회 과외"
  },
  {
    "code": "000008",
    "parent": "000002",
    "tier": 3,
    "title": "논술 과외"
  },
  {
    "code": "000009",
    "parent": "000002",
    "tier": 3,
    "title": "토론 과외"
  },
  {
    "code": "000010",
    "parent": "000002",
    "tier": 3,
    "title": "편입 과외"
  },
  {
    "code": "000011",
    "parent": "000002",
    "tier": 3,
    "title": "검정고시 과외"
  },
  {
    "code": "000012",
    "parent": "000002",
    "tier": 3,
    "title": "속독 과외"
  },
  {
    "code": "000013",
    "parent": "000002",
    "tier": 3,
    "title": "주산/암산 과외"
  },
  {
    "code": "000014",
    "parent": "000002",
    "tier": 3,
    "title": "한문 과외"
  },
  {
    "code": "000015",
    "parent": "000002",
    "tier": 3,
    "title": "유아 방문수업"
  },
  {
    "code": "000016",
    "parent": "000002",
    "tier": 3,
    "title": "체대 입시 준비"
  },
  {
    "code": "000017",
    "parent": "000002",
    "tier": 3,
    "title": "대학 입시 컨설팅"
  },
  {
    "code": "000018",
    "parent": "000002",
    "tier": 3,
    "title": "대학 입시 자소서 컨설팅"
  },
  {
    "code": "000019",
    "parent": "000002",
    "tier": 3,
    "title": "대학원 입시 컨설팅"
  },
  {
    "code": "000020",
    "parent": "000002",
    "tier": 3,
    "title": "논문 컨설팅"
  },
  {
    "code": "000021",
    "parent": "000002",
    "tier": 3,
    "title": "유학 컨설팅"
  },
  {
    "code": "000022",
    "parent": "000002",
    "tier": 3,
    "title": "자기주도학습 코칭"
  },
  {
    "code": "000023",
    "parent": "000001",
    "tier": 2,
    "title": "외국어"
  },
  {
    "code": "000024",
    "parent": "000023",
    "tier": 3,
    "title": "영어 괴외"
  },
  {
    "code": "000025",
    "parent": "000023",
    "tier": 3,
    "title": "비즈니스 영어"
  },
  {
    "code": "000026",
    "parent": "000023",
    "tier": 3,
    "title": "화상영어/전화영어 회화"
  },
  {
    "code": "000027",
    "parent": "000023",
    "tier": 3,
    "title": "중국어 과외"
  },
  {
    "code": "000028",
    "parent": "000023",
    "tier": 3,
    "title": "비즈니스 중국어"
  },
  {
    "code": "000029",
    "parent": "000023",
    "tier": 3,
    "title": "일본어(일어) 과외"
  },
  {
    "code": "000030",
    "parent": "000023",
    "tier": 3,
    "title": "비즈니스 일본어"
  },
  {
    "code": "000031",
    "parent": "000023",
    "tier": 3,
    "title": "네덜란드어 과외"
  },
  {
    "code": "000032",
    "parent": "000023",
    "tier": 3,
    "title": "독일어(독어) 과외"
  },
  {
    "code": "000033",
    "parent": "000023",
    "tier": 3,
    "title": "라틴어 과외"
  },
  {
    "code": "000034",
    "parent": "000023",
    "tier": 3,
    "title": "러시아어 과외"
  },
  {
    "code": "000035",
    "parent": "000023",
    "tier": 3,
    "title": "몽골어 과외"
  },
  {
    "code": "000036",
    "parent": "000023",
    "tier": 3,
    "title": "베트남어 과외"
  },
  {
    "code": "000037",
    "parent": "000023",
    "tier": 3,
    "title": "스와힐리어 과외"
  },
  {
    "code": "000038",
    "parent": "000023",
    "tier": 3,
    "title": "스웨덴어 과외"
  },
  {
    "code": "000039",
    "parent": "000023",
    "tier": 3,
    "title": "스페인어 과외"
  },
  {
    "code": "000040",
    "parent": "000023",
    "tier": 3,
    "title": "아랍어 과외"
  },
  {
    "code": "000041",
    "parent": "000023",
    "tier": 3,
    "title": "이탈리아어 과외"
  },
  {
    "code": "000042",
    "parent": "000023",
    "tier": 3,
    "title": "인도네시아어/말레이시아어 과외"
  },
  {
    "code": "000043",
    "parent": "000023",
    "tier": 3,
    "title": "체코어 과외"
  },
  {
    "code": "000044",
    "parent": "000023",
    "tier": 3,
    "title": "태국어 과외"
  },
  {
    "code": "000045",
    "parent": "000023",
    "tier": 3,
    "title": "터키어 과외"
  },
  {
    "code": "000046",
    "parent": "000023",
    "tier": 3,
    "title": "포르투갈어 과외"
  },
  {
    "code": "000047",
    "parent": "000023",
    "tier": 3,
    "title": "폴란드어 과외"
  },
  {
    "code": "000048",
    "parent": "000023",
    "tier": 3,
    "title": "프랑스어(불어) 과외"
  },
  {
    "code": "000049",
    "parent": "000023",
    "tier": 3,
    "title": "헝가리어 과외"
  },
  {
    "code": "000050",
    "parent": "000023",
    "tier": 3,
    "title": "히브리어 과외"
  },
  {
    "code": "000051",
    "parent": "000023",
    "tier": 3,
    "title": "힌디어 과외"
  },
  {
    "code": "000052",
    "parent": "000001",
    "tier": 2,
    "title": "외국어시험"
  },
  {
    "code": "000053",
    "parent": "000052",
    "tier": 3,
    "title": "TOEIC/speaking/writing 과외"
  },
  {
    "code": "000054",
    "parent": "000052",
    "tier": 3,
    "title": "OPIc 과외"
  },
  {
    "code": "000055",
    "parent": "000052",
    "tier": 3,
    "title": "IELTS 과외"
  },
  {
    "code": "000056",
    "parent": "000052",
    "tier": 3,
    "title": "TOEFL 과외"
  },
  {
    "code": "000057",
    "parent": "000052",
    "tier": 3,
    "title": "HSK 과외"
  },
  {
    "code": "000058",
    "parent": "000052",
    "tier": 3,
    "title": "JLPT 과외"
  },
  {
    "code": "000059",
    "parent": "000052",
    "tier": 3,
    "title": "ACT 과외"
  },
  {
    "code": "000060",
    "parent": "000052",
    "tier": 3,
    "title": "AP 과외"
  },
  {
    "code": "000061",
    "parent": "000052",
    "tier": 3,
    "title": "DELE 과외"
  },
  {
    "code": "000062",
    "parent": "000052",
    "tier": 3,
    "title": "DELE/DALF 과외"
  },
  {
    "code": "000063",
    "parent": "000052",
    "tier": 3,
    "title": "EJU 과외"
  },
  {
    "code": "000064",
    "parent": "000052",
    "tier": 3,
    "title": "FLEX 과외"
  },
  {
    "code": "000065",
    "parent": "000052",
    "tier": 3,
    "title": "G-TELP 과외"
  },
  {
    "code": "000066",
    "parent": "000052",
    "tier": 3,
    "title": "GED 과외"
  },
  {
    "code": "000067",
    "parent": "000052",
    "tier": 3,
    "title": "GMAT 과외"
  },
  {
    "code": "000068",
    "parent": "000052",
    "tier": 3,
    "title": "GRE 과외"
  },
  {
    "code": "000069",
    "parent": "000052",
    "tier": 3,
    "title": "IB 과외"
  },
  {
    "code": "000070",
    "parent": "000052",
    "tier": 3,
    "title": "JPT 과외"
  },
  {
    "code": "000071",
    "parent": "000052",
    "tier": 3,
    "title": "LSAT 과외"
  },
  {
    "code": "000072",
    "parent": "000052",
    "tier": 3,
    "title": "SAT 과외"
  },
  {
    "code": "000073",
    "parent": "000052",
    "tier": 3,
    "title": "SJPT 과외"
  },
  {
    "code": "000074",
    "parent": "000052",
    "tier": 3,
    "title": "TCF 과외"
  },
  {
    "code": "000075",
    "parent": "000052",
    "tier": 3,
    "title": "TEPS 과외"
  },
  {
    "code": "000076",
    "parent": "000052",
    "tier": 3,
    "title": "TORFL 과외"
  },
  {
    "code": "000077",
    "parent": "000052",
    "tier": 3,
    "title": "TSC 과외"
  },
  {
    "code": "000078",
    "parent": "000052",
    "tier": 3,
    "title": "ZD 과외"
  },
  {
    "code": "000079",
    "parent": "000001",
    "tier": 2,
    "title": "공예"
  },
  {
    "code": "000080",
    "parent": "000079",
    "tier": 3,
    "title": "플라워/꽃꽃이 레슨"
  },
  {
    "code": "000081",
    "parent": "000079",
    "tier": 3,
    "title": "LED 플라워 레슨"
  },
  {
    "code": "000082",
    "parent": "000079",
    "tier": 3,
    "title": "네온공예 레슨"
  },
  {
    "code": "000083",
    "parent": "000079",
    "tier": 3,
    "title": "가구/목공예 레슨"
  },
  {
    "code": "000084",
    "parent": "000079",
    "tier": 3,
    "title": "가죽공예 레슨"
  },
  {
    "code": "000085",
    "parent": "000079",
    "tier": 3,
    "title": "마카쥬 레슨"
  },
  {
    "code": "000086",
    "parent": "000079",
    "tier": 3,
    "title": "바느질/재봉틀 레슨"
  },
  {
    "code": "000087",
    "parent": "000079",
    "tier": 3,
    "title": "뜨개질/위빙 레슨"
  },
  {
    "code": "000088",
    "parent": "000079",
    "tier": 3,
    "title": "금속/악세사리공예 레슨"
  },
  {
    "code": "000089",
    "parent": "000079",
    "tier": 3,
    "title": "레진아트 레슨"
  },
  {
    "code": "000090",
    "parent": "000079",
    "tier": 3,
    "title": "업사이클링 레슨"
  },
  {
    "code": "000091",
    "parent": "000079",
    "tier": 3,
    "title": "미니어처 레슨"
  },
  {
    "code": "000092",
    "parent": "000079",
    "tier": 3,
    "title": "클레이아트 레슨"
  },
  {
    "code": "000093",
    "parent": "000079",
    "tier": 3,
    "title": "냅킨/포크아트 레슨"
  },
  {
    "code": "000094",
    "parent": "000079",
    "tier": 3,
    "title": "도자공예 레슨"
  },
  {
    "code": "000095",
    "parent": "000079",
    "tier": 3,
    "title": "디퓨저/향수 레슨"
  },
  {
    "code": "000096",
    "parent": "000079",
    "tier": 3,
    "title": "리본/포장공예 레슨"
  },
  {
    "code": "000097",
    "parent": "000079",
    "tier": 3,
    "title": "라탄공예 레슨"
  },
  {
    "code": "000098",
    "parent": "000079",
    "tier": 3,
    "title": "매듭공예 레슨"
  },
  {
    "code": "000099",
    "parent": "000079",
    "tier": 3,
    "title": "마크라메 레슨"
  },
  {
    "code": "000100",
    "parent": "000079",
    "tier": 3,
    "title": "스트링아트 레슨"
  },
  {
    "code": "000101",
    "parent": "000079",
    "tier": 3,
    "title": "샌드아트 레슨"
  },
  {
    "code": "000102",
    "parent": "000079",
    "tier": 3,
    "title": "유리공예 레슨"
  },
  {
    "code": "000103",
    "parent": "000079",
    "tier": 3,
    "title": "자수 레슨"
  },
  {
    "code": "000104",
    "parent": "000079",
    "tier": 3,
    "title": "종이공예 레슨"
  },
  {
    "code": "000105",
    "parent": "000079",
    "tier": 3,
    "title": "천연비누/화장품 레슨"
  },
  {
    "code": "000106",
    "parent": "000079",
    "tier": 3,
    "title": "캔들/석고공예 레슨"
  },
  {
    "code": "000107",
    "parent": "000079",
    "tier": 3,
    "title": "캘리그라피 레슨"
  },
  {
    "code": "000108",
    "parent": "000079",
    "tier": 3,
    "title": "펠트공예 레슨"
  },
  {
    "code": "000109",
    "parent": "000079",
    "tier": 3,
    "title": "풍선아트 레슨"
  },
  {
    "code": "000110",
    "parent": "000001",
    "tier": 2,
    "title": "미술"
  },
  {
    "code": "000111",
    "parent": "000110",
    "tier": 3,
    "title": "미술 회화 레슨"
  },
  {
    "code": "000112",
    "parent": "000110",
    "tier": 3,
    "title": "소묘/드로잉 레슨"
  },
  {
    "code": "000113",
    "parent": "000110",
    "tier": 3,
    "title": "디지털 드로잉 레슨"
  },
  {
    "code": "000114",
    "parent": "000110",
    "tier": 3,
    "title": "만화/웹툰/애니 레슨"
  },
  {
    "code": "000115",
    "parent": "000110",
    "tier": 3,
    "title": "서예 레슨"
  },
  {
    "code": "000116",
    "parent": "000110",
    "tier": 3,
    "title": "아동미술 레슨"
  },
  {
    "code": "000117",
    "parent": "000110",
    "tier": 3,
    "title": "클레이아트 레슨"
  },
  {
    "code": "000118",
    "parent": "000110",
    "tier": 3,
    "title": "조소 레슨"
  },
  {
    "code": "000119",
    "parent": "000110",
    "tier": 3,
    "title": "동양화 레슨"
  },
  {
    "code": "000120",
    "parent": "000110",
    "tier": 3,
    "title": "팝아트 레슨"
  },
  {
    "code": "000121",
    "parent": "000110",
    "tier": 3,
    "title": "마카쥬 레슨"
  },
  {
    "code": "000122",
    "parent": "000001",
    "tier": 2,
    "title": "음악이론/보컬"
  },
  {
    "code": "000123",
    "parent": "000122",
    "tier": 3,
    "title": "보컬 레슨"
  },
  {
    "code": "000124",
    "parent": "000122",
    "tier": 3,
    "title": "렙 레슨"
  },
  {
    "code": "000125",
    "parent": "000122",
    "tier": 3,
    "title": "비트박스 레슨"
  },
  {
    "code": "000126",
    "parent": "000122",
    "tier": 3,
    "title": "미디/컴퓨터작곡 레슨"
  },
  {
    "code": "000127",
    "parent": "000122",
    "tier": 3,
    "title": "음향/레코딩 레슨"
  },
  {
    "code": "000128",
    "parent": "000122",
    "tier": 3,
    "title": "디제잉 레슨"
  },
  {
    "code": "000129",
    "parent": "000122",
    "tier": 3,
    "title": "시창청음/화성학 레슨"
  },
  {
    "code": "000130",
    "parent": "000122",
    "tier": 3,
    "title": "작곡/편곡 레슨"
  },
  {
    "code": "000131",
    "parent": "000122",
    "tier": 3,
    "title": "작사 레슨"
  },
  {
    "code": "000132",
    "parent": "000122",
    "tier": 3,
    "title": "성악 레슨"
  },
  {
    "code": "000133",
    "parent": "000122",
    "tier": 3,
    "title": "지휘 레슨"
  },
  {
    "code": "000134",
    "parent": "000122",
    "tier": 3,
    "title": "성우 레슨"
  },
  {
    "code": "000135",
    "parent": "000001",
    "tier": 2,
    "title": "연기/마술"
  },
  {
    "code": "000136",
    "parent": "000135",
    "tier": 3,
    "title": "연출 레슨"
  },
  {
    "code": "000137",
    "parent": "000135",
    "tier": 3,
    "title": "연기 레슨"
  },
  {
    "code": "000138",
    "parent": "000135",
    "tier": 3,
    "title": "뮤지컬 레슨"
  },
  {
    "code": "000139",
    "parent": "000135",
    "tier": 3,
    "title": "마술 레슨"
  },
  {
    "code": "000140",
    "parent": "000001",
    "tier": 2,
    "title": "댄스"
  },
  {
    "code": "000141",
    "parent": "000140",
    "tier": 3,
    "title": "방송댄스 레슨"
  },
  {
    "code": "000142",
    "parent": "000140",
    "tier": 3,
    "title": "스트릿댄스 레슨"
  },
  {
    "code": "000143",
    "parent": "000140",
    "tier": 3,
    "title": "얼반댄스 레슨"
  },
  {
    "code": "000144",
    "parent": "000140",
    "tier": 3,
    "title": "발레 레슨"
  },
  {
    "code": "000145",
    "parent": "000140",
    "tier": 3,
    "title": "현대무용 레슨"
  },
  {
    "code": "000146",
    "parent": "000140",
    "tier": 3,
    "title": "한국무용 레슨"
  },
  {
    "code": "000147",
    "parent": "000140",
    "tier": 3,
    "title": "댄스스포츠 레슨"
  },
  {
    "code": "000148",
    "parent": "000140",
    "tier": 3,
    "title": "밸리댄스 레슨"
  },
  {
    "code": "000149",
    "parent": "000140",
    "tier": 3,
    "title": "바차타댄스 레슨"
  },
  {
    "code": "000150",
    "parent": "000140",
    "tier": 3,
    "title": "살사댄스 레슨"
  },
  {
    "code": "000151",
    "parent": "000140",
    "tier": 3,
    "title": "스윙댄스 레슨"
  },
  {
    "code": "000152",
    "parent": "000140",
    "tier": 3,
    "title": "아르헨티나 탱고 레슨"
  },
  {
    "code": "000153",
    "parent": "000140",
    "tier": 3,
    "title": "재즈댄스 레슨"
  },
  {
    "code": "000154",
    "parent": "000140",
    "tier": 3,
    "title": "줌바댄스 레슨"
  },
  {
    "code": "000155",
    "parent": "000140",
    "tier": 3,
    "title": "라인댄스 레슨"
  },
  {
    "code": "000156",
    "parent": "000140",
    "tier": 3,
    "title": "탭 댄스 레슨"
  },
  {
    "code": "000157",
    "parent": "000140",
    "tier": 3,
    "title": "플라멩코 댄스 레슨"
  },
  {
    "code": "000158",
    "parent": "000140",
    "tier": 3,
    "title": "폴 댄스 레슨"
  },
  {
    "code": "000159",
    "parent": "000140",
    "tier": 3,
    "title": "훌라댄스 레슨"
  },
  {
    "code": "000160",
    "parent": "000001",
    "tier": 2,
    "title": "악기"
  },
  {
    "code": "000161",
    "parent": "000160",
    "tier": 3,
    "title": "피아노/키보드 레슨"
  },
  {
    "code": "000162",
    "parent": "000160",
    "tier": 3,
    "title": "기타 레슨"
  },
  {
    "code": "000163",
    "parent": "000160",
    "tier": 3,
    "title": "베이스기타 레슨"
  },
  {
    "code": "000164",
    "parent": "000160",
    "tier": 3,
    "title": "드럼 레슨"
  },
  {
    "code": "000165",
    "parent": "000160",
    "tier": 3,
    "title": "바이올린 레슨"
  },
  {
    "code": "000166",
    "parent": "000160",
    "tier": 3,
    "title": "비올라 레슨"
  },
  {
    "code": "000167",
    "parent": "000160",
    "tier": 3,
    "title": "첼로 레슨"
  },
  {
    "code": "000168",
    "parent": "000160",
    "tier": 3,
    "title": "콘트라베이스 레슨"
  },
  {
    "code": "000169",
    "parent": "000160",
    "tier": 3,
    "title": "만돌린 레슨"
  },
  {
    "code": "000170",
    "parent": "000160",
    "tier": 3,
    "title": "리코더 레슨"
  },
  {
    "code": "000171",
    "parent": "000160",
    "tier": 3,
    "title": "바순 레슨"
  },
  {
    "code": "000172",
    "parent": "000160",
    "tier": 3,
    "title": "색소폰 레슨"
  },
  {
    "code": "000173",
    "parent": "000160",
    "tier": 3,
    "title": "아코디언 레슨"
  },
  {
    "code": "000174",
    "parent": "000160",
    "tier": 3,
    "title": "오르간 레슨"
  },
  {
    "code": "000175",
    "parent": "000160",
    "tier": 3,
    "title": "오보에 레슨"
  },
  {
    "code": "000176",
    "parent": "000160",
    "tier": 3,
    "title": "오카리나 레슨"
  },
  {
    "code": "000177",
    "parent": "000160",
    "tier": 3,
    "title": "우쿨렐레 레슨"
  },
  {
    "code": "000178",
    "parent": "000160",
    "tier": 3,
    "title": "칼림바 레슨"
  },
  {
    "code": "000179",
    "parent": "000160",
    "tier": 3,
    "title": "클라리넷 레슨"
  },
  {
    "code": "000180",
    "parent": "000160",
    "tier": 3,
    "title": "튜바 레슨"
  },
  {
    "code": "000181",
    "parent": "000160",
    "tier": 3,
    "title": "트럼펫 레슨"
  },
  {
    "code": "000182",
    "parent": "000160",
    "tier": 3,
    "title": "트롬본 레슨"
  },
  {
    "code": "000183",
    "parent": "000160",
    "tier": 3,
    "title": "팬플룻 레슨"
  },
  {
    "code": "000184",
    "parent": "000160",
    "tier": 3,
    "title": "플룻 레슨"
  },
  {
    "code": "000185",
    "parent": "000160",
    "tier": 3,
    "title": "하모니카 레슨"
  },
  {
    "code": "000186",
    "parent": "000160",
    "tier": 3,
    "title": "하프 레슨"
  },
  {
    "code": "000187",
    "parent": "000160",
    "tier": 3,
    "title": "호른 레슨"
  },
  {
    "code": "000188",
    "parent": "000160",
    "tier": 3,
    "title": "타악기 레슨"
  },
  {
    "code": "000189",
    "parent": "000001",
    "tier": 2,
    "title": "국악"
  },
  {
    "code": "000190",
    "parent": "000190",
    "tier": 3,
    "title": "판소리 레슨"
  },
  {
    "code": "000191",
    "parent": "000190",
    "tier": 3,
    "title": "민요 레슨"
  },
  {
    "code": "000192",
    "parent": "000190",
    "tier": 3,
    "title": "정가 레슨"
  },
  {
    "code": "000193",
    "parent": "000190",
    "tier": 3,
    "title": "가야금 레슨"
  },
  {
    "code": "000194",
    "parent": "000190",
    "tier": 3,
    "title": "거문고 레슨"
  },
  {
    "code": "000195",
    "parent": "000190",
    "tier": 3,
    "title": "단소 레슨"
  },
  {
    "code": "000196",
    "parent": "000190",
    "tier": 3,
    "title": "대금 레슨"
  },
  {
    "code": "000197",
    "parent": "000190",
    "tier": 3,
    "title": "소금 레슨"
  },
  {
    "code": "000198",
    "parent": "000190",
    "tier": 3,
    "title": "사물놀이 레슨"
  },
  {
    "code": "000199",
    "parent": "000190",
    "tier": 3,
    "title": "생황 레슨"
  },
  {
    "code": "000200",
    "parent": "000190",
    "tier": 3,
    "title": "아쟁 레슨"
  },
  {
    "code": "000201",
    "parent": "000190",
    "tier": 3,
    "title": "태평소 레슨"
  },
  {
    "code": "000202",
    "parent": "000190",
    "tier": 3,
    "title": "피리 레슨"
  },
  {
    "code": "000203",
    "parent": "000190",
    "tier": 3,
    "title": "해금 레슨"
  },
  {
    "code": "000204",
    "parent": "000001",
    "tier": 2,
    "title": "사진/영상"
  },
  {
    "code": "000205",
    "parent": "000204",
    "tier": 3,
    "title": "사진 촬영/편집 레슨"
  },
  {
    "code": "000206",
    "parent": "000204",
    "tier": 3,
    "title": "영상 촬영/편집 레슨"
  },
  {
    "code": "000207",
    "parent": "000001",
    "tier": 2,
    "title": "취미/생활"
  },
  {
    "code": "000208",
    "parent": "000207",
    "tier": 3,
    "title": "인테리어 기술교육"
  },
  {
    "code": "000209",
    "parent": "000207",
    "tier": 3,
    "title": "드론 레슨"
  },
  {
    "code": "000210",
    "parent": "000207",
    "tier": 3,
    "title": "글쓰기 레슨"
  },
  {
    "code": "000211",
    "parent": "000207",
    "tier": 3,
    "title": "글씨교정 레슨"
  },
  {
    "code": "000212",
    "parent": "000207",
    "tier": 3,
    "title": "수어 레슨"
  },
  {
    "code": "000213",
    "parent": "000207",
    "tier": 3,
    "title": "서예 레슨"
  },
  {
    "code": "000214",
    "parent": "000207",
    "tier": 3,
    "title": "타투이스트 준비"
  },
  {
    "code": "000215",
    "parent": "000207",
    "tier": 3,
    "title": "게임 레슨"
  },
  {
    "code": "000216",
    "parent": "000207",
    "tier": 3,
    "title": "다트 레슨"
  },
  {
    "code": "000217",
    "parent": "000207",
    "tier": 3,
    "title": "큐브 레슨"
  },
  {
    "code": "000218",
    "parent": "000207",
    "tier": 3,
    "title": "저글링 레슨"
  },
  {
    "code": "000219",
    "parent": "000207",
    "tier": 3,
    "title": "바둑 레슨"
  },
  {
    "code": "000220",
    "parent": "000207",
    "tier": 3,
    "title": "장기 레슨"
  },
  {
    "code": "000221",
    "parent": "000207",
    "tier": 3,
    "title": "체스 레슨"
  },
  {
    "code": "000222",
    "parent": "000207",
    "tier": 3,
    "title": "포커 레슨"
  },
  {
    "code": "000223",
    "parent": "000207",
    "tier": 3,
    "title": "타로카드 레슨"
  },
  {
    "code": "000224",
    "parent": "000207",
    "tier": 3,
    "title": "사주/명리학 레슨"
  },
  {
    "code": "000225",
    "parent": "000207",
    "tier": 3,
    "title": "낚시 레슨"
  },
  {
    "code": "000226",
    "parent": "000207",
    "tier": 3,
    "title": "농사 레슨"
  },
  {
    "code": "000227",
    "parent": "000207",
    "tier": 3,
    "title": "다도 레슨"
  },
  {
    "code": "000228",
    "parent": "000207",
    "tier": 3,
    "title": "정리정돈/수납 레슨"
  },
  {
    "code": "000229",
    "parent": "000207",
    "tier": 3,
    "title": "반려동물관리 레슨"
  },
  {
    "code": "000230",
    "parent": "000001",
    "tier": 2,
    "title": "투자/부업/N잡"
  },
  {
    "code": "000231",
    "parent": "000230",
    "tier": 3,
    "title": "유튜브 크리에이터 레슨"
  },
  {
    "code": "000232",
    "parent": "000230",
    "tier": 3,
    "title": "파워블로거 레슨"
  },
  {
    "code": "000233",
    "parent": "000230",
    "tier": 3,
    "title": "주식 레슨"
  },
  {
    "code": "000234",
    "parent": "000230",
    "tier": 3,
    "title": "선물 레슨"
  },
  {
    "code": "000235",
    "parent": "000230",
    "tier": 3,
    "title": "공유숙박 컨설팅(셰어/게스트하우스 등)"
  },
  {
    "code": "000236",
    "parent": "000230",
    "tier": 3,
    "title": "암호화폐 레슨"
  },
  {
    "code": "000237",
    "parent": "000230",
    "tier": 3,
    "title": "재테크/부동산 레슨"
  },
  {
    "code": "000238",
    "parent": "000230",
    "tier": 3,
    "title": "구매대행 레슨"
  },
  {
    "code": "000239",
    "parent": "000230",
    "tier": 3,
    "title": "국내 오픈마켓 컨설팅"
  },
  {
    "code": "000240",
    "parent": "000230",
    "tier": 3,
    "title": "해외 오픈마켓 컨설팅"
  },
  {
    "code": "000241",
    "parent": "000001",
    "tier": 2,
    "title": "요리/조리"
  },
  {
    "code": "000242",
    "parent": "000242",
    "tier": 3,
    "title": "요리/조리 레슨"
  },
  {
    "code": "000243",
    "parent": "000242",
    "tier": 3,
    "title": "푸드카빙 레슨"
  },
  {
    "code": "000244",
    "parent": "000242",
    "tier": 3,
    "title": "베이킹 레슨"
  },
  {
    "code": "000245",
    "parent": "000242",
    "tier": 3,
    "title": "초콜릿 레슨"
  },
  {
    "code": "000246",
    "parent": "000242",
    "tier": 3,
    "title": "커피 레슨"
  },
  {
    "code": "000247",
    "parent": "000242",
    "tier": 3,
    "title": "차(TEA) 레슨"
  },
  {
    "code": "000248",
    "parent": "000242",
    "tier": 3,
    "title": "다도 레슨"
  },
  {
    "code": "000249",
    "parent": "000242",
    "tier": 3,
    "title": "와인 레슨"
  },
  {
    "code": "000250",
    "parent": "000242",
    "tier": 3,
    "title": "위스키 레슨"
  },
  {
    "code": "000251",
    "parent": "000242",
    "tier": 3,
    "title": "칵테일 레슨"
  },
  {
    "code": "000252",
    "parent": "000242",
    "tier": 3,
    "title": "수제맥주 레슨"
  },
  {
    "code": "000253",
    "parent": "000242",
    "tier": 3,
    "title": "전통주 레슨"
  },
  {
    "code": "000254",
    "parent": "000001",
    "tier": 2,
    "title": "스포츠/건강"
  },
  {
    "code": "000255",
    "parent": "000254",
    "tier": 3,
    "title": "퍼스널트레이닝(PT)"
  },
  {
    "code": "000256",
    "parent": "000254",
    "tier": 3,
    "title": "크로스핏"
  },
  {
    "code": "000257",
    "parent": "000254",
    "tier": 3,
    "title": "스피닝"
  },
  {
    "code": "000258",
    "parent": "000254",
    "tier": 3,
    "title": "필라테스"
  },
  {
    "code": "000259",
    "parent": "000254",
    "tier": 3,
    "title": "요가"
  },
  {
    "code": "000260",
    "parent": "000254",
    "tier": 3,
    "title": "골프 레슨"
  },
  {
    "code": "000261",
    "parent": "000254",
    "tier": 3,
    "title": "수영 레슨"
  },
  {
    "code": "000262",
    "parent": "000254",
    "tier": 3,
    "title": "축구 레슨"
  },
  {
    "code": "000263",
    "parent": "000254",
    "tier": 3,
    "title": "볼링 레슨"
  },
  {
    "code": "000264",
    "parent": "000254",
    "tier": 3,
    "title": "당구 레슨"
  },
  {
    "code": "000265",
    "parent": "000254",
    "tier": 3,
    "title": "농구 레슨"
  },
  {
    "code": "000266",
    "parent": "000254",
    "tier": 3,
    "title": "야구 레슨"
  },
  {
    "code": "000267",
    "parent": "000254",
    "tier": 3,
    "title": "족구 레슨"
  },
  {
    "code": "000268",
    "parent": "000254",
    "tier": 3,
    "title": "배구 레슨"
  },
  {
    "code": "000269",
    "parent": "000254",
    "tier": 3,
    "title": "테니스 레슨"
  },
  {
    "code": "000270",
    "parent": "000254",
    "tier": 3,
    "title": "배드민턴 레슨"
  },
  {
    "code": "000271",
    "parent": "000254",
    "tier": 3,
    "title": "탁구 레슨"
  },
  {
    "code": "000272",
    "parent": "000254",
    "tier": 3,
    "title": "스쿼시/라켓볼 레슨"
  },
  {
    "code": "000273",
    "parent": "000254",
    "tier": 3,
    "title": "스케이트보드 레슨"
  },
  {
    "code": "000274",
    "parent": "000254",
    "tier": 3,
    "title": "인라인 스케이트 레슨"
  },
  {
    "code": "000275",
    "parent": "000254",
    "tier": 3,
    "title": "복싱 레슨"
  },
  {
    "code": "000276",
    "parent": "000254",
    "tier": 3,
    "title": "태권도 레슨"
  },
  {
    "code": "000277",
    "parent": "000254",
    "tier": 3,
    "title": "주짓수 레슨"
  },
  {
    "code": "000278",
    "parent": "000254",
    "tier": 3,
    "title": "유도 레슨"
  },
  {
    "code": "000279",
    "parent": "000254",
    "tier": 3,
    "title": "킥복싱/무에타이 레슨"
  },
  {
    "code": "000280",
    "parent": "000254",
    "tier": 3,
    "title": "종합격투기 레슨"
  },
  {
    "code": "000281",
    "parent": "000254",
    "tier": 3,
    "title": "택견 레슨"
  },
  {
    "code": "000282",
    "parent": "000254",
    "tier": 3,
    "title": "호신술 레슨"
  },
  {
    "code": "000283",
    "parent": "000254",
    "tier": 3,
    "title": "합기도 레슨"
  },
  {
    "code": "000284",
    "parent": "000254",
    "tier": 3,
    "title": "중국무술 레슨"
  },
  {
    "code": "000285",
    "parent": "000254",
    "tier": 3,
    "title": "공수도(가라데) 레슨"
  },
  {
    "code": "000286",
    "parent": "000254",
    "tier": 3,
    "title": "마라톤/육상 레슨"
  },
  {
    "code": "000287",
    "parent": "000254",
    "tier": 3,
    "title": "에어로빅 레슨"
  },
  {
    "code": "000288",
    "parent": "000254",
    "tier": 3,
    "title": "체조 레슨"
  },
  {
    "code": "000289",
    "parent": "000254",
    "tier": 3,
    "title": "클라이밍/암벽등반 레슨"
  },
  {
    "code": "000290",
    "parent": "000254",
    "tier": 3,
    "title": "파쿠르 레슨"
  },
  {
    "code": "000291",
    "parent": "000254",
    "tier": 3,
    "title": "펜싱 레슨"
  },
  {
    "code": "000292",
    "parent": "000254",
    "tier": 3,
    "title": "검도 레슨"
  },
  {
    "code": "000293",
    "parent": "000254",
    "tier": 3,
    "title": "쌍절곤 레슨"
  },
  {
    "code": "000294",
    "parent": "000254",
    "tier": 3,
    "title": "사격 레슨"
  },
  {
    "code": "000295",
    "parent": "000254",
    "tier": 3,
    "title": "양궁/국궁 레슨"
  },
  {
    "code": "000296",
    "parent": "000254",
    "tier": 3,
    "title": "자전거/사이클 레슨"
  },
  {
    "code": "000297",
    "parent": "000254",
    "tier": 3,
    "title": "승마 레슨"
  },
  {
    "code": "000298",
    "parent": "000254",
    "tier": 3,
    "title": "음악 줄넘기"
  },
  {
    "code": "000299",
    "parent": "000001",
    "tier": 2,
    "title": "계절스포츠"
  },
  {
    "code": "000300",
    "parent": "000299",
    "tier": 3,
    "title": "스키 강습"
  },
  {
    "code": "000301",
    "parent": "000299",
    "tier": 3,
    "title": "스노우보드 강습"
  },
  {
    "code": "000302",
    "parent": "000299",
    "tier": 3,
    "title": "아이스 스케이트 강습"
  },
  {
    "code": "000303",
    "parent": "000299",
    "tier": 3,
    "title": "카누/카약 강습"
  },
  {
    "code": "000304",
    "parent": "000299",
    "tier": 3,
    "title": "서핑 강습"
  },
  {
    "code": "000305",
    "parent": "000299",
    "tier": 3,
    "title": "수상스키 강습"
  },
  {
    "code": "000306",
    "parent": "000299",
    "tier": 3,
    "title": "프리다이빙 강습"
  },
  {
    "code": "000307",
    "parent": "000299",
    "tier": 3,
    "title": "스쿠버다이빙 강습"
  },
  {
    "code": "000308",
    "parent": "000299",
    "tier": 3,
    "title": "스노클링 강습"
  },
  {
    "code": "000309",
    "parent": "000299",
    "tier": 3,
    "title": "요트 강습"
  },
  {
    "code": "000310",
    "parent": "000299",
    "tier": 3,
    "title": "웨이크보드 강습"
  },
  {
    "code": "000311",
    "parent": "000299",
    "tier": 3,
    "title": "패들보드(SUP) 강습"
  },
  {
    "code": "000312",
    "parent": "000001",
    "tier": 2,
    "title": "실무교육/컴퓨터"
  },
  {
    "code": "000313",
    "parent": "000312",
    "tier": 3,
    "title": "프로그래밍/코딩 레슨"
  },
  {
    "code": "000314",
    "parent": "000312",
    "tier": 3,
    "title": "정보보안 레슨"
  },
  {
    "code": "000315",
    "parent": "000312",
    "tier": 3,
    "title": "컴퓨터 활용 레슨"
  },
  {
    "code": "000316",
    "parent": "000312",
    "tier": 3,
    "title": "프로토타이핑 레슨"
  },
  {
    "code": "000317",
    "parent": "000312",
    "tier": 3,
    "title": "데이터 분석 레슨"
  },
  {
    "code": "000318",
    "parent": "000001",
    "tier": 2,
    "title": "실무교육/디자인"
  },
  {
    "code": "000319",
    "parent": "000318",
    "tier": 3,
    "title": "포토샵 레슨"
  },
  {
    "code": "000320",
    "parent": "000318",
    "tier": 3,
    "title": "일러스트레이터 레슨"
  },
  {
    "code": "000321",
    "parent": "000318",
    "tier": 3,
    "title": "인디자인 레슨"
  },
  {
    "code": "000322",
    "parent": "000318",
    "tier": 3,
    "title": "그래픽디자인 레슨"
  },
  {
    "code": "000323",
    "parent": "000318",
    "tier": 3,
    "title": "UI/UX 디자인 레슨"
  },
  {
    "code": "000324",
    "parent": "000318",
    "tier": 3,
    "title": "3D 모델링/캐드(CAD) 레슨"
  },
  {
    "code": "000325",
    "parent": "000001",
    "tier": 2,
    "title": "실무교육/마케팅"
  },
  {
    "code": "000326",
    "parent": "000325",
    "tier": 3,
    "title": "데이터 분석 레슨"
  },
  {
    "code": "000327",
    "parent": "000325",
    "tier": 3,
    "title": "검색엔진 최적화(SEO) 레슨"
  },
  {
    "code": "000328",
    "parent": "000325",
    "tier": 3,
    "title": "키워드 광고(SEM) 레슨"
  },
  {
    "code": "000329",
    "parent": "000325",
    "tier": 3,
    "title": "콘텐츠/바이럴 마케팅 레슨"
  },
  {
    "code": "000330",
    "parent": "000325",
    "tier": 3,
    "title": "디스플레이 광고 레슨"
  },
  {
    "code": "000331",
    "parent": "000325",
    "tier": 3,
    "title": "페이스북/인스타그램 광고 레슨"
  },
  {
    "code": "000332",
    "parent": "000325",
    "tier": 3,
    "title": "인플루언서 마케팅 레슨"
  },
  {
    "code": "000333",
    "parent": "000325",
    "tier": 3,
    "title": "앱 광고 레슨"
  },
  {
    "code": "000334",
    "parent": "000001",
    "tier": 2,
    "title": "취업준비"
  },
  {
    "code": "000335",
    "parent": "000334",
    "tier": 3,
    "title": "이력서/자소서 컨설팅"
  },
  {
    "code": "000336",
    "parent": "000334",
    "tier": 3,
    "title": "인적성/필기시험 컨설팅"
  },
  {
    "code": "000337",
    "parent": "000334",
    "tier": 3,
    "title": "면접 컨설팅"
  },
  {
    "code": "000338",
    "parent": "000334",
    "tier": 3,
    "title": "스피치 컨설팅"
  },
  {
    "code": "000339",
    "parent": "000334",
    "tier": 3,
    "title": "취업 컨설팅"
  },
  {
    "code": "000340",
    "parent": "000334",
    "tier": 3,
    "title": "해외 취업 컨설팅"
  },
  {
    "code": "000341",
    "parent": "000334",
    "tier": 3,
    "title": "커리어 컨설팅"
  },
  {
    "code": "000342",
    "parent": "000334",
    "tier": 3,
    "title": "포트폴리오 컨설팅"
  },
  {
    "code": "000343",
    "parent": "000334",
    "tier": 3,
    "title": "쇼호스트 준비"
  },
  {
    "code": "000344",
    "parent": "000334",
    "tier": 3,
    "title": "승무원 준비"
  },
  {
    "code": "000345",
    "parent": "000334",
    "tier": 3,
    "title": "GSAT 과외"
  },
  {
    "code": "000346",
    "parent": "000001",
    "tier": 2,
    "title": "시험/자격증"
  },
  {
    "code": "000347",
    "parent": "000346",
    "tier": 3,
    "title": "공무원 시험 준비"
  },
  {
    "code": "000348",
    "parent": "000346",
    "tier": 3,
    "title": "공인중개사 준비"
  },
  {
    "code": "000349",
    "parent": "000346",
    "tier": 3,
    "title": "교원 임용시험 준비"
  },
  {
    "code": "000350",
    "parent": "000346",
    "tier": 3,
    "title": "간호사 준비"
  },
  {
    "code": "000351",
    "parent": "000346",
    "tier": 3,
    "title": "타투이스트 준비"
  },
  {
    "code": "000352",
    "parent": "000346",
    "tier": 3,
    "title": "건강운동관리사 준비"
  },
  {
    "code": "000353",
    "parent": "000346",
    "tier": 3,
    "title": "관세사 준비"
  },
  {
    "code": "000354",
    "parent": "000346",
    "tier": 3,
    "title": "관광통역안내사 준비"
  },
  {
    "code": "000355",
    "parent": "000346",
    "tier": 3,
    "title": "경비지도사 준비"
  },
  {
    "code": "000356",
    "parent": "000346",
    "tier": 3,
    "title": "노무사 준비"
  },
  {
    "code": "000357",
    "parent": "000346",
    "tier": 3,
    "title": "대기환경(산업)기사 준비"
  },
  {
    "code": "000358",
    "parent": "000346",
    "tier": 3,
    "title": "변리사 준비"
  },
  {
    "code": "000359",
    "parent": "000346",
    "tier": 3,
    "title": "보세사 준비"
  },
  {
    "code": "000360",
    "parent": "000346",
    "tier": 3,
    "title": "비서 준비"
  },
  {
    "code": "000361",
    "parent": "000346",
    "tier": 3,
    "title": "사회복지사 준비"
  },
  {
    "code": "000362",
    "parent": "000346",
    "tier": 3,
    "title": "세무사 준비"
  },
  {
    "code": "000363",
    "parent": "000346",
    "tier": 3,
    "title": "속기사 준비"
  },
  {
    "code": "000364",
    "parent": "000346",
    "tier": 3,
    "title": "손해사정사 준비"
  },
  {
    "code": "000365",
    "parent": "000346",
    "tier": 3,
    "title": "수질환경(산업)기사 준비"
  },
  {
    "code": "000366",
    "parent": "000346",
    "tier": 3,
    "title": "스포츠지도사 준비"
  },
  {
    "code": "000367",
    "parent": "000346",
    "tier": 3,
    "title": "언론사 준비"
  },
  {
    "code": "000368",
    "parent": "000346",
    "tier": 3,
    "title": "용접사 준비"
  },
  {
    "code": "000369",
    "parent": "000346",
    "tier": 3,
    "title": "유통관리사 준비"
  },
  {
    "code": "000370",
    "parent": "000346",
    "tier": 3,
    "title": "일반기계기사 준비"
  },
  {
    "code": "000371",
    "parent": "000346",
    "tier": 3,
    "title": "재무분석사(CFA) 준비"
  },
  {
    "code": "000372",
    "parent": "000346",
    "tier": 3,
    "title": "재무위험관리사(FRM) 준비"
  },
  {
    "code": "000373",
    "parent": "000346",
    "tier": 3,
    "title": "전기기사 준비"
  },
  {
    "code": "000374",
    "parent": "000346",
    "tier": 3,
    "title": "전산세무회계 준비"
  },
  {
    "code": "000375",
    "parent": "000346",
    "tier": 3,
    "title": "전자상거래관리사/운용사 준비"
  },
  {
    "code": "000376",
    "parent": "000346",
    "tier": 3,
    "title": "정보보안 레슨"
  },
  {
    "code": "000377",
    "parent": "000346",
    "tier": 3,
    "title": "정보처리기사 준비"
  },
  {
    "code": "000378",
    "parent": "000346",
    "tier": 3,
    "title": "컴퓨터활용능력 준비"
  },
  {
    "code": "000379",
    "parent": "000346",
    "tier": 3,
    "title": "토양환경기사 준비"
  },
  {
    "code": "000380",
    "parent": "000346",
    "tier": 3,
    "title": "폐기물처리(산업)기사 준비"
  },
  {
    "code": "000381",
    "parent": "000346",
    "tier": 3,
    "title": "퍼스널컬러자격증 준비"
  },
  {
    "code": "000382",
    "parent": "000346",
    "tier": 3,
    "title": "한국사능력검정 준비"
  },
  {
    "code": "000383",
    "parent": "000346",
    "tier": 3,
    "title": "한국어능력시험 준비"
  },
  {
    "code": "000384",
    "parent": "000346",
    "tier": 3,
    "title": "회계사(CPA) 준비"
  },
  {
    "code": "000385",
    "parent": "000346",
    "tier": 3,
    "title": "MOS(MCAS) 준비"
  },
  {
    "code": "000386",
    "parent": "000346",
    "tier": 3,
    "title": "반려동물관리 레슨"
  },
  {
    "code": "000387",
    "parent": "000001",
    "tier": 2,
    "title": "패션/뷰티"
  },
  {
    "code": "000388",
    "parent": "000387",
    "tier": 3,
    "title": "뷰티/미용 레슨"
  },
  {
    "code": "000389",
    "parent": "000387",
    "tier": 3,
    "title": "패션디자인 레슨"
  },
  {
    "code": "000390",
    "parent": "000387",
    "tier": 3,
    "title": "모델 레슨"
  },
  {
    "code": "000391",
    "parent": "000387",
    "tier": 3,
    "title": "퍼스널컬러자격증 준비"
  },
  {
    "code": "000392",
    "parent": "",
    "tier": 1,
    "title": "홈/리빙"
  },
  {
    "code": "000393",
    "parent": "000392",
    "tier": 2,
    "title": "이사"
  },
  {
    "code": "000394",
    "parent": "000393",
    "tier": 3,
    "title": "원룸/소형 이사"
  },
  {
    "code": "000395",
    "parent": "000393",
    "tier": 3,
    "title": "용달/화물 운송"
  },
  {
    "code": "000396",
    "parent": "000393",
    "tier": 3,
    "title": "국내 이사"
  },
  {
    "code": "000397",
    "parent": "000393",
    "tier": 3,
    "title": "가정이사(투룸 이상)"
  },
  {
    "code": "000398",
    "parent": "000393",
    "tier": 3,
    "title": "사무실/상업공간 이사"
  },
  {
    "code": "000399",
    "parent": "000393",
    "tier": 3,
    "title": "짐 보관"
  },
  {
    "code": "000400",
    "parent": "000393",
    "tier": 3,
    "title": "무진동차량/냉동차량/냉장차량"
  },
  {
    "code": "000401",
    "parent": "000392",
    "tier": 2,
    "title": "청소 업체"
  },
  {
    "code": "000402",
    "parent": "000401",
    "tier": 3,
    "title": "이사/입주 청소 업체"
  },
  {
    "code": "000403",
    "parent": "000401",
    "tier": 3,
    "title": "에어컨 청소"
  },
  {
    "code": "000404",
    "parent": "000401",
    "tier": 3,
    "title": "거주 청소 업체"
  },
  {
    "code": "000405",
    "parent": "000401",
    "tier": 3,
    "title": "세탁기 청소"
  },
  {
    "code": "000406",
    "parent": "000401",
    "tier": 3,
    "title": "정리수납 컨설팅"
  },
  {
    "code": "000407",
    "parent": "000401",
    "tier": 3,
    "title": "줄눈 시공"
  },
  {
    "code": "000408",
    "parent": "000401",
    "tier": 3,
    "title": "해충방역"
  },
  {
    "code": "000409",
    "parent": "000401",
    "tier": 3,
    "title": "누수 탐지"
  },
  {
    "code": "000410",
    "parent": "000401",
    "tier": 3,
    "title": "침대/매트리스 청소"
  },
  {
    "code": "000411",
    "parent": "000401",
    "tier": 3,
    "title": "사무실/상업공간 청소 업체"
  },
  {
    "code": "000412",
    "parent": "000401",
    "tier": 3,
    "title": "바퀴벌레 퇴치"
  },
  {
    "code": "000413",
    "parent": "000401",
    "tier": 3,
    "title": "곰팡이 제거"
  },
  {
    "code": "000414",
    "parent": "000401",
    "tier": 3,
    "title": "하수구 청소"
  },
  {
    "code": "000415",
    "parent": "000401",
    "tier": 3,
    "title": "소파 청소"
  },
  {
    "code": "000416",
    "parent": "000401",
    "tier": 3,
    "title": "냉장고 청소"
  },
  {
    "code": "000417",
    "parent": "000401",
    "tier": 3,
    "title": "시스템에어컨 청소"
  },
  {
    "code": "000418",
    "parent": "000401",
    "tier": 3,
    "title": "계단/화장실 청소"
  },
  {
    "code": "000419",
    "parent": "000401",
    "tier": 3,
    "title": "비둘기 퇴치"
  },
  {
    "code": "000420",
    "parent": "000401",
    "tier": 3,
    "title": "건물 외부 청소(외벽/유리창)"
  },
  {
    "code": "000421",
    "parent": "000401",
    "tier": 3,
    "title": "단열/결로 시공"
  },
  {
    "code": "000422",
    "parent": "000401",
    "tier": 3,
    "title": "보일러/수도 배관 청소"
  },
  {
    "code": "000423",
    "parent": "000401",
    "tier": 3,
    "title": "가전제품 청소"
  },
  {
    "code": "000424",
    "parent": "000401",
    "tier": 3,
    "title": "악취 제거"
  },
  {
    "code": "000425",
    "parent": "000401",
    "tier": 3,
    "title": "후드 청소"
  },
  {
    "code": "000426",
    "parent": "000401",
    "tier": 3,
    "title": "바닥 청소(왁스 코팅)"
  },
  {
    "code": "000427",
    "parent": "000401",
    "tier": 3,
    "title": "카페트 청소"
  },
  {
    "code": "000428",
    "parent": "000401",
    "tier": 3,
    "title": "건물 내부 청소(바닥/계단/화장실)"
  },
  {
    "code": "000429",
    "parent": "000401",
    "tier": 3,
    "title": "새집/헌집증후군 시공"
  },
  {
    "code": "000430",
    "parent": "000401",
    "tier": 3,
    "title": "방역소독"
  },
  {
    "code": "000431",
    "parent": "000401",
    "tier": 3,
    "title": "준공 청소"
  },
  {
    "code": "000432",
    "parent": "000401",
    "tier": 3,
    "title": "단체 세탁"
  },
  {
    "code": "000433",
    "parent": "000401",
    "tier": 3,
    "title": "실외기 청소"
  },
  {
    "code": "000434",
    "parent": "000401",
    "tier": 3,
    "title": "시설/건물 관리"
  },
  {
    "code": "000435",
    "parent": "000401",
    "tier": 3,
    "title": "입주 사전점검 대행"
  },
  {
    "code": "000436",
    "parent": "000401",
    "tier": 3,
    "title": "비데 렌탈/구입/청소"
  },
  {
    "code": "000437",
    "parent": "000401",
    "tier": 3,
    "title": "유품정리/특수 청소"
  },
  {
    "code": "000438",
    "parent": "000401",
    "tier": 3,
    "title": "화재 복구/청소"
  },
  {
    "code": "000439",
    "parent": "000401",
    "tier": 3,
    "title": "닥트/환풍구 청소"
  },
  {
    "code": "000440",
    "parent": "000401",
    "tier": 3,
    "title": "온풍기/냉난방기 청소"
  },
  {
    "code": "000441",
    "parent": "000401",
    "tier": 3,
    "title": "물탱크/저수조 청소"
  },
  {
    "code": "000442",
    "parent": "000401",
    "tier": 3,
    "title": "가구 청소"
  },
  {
    "code": "000443",
    "parent": "000401",
    "tier": 3,
    "title": "어항/수족관 제작 및 관리"
  },
  {
    "code": "000444",
    "parent": "000401",
    "tier": 3,
    "title": "침수 복구/청소"
  },
  {
    "code": "000445",
    "parent": "000401",
    "tier": 3,
    "title": "수질 관리/녹조 제거"
  },
  {
    "code": "000446",
    "parent": "000401",
    "tier": 3,
    "title": "라돈 저감 시공"
  },
  {
    "code": "000447",
    "parent": "000401",
    "tier": 3,
    "title": "대기 측정/관리"
  },
  {
    "code": "000448",
    "parent": "000392",
    "tier": 2,
    "title": "인테리어"
  },
  {
    "code": "000449",
    "parent": "000448",
    "tier": 3,
    "title": "집 인테리어"
  },
  {
    "code": "000450",
    "parent": "000448",
    "tier": 3,
    "title": "상업공간 인테리어"
  },
  {
    "code": "000451",
    "parent": "000448",
    "tier": 3,
    "title": "아파트 인테리어"
  },
  {
    "code": "000452",
    "parent": "000448",
    "tier": 3,
    "title": "조명 인테리어"
  },
  {
    "code": "000453",
    "parent": "000448",
    "tier": 3,
    "title": "욕실/화장실 리모델링"
  },
  {
    "code": "000454",
    "parent": "000448",
    "tier": 3,
    "title": "주택 건축"
  },
  {
    "code": "000455",
    "parent": "000448",
    "tier": 3,
    "title": "주택 리모델링"
  },
  {
    "code": "000456",
    "parent": "000448",
    "tier": 3,
    "title": "집 수리"
  },
  {
    "code": "000457",
    "parent": "000448",
    "tier": 3,
    "title": "홈 스타일링"
  },
  {
    "code": "000458",
    "parent": "000448",
    "tier": 3,
    "title": "미술품 구매 및 렌탈"
  },
  {
    "code": "000459",
    "parent": "000448",
    "tier": 3,
    "title": "식물 관리/렌탈"
  },
  {
    "code": "000460",
    "parent": "000448",
    "tier": 3,
    "title": "미장 시공"
  },
  {
    "code": "000461",
    "parent": "000448",
    "tier": 3,
    "title": "도배 시공"
  },
  {
    "code": "000462",
    "parent": "000448",
    "tier": 3,
    "title": "장판 시공"
  },
  {
    "code": "000463",
    "parent": "000448",
    "tier": 3,
    "title": "도배장판 시공"
  },
  {
    "code": "000464",
    "parent": "000448",
    "tier": 3,
    "title": "인테리어 필름 시공"
  },
  {
    "code": "000465",
    "parent": "000448",
    "tier": 3,
    "title": "페인트 시공"
  },
  {
    "code": "000466",
    "parent": "000448",
    "tier": 3,
    "title": "아트월 시공"
  },
  {
    "code": "000467",
    "parent": "000448",
    "tier": 3,
    "title": "타일 시공"
  },
  {
    "code": "000468",
    "parent": "000448",
    "tier": 3,
    "title": "줄눈 시공"
  },
  {
    "code": "000469",
    "parent": "000448",
    "tier": 3,
    "title": "나노코팅 시공"
  },
  {
    "code": "000470",
    "parent": "000448",
    "tier": 3,
    "title": "수영장/스파 시공"
  },
  {
    "code": "000471",
    "parent": "000448",
    "tier": 3,
    "title": "주방 리모델링"
  },
  {
    "code": "000472",
    "parent": "000448",
    "tier": 3,
    "title": "주방후드 교체/설치"
  },
  {
    "code": "000473",
    "parent": "000448",
    "tier": 3,
    "title": "닥트 설치 및 수리"
  },
  {
    "code": "000474",
    "parent": "000448",
    "tier": 3,
    "title": "환풍기 교체/설치"
  },
  {
    "code": "000475",
    "parent": "000448",
    "tier": 3,
    "title": "싱크대 교체"
  },
  {
    "code": "000476",
    "parent": "000448",
    "tier": 3,
    "title": "빨래건조대 설치 및 수리"
  },
  {
    "code": "000477",
    "parent": "000448",
    "tier": 3,
    "title": "마루 시공"
  },
  {
    "code": "000478",
    "parent": "000448",
    "tier": 3,
    "title": "마루 보수"
  },
  {
    "code": "000479",
    "parent": "000448",
    "tier": 3,
    "title": "바닥재 시공"
  },
  {
    "code": "000480",
    "parent": "000448",
    "tier": 3,
    "title": "에폭시 바닥 시공"
  },
  {
    "code": "000481",
    "parent": "000448",
    "tier": 3,
    "title": "카페트 시공"
  },
  {
    "code": "000482",
    "parent": "000448",
    "tier": 3,
    "title": "층간소음매트 시공"
  },
  {
    "code": "000483",
    "parent": "000448",
    "tier": 3,
    "title": "방음 시공"
  },
  {
    "code": "000484",
    "parent": "000448",
    "tier": 3,
    "title": "가벽/파티션 인테리어"
  },
  {
    "code": "000485",
    "parent": "000448",
    "tier": 3,
    "title": "칸막이 시공"
  },
  {
    "code": "000486",
    "parent": "000448",
    "tier": 3,
    "title": "중문 시공"
  },
  {
    "code": "000487",
    "parent": "000448",
    "tier": 3,
    "title": "몰딩 시공"
  },
  {
    "code": "000488",
    "parent": "000448",
    "tier": 3,
    "title": "베란다/발코니 확장"
  },
  {
    "code": "000489",
    "parent": "000448",
    "tier": 3,
    "title": "단열/결로 시공"
  },
  {
    "code": "000490",
    "parent": "000448",
    "tier": 3,
    "title": "탄성/바이오세라믹 코트"
  },
  {
    "code": "000491",
    "parent": "000448",
    "tier": 3,
    "title": "코킹 시공"
  },
  {
    "code": "000492",
    "parent": "000448",
    "tier": 3,
    "title": "수납 가구 제작(신발장/붙박이장 등)"
  },
  {
    "code": "000493",
    "parent": "000448",
    "tier": 3,
    "title": "신발장 시공"
  },
  {
    "code": "000494",
    "parent": "000448",
    "tier": 3,
    "title": "붙박이장 시공"
  },
  {
    "code": "000495",
    "parent": "000448",
    "tier": 3,
    "title": "가구 리폼"
  },
  {
    "code": "000496",
    "parent": "000448",
    "tier": 3,
    "title": "벽난로 설치/수리"
  },
  {
    "code": "000497",
    "parent": "000448",
    "tier": 3,
    "title": "앙카/해먹 설치"
  },
  {
    "code": "000498",
    "parent": "000448",
    "tier": 3,
    "title": "에어컨튼 설치"
  },
  {
    "code": "000499",
    "parent": "000448",
    "tier": 3,
    "title": "핸드레일 설치 및 수리"
  },
  {
    "code": "000500",
    "parent": "000448",
    "tier": 3,
    "title": "소방설비 설치 및 수리"
  },
  {
    "code": "000501",
    "parent": "000448",
    "tier": 3,
    "title": "체육시설/운동기구 설치"
  },
  {
    "code": "000502",
    "parent": "000448",
    "tier": 3,
    "title": "업소용 주방기구 구매"
  },
  {
    "code": "000503",
    "parent": "000448",
    "tier": 3,
    "title": "업소용 주방기구 판매"
  },
  {
    "code": "000504",
    "parent": "000392",
    "tier": 2,
    "title": "야외 시공"
  },
  {
    "code": "000505",
    "parent": "000504",
    "tier": 3,
    "title": "간판 제작"
  },
  {
    "code": "000506",
    "parent": "000504",
    "tier": 3,
    "title": "고보라이트 제작/설치"
  },
  {
    "code": "000507",
    "parent": "000504",
    "tier": 3,
    "title": "벽화 시공"
  },
  {
    "code": "000508",
    "parent": "000504",
    "tier": 3,
    "title": "외벽 리모델링"
  },
  {
    "code": "000509",
    "parent": "000504",
    "tier": 3,
    "title": "옥상공사/방수"
  },
  {
    "code": "000510",
    "parent": "000504",
    "tier": 3,
    "title": "지붕 공사"
  },
  {
    "code": "000511",
    "parent": "000504",
    "tier": 3,
    "title": "조경 공사"
  },
  {
    "code": "000512",
    "parent": "000504",
    "tier": 3,
    "title": "어닝/차양 시공"
  },
  {
    "code": "000513",
    "parent": "000504",
    "tier": 3,
    "title": "테크 시공"
  },
  {
    "code": "000514",
    "parent": "000504",
    "tier": 3,
    "title": "인조잔디 시공"
  },
  {
    "code": "000515",
    "parent": "000504",
    "tier": 3,
    "title": "수영장/스파 시공"
  },
  {
    "code": "000516",
    "parent": "000504",
    "tier": 3,
    "title": "조형물 시공"
  },
  {
    "code": "000517",
    "parent": "000504",
    "tier": 3,
    "title": "LED 제작"
  },
  {
    "code": "000518",
    "parent": "000504",
    "tier": 3,
    "title": "용접 시공"
  },
  {
    "code": "000519",
    "parent": "000504",
    "tier": 3,
    "title": "집진기 설치/수리"
  },
  {
    "code": "000520",
    "parent": "000504",
    "tier": 3,
    "title": "대형천막 시공"
  },
  {
    "code": "000521",
    "parent": "000504",
    "tier": 3,
    "title": "비닐하우스 시공"
  },
  {
    "code": "000522",
    "parent": "000504",
    "tier": 3,
    "title": "정화조 설치 및 수리"
  },
  {
    "code": "000523",
    "parent": "000504",
    "tier": 3,
    "title": "장애인 편의시설 설치"
  },
  {
    "code": "000524",
    "parent": "000504",
    "tier": 3,
    "title": "체육시설/운동기구 설치"
  },
  {
    "code": "000525",
    "parent": "000504",
    "tier": 3,
    "title": "그물망 설치(안정망/스포츠망 등)"
  },
  {
    "code": "000526",
    "parent": "000504",
    "tier": 3,
    "title": "주차시스템 설치(차단기/차량인식기 등)"
  },
  {
    "code": "000527",
    "parent": "000504",
    "tier": 3,
    "title": "전기차 충전기 설치/수리"
  },
  {
    "code": "000528",
    "parent": "000504",
    "tier": 3,
    "title": "대문자바라 설치"
  },
  {
    "code": "000529",
    "parent": "000504",
    "tier": 3,
    "title": "스테인레스 제작(자전거 거치대, 국기게양대)"
  },
  {
    "code": "000530",
    "parent": "000504",
    "tier": 3,
    "title": "아스팔트/콘크리트 시공"
  },
  {
    "code": "000531",
    "parent": "000504",
    "tier": 3,
    "title": "차선 도색/제거"
  },
  {
    "code": "000532",
    "parent": "000504",
    "tier": 3,
    "title": "굴착기 대여"
  },
  {
    "code": "000533",
    "parent": "000504",
    "tier": 3,
    "title": "벌초/예초"
  },
  {
    "code": "000534",
    "parent": "000392",
    "tier": 2,
    "title": "부동산"
  },
  {
    "code": "000535",
    "parent": "000534",
    "tier": 3,
    "title": "집 사기"
  },
  {
    "code": "000536",
    "parent": "000534",
    "tier": 3,
    "title": "집 팔기"
  },
  {
    "code": "000537",
    "parent": "000534",
    "tier": 3,
    "title": "감정평가"
  },
  {
    "code": "000538",
    "parent": "000534",
    "tier": 3,
    "title": "집 전세/월세 구하기"
  },
  {
    "code": "000539",
    "parent": "000534",
    "tier": 3,
    "title": "집 전세/월세 내놓기"
  },
  {
    "code": "000540",
    "parent": "000534",
    "tier": 3,
    "title": "사무실 임대"
  },
  {
    "code": "000541",
    "parent": "000392",
    "tier": 2,
    "title": "철거/정리"
  },
  {
    "code": "000542",
    "parent": "000541",
    "tier": 3,
    "title": "철거"
  },
  {
    "code": "000543",
    "parent": "000541",
    "tier": 3,
    "title": "폐기물 처리"
  },
  {
    "code": "000544",
    "parent": "000541",
    "tier": 3,
    "title": "정리수납 컨설팅"
  },
  {
    "code": "000545",
    "parent": "000392",
    "tier": 2,
    "title": "펫/반려동물"
  },
  {
    "code": "000546",
    "parent": "000545",
    "tier": 3,
    "title": "반려동물 훈련"
  },
  {
    "code": "000547",
    "parent": "000545",
    "tier": 3,
    "title": "반려견 산책"
  },
  {
    "code": "000548",
    "parent": "000545",
    "tier": 3,
    "title": "펫 호텔"
  },
  {
    "code": "000549",
    "parent": "000545",
    "tier": 3,
    "title": "펫 시터(주인 집에서)"
  },
  {
    "code": "000550",
    "parent": "000545",
    "tier": 3,
    "title": "펫 시터(시터 집에서)"
  },
  {
    "code": "000551",
    "parent": "000545",
    "tier": 3,
    "title": "펫 미용"
  },
  {
    "code": "000552",
    "parent": "000545",
    "tier": 3,
    "title": "펫 미용용품 만들기 레슨"
  },
  {
    "code": "000553",
    "parent": "000545",
    "tier": 3,
    "title": "펫 사료/간식 만들기 레슨"
  },
  {
    "code": "000554",
    "parent": "000545",
    "tier": 3,
    "title": "펫 미용용품 제작"
  },
  {
    "code": "000555",
    "parent": "000545",
    "tier": 3,
    "title": "펫 사료/간식 제작"
  },
  {
    "code": "000556",
    "parent": "000545",
    "tier": 3,
    "title": "펫 홈 클리닝"
  },
  {
    "code": "000557",
    "parent": "000545",
    "tier": 3,
    "title": "반려동물 장례"
  },
  {
    "code": "000558",
    "parent": "000545",
    "tier": 3,
    "title": "반려동물관리 레슨"
  },
  {
    "code": "000559",
    "parent": "000392",
    "tier": 2,
    "title": "문/창문"
  },
  {
    "code": "000560",
    "parent": "000559",
    "tier": 3,
    "title": "문 설치 및 수리"
  },
  {
    "code": "000561",
    "parent": "000559",
    "tier": 3,
    "title": "도어 시공"
  },
  {
    "code": "000562",
    "parent": "000559",
    "tier": 3,
    "title": "중문 시공"
  },
  {
    "code": "000563",
    "parent": "000559",
    "tier": 3,
    "title": "샷시 설치 및 수리"
  },
  {
    "code": "000564",
    "parent": "000559",
    "tier": 3,
    "title": "외풍차단/틈막이 시공"
  },
  {
    "code": "000565",
    "parent": "000559",
    "tier": 3,
    "title": "유리 제작 및 시공"
  },
  {
    "code": "000566",
    "parent": "000559",
    "tier": 3,
    "title": "유리 필름/시트 시공"
  },
  {
    "code": "000567",
    "parent": "000559",
    "tier": 3,
    "title": "단열필름 시공"
  },
  {
    "code": "000568",
    "parent": "000559",
    "tier": 3,
    "title": "블라인드/커튼 제작/설치/수리"
  },
  {
    "code": "000569",
    "parent": "000559",
    "tier": 3,
    "title": "방충망 설치 및 수리"
  },
  {
    "code": "000570",
    "parent": "000559",
    "tier": 3,
    "title": "방범창 설치 및 수리"
  },
  {
    "code": "000571",
    "parent": "000559",
    "tier": 3,
    "title": "열쇠/도어락 설치 및 수리"
  },
  {
    "code": "000572",
    "parent": "000392",
    "tier": 2,
    "title": "수도/보일러/전기"
  },
  {
    "code": "000573",
    "parent": "000572",
    "tier": 3,
    "title": "누수 탐지"
  },
  {
    "code": "000574",
    "parent": "000572",
    "tier": 3,
    "title": "수도 관련 설치 및 수리"
  },
  {
    "code": "000575",
    "parent": "000572",
    "tier": 3,
    "title": "보일러 설치 및 수리"
  },
  {
    "code": "000576",
    "parent": "000572",
    "tier": 3,
    "title": "온수기 설치 및 수리"
  },
  {
    "code": "000577",
    "parent": "000572",
    "tier": 3,
    "title": "전기 배선 설치 및 수리"
  },
  {
    "code": "000578",
    "parent": "000572",
    "tier": 3,
    "title": "인터넷/랜 공사"
  },
  {
    "code": "000579",
    "parent": "000572",
    "tier": 3,
    "title": "랜선 정리"
  },
  {
    "code": "000580",
    "parent": "000572",
    "tier": 3,
    "title": "도시가스 공사"
  },
  {
    "code": "000581",
    "parent": "000572",
    "tier": 3,
    "title": "승강기 유지보수"
  },
  {
    "code": "000582",
    "parent": "000572",
    "tier": 3,
    "title": "태양광발전/패널 설치"
  },
  {
    "code": "000583",
    "parent": "000392",
    "tier": 2,
    "title": "가전제품"
  },
  {
    "code": "000584",
    "parent": "000583",
    "tier": 3,
    "title": "휴대폰/태블릿/스마트기기 수리"
  },
  {
    "code": "000585",
    "parent": "000583",
    "tier": 3,
    "title": "전자제품 수리"
  },
  {
    "code": "000586",
    "parent": "000583",
    "tier": 3,
    "title": "에어컨 설치 및 수리"
  },
  {
    "code": "000587",
    "parent": "000583",
    "tier": 3,
    "title": "냉장고 설치 및 수리"
  },
  {
    "code": "000588",
    "parent": "000583",
    "tier": 3,
    "title": "세탁기 설치 및 수리"
  },
  {
    "code": "000589",
    "parent": "000583",
    "tier": 3,
    "title": "벽걸이TV 설치 및 철거"
  },
  {
    "code": "000590",
    "parent": "000583",
    "tier": 3,
    "title": "인덕션(전기레인지) 설치"
  },
  {
    "code": "000591",
    "parent": "000583",
    "tier": 3,
    "title": "식기세척기 설치/수리"
  },
  {
    "code": "000592",
    "parent": "000583",
    "tier": 3,
    "title": "음식물처리기 설치 및 수리"
  },
  {
    "code": "000593",
    "parent": "000583",
    "tier": 3,
    "title": "비데 렌탈/구입/청소"
  },
  {
    "code": "000594",
    "parent": "000583",
    "tier": 3,
    "title": "핸드드라이어 설치/수리"
  },
  {
    "code": "000595",
    "parent": "000583",
    "tier": 3,
    "title": "음향/영상기기 설치"
  },
  {
    "code": "000596",
    "parent": "000583",
    "tier": 3,
    "title": "CCTV 설치"
  },
  {
    "code": "000597",
    "parent": "000583",
    "tier": 3,
    "title": "IoT 설치"
  },
  {
    "code": "000598",
    "parent": "000583",
    "tier": 3,
    "title": "컴퓨터 수리"
  },
  {
    "code": "000599",
    "parent": "000583",
    "tier": 3,
    "title": "조립PC 구매"
  },
  {
    "code": "000600",
    "parent": "000583",
    "tier": 3,
    "title": "아이폰 수리"
  },
  {
    "code": "000601",
    "parent": "000583",
    "tier": 3,
    "title": "신규 핸드폰구매"
  },
  {
    "code": "000602",
    "parent": "000583",
    "tier": 3,
    "title": "알뜰폰/선불폰 개통"
  },
  {
    "code": "000603",
    "parent": "000583",
    "tier": 3,
    "title": "전동킥보드/전동휠 수리"
  },
  {
    "code": "000604",
    "parent": "000392",
    "tier": 2,
    "title": "가구"
  },
  {
    "code": "000605",
    "parent": "000604",
    "tier": 3,
    "title": "수납 가구 제작(신발장/붙박이장 등)"
  },
  {
    "code": "000606",
    "parent": "000604",
    "tier": 3,
    "title": "붙박이장 시공"
  },
  {
    "code": "000607",
    "parent": "000604",
    "tier": 3,
    "title": "가구/목공예 제작"
  },
  {
    "code": "000608",
    "parent": "000604",
    "tier": 3,
    "title": "가구 수리"
  },
  {
    "code": "000609",
    "parent": "000604",
    "tier": 3,
    "title": "가구 리폼"
  },
  {
    "code": "000610",
    "parent": "000604",
    "tier": 3,
    "title": "피아노 운반"
  },
  {
    "code": "000611",
    "parent": "000604",
    "tier": 3,
    "title": "가구 조립/설치"
  },
  {
    "code": "000612",
    "parent": "000604",
    "tier": 3,
    "title": "피아노 조율/수리"
  },
  {
    "code": "000613",
    "parent": "000604",
    "tier": 3,
    "title": "신발장 시공"
  },
  {
    "code": "000614",
    "parent": "000604",
    "tier": 3,
    "title": "가구 이동/재배치"
  },
  {
    "code": "000615",
    "parent": "000604",
    "tier": 3,
    "title": "악기 조율/수리"
  },
  {
    "code": "000616",
    "parent": "000604",
    "tier": 3,
    "title": "액자 제작"
  },
  {
    "code": "000617",
    "parent": "000604",
    "tier": 3,
    "title": "도금(가구/설비/조형물 등)"
  },
  {
    "code": "000618",
    "parent": "000604",
    "tier": 3,
    "title": "수제악기 제작"
  },
  {
    "code": "000619",
    "parent": "000392",
    "tier": 2,
    "title": "도우미"
  },
  {
    "code": "000620",
    "parent": "000619",
    "tier": 3,
    "title": "가사 도우미"
  },
  {
    "code": "000621",
    "parent": "000619",
    "tier": 3,
    "title": "등하원 도우미"
  },
  {
    "code": "000622",
    "parent": "000619",
    "tier": 3,
    "title": "집 청소 도우미"
  },
  {
    "code": "000623",
    "parent": "000619",
    "tier": 3,
    "title": "산후/육아/아이돌보미"
  },
  {
    "code": "000624",
    "parent": "000619",
    "tier": 3,
    "title": "실버/간병 도우미"
  },
  {
    "code": "000625",
    "parent": "000619",
    "tier": 3,
    "title": "요리 도우미"
  },
  {
    "code": "000626",
    "parent": "000619",
    "tier": 3,
    "title": "경호원(신변보호/의전/경비 등)"
  },
  {
    "code": "000627",
    "parent": "",
    "tier": 1,
    "title": "이벤트"
  },
  {
    "code": "000628",
    "parent": "000627",
    "tier": 2,
    "title": "웨딩"
  },
  {
    "code": "000629",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 영상 촬영"
  },
  {
    "code": "000630",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 사진 촬영(본식)"
  },
  {
    "code": "000631",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 스냅 촬영(스튜디오/야외)"
  },
  {
    "code": "000632",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 헤어/메이크업"
  },
  {
    "code": "000633",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 연주"
  },
  {
    "code": "000634",
    "parent": "000628",
    "tier": 3,
    "title": "축가 요청"
  },
  {
    "code": "000635",
    "parent": "000628",
    "tier": 3,
    "title": "결혼식 사회자"
  },
  {
    "code": "000636",
    "parent": "000628",
    "tier": 3,
    "title": "주례"
  },
  {
    "code": "000637",
    "parent": "000628",
    "tier": 3,
    "title": "스드메/웨딩플래너"
  },
  {
    "code": "000638",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 헬퍼"
  },
  {
    "code": "000639",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩홀 대관"
  },
  {
    "code": "000640",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 꽃장식"
  },
  {
    "code": "000641",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩소품 제작"
  },
  {
    "code": "000642",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 케이터링"
  },
  {
    "code": "000643",
    "parent": "000628",
    "tier": 3,
    "title": "웨딩 케이크"
  },
  {
    "code": "000644",
    "parent": "000628",
    "tier": 3,
    "title": "폐백/이바지 음식 대행"
  },
  {
    "code": "000645",
    "parent": "000628",
    "tier": 3,
    "title": "한복"
  },
  {
    "code": "000646",
    "parent": "000628",
    "tier": 3,
    "title": "맞춤침구 제작"
  },
  {
    "code": "000647",
    "parent": "000628",
    "tier": 3,
    "title": "예물 제작"
  },
  {
    "code": "000648",
    "parent": "000628",
    "tier": 3,
    "title": "허니문"
  },
  {
    "code": "000649",
    "parent": "000627",
    "tier": 2,
    "title": "촬영 및 편집"
  },
  {
    "code": "000650",
    "parent": "000649",
    "tier": 3,
    "title": "스냅 촬영"
  },
  {
    "code": "000651",
    "parent": "000649",
    "tier": 3,
    "title": "개인용 사진 촬영"
  },
  {
    "code": "000652",
    "parent": "000649",
    "tier": 3,
    "title": "기업/상업용 영상 촬영"
  },
  {
    "code": "000653",
    "parent": "000649",
    "tier": 3,
    "title": "개인용 영상 촬영"
  },
  {
    "code": "000654",
    "parent": "000649",
    "tier": 3,
    "title": "기업/상용 영상 촬영"
  },
  {
    "code": "000655",
    "parent": "000649",
    "tier": 3,
    "title": "생중계/스트리밍 촬영"
  },
  {
    "code": "000656",
    "parent": "000649",
    "tier": 3,
    "title": "3D 영상 제작"
  },
  {
    "code": "000657",
    "parent": "000649",
    "tier": 3,
    "title": "사진 편집/보정"
  },
  {
    "code": "000658",
    "parent": "000649",
    "tier": 3,
    "title": "영상 편집"
  },
  {
    "code": "000659",
    "parent": "000649",
    "tier": 3,
    "title": "자막 제작"
  },
  {
    "code": "000660",
    "parent": "000649",
    "tier": 3,
    "title": "드론 촬영"
  },
  {
    "code": "000661",
    "parent": "000627",
    "tier": 2,
    "title": "뮤직/엔터테인먼트"
  },
  {
    "code": "000662",
    "parent": "000661",
    "tier": 3,
    "title": "강연자 섭외"
  },
  {
    "code": "000663",
    "parent": "000661",
    "tier": 3,
    "title": "행사 MC"
  },
  {
    "code": "000664",
    "parent": "000661",
    "tier": 3,
    "title": "댄스 공연"
  },
  {
    "code": "000665",
    "parent": "000661",
    "tier": 3,
    "title": "보컬 공연"
  },
  {
    "code": "000666",
    "parent": "000661",
    "tier": 3,
    "title": "밴드 공연"
  },
  {
    "code": "000667",
    "parent": "000661",
    "tier": 3,
    "title": "클래식 공연"
  },
  {
    "code": "000668",
    "parent": "000661",
    "tier": 3,
    "title": "국악 공연"
  },
  {
    "code": "000669",
    "parent": "000661",
    "tier": 3,
    "title": "DJ 공연"
  },
  {
    "code": "000670",
    "parent": "000661",
    "tier": 3,
    "title": "마술 공연"
  },
  {
    "code": "000671",
    "parent": "000661",
    "tier": 3,
    "title": "샌드아트 행사"
  },
  {
    "code": "000672",
    "parent": "000661",
    "tier": 3,
    "title": "타로 행사"
  },
  {
    "code": "000673",
    "parent": "000661",
    "tier": 3,
    "title": "캐리커쳐/캘리그라피 행사"
  },
  {
    "code": "000674",
    "parent": "000661",
    "tier": 3,
    "title": "페이스페인팅/헤나타투 행사"
  },
  {
    "code": "000675",
    "parent": "000661",
    "tier": 3,
    "title": "삐에로/행사도우미"
  },
  {
    "code": "000676",
    "parent": "000627",
    "tier": 2,
    "title": "음식"
  },
  {
    "code": "000677",
    "parent": "000676",
    "tier": 3,
    "title": "요리 도우미"
  },
  {
    "code": "000678",
    "parent": "000676",
    "tier": 3,
    "title": "푸드 스타일링"
  },
  {
    "code": "000679",
    "parent": "000676",
    "tier": 3,
    "title": "케이터링"
  },
  {
    "code": "000680",
    "parent": "000676",
    "tier": 3,
    "title": "맞춤 케이크"
  },
  {
    "code": "000681",
    "parent": "000676",
    "tier": 3,
    "title": "반찬/도시락 배달"
  },
  {
    "code": "000682",
    "parent": "000676",
    "tier": 3,
    "title": "푸드트럭/밥차"
  },
  {
    "code": "000683",
    "parent": "000676",
    "tier": 3,
    "title": "명절/제사 음식 대행"
  },
  {
    "code": "000684",
    "parent": "000676",
    "tier": 3,
    "title": "폐백/이바지 음식 대행"
  },
  {
    "code": "000685",
    "parent": "000627",
    "tier": 2,
    "title": "뷰티/미용"
  },
  {
    "code": "000686",
    "parent": "000685",
    "tier": 3,
    "title": "헤어(컷/염색/펌)"
  },
  {
    "code": "000687",
    "parent": "000685",
    "tier": 3,
    "title": "헤어/메이크업"
  },
  {
    "code": "000688",
    "parent": "000685",
    "tier": 3,
    "title": "네일"
  },
  {
    "code": "000689",
    "parent": "000685",
    "tier": 3,
    "title": "왁싱"
  },
  {
    "code": "000690",
    "parent": "000685",
    "tier": 3,
    "title": "속눈썹 연장/파마"
  },
  {
    "code": "000691",
    "parent": "000685",
    "tier": 3,
    "title": "피부 관리"
  },
  {
    "code": "000692",
    "parent": "000685",
    "tier": 3,
    "title": "얼굴 경락 관리"
  },
  {
    "code": "000693",
    "parent": "000685",
    "tier": 3,
    "title": "퍼스널 쇼퍼"
  },
  {
    "code": "000694",
    "parent": "000685",
    "tier": 3,
    "title": "퍼스널 컬러/이미지 메이킹"
  },
  {
    "code": "000695",
    "parent": "000627",
    "tier": 2,
    "title": "기획 및 장식"
  },
  {
    "code": "000696",
    "parent": "000695",
    "tier": 3,
    "title": "파티/행사 기획"
  },
  {
    "code": "000697",
    "parent": "000695",
    "tier": 3,
    "title": "꽃장식"
  },
  {
    "code": "000698",
    "parent": "000695",
    "tier": 3,
    "title": "엽서 제작(초대장/청첩장)"
  },
  {
    "code": "000699",
    "parent": "000695",
    "tier": 3,
    "title": "에어간판/스카이댄스 제작"
  },
  {
    "code": "000700",
    "parent": "000695",
    "tier": 3,
    "title": "전시부스 제작"
  },
  {
    "code": "000701",
    "parent": "000695",
    "tier": 3,
    "title": "얼음조각 제작"
  },
  {
    "code": "000702",
    "parent": "000695",
    "tier": 3,
    "title": "백일상/돌상 대여"
  },
  {
    "code": "000703",
    "parent": "000627",
    "tier": 2,
    "title": "장비 및 자동차 대여"
  },
  {
    "code": "000704",
    "parent": "000703",
    "tier": 3,
    "title": "의상 대여"
  },
  {
    "code": "000705",
    "parent": "000703",
    "tier": 3,
    "title": "무대장비 대여"
  },
  {
    "code": "000706",
    "parent": "000703",
    "tier": 3,
    "title": "버스 대절"
  },
  {
    "code": "000707",
    "parent": "",
    "tier": 1,
    "title": "비즈니스"
  },
  {
    "code": "000708",
    "parent": "000707",
    "tier": 2,
    "title": "번역"
  },
  {
    "code": "000709",
    "parent": "000708",
    "tier": 3,
    "title": "한문 번역"
  },
  {
    "code": "000710",
    "parent": "000708",
    "tier": 3,
    "title": "영어 번역"
  },
  {
    "code": "000711",
    "parent": "000708",
    "tier": 3,
    "title": "중국어 번역"
  },
  {
    "code": "000712",
    "parent": "000708",
    "tier": 3,
    "title": "일본어(일어) 번역"
  },
  {
    "code": "000713",
    "parent": "000708",
    "tier": 3,
    "title": "베트남어 번역"
  },
  {
    "code": "000714",
    "parent": "000708",
    "tier": 3,
    "title": "프랑스어(불어) 번역"
  },
  {
    "code": "000715",
    "parent": "000708",
    "tier": 3,
    "title": "독일어 번역"
  },
  {
    "code": "000716",
    "parent": "000708",
    "tier": 3,
    "title": "라틴어 번역"
  },
  {
    "code": "000717",
    "parent": "000708",
    "tier": 3,
    "title": "러시아어 번역"
  },
  {
    "code": "000718",
    "parent": "000708",
    "tier": 3,
    "title": "몽골어 번역"
  },
  {
    "code": "000719",
    "parent": "000708",
    "tier": 3,
    "title": "스웨덴어 번역"
  },
  {
    "code": "000720",
    "parent": "000708",
    "tier": 3,
    "title": "스페인어 번역"
  },
  {
    "code": "000721",
    "parent": "000708",
    "tier": 3,
    "title": "아랍어 번역"
  },
  {
    "code": "000722",
    "parent": "000708",
    "tier": 3,
    "title": "이탈리아어 번역"
  },
  {
    "code": "000723",
    "parent": "000708",
    "tier": 3,
    "title": "인도네시아어/말레이시아어 번역"
  },
  {
    "code": "000724",
    "parent": "000708",
    "tier": 3,
    "title": "체코어 번역"
  },
  {
    "code": "000725",
    "parent": "000708",
    "tier": 3,
    "title": "태국어 번역"
  },
  {
    "code": "000726",
    "parent": "000708",
    "tier": 3,
    "title": "터키어 번역"
  },
  {
    "code": "000727",
    "parent": "000708",
    "tier": 3,
    "title": "포르투갈어 번역"
  },
  {
    "code": "000728",
    "parent": "000708",
    "tier": 3,
    "title": "폴란드어 번역"
  },
  {
    "code": "000729",
    "parent": "000708",
    "tier": 3,
    "title": "헝가리어 번역"
  },
  {
    "code": "000730",
    "parent": "000708",
    "tier": 3,
    "title": "힌디어"
  },
  {
    "code": "000731",
    "parent": "000708",
    "tier": 3,
    "title": "기타 언어 번역"
  },
  {
    "code": "000732",
    "parent": "000707",
    "tier": 2,
    "title": "통역"
  },
  {
    "code": "000733",
    "parent": "000732",
    "tier": 3,
    "title": "영어 통역"
  },
  {
    "code": "000734",
    "parent": "000732",
    "tier": 3,
    "title": "중국어 통역"
  },
  {
    "code": "000735",
    "parent": "000732",
    "tier": 3,
    "title": "일본어(일어) 통역"
  },
  {
    "code": "000736",
    "parent": "000732",
    "tier": 3,
    "title": "러시아어 통역"
  },
  {
    "code": "000737",
    "parent": "000732",
    "tier": 3,
    "title": "베트남어 통역"
  },
  {
    "code": "000738",
    "parent": "000732",
    "tier": 3,
    "title": "독일어 통역"
  },
  {
    "code": "000739",
    "parent": "000732",
    "tier": 3,
    "title": "스웨덴어 통역"
  },
  {
    "code": "000740",
    "parent": "000732",
    "tier": 3,
    "title": "스페인어 통역"
  },
  {
    "code": "000741",
    "parent": "000732",
    "tier": 3,
    "title": "아랍어 통역"
  },
  {
    "code": "000742",
    "parent": "000732",
    "tier": 3,
    "title": "이탈리아어 통역"
  },
  {
    "code": "000743",
    "parent": "000732",
    "tier": 3,
    "title": "체코어 통역"
  },
  {
    "code": "000744",
    "parent": "000732",
    "tier": 3,
    "title": "태국어 통역"
  },
  {
    "code": "000745",
    "parent": "000732",
    "tier": 3,
    "title": "터키어 통역"
  },
  {
    "code": "000746",
    "parent": "000732",
    "tier": 3,
    "title": "포르투갈어 통역"
  },
  {
    "code": "000747",
    "parent": "000732",
    "tier": 3,
    "title": "폴란드 통역"
  },
  {
    "code": "000748",
    "parent": "000732",
    "tier": 3,
    "title": "프랑스어(불어) 통역"
  },
  {
    "code": "000749",
    "parent": "000732",
    "tier": 3,
    "title": "헝가리어 통역"
  },
  {
    "code": "000750",
    "parent": "000732",
    "tier": 3,
    "title": "힌디어 통역"
  },
  {
    "code": "000751",
    "parent": "000732",
    "tier": 3,
    "title": "수어 통역"
  },
  {
    "code": "000752",
    "parent": "000732",
    "tier": 3,
    "title": "기타 언어 통역"
  },
  {
    "code": "000753",
    "parent": "000707",
    "tier": 2,
    "title": "문서"
  },
  {
    "code": "000754",
    "parent": "000753",
    "tier": 3,
    "title": "교정/교열"
  },
  {
    "code": "000755",
    "parent": "000753",
    "tier": 3,
    "title": "문서/글 작성"
  },
  {
    "code": "000756",
    "parent": "000753",
    "tier": 3,
    "title": "속기(타이핑)"
  },
  {
    "code": "000757",
    "parent": "000753",
    "tier": 3,
    "title": "사업계획서 작성"
  },
  {
    "code": "000758",
    "parent": "000753",
    "tier": 3,
    "title": "PPT 제작"
  },
  {
    "code": "000759",
    "parent": "000753",
    "tier": 3,
    "title": "자막 제작"
  },
  {
    "code": "000760",
    "parent": "000753",
    "tier": 3,
    "title": "앱/웹 기획"
  },
  {
    "code": "000761",
    "parent": "000753",
    "tier": 3,
    "title": "문서/데이터 파쇄"
  },
  {
    "code": "000762",
    "parent": "000753",
    "tier": 3,
    "title": "데이터 복구"
  },
  {
    "code": "000763",
    "parent": "000753",
    "tier": 3,
    "title": "데이터 크롤링"
  },
  {
    "code": "000764",
    "parent": "000753",
    "tier": 3,
    "title": "데이터 가공/라벨링"
  },
  {
    "code": "000765",
    "parent": "000753",
    "tier": 3,
    "title": "디지털 장의사"
  },
  {
    "code": "000766",
    "parent": "000707",
    "tier": 2,
    "title": "인쇄"
  },
  {
    "code": "000767",
    "parent": "000766",
    "tier": 3,
    "title": "굿즈/판촉물 제작"
  },
  {
    "code": "000768",
    "parent": "000766",
    "tier": 3,
    "title": "엽서 제작(초대장/청첩장)"
  },
  {
    "code": "000769",
    "parent": "000766",
    "tier": 3,
    "title": "배너 제작"
  },
  {
    "code": "000770",
    "parent": "000766",
    "tier": 3,
    "title": "현수막 제작"
  },
  {
    "code": "000771",
    "parent": "000766",
    "tier": 3,
    "title": "시트지 인쇄/컷팅"
  },
  {
    "code": "000772",
    "parent": "000766",
    "tier": 3,
    "title": "에어간판/스카이댄스 제작"
  },
  {
    "code": "000773",
    "parent": "000766",
    "tier": 3,
    "title": "고보라이트 제작/설치"
  },
  {
    "code": "000774",
    "parent": "000766",
    "tier": 3,
    "title": "전시부스 제작"
  },
  {
    "code": "000775",
    "parent": "000766",
    "tier": 3,
    "title": "명함 인쇄"
  },
  {
    "code": "000776",
    "parent": "000766",
    "tier": 3,
    "title": "포스터/전단지 인쇄"
  },
  {
    "code": "000777",
    "parent": "000766",
    "tier": 3,
    "title": "출력/제본"
  },
  {
    "code": "000778",
    "parent": "000766",
    "tier": 3,
    "title": "출판"
  },
  {
    "code": "000779",
    "parent": "000766",
    "tier": 3,
    "title": "3D 프린팅"
  },
  {
    "code": "000780",
    "parent": "000766",
    "tier": 3,
    "title": "각인"
  },
  {
    "code": "000781",
    "parent": "000707",
    "tier": 2,
    "title": "마케팅"
  },
  {
    "code": "000782",
    "parent": "000781",
    "tier": 3,
    "title": "블로그 마케팅"
  },
  {
    "code": "000783",
    "parent": "000781",
    "tier": 3,
    "title": "SNS/바이럴 마케팅"
  },
  {
    "code": "000784",
    "parent": "000781",
    "tier": 3,
    "title": "영상 광고"
  },
  {
    "code": "000785",
    "parent": "000781",
    "tier": 3,
    "title": "디지털 마케팅"
  },
  {
    "code": "000786",
    "parent": "000781",
    "tier": 3,
    "title": "인플루언서 마케팅"
  },
  {
    "code": "000787",
    "parent": "000781",
    "tier": 3,
    "title": "체험단 마케팅"
  },
  {
    "code": "000788",
    "parent": "000781",
    "tier": 3,
    "title": "검색/키워드 광고"
  },
  {
    "code": "000789",
    "parent": "000781",
    "tier": 3,
    "title": "오프라인 광고"
  },
  {
    "code": "000790",
    "parent": "000781",
    "tier": 3,
    "title": "종합 광고 대행"
  },
  {
    "code": "000791",
    "parent": "000781",
    "tier": 3,
    "title": "카피라이팅"
  },
  {
    "code": "000792",
    "parent": "000781",
    "tier": 3,
    "title": "PPL/협찬 광고"
  },
  {
    "code": "000793",
    "parent": "000781",
    "tier": 3,
    "title": "언론 홍보/PR"
  },
  {
    "code": "000794",
    "parent": "000781",
    "tier": 3,
    "title": "콘텐츠 마케팅"
  },
  {
    "code": "000795",
    "parent": "000781",
    "tier": 3,
    "title": "해외 마케팅"
  },
  {
    "code": "000796",
    "parent": "000781",
    "tier": 3,
    "title": "텔레마케팅/CRM"
  },
  {
    "code": "000797",
    "parent": "000781",
    "tier": 3,
    "title": "앱 광고"
  },
  {
    "code": "000798",
    "parent": "000781",
    "tier": 3,
    "title": "디스플레이/배너 광고"
  },
  {
    "code": "000799",
    "parent": "000781",
    "tier": 3,
    "title": "리워드 광고"
  },
  {
    "code": "000800",
    "parent": "000707",
    "tier": 2,
    "title": "음향"
  },
  {
    "code": "000801",
    "parent": "000800",
    "tier": 3,
    "title": "음악 편집 및 제작"
  },
  {
    "code": "000802",
    "parent": "000800",
    "tier": 3,
    "title": "BGM/사운드 제작"
  },
  {
    "code": "000803",
    "parent": "000800",
    "tier": 3,
    "title": "음반 제작/발매"
  },
  {
    "code": "000804",
    "parent": "000800",
    "tier": 3,
    "title": "나레이션/더빙"
  },
  {
    "code": "000805",
    "parent": "000800",
    "tier": 3,
    "title": "악보 제작"
  },
  {
    "code": "000806",
    "parent": "000707",
    "tier": 2,
    "title": "아웃소싱"
  },
  {
    "code": "000807",
    "parent": "000806",
    "tier": 3,
    "title": "리서치/서베이 대행"
  },
  {
    "code": "000808",
    "parent": "000806",
    "tier": 3,
    "title": "무역 대행(수입/수출/포워딩 등)"
  },
  {
    "code": "000809",
    "parent": "000806",
    "tier": 3,
    "title": "포장/물류 대행"
  },
  {
    "code": "000810",
    "parent": "000806",
    "tier": 3,
    "title": "영업 대행"
  },
  {
    "code": "000811",
    "parent": "000806",
    "tier": 3,
    "title": "CS 대행"
  },
  {
    "code": "000812",
    "parent": "000806",
    "tier": 3,
    "title": "국내 오픈마켓 운영 대행"
  },
  {
    "code": "000813",
    "parent": "000806",
    "tier": 3,
    "title": "해외 오픈마켓 운영 대행"
  },
  {
    "code": "000814",
    "parent": "000806",
    "tier": 3,
    "title": "서버/웹 호스팅(클라우드)"
  },
  {
    "code": "000815",
    "parent": "000806",
    "tier": 3,
    "title": "보안 관제"
  },
  {
    "code": "000816",
    "parent": "000806",
    "tier": 3,
    "title": "데이터베이스 구축"
  },
  {
    "code": "000817",
    "parent": "000806",
    "tier": 3,
    "title": "데이터 가공/라벨링"
  },
  {
    "code": "000818",
    "parent": "000806",
    "tier": 3,
    "title": "데이터 크롤링"
  },
  {
    "code": "000819",
    "parent": "000707",
    "tier": 2,
    "title": "컨설팅"
  },
  {
    "code": "000820",
    "parent": "000819",
    "tier": 3,
    "title": "타투이스트 준비"
  },
  {
    "code": "000821",
    "parent": "000819",
    "tier": 3,
    "title": "애자일 코칭"
  },
  {
    "code": "000822",
    "parent": "000819",
    "tier": 3,
    "title": "프렌차이즈 창업"
  },
  {
    "code": "000823",
    "parent": "000819",
    "tier": 3,
    "title": "특수상권 입점(백화점/마트 등)"
  },
  {
    "code": "000824",
    "parent": "000819",
    "tier": 3,
    "title": "창업 컨설팅"
  },
  {
    "code": "000825",
    "parent": "000819",
    "tier": 3,
    "title": "공유숙박 컨설팅(셰어/게스트하우스 등)"
  },
  {
    "code": "000826",
    "parent": "000819",
    "tier": 3,
    "title": "경영 컨설팅"
  },
  {
    "code": "000827",
    "parent": "000819",
    "tier": 3,
    "title": "브랜딩/네이밍 컨설팅"
  },
  {
    "code": "000828",
    "parent": "000819",
    "tier": 3,
    "title": "크라우드펀딩 컨설팅"
  },
  {
    "code": "000829",
    "parent": "000819",
    "tier": 3,
    "title": "국내 오픈마켓 컨설팅"
  },
  {
    "code": "000830",
    "parent": "000819",
    "tier": 3,
    "title": "해외 오픈마켓 컨설팅"
  },
  {
    "code": "000831",
    "parent": "000819",
    "tier": 3,
    "title": "매장관리(적립/대기/예약 시스템)"
  },
  {
    "code": "000832",
    "parent": "000819",
    "tier": 3,
    "title": "통계분석"
  },
  {
    "code": "000833",
    "parent": "000819",
    "tier": 3,
    "title": "환경 컨설팅"
  },
  {
    "code": "000834",
    "parent": "000707",
    "tier": 2,
    "title": "회계/세무/재무"
  },
  {
    "code": "000835",
    "parent": "000834",
    "tier": 3,
    "title": "회계/세무"
  },
  {
    "code": "000836",
    "parent": "000834",
    "tier": 3,
    "title": "감정평가"
  },
  {
    "code": "000837",
    "parent": "000707",
    "tier": 2,
    "title": "인사"
  },
  {
    "code": "000838",
    "parent": "000837",
    "tier": 3,
    "title": "기업교육"
  },
  {
    "code": "000839",
    "parent": "000837",
    "tier": 3,
    "title": "인권/성교육"
  },
  {
    "code": "000840",
    "parent": "000837",
    "tier": 3,
    "title": "리쿠르팅"
  },
  {
    "code": "000841",
    "parent": "",
    "tier": 1,
    "title": "디자인/개발"
  },
  {
    "code": "000842",
    "parent": "000841",
    "tier": 2,
    "title": "디자인 외주"
  },
  {
    "code": "000843",
    "parent": "000842",
    "tier": 3,
    "title": "인쇄물 디자인"
  },
  {
    "code": "000844",
    "parent": "000842",
    "tier": 3,
    "title": "명함 디자인"
  },
  {
    "code": "000845",
    "parent": "000842",
    "tier": 3,
    "title": "로고 디자인"
  },
  {
    "code": "000846",
    "parent": "000842",
    "tier": 3,
    "title": "간판 디자인"
  },
  {
    "code": "000847",
    "parent": "000842",
    "tier": 3,
    "title": "프레젠테이션 디자인"
  },
  {
    "code": "000848",
    "parent": "000842",
    "tier": 3,
    "title": "일러스트 디자인"
  },
  {
    "code": "000849",
    "parent": "000842",
    "tier": 3,
    "title": "캘리그라피 디자인"
  },
  {
    "code": "000850",
    "parent": "000842",
    "tier": 3,
    "title": "패키지 디자인"
  },
  {
    "code": "000851",
    "parent": "000842",
    "tier": 3,
    "title": "제품 디자인"
  },
  {
    "code": "000852",
    "parent": "000842",
    "tier": 3,
    "title": "라벨 디자인"
  },
  {
    "code": "000853",
    "parent": "000842",
    "tier": 3,
    "title": "웹 디자인"
  },
  {
    "code": "000854",
    "parent": "000842",
    "tier": 3,
    "title": "앱 디자인"
  },
  {
    "code": "000855",
    "parent": "000842",
    "tier": 3,
    "title": "상세페이지 제작"
  },
  {
    "code": "000856",
    "parent": "000842",
    "tier": 3,
    "title": "썸네일 제작"
  },
  {
    "code": "000857",
    "parent": "000842",
    "tier": 3,
    "title": "스토리보드/콘티 제작"
  },
  {
    "code": "000858",
    "parent": "000842",
    "tier": 3,
    "title": "캐릭터/이모티콘 제작"
  },
  {
    "code": "000859",
    "parent": "000842",
    "tier": 3,
    "title": "애니메이션 제작"
  },
  {
    "code": "000860",
    "parent": "000842",
    "tier": 3,
    "title": "폰트 제작"
  },
  {
    "code": "000861",
    "parent": "000842",
    "tier": 3,
    "title": "커스텀 제작"
  },
  {
    "code": "000862",
    "parent": "000842",
    "tier": 3,
    "title": "3D 모델링"
  },
  {
    "code": "000863",
    "parent": "000842",
    "tier": 3,
    "title": "3D 영상 제작"
  },
  {
    "code": "000864",
    "parent": "000842",
    "tier": 3,
    "title": "VR/AR 제작"
  },
  {
    "code": "000865",
    "parent": "000842",
    "tier": 3,
    "title": "인테리어 도면(캐드/3D)"
  },
  {
    "code": "000866",
    "parent": "000842",
    "tier": 3,
    "title": "인터넷 배너/디스플레이 광고 디자인"
  },
  {
    "code": "000867",
    "parent": "000841",
    "tier": 2,
    "title": "개발 외주"
  },
  {
    "code": "000868",
    "parent": "000867",
    "tier": 3,
    "title": "게임 개발"
  },
  {
    "code": "000869",
    "parent": "000867",
    "tier": 3,
    "title": "iOS 개발"
  },
  {
    "code": "000870",
    "parent": "000867",
    "tier": 3,
    "title": "안드로이드 개발"
  },
  {
    "code": "000871",
    "parent": "000867",
    "tier": 3,
    "title": "웹 개발"
  },
  {
    "code": "000872",
    "parent": "000867",
    "tier": 3,
    "title": "퍼블리싱"
  },
  {
    "code": "000873",
    "parent": "000867",
    "tier": 3,
    "title": "소프트웨어 개발"
  },
  {
    "code": "000874",
    "parent": "000867",
    "tier": 3,
    "title": "워드프레스 개발"
  },
  {
    "code": "000875",
    "parent": "000867",
    "tier": 3,
    "title": "커머스/쇼핑몰 개발"
  },
  {
    "code": "000876",
    "parent": "000867",
    "tier": 3,
    "title": "매크로/VBA 개발"
  },
  {
    "code": "000877",
    "parent": "000867",
    "tier": 3,
    "title": "인공지능(AI) 개발"
  },
  {
    "code": "000878",
    "parent": "000867",
    "tier": 3,
    "title": "챗봇 개발"
  },
  {
    "code": "000879",
    "parent": "000867",
    "tier": 3,
    "title": "ERP 개발"
  },
  {
    "code": "000880",
    "parent": "000867",
    "tier": 3,
    "title": "QA/테스트"
  },
  {
    "code": "000881",
    "parent": "000867",
    "tier": 3,
    "title": "웹/앱 유지보수"
  },
  {
    "code": "000882",
    "parent": "",
    "tier": 1,
    "title": "건강/미용"
  },
  {
    "code": "000883",
    "parent": "000882",
    "tier": 2,
    "title": "심리"
  },
  {
    "code": "000884",
    "parent": "000883",
    "tier": 3,
    "title": "심리검사"
  },
  {
    "code": "000885",
    "parent": "000883",
    "tier": 3,
    "title": "심리상담"
  },
  {
    "code": "000886",
    "parent": "000883",
    "tier": 3,
    "title": "성인 상담"
  },
  {
    "code": "000887",
    "parent": "000883",
    "tier": 3,
    "title": "부부/커플상담"
  },
  {
    "code": "000888",
    "parent": "000883",
    "tier": 3,
    "title": "아동/청소년 상담"
  },
  {
    "code": "000889",
    "parent": "000883",
    "tier": 3,
    "title": "가족상담"
  },
  {
    "code": "000890",
    "parent": "000883",
    "tier": 3,
    "title": "심리치료"
  },
  {
    "code": "000891",
    "parent": "000883",
    "tier": 3,
    "title": "놀이치료"
  },
  {
    "code": "000892",
    "parent": "000883",
    "tier": 3,
    "title": "독서치료"
  },
  {
    "code": "000893",
    "parent": "000883",
    "tier": 3,
    "title": "미술치료"
  },
  {
    "code": "000894",
    "parent": "000883",
    "tier": 3,
    "title": "언어치료"
  },
  {
    "code": "000895",
    "parent": "000883",
    "tier": 3,
    "title": "연극치료"
  },
  {
    "code": "000896",
    "parent": "000883",
    "tier": 3,
    "title": "영화/사진치료"
  },
  {
    "code": "000897",
    "parent": "000883",
    "tier": 3,
    "title": "음악치료"
  },
  {
    "code": "000898",
    "parent": "000883",
    "tier": 3,
    "title": "EFT치료"
  },
  {
    "code": "000899",
    "parent": "000883",
    "tier": 3,
    "title": "명상"
  },
  {
    "code": "000900",
    "parent": "000882",
    "tier": 2,
    "title": "미용"
  },
  {
    "code": "000901",
    "parent": "000900",
    "tier": 3,
    "title": "퍼스널 컬러/이미지 메이킹"
  },
  {
    "code": "000902",
    "parent": "000900",
    "tier": 3,
    "title": "헤어/메이크업"
  },
  {
    "code": "000903",
    "parent": "000900",
    "tier": 3,
    "title": "헤어(컷/염색/펌)"
  },
  {
    "code": "000904",
    "parent": "000900",
    "tier": 3,
    "title": "네일"
  },
  {
    "code": "000905",
    "parent": "000900",
    "tier": 3,
    "title": "왁싱"
  },
  {
    "code": "000906",
    "parent": "000900",
    "tier": 3,
    "title": "속눈썹 연장/파마"
  },
  {
    "code": "000907",
    "parent": "000900",
    "tier": 3,
    "title": "얼굴 경락 관리"
  },
  {
    "code": "000908",
    "parent": "000900",
    "tier": 3,
    "title": "피부 관리"
  },
  {
    "code": "000909",
    "parent": "000900",
    "tier": 3,
    "title": "두피/모발 관리"
  },
  {
    "code": "000910",
    "parent": "000900",
    "tier": 3,
    "title": "탈모 관리"
  },
  {
    "code": "000911",
    "parent": "000882",
    "tier": 2,
    "title": "건강"
  },
  {
    "code": "000912",
    "parent": "000911",
    "tier": 3,
    "title": "반찬/도시락 배달"
  },
  {
    "code": "000913",
    "parent": "000911",
    "tier": 3,
    "title": "영양/식단 관리"
  },
  {
    "code": "000914",
    "parent": "000911",
    "tier": 3,
    "title": "퍼스널트레이닝(PT)"
  },
  {
    "code": "000915",
    "parent": "000911",
    "tier": 3,
    "title": "크로스핏"
  },
  {
    "code": "000916",
    "parent": "000911",
    "tier": 3,
    "title": "스피닝"
  },
  {
    "code": "000917",
    "parent": "000911",
    "tier": 3,
    "title": "필라테스"
  },
  {
    "code": "000918",
    "parent": "000911",
    "tier": 3,
    "title": "요가"
  },
  {
    "code": "000919",
    "parent": "000911",
    "tier": 3,
    "title": "음악 줄넘기"
  },
  {
    "code": "000920",
    "parent": "",
    "tier": 1,
    "title": "알바"
  },
  {
    "code": "000921",
    "parent": "000920",
    "tier": 2,
    "title": "서빙/주방 알바"
  },
  {
    "code": "000922",
    "parent": "000921",
    "tier": 3,
    "title": "일반음식점 알바"
  },
  {
    "code": "000923",
    "parent": "000921",
    "tier": 3,
    "title": "레스토랑 알바"
  },
  {
    "code": "000924",
    "parent": "000921",
    "tier": 3,
    "title": "패스트푸드/치킨/피자 전문점 알바"
  },
  {
    "code": "000925",
    "parent": "000921",
    "tier": 3,
    "title": "커피/디저트 전문점 알바"
  },
  {
    "code": "000926",
    "parent": "000921",
    "tier": 3,
    "title": "베이커리/도넛/떡집 알바"
  },
  {
    "code": "000927",
    "parent": "000921",
    "tier": 3,
    "title": "일반주점/호프 알바"
  },
  {
    "code": "000928",
    "parent": "000921",
    "tier": 3,
    "title": "결혼/연회/장례도우미 알바"
  },
  {
    "code": "000929",
    "parent": "000921",
    "tier": 3,
    "title": "급식/푸드코드 알바"
  },
  {
    "code": "000930",
    "parent": "000921",
    "tier": 3,
    "title": "기타 서빙/주방 알바"
  },
  {
    "code": "000931",
    "parent": "000920",
    "tier": 2,
    "title": "매장관리/판매 알바"
  },
  {
    "code": "000932",
    "parent": "000931",
    "tier": 3,
    "title": "편의점 알바"
  },
  {
    "code": "000933",
    "parent": "000931",
    "tier": 3,
    "title": "마트/유통점 알바"
  },
  {
    "code": "000934",
    "parent": "000931",
    "tier": 3,
    "title": "백화점/면세점/아울렛 알바"
  },
  {
    "code": "000935",
    "parent": "000931",
    "tier": 3,
    "title": "의류/잡화매장 알바"
  },
  {
    "code": "000936",
    "parent": "000931",
    "tier": 3,
    "title": "인터넷쇼핑몰/소셜커머스/홈쇼핑 알바"
  },
  {
    "code": "000937",
    "parent": "000931",
    "tier": 3,
    "title": "뷰티/헬스 스토어 알바"
  },
  {
    "code": "000938",
    "parent": "000931",
    "tier": 3,
    "title": "PC방/오락식/게임장 알바"
  },
  {
    "code": "000939",
    "parent": "000931",
    "tier": 3,
    "title": "볼링/당구/스크린골프장 알바"
  },
  {
    "code": "000940",
    "parent": "000931",
    "tier": 3,
    "title": "노래방/멀티방/만화카페 알바"
  },
  {
    "code": "000941",
    "parent": "000931",
    "tier": 3,
    "title": "스터디룸/독서실/고시원 알바"
  },
  {
    "code": "000942",
    "parent": "000931",
    "tier": 3,
    "title": "휴대폰/전자제품 매장 알바"
  },
  {
    "code": "000943",
    "parent": "000931",
    "tier": 3,
    "title": "서점/문구/팬시점 알바"
  },
  {
    "code": "000944",
    "parent": "000931",
    "tier": 3,
    "title": "가구/침구/생활소품점 알바"
  },
  {
    "code": "000945",
    "parent": "000931",
    "tier": 3,
    "title": "농수산/청과/축산점 알바"
  },
  {
    "code": "000946",
    "parent": "000931",
    "tier": 3,
    "title": "화훼/꽃집 알바"
  },
  {
    "code": "000947",
    "parent": "000931",
    "tier": 3,
    "title": "약국 알바"
  },
  {
    "code": "000948",
    "parent": "000931",
    "tier": 3,
    "title": "기타 매장관리/판매 알바"
  },
  {
    "code": "000949",
    "parent": "000920",
    "tier": 2,
    "title": "서비스/행사 알바"
  },
  {
    "code": "000950",
    "parent": "000949",
    "tier": 3,
    "title": "안내데스크/매표 알바"
  },
  {
    "code": "000951",
    "parent": "000949",
    "tier": 3,
    "title": "주차관리/주차도우미 알바"
  },
  {
    "code": "000952",
    "parent": "000949",
    "tier": 3,
    "title": "보안/경비/경호 알바"
  },
  {
    "code": "000953",
    "parent": "000949",
    "tier": 3,
    "title": "부분/피팅모델 알바"
  },
  {
    "code": "000954",
    "parent": "000949",
    "tier": 3,
    "title": "이벤트 행사스텝 알바"
  },
  {
    "code": "000955",
    "parent": "000949",
    "tier": 3,
    "title": "기타 서비스 행사 알바"
  },
  {
    "code": "000956",
    "parent": "000920",
    "tier": 2,
    "title": "문화/여가/생활 알바"
  },
  {
    "code": "000957",
    "parent": "000956",
    "tier": 3,
    "title": "호텔/리조트/숙박시설 알바"
  },
  {
    "code": "000958",
    "parent": "000956",
    "tier": 3,
    "title": "놀이공원/테마파크 알바"
  },
  {
    "code": "000959",
    "parent": "000956",
    "tier": 3,
    "title": "여행/캠프/레포츠 알바"
  },
  {
    "code": "000960",
    "parent": "000956",
    "tier": 3,
    "title": "영화/공연/전시장 알바"
  },
  {
    "code": "000961",
    "parent": "000956",
    "tier": 3,
    "title": "이색테마/키즈카페 알바"
  },
  {
    "code": "000962",
    "parent": "000956",
    "tier": 3,
    "title": "찜질방/사우나/스파 알바"
  },
  {
    "code": "000963",
    "parent": "000956",
    "tier": 3,
    "title": "피트니스 스포츠 알바"
  },
  {
    "code": "000964",
    "parent": "000956",
    "tier": 3,
    "title": "기타 문화/여가/생활 알바"
  },
  {
    "code": "000965",
    "parent": "000920",
    "tier": 2,
    "title": "방송/미디어 알바"
  },
  {
    "code": "000966",
    "parent": "000965",
    "tier": 3,
    "title": "보조출연/방청 알바"
  },
  {
    "code": "000967",
    "parent": "000965",
    "tier": 3,
    "title": "방송스텝/촬영보조 알바"
  },
  {
    "code": "000968",
    "parent": "000965",
    "tier": 3,
    "title": "조명/음향/무대 알바"
  },
  {
    "code": "000969",
    "parent": "000965",
    "tier": 3,
    "title": "방송사/프로덕션 알바"
  },
  {
    "code": "000970",
    "parent": "000965",
    "tier": 3,
    "title": "신문/잡지/출판사 알바"
  },
  {
    "code": "000971",
    "parent": "000965",
    "tier": 3,
    "title": "기타 방송/미디어 알바"
  },
  {
    "code": "000972",
    "parent": "000920",
    "tier": 2,
    "title": "사무직 알바"
  },
  {
    "code": "000973",
    "parent": "000972",
    "tier": 3,
    "title": "사무보조/문서작성 알바"
  },
  {
    "code": "000974",
    "parent": "000972",
    "tier": 3,
    "title": "자료조사/리서치 알바"
  },
  {
    "code": "000975",
    "parent": "000972",
    "tier": 3,
    "title": "경리/회계/총무 알바"
  },
  {
    "code": "000976",
    "parent": "000972",
    "tier": 3,
    "title": "비서 알바"
  },
  {
    "code": "000977",
    "parent": "000972",
    "tier": 3,
    "title": "공공기관/공기업/협회 알바"
  },
  {
    "code": "000978",
    "parent": "000972",
    "tier": 3,
    "title": "학교/도서관/교육기관 알바"
  },
  {
    "code": "000979",
    "parent": "000972",
    "tier": 3,
    "title": "기타 사무직 알바"
  },
  {
    "code": "000980",
    "parent": "000920",
    "tier": 2,
    "title": "생산/기능/노무 알바"
  },
  {
    "code": "000981",
    "parent": "000980",
    "tier": 3,
    "title": "제조/가공 알바"
  },
  {
    "code": "000982",
    "parent": "000980",
    "tier": 3,
    "title": "포장/조립 알바"
  },
  {
    "code": "000983",
    "parent": "000980",
    "tier": 3,
    "title": "품질검사/관리 알바"
  },
  {
    "code": "000984",
    "parent": "000980",
    "tier": 3,
    "title": "입출고/창고관리 알바"
  },
  {
    "code": "000985",
    "parent": "000980",
    "tier": 3,
    "title": "상하차/소화물분류 알바"
  },
  {
    "code": "000986",
    "parent": "000980",
    "tier": 3,
    "title": "공사/건설현장 알바"
  },
  {
    "code": "000987",
    "parent": "000980",
    "tier": 3,
    "title": "전기/가스공사 알바"
  },
  {
    "code": "000988",
    "parent": "000980",
    "tier": 3,
    "title": "기계정비/수리/설치/A.S 알바"
  },
  {
    "code": "000989",
    "parent": "000980",
    "tier": 3,
    "title": "기타 생산/기능/노무 알바"
  },
  {
    "code": "000990",
    "parent": "000920",
    "tier": 2,
    "title": "운전/배달/유통 알바"
  },
  {
    "code": "000991",
    "parent": "000990",
    "tier": 3,
    "title": "운전/기사 알바"
  },
  {
    "code": "000992",
    "parent": "000990",
    "tier": 3,
    "title": "배달/택배/퀵서비스 알바"
  },
  {
    "code": "000993",
    "parent": "000990",
    "tier": 3,
    "title": "운송/이사 알바"
  },
  {
    "code": "000994",
    "parent": "000990",
    "tier": 3,
    "title": "화물/중장비/특수차운전 알바"
  },
  {
    "code": "000995",
    "parent": "000990",
    "tier": 3,
    "title": "유통/도소매 알바"
  },
  {
    "code": "000996",
    "parent": "000990",
    "tier": 3,
    "title": "기타 운전/배달 유통 알바"
  },
  {
    "code": "000997",
    "parent": "000920",
    "tier": 2,
    "title": "병원/간호/연구 알바"
  },
  {
    "code": "000998",
    "parent": "000997",
    "tier": 3,
    "title": "간호조무사/간호사 알바"
  },
  {
    "code": "000999",
    "parent": "000997",
    "tier": 3,
    "title": "간병/요양보호사 알바"
  },
  {
    "code": "001000",
    "parent": "000997",
    "tier": 3,
    "title": "원무/코디네이터 알바"
  },
  {
    "code": "001001",
    "parent": "000997",
    "tier": 3,
    "title": "외래보조/병동보조 알바"
  },
  {
    "code": "001002",
    "parent": "000997",
    "tier": 3,
    "title": "수의사/수의간호사 알바"
  },
  {
    "code": "001003",
    "parent": "000997",
    "tier": 3,
    "title": "실험/연구보조 알바"
  },
  {
    "code": "001004",
    "parent": "000997",
    "tier": 3,
    "title": "기타 병원/간호/연구 알바"
  },
  {
    "code": "001005",
    "parent": "000920",
    "tier": 2,
    "title": "기타"
  },
  {
    "code": "001006",
    "parent": "001005",
    "tier": 3,
    "title": "기타 알바"
  },
  {
    "code": "001007",
    "parent": "",
    "tier": 1,
    "title": "기타"
  },
  {
    "code": "001008",
    "parent": "001007",
    "tier": 2,
    "title": "여행"
  },
  {
    "code": "001009",
    "parent": "001008",
    "tier": 3,
    "title": "국내 여행"
  },
  {
    "code": "001010",
    "parent": "001008",
    "tier": 3,
    "title": "반려동물 동반 여행"
  },
  {
    "code": "001011",
    "parent": "001008",
    "tier": 3,
    "title": "남유럽/지중해 패키지여행"
  },
  {
    "code": "001012",
    "parent": "001008",
    "tier": 3,
    "title": "동남아 패키지여행"
  },
  {
    "code": "001013",
    "parent": "001008",
    "tier": 3,
    "title": "동유럽 패키지여행"
  },
  {
    "code": "001014",
    "parent": "001008",
    "tier": 3,
    "title": "러시아/북유럽 패키지여행"
  },
  {
    "code": "001015",
    "parent": "001008",
    "tier": 3,
    "title": "북미 패키지여행"
  },
  {
    "code": "001016",
    "parent": "001008",
    "tier": 3,
    "title": "서유럽 패키지여행"
  },
  {
    "code": "001017",
    "parent": "001008",
    "tier": 3,
    "title": "아프리카 패키지여행"
  },
  {
    "code": "001018",
    "parent": "001008",
    "tier": 3,
    "title": "오세아니아/남태평양 패키지여행"
  },
  {
    "code": "001019",
    "parent": "001008",
    "tier": 3,
    "title": "인도/중남아시아 패키지여행"
  },
  {
    "code": "001020",
    "parent": "001008",
    "tier": 3,
    "title": "중국/일본 패키지여행"
  },
  {
    "code": "001021",
    "parent": "001008",
    "tier": 3,
    "title": "중남미 패키지여행"
  },
  {
    "code": "001022",
    "parent": "001008",
    "tier": 3,
    "title": "홍콩/마카오/대만/싱가폴/패키지여행"
  },
  {
    "code": "001023",
    "parent": "001008",
    "tier": 3,
    "title": "남유럽/지중해 가이드 투어"
  },
  {
    "code": "001024",
    "parent": "001008",
    "tier": 3,
    "title": "동남아 가이드투어"
  },
  {
    "code": "001025",
    "parent": "001008",
    "tier": 3,
    "title": "동유럽 가이드투어"
  },
  {
    "code": "001026",
    "parent": "001008",
    "tier": 3,
    "title": "러시아/북유럽 가이드투어"
  },
  {
    "code": "001027",
    "parent": "001008",
    "tier": 3,
    "title": "북미 가이드투어"
  },
  {
    "code": "001028",
    "parent": "001008",
    "tier": 3,
    "title": "서유럽 가이드투어"
  },
  {
    "code": "001029",
    "parent": "001008",
    "tier": 3,
    "title": "아프리카 가이드투어"
  },
  {
    "code": "001030",
    "parent": "001008",
    "tier": 3,
    "title": "오세아니아/남태평양 가이드투어"
  },
  {
    "code": "001031",
    "parent": "001008",
    "tier": 3,
    "title": "인도/중남아시아 가이드 투어"
  },
  {
    "code": "001032",
    "parent": "001008",
    "tier": 3,
    "title": "중국/일본 가이드투어"
  },
  {
    "code": "001033",
    "parent": "001008",
    "tier": 3,
    "title": "중남미 가이드투어"
  },
  {
    "code": "001034",
    "parent": "001008",
    "tier": 3,
    "title": "홍콩/마카오/대만/싱가폴 가이드 투어"
  },
  {
    "code": "001035",
    "parent": "001007",
    "tier": 2,
    "title": "공예제작"
  },
  {
    "code": "001036",
    "parent": "001035",
    "tier": 3,
    "title": "플라워 제작"
  },
  {
    "code": "001037",
    "parent": "001035",
    "tier": 3,
    "title": "꽃풍선 제작"
  },
  {
    "code": "001038",
    "parent": "001035",
    "tier": 3,
    "title": "캐릭터/이모티콘 제작"
  },
  {
    "code": "001039",
    "parent": "001035",
    "tier": 3,
    "title": "가구/목공예 제작"
  },
  {
    "code": "001040",
    "parent": "001035",
    "tier": 3,
    "title": "커스텀 제작"
  },
  {
    "code": "001041",
    "parent": "001035",
    "tier": 3,
    "title": "궂즈/판촉물 제작"
  },
  {
    "code": "001042",
    "parent": "001035",
    "tier": 3,
    "title": "수제도장 제작"
  },
  {
    "code": "001043",
    "parent": "001035",
    "tier": 3,
    "title": "수제악기 제작"
  },
  {
    "code": "001044",
    "parent": "001035",
    "tier": 3,
    "title": "액자 제작"
  },
  {
    "code": "001045",
    "parent": "001035",
    "tier": 3,
    "title": "가죽공예 제작"
  },
  {
    "code": "001046",
    "parent": "001035",
    "tier": 3,
    "title": "인형/인형옷 제작"
  },
  {
    "code": "001047",
    "parent": "001035",
    "tier": 3,
    "title": "미니어처/디오라마 제작"
  },
  {
    "code": "001048",
    "parent": "001035",
    "tier": 3,
    "title": "자수 제작"
  },
  {
    "code": "001049",
    "parent": "001035",
    "tier": 3,
    "title": "뜨개질/위빙 제작"
  },
  {
    "code": "001050",
    "parent": "001035",
    "tier": 3,
    "title": "리본공예 제작"
  },
  {
    "code": "001051",
    "parent": "001035",
    "tier": 3,
    "title": "웨딩소품 제작"
  },
  {
    "code": "001052",
    "parent": "001035",
    "tier": 3,
    "title": "패브릭 포스터 제작"
  },
  {
    "code": "001053",
    "parent": "001035",
    "tier": 3,
    "title": "캘리그라피 디자인"
  },
  {
    "code": "001054",
    "parent": "001035",
    "tier": 3,
    "title": "POP예쁜글씨 제작"
  },
  {
    "code": "001055",
    "parent": "001035",
    "tier": 3,
    "title": "초크아트 제작"
  },
  {
    "code": "001056",
    "parent": "001035",
    "tier": 3,
    "title": "트로피/상패 제작"
  },
  {
    "code": "001057",
    "parent": "001035",
    "tier": 3,
    "title": "얼음조각 제작"
  },
  {
    "code": "001058",
    "parent": "001035",
    "tier": 3,
    "title": "LED 제작"
  },
  {
    "code": "001059",
    "parent": "001035",
    "tier": 3,
    "title": "각인"
  },
  {
    "code": "001060",
    "parent": "001035",
    "tier": 3,
    "title": "도금(가구/설비/조형물 등)"
  },
  {
    "code": "001061",
    "parent": "001007",
    "tier": 2,
    "title": "의류/잡화"
  },
  {
    "code": "001062",
    "parent": "001061",
    "tier": 3,
    "title": "중고 골프채 구매"
  },
  {
    "code": "001063",
    "parent": "001061",
    "tier": 3,
    "title": "골프 피팅/수리"
  },
  {
    "code": "001064",
    "parent": "001061",
    "tier": 3,
    "title": "자전거 피팅/수리"
  },
  {
    "code": "001065",
    "parent": "001061",
    "tier": 3,
    "title": "명품 수선/리폼"
  },
  {
    "code": "001066",
    "parent": "001061",
    "tier": 3,
    "title": "수제화 제작"
  },
  {
    "code": "001067",
    "parent": "001061",
    "tier": 3,
    "title": "맞춤정장 제작"
  },
  {
    "code": "001068",
    "parent": "001061",
    "tier": 3,
    "title": "맞춤옷 제작"
  },
  {
    "code": "001069",
    "parent": "001061",
    "tier": 3,
    "title": "맞춤안경 제작"
  },
  {
    "code": "001070",
    "parent": "001061",
    "tier": 3,
    "title": "단체복 제작"
  },
  {
    "code": "001071",
    "parent": "001061",
    "tier": 3,
    "title": "단체티셔츠 제작"
  },
  {
    "code": "001072",
    "parent": "001061",
    "tier": 3,
    "title": "맞춤침구 제작"
  },
  {
    "code": "001073",
    "parent": "001007",
    "tier": 2,
    "title": "자동차"
  },
  {
    "code": "001074",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 외부수리"
  },
  {
    "code": "001075",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 정비"
  },
  {
    "code": "001076",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 튜닝"
  },
  {
    "code": "001077",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 썬팅"
  },
  {
    "code": "001078",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 랩핑"
  },
  {
    "code": "001079",
    "parent": "001073",
    "tier": 3,
    "title": "캠핑카 제작"
  },
  {
    "code": "001080",
    "parent": "001073",
    "tier": 3,
    "title": "오토바이 정비/수리"
  },
  {
    "code": "001081",
    "parent": "001073",
    "tier": 3,
    "title": "오토바이 튜닝"
  },
  {
    "code": "001082",
    "parent": "001073",
    "tier": 3,
    "title": "블랙박스/내비게이션 설치 및 수리"
  },
  {
    "code": "001083",
    "parent": "001073",
    "tier": 3,
    "title": "출장 세차"
  },
  {
    "code": "001084",
    "parent": "001073",
    "tier": 3,
    "title": "스팀 세차"
  },
  {
    "code": "001085",
    "parent": "001073",
    "tier": 3,
    "title": "디테일링세차/광택"
  },
  {
    "code": "001086",
    "parent": "001073",
    "tier": 3,
    "title": "신차 구매"
  },
  {
    "code": "001087",
    "parent": "001073",
    "tier": 3,
    "title": "중고차 구매"
  },
  {
    "code": "001088",
    "parent": "001073",
    "tier": 3,
    "title": "중고차 판매"
  },
  {
    "code": "001089",
    "parent": "001073",
    "tier": 3,
    "title": "자동차 구매 동행"
  },
  {
    "code": "001090",
    "parent": "001007",
    "tier": 2,
    "title": "대여/대관"
  },
  {
    "code": "001091",
    "parent": "001090",
    "tier": 3,
    "title": "노트북/PC 렌탈"
  },
  {
    "code": "001092",
    "parent": "001090",
    "tier": 3,
    "title": "가전제품 렌탈"
  },
  {
    "code": "001093",
    "parent": "001090",
    "tier": 3,
    "title": "헬스기구 렌탈"
  },
  {
    "code": "001094",
    "parent": "001090",
    "tier": 3,
    "title": "자판기 렌탈/구매"
  },
  {
    "code": "001095",
    "parent": "001090",
    "tier": 3,
    "title": "미술품 구매 및 렌탈"
  },
  {
    "code": "001096",
    "parent": "001090",
    "tier": 3,
    "title": "카메라 대여"
  },
  {
    "code": "001097",
    "parent": "001090",
    "tier": 3,
    "title": "음향기기 대여"
  },
  {
    "code": "001098",
    "parent": "001090",
    "tier": 3,
    "title": "밴드 악기 대여"
  },
  {
    "code": "001099",
    "parent": "001090",
    "tier": 3,
    "title": "클래식 악기 대여"
  },
  {
    "code": "001100",
    "parent": "001090",
    "tier": 3,
    "title": "국악기 대여"
  },
  {
    "code": "001101",
    "parent": "001090",
    "tier": 3,
    "title": "아동/유아도서 대여(동화책/전집)"
  },
  {
    "code": "001102",
    "parent": "001090",
    "tier": 3,
    "title": "아기용품/유아용품 대여"
  },
  {
    "code": "001103",
    "parent": "001090",
    "tier": 3,
    "title": "백일상/돌상 대여"
  },
  {
    "code": "001104",
    "parent": "001090",
    "tier": 3,
    "title": "의상 대여"
  },
  {
    "code": "001105",
    "parent": "001090",
    "tier": 3,
    "title": "물놀이바운스/슬라이드/풀장 대여"
  },
  {
    "code": "001106",
    "parent": "001090",
    "tier": 3,
    "title": "서핑보드/패들보드(SUP) 대여"
  },
  {
    "code": "001107",
    "parent": "001090",
    "tier": 3,
    "title": "캠핑용품 대여"
  },
  {
    "code": "001108",
    "parent": "001090",
    "tier": 3,
    "title": "매장관리(적립/대기/예약 시스템)"
  },
  {
    "code": "001109",
    "parent": "001090",
    "tier": 3,
    "title": "카드단말기/포스기/키오스크 대여"
  },
  {
    "code": "001110",
    "parent": "001090",
    "tier": 3,
    "title": "계측기 구매/대여(열화상카메라 등)"
  },
  {
    "code": "001111",
    "parent": "001090",
    "tier": 3,
    "title": "사다리차/스카이차 대여"
  },
  {
    "code": "001112",
    "parent": "001090",
    "tier": 3,
    "title": "굴착기 대여"
  },
  {
    "code": "001113",
    "parent": "001090",
    "tier": 3,
    "title": "스터디룸/회의실 대관"
  },
  {
    "code": "001114",
    "parent": "001090",
    "tier": 3,
    "title": "연습실 대관"
  },
  {
    "code": "001115",
    "parent": "001090",
    "tier": 3,
    "title": "녹음실 대관"
  },
  {
    "code": "001116",
    "parent": "001090",
    "tier": 3,
    "title": "스튜디오 대관"
  },
  {
    "code": "001117",
    "parent": "001090",
    "tier": 3,
    "title": "소극장/공연장 대관"
  },
  {
    "code": "001118",
    "parent": "001090",
    "tier": 3,
    "title": "사무실 임대"
  },
  {
    "code": "001119",
    "parent": "001090",
    "tier": 3,
    "title": "짐 보관"
  },
  {
    "code": "001120",
    "parent": "001090",
    "tier": 3,
    "title": "버스 대절"
  },
  {
    "code": "001121",
    "parent": "001007",
    "tier": 2,
    "title": "금융"
  },
  {
    "code": "001122",
    "parent": "001121",
    "tier": 3,
    "title": "재무 설계"
  },
  {
    "code": "001123",
    "parent": "001121",
    "tier": 3,
    "title": "보험 설계"
  },
  {
    "code": "001124",
    "parent": "001121",
    "tier": 3,
    "title": "보험 청구 상담"
  },
  {
    "code": "001125",
    "parent": "001121",
    "tier": 3,
    "title": "암 보험"
  },
  {
    "code": "001126",
    "parent": "001121",
    "tier": 3,
    "title": "화재 보험"
  },
  {
    "code": "001127",
    "parent": "001121",
    "tier": 3,
    "title": "자동차 보험"
  },
  {
    "code": "001128",
    "parent": "001121",
    "tier": 3,
    "title": "운전자 보험"
  },
  {
    "code": "001129",
    "parent": "001121",
    "tier": 3,
    "title": "여행자 보험"
  },
  {
    "code": "001130",
    "parent": "001121",
    "tier": 3,
    "title": "펫 보험"
  },
  {
    "code": "001131",
    "parent": "001007",
    "tier": 2,
    "title": "법률"
  },
  {
    "code": "001132",
    "parent": "001131",
    "tier": 3,
    "title": "종합 법률 상담"
  },
  {
    "code": "001133",
    "parent": "001131",
    "tier": 3,
    "title": "계약 법률 상담"
  },
  {
    "code": "001134",
    "parent": "001131",
    "tier": 3,
    "title": "금융 법률 상담"
  },
  {
    "code": "001135",
    "parent": "001131",
    "tier": 3,
    "title": "교통사고 법률 상담"
  },
  {
    "code": "001136",
    "parent": "001131",
    "tier": 3,
    "title": "건축/부동산 법률 상담"
  },
  {
    "code": "001137",
    "parent": "001131",
    "tier": 3,
    "title": "국방/병역 법률 상담"
  },
  {
    "code": "001138",
    "parent": "001131",
    "tier": 3,
    "title": "노동/인사 법률 상담"
  },
  {
    "code": "001139",
    "parent": "001131",
    "tier": 3,
    "title": "법률 서류 작성"
  },
  {
    "code": "001140",
    "parent": "001131",
    "tier": 3,
    "title": "보험 법률 상담"
  },
  {
    "code": "001141",
    "parent": "001131",
    "tier": 3,
    "title": "의료 법률 상담"
  },
  {
    "code": "001142",
    "parent": "001131",
    "tier": 3,
    "title": "이민 상담"
  },
  {
    "code": "001143",
    "parent": "001131",
    "tier": 3,
    "title": "지식재산 법률 상담"
  },
  {
    "code": "001144",
    "parent": "001131",
    "tier": 3,
    "title": "특허 출원"
  },
  {
    "code": "001145",
    "parent": "001131",
    "tier": 3,
    "title": "헌번/기본권 상담"
  },
  {
    "code": "001146",
    "parent": "001131",
    "tier": 3,
    "title": "일반 민사 소송"
  },
  {
    "code": "001147",
    "parent": "001131",
    "tier": 3,
    "title": "일반 형사 소송"
  },
  {
    "code": "001148",
    "parent": "001131",
    "tier": 3,
    "title": "가사 소송"
  },
  {
    "code": "001149",
    "parent": "001131",
    "tier": 3,
    "title": "이혼 소송"
  },
  {
    "code": "001150",
    "parent": "001131",
    "tier": 3,
    "title": "경제 소송"
  },
  {
    "code": "001151",
    "parent": "001131",
    "tier": 3,
    "title": "기업 소송"
  },
  {
    "code": "001152",
    "parent": "001131",
    "tier": 3,
    "title": "행정 소송"
  },
  {
    "code": "001153",
    "parent": "001131",
    "tier": 3,
    "title": "단체소송/집단소송"
  },
  {
    "code": "001154",
    "parent": "001131",
    "tier": 3,
    "title": "손해배상/산업재해"
  },
  {
    "code": "001155",
    "parent": "001007",
    "tier": 2,
    "title": "그 외"
  },
  {
    "code": "001156",
    "parent": "001155",
    "tier": 3,
    "title": "악기 조율/수리"
  },
  {
    "code": "001157",
    "parent": "001155",
    "tier": 3,
    "title": "작명"
  },
  {
    "code": "001158",
    "parent": "001155",
    "tier": 3,
    "title": "보청기 제작"
  },
  {
    "code": "001159",
    "parent": "001155",
    "tier": 3,
    "title": "강연자 섭외"
  }
]""";