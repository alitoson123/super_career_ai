class ProjectModel {
	int? id;
	String? title;
	String? description;
	String? budget;
	dynamic deadline;
	String? duration;
	String? status;
	List<String>? requiredSkills;
	String? platformName;
	String? sourceUrl;
	String? postedDate;
	DateTime? scrapedAt;
	int? matchScore;

	ProjectModel({
		this.id, 
		this.title, 
		this.description, 
		this.budget, 
		this.deadline, 
		this.duration, 
		this.status, 
		this.requiredSkills, 
		this.platformName, 
		this.sourceUrl, 
		this.postedDate, 
		this.scrapedAt, 
		this.matchScore, 
	});

	factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
				id: json['id'] as int?,
				title: json['title'] as String?,
				description: json['description'] as String?,
				budget: json['budget'] as String?,
				deadline: json['deadline'] as dynamic,
				duration: json['duration'] as String?,
				status: json['status'] as String?,
				requiredSkills: json['required_skills'] as List<String>?,
				platformName: json['platform_name'] as String?,
				sourceUrl: json['source_url'] as String?,
				postedDate: json['posted_date'] as String?,
				scrapedAt: json['scraped_at'] == null
						? null
						: DateTime.parse(json['scraped_at'] as String),
				matchScore: json['match_score'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'title': title,
				'description': description,
				'budget': budget,
				'deadline': deadline,
				'duration': duration,
				'status': status,
				'required_skills': requiredSkills,
				'platform_name': platformName,
				'source_url': sourceUrl,
				'posted_date': postedDate,
				'scraped_at': scrapedAt?.toIso8601String(),
				'match_score': matchScore,
			};

	ProjectModel copyWith({
		int? id,
		String? title,
		String? description,
		String? budget,
		dynamic deadline,
		String? duration,
		String? status,
		List<String>? requiredSkills,
		String? platformName,
		String? sourceUrl,
		String? postedDate,
		DateTime? scrapedAt,
		int? matchScore,
	}) {
		return ProjectModel(
			id: id ?? this.id,
			title: title ?? this.title,
			description: description ?? this.description,
			budget: budget ?? this.budget,
			deadline: deadline ?? this.deadline,
			duration: duration ?? this.duration,
			status: status ?? this.status,
			requiredSkills: requiredSkills ?? this.requiredSkills,
			platformName: platformName ?? this.platformName,
			sourceUrl: sourceUrl ?? this.sourceUrl,
			postedDate: postedDate ?? this.postedDate,
			scrapedAt: scrapedAt ?? this.scrapedAt,
			matchScore: matchScore ?? this.matchScore,
		);
	}
}
