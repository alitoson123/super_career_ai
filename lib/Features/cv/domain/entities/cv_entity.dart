class CvEntity {
  const CvEntity({
    required this.personalInfo,
    required this.workExperiences,
    required this.educations,
    required this.skills,
  });

  final PersonalInfoEntity personalInfo;
  final List<WorkExperienceEntity> workExperiences;
  final List<EducationEntity> educations;
  final List<String> skills;

  CvEntity copyWith({
    PersonalInfoEntity? personalInfo,
    List<WorkExperienceEntity>? workExperiences,
    List<EducationEntity>? educations,
    List<String>? skills,
  }) {
    return CvEntity(
      personalInfo: personalInfo ?? this.personalInfo,
      workExperiences: workExperiences ?? this.workExperiences,
      educations: educations ?? this.educations,
      skills: skills ?? this.skills,
    );
  }

  bool get isValid =>
      personalInfo.isValid &&
      workExperiences.every((e) => e.isValid) &&
      educations.every((e) => e.isValid) &&
      skills.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      "Personal Details": personalInfo.toJson(),
      "Experience": workExperiences.map((e) => e.toJson()).toList(),
      "Education": educations.map((e) => e.toJson()).toList(),
      "Skills": skills,
    };
  }
}

class PersonalInfoEntity {
  const PersonalInfoEntity({
    required this.fullName,
    required this.professionalTitle,
    required this.email,
    required this.phone,
    required this.location,
    required this.summary,
    required this.portfolioUrl,
  });

  final String fullName;
  final String professionalTitle;
  final String email;
  final String phone;
  final String location;
  final String summary;
  final String portfolioUrl;

  PersonalInfoEntity copyWith({
    String? fullName,
    String? professionalTitle,
    String? email,
    String? phone,
    String? location,
    String? summary,
    String? portfolioUrl,
  }) {
    return PersonalInfoEntity(
      fullName: fullName ?? this.fullName,
      professionalTitle: professionalTitle ?? this.professionalTitle,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      summary: summary ?? this.summary,
      portfolioUrl: portfolioUrl ?? this.portfolioUrl,
    );
  }

  bool get isValid =>
      fullName.isNotEmpty &&
      professionalTitle.isNotEmpty &&
      email.isNotEmpty &&
      phone.isNotEmpty &&
      location.isNotEmpty &&
      summary.isNotEmpty &&
      portfolioUrl.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      "Full Name": fullName,
      "Phone Number": phone,
      "Professional Title": professionalTitle,
      "Email Address": email,
      "Location": location,
      "Portfolio / LinkedIn URL": portfolioUrl,
      "Professional Summary": summary,
    };
  }

  static PersonalInfoEntity empty() => const PersonalInfoEntity(
        fullName: '',
        professionalTitle: '',
        email: '',
        phone: '',
        location: '',
        summary: '',
        portfolioUrl: '',
      );
}

class WorkExperienceEntity {
  const WorkExperienceEntity({
    required this.jobTitle,
    required this.company,
    required this.startDate,
    required this.endDate,
    required this.isCurrentJob,
    required this.description,
  });

  final String jobTitle;
  final String company;
  final String startDate;
  final String endDate;
  final bool isCurrentJob;
  final String description;

  WorkExperienceEntity copyWith({
    String? jobTitle,
    String? company,
    String? startDate,
    String? endDate,
    bool? isCurrentJob,
    String? description,
  }) {
    return WorkExperienceEntity(
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentJob: isCurrentJob ?? this.isCurrentJob,
      description: description ?? this.description,
    );
  }

  bool get isValid =>
      jobTitle.isNotEmpty &&
      company.isNotEmpty &&
      startDate.isNotEmpty &&
      (isCurrentJob || endDate.isNotEmpty) &&
      description.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      "I currently work here": isCurrentJob,
      "Job Title": jobTitle,
      "Company": company,
      "Start Date": startDate,
      "End Date": isCurrentJob ? "Present" : endDate,
      "Description": description,
    };
  }

  static WorkExperienceEntity empty() => const WorkExperienceEntity(
        jobTitle: '',
        company: '',
        startDate: '',
        endDate: '',
        isCurrentJob: false,
        description: '',
      );
}

class EducationEntity {
  const EducationEntity({
    required this.school,
    required this.degree,
    required this.graduationYear,
    required this.description,
  });

  final String school;
  final String degree;
  final String graduationYear;
  final String description;

  EducationEntity copyWith({
    String? school,
    String? degree,
    String? graduationYear,
    String? description,
  }) {
    return EducationEntity(
      school: school ?? this.school,
      degree: degree ?? this.degree,
      graduationYear: graduationYear ?? this.graduationYear,
      description: description ?? this.description,
    );
  }

  bool get isValid =>
      school.isNotEmpty &&
      degree.isNotEmpty &&
      graduationYear.isNotEmpty &&
      description.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      "School / University": school,
      "Degree / Qualification": degree,
      "Year of Graduation": graduationYear,
      "Additional Details": description,
    };
  }

  static EducationEntity empty() => const EducationEntity(
        school: '',
        degree: '',
        graduationYear: '',
        description: '',
      );
}
