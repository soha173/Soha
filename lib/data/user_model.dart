class UserModel {
  final String? name;
  final String? pass;
  final String? confirmationPass;
  final String? gender;
  final String email;
  final String? phone;

  UserModel({
    this.name,
    this.pass,
    this.confirmationPass,
    this.gender,
    required this.email,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name']?.toString(),
      pass: json['password']?.toString(),
      confirmationPass: json['password_confirmation']?.toString(),
      gender: json['gender']?.toString(),
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'password': pass,
      'password_confirmation': confirmationPass,
      'gender': gender,
      'email': email,
      'phone': phone,
    };
  }
}
