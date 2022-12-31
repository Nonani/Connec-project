class MemberBody {
  String? uid;
  String? work;
  String? career;
  String? location;
  String? gender;
  String? age;
  String? capability;
  String? introduction;

  MemberBody(
      {this.uid,
        this.work,
        this.career,
        this.location,
        this.gender,
        this.age,
        this.capability,
        this.introduction});

  MemberBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    work = json['work'];
    career = json['career'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    capability = json['capability'];
    introduction = json['introduction'];
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
    return data;
  }

}