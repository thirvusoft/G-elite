class Event {
  String name;
  DateTime startsOn;

  Event({required this.name, required this.startsOn});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'] ?? '',
      startsOn: DateTime.parse(json['starts_on'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'starts_on': startsOn.toIso8601String(),
    };
  }
}

class Events {
  String name;
  DateTime startsOn;

  Events({required this.name, required this.startsOn});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      name: json['name'] ?? '',
      startsOn: DateTime.parse(json['starts_on'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'starts_on': startsOn.toIso8601String(),
    };
  }
}

class Eventadmin {
  final String subject;
  final String startsOn;
  final String name;

  Eventadmin({required this.subject, required this.startsOn, required this.name});

  factory Eventadmin.fromJson(Map<String, dynamic> json) {
    return Eventadmin(
      subject: json['subject'],
      startsOn: json['starts_on'],
      name: json['name'],
    );
  }
}
