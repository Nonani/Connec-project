import 'JobType.dart';

class JobSubType {
  final String name;
  final String code;

  JobSubType(this.name, this.code);
}

final Map<String, List<JobSubType>> subTypes = {
  jobTypes[0].code: [
    JobSubType('안드로이드 앱 개발', '001'),
    JobSubType('ios 앱 개발', '002'),
    JobSubType('웹사이트 개발', '003'),
    JobSubType('게임 개발', '004'),
    JobSubType('매크로 개발', '005'),
    JobSubType('챗봇 개발', '006'),
    JobSubType('프로그램 개발', '007'),
    JobSubType('서버 개발', '008'),
    JobSubType('데이터 관리', '009'),
    JobSubType('데이터 분석', '010'),
    JobSubType('인공지능 개발', '011'),
    JobSubType('블록체인 개발', '012'),
    JobSubType('NFT 개발', '013'),
    JobSubType('메타버스 개발', '014'),
    JobSubType('VR 개발', '015'),
    JobSubType('AR 개발', '016'),
    JobSubType('보안', '017'),
    JobSubType('개발 PM', '018'),
    JobSubType('개발 기획', '019'),
    JobSubType('백엔드 개발', '020'),
    JobSubType('프론트 개발', '021'),
    JobSubType('풀스택 개발', '022'),
  ],
  jobTypes[1].code: [
    JobSubType('앱', '101'),
    JobSubType('웹사이트', '102'),
    JobSubType('제품 제조', '103'),
    JobSubType('제품 유통', '104'),
    JobSubType('식품 제조', '105'),
    JobSubType('식품 유통', '106'),
    JobSubType('컨설팅', '107'),
    JobSubType('중개업', '108'),
    JobSubType('영업', '109'),
    JobSubType('오프라인 매장', '110'),
    JobSubType('투자', '111'),

  ]
};
