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

class FamilyDetails {
  final String fathersName;
  final String mothersName;
  final String? spouseHusbandName;
  final String? spouseHusbandMobileNumber;
  final String? spouseHusbandKootamKovil;
  final String? anniversaryDate;
  final List<ChildDetails> childrenDetails;

  FamilyDetails({
    required this.fathersName,
    required this.mothersName,
    this.spouseHusbandName,
    this.spouseHusbandMobileNumber,
    this.spouseHusbandKootamKovil,
    this.anniversaryDate,
    required this.childrenDetails,
  });

  factory FamilyDetails.fromJson(Map<String, dynamic> json) {
    List<dynamic> childrenJson = json['children_details'] ?? [];
    List<ChildDetails> childrenDetails = childrenJson
        .map((childJson) => ChildDetails.fromJson(childJson))
        .toList();

    return FamilyDetails(
      fathersName: json['fathers_name'] ?? '',
      mothersName: json['mothers_name'] ?? '',
      spouseHusbandName: json['spousehusband_name'] ?? '',
      spouseHusbandMobileNumber: json['spousehusband_mobile_no'] ?? '',
      spouseHusbandKootamKovil: json['spousehusband_kootam_kovil'] ?? '',
      anniversaryDate: json['anniversary_date'] ?? '',
      childrenDetails: childrenDetails,
    );
  }
}

class ChildDetails {
  final String dateOfBirth;
  final String name;
  final int age;
  final String educationOccupation;

  ChildDetails({
    required this.dateOfBirth,
    required this.name,
    required this.age,
    required this.educationOccupation,
  });

  factory ChildDetails.fromJson(Map<String, dynamic> json) {
    return ChildDetails(
      dateOfBirth: json['date_of_birth'],
      name: json['name1'],
      age: json['age'],
      educationOccupation: json['education_occupation'],
    );
  }
}

class OrganisationDetails {
  final String companyName;
  final String industryType;
  final String? address;

  OrganisationDetails({
    required this.companyName,
    required this.industryType,
    this.address,
  });

  factory OrganisationDetails.fromJson(Map<String, dynamic> json) {
    return OrganisationDetails(
      companyName: json['company_name'] ?? '',
      industryType: json['industry_type'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
