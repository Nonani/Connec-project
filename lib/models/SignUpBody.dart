class SignUpBody {
  String? uid;
  String? email;
  String? password;
  String? name;
  String? work;
  List<String>? career;
  String? location;
  String? gender;
  String? birth;
  double? rate;
  String? phoneNum;
  String? profileImageUrl;

  SignUpBody(
      {this.uid,
      this.email,
      this.password,
      this.name,
      this.work,
      this.location,
      this.gender,
      this.birth,
      this.phoneNum,
      this.profileImageUrl,
      this.rate});

  SignUpBody.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    email = json['email'];
    password = json['password'];
    name = json['name'];
    work = json['work'];
    location = json['location'];
    gender = json['gender'];
    phoneNum = json['phoneNum'];
    birth = json['age'];
    profileImageUrl = json['profile_image_url'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['work'] = work;
    data['location'] = location;
    data['phoneNum'] = phoneNum;
    data['gender'] = gender;
    data['age'] = birth;
    data['profile_image_url'] = profileImageUrl;
    data['rate'] = rate;
    return data;
  }
}
