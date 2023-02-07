class MemberBody {
  String? uid;
  List<String>? workArea;
  String? career;
  String? location;
  String? gender;
  String? age;
  String? capability;
  String? introduction;
  String? docId;

  MemberBody(
      {this.uid,
      this.workArea,
      this.career,
      this.location,
      this.gender,
      this.age,
      this.capability,
      this.introduction,
      this.docId});

  MemberBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    workArea = json['workArea'];
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
    data['workArea'] = this.workArea;
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
