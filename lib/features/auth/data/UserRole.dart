class UserRole {
  final String id;
  final String roleName;

  UserRole({required this.id, required this.roleName});

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'], // or 'userRoleId'
      roleName: json['roleName'], // or 'name'
    );
  }
}