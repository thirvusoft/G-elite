class CallNotification {
  final String user;
  final String description;
  final String owner;

  CallNotification({
    required this.user,
    required this.description,
    required this.owner,
  });

  factory CallNotification.fromJson(Map<String, dynamic> json) {
    return CallNotification(
      user: json['user'] ?? '',
      description: json['description'] ?? '',
      owner: json['owner'] ?? '',
    );
  }
}
