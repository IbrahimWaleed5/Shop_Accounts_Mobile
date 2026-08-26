class AccountRequestModel {
  final int id;
  final String name;
  final String email;
  final String role;
  final String status;
  final DateTime? requestedAt;
  final DateTime? reviewedAt;
  final String? reviewedByName;
  final String? rejectionReason;

  const AccountRequestModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    this.requestedAt,
    this.reviewedAt,
    this.reviewedByName,
    this.rejectionReason,
  });

  factory AccountRequestModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AccountRequestModel(
      id:
          (json['id'] as num).toInt(),
      name:
          json['name'].toString(),
      email:
          json['email'].toString(),
      role:
          json['role'].toString(),
      status:
          json['status'].toString(),
      requestedAt:
          json['requested_at'] == null
              ? null
              : DateTime.parse(
                  json['requested_at']
                      .toString(),
                ),
      reviewedAt:
          json['reviewed_at'] == null
              ? null
              : DateTime.parse(
                  json['reviewed_at']
                      .toString(),
                ),
      reviewedByName:
          json['reviewed_by_name']
              ?.toString(),
      rejectionReason:
          json['rejection_reason']
              ?.toString(),
    );
  }

  bool get isPending =>
      status == 'pending';

  bool get isApproved =>
      status == 'active';

  bool get isRejected =>
      status == 'rejected';
}
