class UserModel {
  final int id;
  final String name;
  final String email;
  final String? phone;
  final String? photo;
  final bool? isPremium;
  final String? createdAt;
  final String? district;
  final List<int>? targetCategories;
  final String? deviceToken;
  final Map<String, dynamic>? notificationPreferences;
  final int? totalPoints;
  final int? totalExams;
  final List<String>? roles;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photo,
    this.isPremium,
    this.createdAt,
    this.district,
    this.targetCategories,
    this.deviceToken,
    this.notificationPreferences,
    this.totalPoints,
    this.totalExams,
    this.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      photo: json['photo'] ?? json['photo_url'],
      isPremium: json['is_premium'] ?? false,
      createdAt: json['created_at']?.toString(),
      district: json['district'],
      targetCategories: json['target_categories'] != null
          ? List<int>.from(json['target_categories'] as List)
          : null,
      deviceToken: json['device_token'],
      notificationPreferences: json['notification_preferences'] != null
          ? Map<String, dynamic>.from(json['notification_preferences'] as Map)
          : null,
      totalPoints: json['total_points'] != null ? int.tryParse(json['total_points'].toString()) : null,
      totalExams: json['total_exams'] != null ? int.tryParse(json['total_exams'].toString()) : null,
      roles: json['roles'] != null ? List<String>.from(json['roles'] as List) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'is_premium': isPremium,
      'created_at': createdAt,
      'district': district,
      'target_categories': targetCategories,
      'device_token': deviceToken,
      'notification_preferences': notificationPreferences,
      'roles': roles,
    };
  }

  bool hasRole(String role) {
    return roles != null && roles!.contains(role);
  }

  bool get isAdmin => hasRole('admin') || hasRole('super_admin');
  bool get isEmployer => hasRole('employer');
  bool get isStudent => hasRole('student') || roles == null || roles!.isEmpty;
}
