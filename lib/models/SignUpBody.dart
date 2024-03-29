class SignUpBody {
  String? uid;
  String? uuid;
  String? serviceName;
  String? email;
  String? password;
  String? name;
  String? work;
  List<String>? workArea;
  List<String>? personality;
  List<String>? career;
  String? location;
  String? gender;
  String? age;
  String? introduction;
  double? rate;

  SignUpBody(
      {this.uid,
      this.uuid,
      this.serviceName,
      this.email,
      this.password,
      this.name,
      this.work,
      this.workArea,
      this.personality,
      this.career,
      this.location,
      this.gender,
      this.age,
      this.introduction,
      this.rate});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uuid = json['uuid'];
    serviceName = json['serviceName'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    work = json['work'];
    workArea = json['workArea'];
    personality = json['personality'];
    career = json['career'];
    location = json['location'];
    gender = json['gender'];
    age = json['age'];
    introduction = json['introduction'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = this.uid;
    data['uuid'] = this.uuid;
    data['serviceName'] = this.serviceName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['work'] = this.work;
    data['workArea'] = this.workArea;
    data['personality'] = this.personality;
    data['career'] = this.career;
    data['location'] = this.location;
    data['gender'] = this.gender;
    data['age'] = this.age;
    data['introduction'] = this.introduction;
    data['rate'] = this.rate;
    return data;
  }
}
