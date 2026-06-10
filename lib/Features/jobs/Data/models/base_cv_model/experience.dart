class Experience {
  bool? iCurrentlyWorkHere;
  String? jobTitle;
  String? company;
  String? startDate;
  String? endDate;
  String? description;

  Experience({
    this.iCurrentlyWorkHere,
    this.jobTitle,
    this.company,
    this.startDate,
    this.endDate,
    this.description,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    iCurrentlyWorkHere: json['I currently work here'] as bool?,
    jobTitle: json['Job Title'] as String?,
    company: json['Company'] as String?,
    startDate: json['Start Date'] as String?,
    endDate: json['End Date'] as String?,
    description: json['Description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'I currently work here': iCurrentlyWorkHere,
    'Job Title': jobTitle,
    'Company': company,
    'Start Date': startDate,
    'End Date': endDate,
    'Description': description,
  };
}
