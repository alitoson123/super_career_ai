class ProfileModel {
  final int id;
  final int user;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final String? fullName;
  final String? professionalTitle;

  ProfileModel({
    required this.id,
    required this.user,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.fullName,
    required this.professionalTitle,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      user: (json['user'] as num?)?.toInt() ?? 0,
      firstName: json['first_name']?.toString(),
      lastName: json['last_name']?.toString(),
      email: json['email']?.toString(),
      username: json['username']?.toString(),
      fullName: json['full_name']?.toString(),
      professionalTitle: json['professional_title']?.toString(),
    );
  }

  Map<String, dynamic> toPatchJson({
    String? fullName,
    String? professionalTitle,
    String? email,
  }) {
    final map = <String, dynamic>{};
    if (fullName != null) map['full_name'] = fullName;
    if (professionalTitle != null)
      map['professional_title'] = professionalTitle;
    if (email != null) map['email'] = email;
    return map;
  }

  ProfileModel copyWith({
    String? fullName,
    String? professionalTitle,
    String? email,
  }) {
    return ProfileModel(
      id: id,
      user: user,
      firstName: firstName,
      lastName: lastName,
      email: email ?? this.email,
      username: username,
      fullName: fullName ?? this.fullName,
      professionalTitle: professionalTitle ?? this.professionalTitle,
    );
  }
}
