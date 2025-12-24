class UserRole {
  final bool status;
  final int? id;
  final String? phone;
  final String? role;
  final String? message;

  // Keep ONLY the first constructor
  UserRole(
      this.status,
      this.id,
      this.role,
      this.message, {
        required this.phone,
      });
  UserRole.withPhone(String this.phone): status = false,
        id = null,
        role = null,
        message = null;
  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      json['status'] ?? false,
      json['data']?['id'],
      json['data']?['role'],
      json['message'],
      phone: json['data']?['phone'] ?? "", // required so must pass something
    );
  }
}
