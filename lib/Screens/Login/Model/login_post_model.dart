class Login {
  String? username;
  String? otp;
  String? pushToken;
  String? apnsToken;

  Login({this.username, this.otp});

  Login.fromJson(Map<String, dynamic> json) {
    username = json['phone'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['phone'] = username;
    return data;
  }

  @override
  String toString() {
    return '{ username:$username}';
  }
}
