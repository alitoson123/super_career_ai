import 'education.dart';
import 'experience.dart';
import 'personal_details.dart';

class BaseCvModel {
  int? id;
  int? user;
  dynamic job;
  bool? isBase;
  PersonalDetails? personalDetails;
  List<Experience>? experience;
  List<Education>? education;
  List<dynamic>? skills;
  double? atsScore;
  DateTime? createdAt;

  BaseCvModel({
    this.id,
    this.user,
    this.job,
    this.isBase,
    this.personalDetails,
    this.experience,
    this.education,
    this.skills,
    this.atsScore,
    this.createdAt,
  });

  factory BaseCvModel.fromJson(Map<String, dynamic> json) => BaseCvModel(
    id: json['id'] as int?,
    user: json['user'] as int?,
    job: json['job'] as dynamic,
    isBase: json['is_base'] as bool?,
    personalDetails: json['Personal Details'] == null
        ? null
        : PersonalDetails.fromJson(
            json['Personal Details'] as Map<String, dynamic>,
          ),
    experience: (json['Experience'] as List<dynamic>?)
        ?.map((e) => Experience.fromJson(e as Map<String, dynamic>))
        .toList(),
    education: (json['Education'] as List<dynamic>?)
        ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
        .toList(),
    skills: json['Skills'] as List<dynamic>?,
    atsScore: json['ats_score'] as double?,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user': user,
    'job': job,
    'is_base': isBase,
    'Personal Details': personalDetails?.toJson(),
    'Experience': experience?.map((e) => e.toJson()).toList(),
    'Education': education?.map((e) => e.toJson()).toList(),
    'Skills': skills,
    'ats_score': atsScore,
    'created_at': createdAt?.toIso8601String(),
  };
}
