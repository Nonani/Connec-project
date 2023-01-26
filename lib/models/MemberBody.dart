class MemberBody {
  String? uid;
  List<String>? work;
  String? career;
  String? location;
  String? gender;
  String? age;
  String? capability;
  String? introduction;
  String? docId;

  MemberBody(
      {this.uid,
      this.work,
      this.career,
      this.location,
      this.gender,
      this.age,
      this.capability,
      this.introduction,
      this.docId});

  MemberBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    work = json['work'];
    career = json['career'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    capability = json['capability'];
    introduction = json['introduction'];
    docId = json['docId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['work'] = this.work;
    data['career'] = this.career;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['capability'] = this.capability;
    data['introduction'] = this.introduction;
    data['docId'] = this.docId;
    return data;
  }
}
