class Profile {
  String fullName;
  String territory;
  String kootamKovil;
  String userImage;
  String mobileNo;
  String birthDate;
  String bloodGroup;
  String aadharNo;

  Profile({
    required this.fullName,
    required this.territory,
    required this.kootamKovil,
    required this.userImage,
    required this.mobileNo,
    required this.birthDate,
    required this.bloodGroup,
    required this.aadharNo,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      fullName: json['full_name'] ?? '',
      territory: json['territory'] ?? '',
      kootamKovil: json['kootam_kovil'] ?? '',
      userImage: json['user_image'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      birthDate: json['birth_date'] ?? '',
      bloodGroup: json['blood_group'] ?? '',
      aadharNo: json['aadhar_no'] ?? '',
    );
  }
}

class Banner {
  final String image;
  final String description;
  final String offerMsg;
  final String tittle;

  Banner(
      {required this.image,
      required this.description,
      required this.offerMsg,
      required this.tittle});

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      image: (json['image'] == "")
          ? "https://images.unsplash.com/photo-1614850715649-1d0106293bd1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80"
          : json['image'],
      description: json['description'] ?? '',
      offerMsg: json['offer_msg'] ?? '',
      tittle: json['tittle'] ?? '',
    );
  }
}

List<Banner> parseBanners(List<dynamic> json) {
  return json.map((item) => Banner.fromJson(item)).toList();
}
