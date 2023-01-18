class SignUpBody {
  String? uid;
  String? uuid;
  String? serviceName;
  String? email;
  String? password;
  String? name;
  List<String>? work;
  String? career;
  String? location;
  String? gender;
  String? age;
  String? capability;
  String? introduction;

  SignUpBody(
      {this.uid,
        this.uuid,
        this.serviceName,
        this.email,
        this.password,
        this.name,
        this.work,
        this.career,
        this.location,
        this.gender,
        this.age,
        this.capability,
        this.introduction});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    uuid = json['uuid'];
    serviceName = json['serviceName'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
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
    data['uuid'] = this.uuid;
    data['serviceName'] = this.serviceName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
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