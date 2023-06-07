class UserDetails {
  String fullName;
  String fathersName;
  String mothersName;
  String territory;
  String kootamKovil;
  String userImage;
  String aadharNo;
  String companyName;
  String industryType;
  String mobileNo;
  String emailID;

  UserDetails({
    required this.fullName,
    required this.fathersName,
    required this.mothersName,
    required this.territory,
    required this.kootamKovil,
    required this.userImage,
    required this.aadharNo,
    required this.companyName,
    required this.industryType,
    required this.mobileNo,
    required this.emailID,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      fullName: json['full_name'] ?? '',
      fathersName: json['fathers_name'] ?? '',
      mothersName: json['mothers_name'] ?? '',
      territory: json['territory'] ?? '',
      kootamKovil: json['kootam_kovil'] ?? '',
      userImage: json['user_image'] ?? '',
      aadharNo: json['aadhar_no'] ?? '',
      companyName: json['company_name'] ?? '',
      industryType: json['industry_type'] ?? '',
      mobileNo: json['mobile_no'] ?? '',
      emailID: json['email'] ?? '',
    );
  }
}
