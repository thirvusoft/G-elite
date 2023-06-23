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

class MyModel {
  String image;
  String description;
  String offerMsg;

  MyModel(
      {required this.image, required this.description, required this.offerMsg});

  factory MyModel.fromJson(Map<String, dynamic> json) {
    return MyModel(
      image: json['image'],
      description: json['description'],
      offerMsg: json['offer_msg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'description': description,
      'offer_msg': offerMsg,
    };
  }
}
