class Education {
  String? schoolUniversity;
  String? degreeQualification;
  String? yearOfGraduation;
  String? additionalDetails;

  Education({
    this.schoolUniversity,
    this.degreeQualification,
    this.yearOfGraduation,
    this.additionalDetails,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    schoolUniversity: json['School / University'] as String?,
    degreeQualification: json['Degree / Qualification'] as String?,
    yearOfGraduation: json['Year of Graduation'] as String?,
    additionalDetails: json['Additional Details'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'School / University': schoolUniversity,
    'Degree / Qualification': degreeQualification,
    'Year of Graduation': yearOfGraduation,
    'Additional Details': additionalDetails,
  };
}
