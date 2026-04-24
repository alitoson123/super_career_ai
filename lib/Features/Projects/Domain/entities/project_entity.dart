class ProjectEntity {
  final int id;
  final String title;
  final String description;
  final String? budget;
  final dynamic deadline;
  final String? duration;
  final String status;
  final List<dynamic> requiredSkills;
  final String platformName;
  final String sourceUrl;
  final String? postedDate;
  final DateTime? scrapedAt;
  final int matchScore;

  ProjectEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.budget,
    required this.deadline,
    required this.duration,
    required this.status,
    required this.requiredSkills,
    required this.platformName,
    required this.sourceUrl,
    required this.postedDate,
    required this.scrapedAt,
    required this.matchScore,
  });
}
