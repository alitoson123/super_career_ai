class JobsModel {
	int? id;
	int? matchScore;
	String? title;
	String? company;
	String? description;
	String? location;
	String? sourcePlatform;
	String? sourceUrl;
	String? postedDate;
	DateTime? scrapedAt;

	JobsModel({
		this.id, 
		this.matchScore, 
		this.title, 
		this.company, 
		this.description, 
		this.location, 
		this.sourcePlatform, 
		this.sourceUrl, 
		this.postedDate, 
		this.scrapedAt, 
	});

	factory JobsModel.fromMap(Map<String, dynamic> data) => JobsModel(
				id: data['id'] as int?,
				matchScore: data['match_score'] as int?,
				title: data['title'] as String?,
				company: data['company'] as String?,
				description: data['description'] as String?,
				location: data['location'] as String?,
				sourcePlatform: data['source_platform'] as String?,
				sourceUrl: data['source_url'] as String?,
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
