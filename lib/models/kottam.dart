class Kottam {
  List<String> kottam = [];

  Kottam({required this.kottam});

  Kottam.fromJson(Map<String, dynamic> json) {
    kottam = List<String>.from(json['Kottam']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['Kottam'] = this.kottam;
    return data;
  }
}
