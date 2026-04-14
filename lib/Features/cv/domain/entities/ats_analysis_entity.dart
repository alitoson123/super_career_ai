class AtsAnalysisEntity {
  const AtsAnalysisEntity({
    required this.matchScore,
    required this.keywordsFound,
    required this.totalKeywords,
    required this.improvementTips,
  });

  final int matchScore;
  final int keywordsFound;
  final int totalKeywords;
  final List<ImprovementTipEntity> improvementTips;
}

class ImprovementTipEntity {
  const ImprovementTipEntity({
    required this.title,
    required this.description,
    required this.isWarning,
  });

  final String title;
  final String description;
  final bool isWarning;
}
