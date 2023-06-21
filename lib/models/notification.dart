class CallNotification {
  final String user;
  final String description;
  final String owner;
  final String username;
  final String date;

  CallNotification({
    required this.user,
    required this.description,
    required this.owner,
    required this.username,
    required this.date,
  });

  factory CallNotification.fromJson(Map<String, dynamic> json) {
    return CallNotification(
      user: json['user'] ?? '',
      description: json['description'] ?? '',
      owner: json['owner'] ?? '',
      username: json['user_name'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
