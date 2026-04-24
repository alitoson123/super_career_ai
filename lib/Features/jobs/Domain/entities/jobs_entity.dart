class JobEntity {
  final int id;
  final int matchScore;
  final String title;
  final String company;
  final String description;
  final String location;
  final String sourcePlatform;
  final String sourceUrl;
  final String? postedDate;
  final DateTime? scrapedAt;

  JobEntity({
    required this.id,
    required this.matchScore,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.sourcePlatform,
    required this.sourceUrl,
    required this.postedDate,
    required this.scrapedAt,
  });
}
