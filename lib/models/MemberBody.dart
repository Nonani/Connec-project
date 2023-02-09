class MemberBody {
  String? uid;
  List<String>? workArea;
  List<String>? personality;
  String? career;
  String? location;
  String? gender;
  String? age;
  String? capability;
  String? introduction;
  double? rate;
  String? docId;

  MemberBody(
      {this.uid,
      this.workArea,
      this.career,
      this.location,
      this.gender,
      this.age,
      this.personality,
      this.introduction,
      this.rate,
      this.docId});

  MemberBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    workArea = json['workArea'];
    career = json['career'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    personality = json['personality'];
    introduction = json['introduction'];
    rate = json['rate'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['workArea'] = this.workArea;
    data['career'] = this.career;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['personality'] = this.personality;
    data['introduction'] = this.introduction;
    data['rate'] = this.rate;
    data['docId'] = this.docId;
    return data;
  }
}
