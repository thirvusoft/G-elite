class User {
  String fullName;
  String kootamKovil;
  String userImage;
  String mobileNuber;

  User({
    required this.fullName,
    required this.kootamKovil,
    required this.userImage,
    required this.mobileNuber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['full_name'],
      kootamKovil: json['kootam_kovil'],
      userImage: json['user_image'],
      mobileNuber: json['mobile_no'],
    );
  }
}
