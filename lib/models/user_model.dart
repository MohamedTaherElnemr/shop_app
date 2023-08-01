class UserData {
  bool? status;
  String? message;
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData(this.status, this.message, this.id, this.name, this.email,
      this.phone, this.image, this.points, this.credit, this.token);

  UserData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    id = json['data']['id'];
    name = json['data']['name'];
    email = json['data']['email'];
    phone = json['data']['phone'];
    image = json['data']['image'];
    points = json['data']['points'];
    credit = json['data']['credit'];
    token = json['data']['token'];
  }
}
