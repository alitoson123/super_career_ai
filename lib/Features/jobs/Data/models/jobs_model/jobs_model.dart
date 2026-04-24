import 'package:super_career_ai/Features/jobs/Domain/entities/jobs_entity.dart';

class JobsModel extends JobEntity {
  JobsModel({
    required super.id,
    required super.matchScore,
    required super.title,
    required super.company,
    required super.description,
    required super.location,
    required super.sourcePlatform,
    required super.sourceUrl,
    super.postedDate,
    super.scrapedAt,
  });

  factory JobsModel.fromJson(Map<String, dynamic> data) => JobsModel(
    id: data['id'] as int,
    matchScore: data['match_score'] as int,
    title: data['title'] as String,
    company: data['company'] as String,
    description: data['description'] as String,
    location: data['location'] as String,
    sourcePlatform: data['source_platform'] as String,
    sourceUrl: data['source_url'] as String,
    postedDate: data['posted_date'] as String?,
    scrapedAt: data['scraped_at'] == null
        ? null
        : DateTime.parse(data['scraped_at'] as String),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'match_score': matchScore,
    'title': title,
    'company': company,
    'description': description,
    'location': location,
    'source_platform': sourcePlatform,
    'source_url': sourceUrl,
    'posted_date': postedDate,
    'scraped_at': scrapedAt?.toIso8601String(),
  };

  JobsModel copyWith({
    int? id,
    int? matchScore,
    String? title,
    String? company,
    String? description,
    String? location,
    String? sourcePlatform,
    String? sourceUrl,
    String? postedDate,
    DateTime? scrapedAt,
  }) {
    return JobsModel(
      id: id ?? this.id,
      matchScore: matchScore ?? this.matchScore,
      title: title ?? this.title,
      company: company ?? this.company,
      description: description ?? this.description,
      location: location ?? this.location,
      sourcePlatform: sourcePlatform ?? this.sourcePlatform,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      postedDate: postedDate ?? this.postedDate,
      scrapedAt: scrapedAt ?? this.scrapedAt,
    );
  }
}
