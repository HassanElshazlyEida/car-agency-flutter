class UserModel {
  String? id;
  String? name;
  String? email;
  String? phone;

  UserModel({this.name, this.email, this.phone, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'image': id,
    };
  }
}