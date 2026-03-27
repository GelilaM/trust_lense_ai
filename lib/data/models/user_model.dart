class UserModel {
  final String id;
  final String fullName;
  final String phone;
  final String sex;
  final String? dateOfBirth;
  final String? nationality;
  final String occupation;
  final String businessType;
  final double monthlyIncome;

  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.sex,
    this.dateOfBirth,
    this.nationality,
    required this.occupation,
    required this.businessType,
    required this.monthlyIncome,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['full_name'],
      phone: json['phone'],
      sex: json['sex'],
      dateOfBirth: json['date_of_birth'],
      nationality: json['nationality'],
      occupation: json['occupation'],
      businessType: json['business_type'],
      monthlyIncome: (json['monthly_income'] as num).toDouble(),
    );
  }
}
