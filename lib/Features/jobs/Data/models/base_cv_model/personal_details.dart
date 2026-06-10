class PersonalDetails {
  String? fullName;
  String? phoneNumber;
  String? professionalTitle;
  String? emailAddress;
  String? location;
  String? portfolioLinkedInUrl;
  String? professionalSummary;

  PersonalDetails({
    this.fullName,
    this.phoneNumber,
    this.professionalTitle,
    this.emailAddress,
    this.location,
    this.portfolioLinkedInUrl,
    this.professionalSummary,
  });

  factory PersonalDetails.fromJson(Map<String, dynamic> json) {
    return PersonalDetails(
      fullName: json['Full Name'] as String?,
      phoneNumber: json['Phone Number'] as String?,
      professionalTitle: json['Professional Title'] as String?,
      emailAddress: json['Email Address'] as String?,
      location: json['Location'] as String?,
      portfolioLinkedInUrl: json['Portfolio / LinkedIn URL'] as String?,
      professionalSummary: json['Professional Summary'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'Full Name': fullName,
    'Phone Number': phoneNumber,
    'Professional Title': professionalTitle,
    'Email Address': emailAddress,
    'Location': location,
    'Portfolio / LinkedIn URL': portfolioLinkedInUrl,
    'Professional Summary': professionalSummary,
  };
}
