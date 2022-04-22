class UserLoginModel {
  String user_id = '';
  String user_channel = '';
  String user_name = '';
  String user_phone = '';
  String user_email = '';
  String user_grade = '';
  String user_period = '';
  String user_fav = '';
  String user_history = '';

  UserLoginModel(
      {user_id,
      user_channel,
      user_name,
      user_phone,
      user_email,
      user_grade,
      user_period,
      user_fav,
      user_history});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    this.user_id = json['user_id'];
    this.user_channel = json['user_channel'];
    this.user_name = json['user_name'];
    this.user_phone = json['user_phone'];
    this.user_email = json['user_email'];
    this.user_grade = json['user_grade'];
    this.user_period = json['user_period'];
    this.user_fav = json['user_fav'];
    this.user_history = json['user_history'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.user_id;
    data['user_channel'] = this.user_channel;
    data['user_name'] = this.user_name;
    data['user_phone'] = this.user_phone;
    data['user_email'] = this.user_email;
    data['user_grade'] = this.user_grade;
    data['user_period'] = this.user_period;
    data['user_fav'] = this.user_fav;
    data['user_history'] = this.user_history;
    return data;
  }
}
