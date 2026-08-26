class AppUser {
  final int id;
  final String name;
  final String email;
  final String role;
  final String status;
  final bool trustedDevice;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.trustedDevice = false,
  });

  factory AppUser.fromJson(
    Map<String, dynamic> json, {
    bool trustedDevice = false,
  }) {
    return AppUser(
      id: json['id'] as int,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      trustedDevice: trustedDevice,
    );
  }

  bool get isManager => role == 'manager';

  bool get isAccountant => role == 'accountant';
}
