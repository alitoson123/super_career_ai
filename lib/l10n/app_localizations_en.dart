// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get superCareer => 'Super Career';

  @override
  String get welcomeBack => 'Welcome Back, Alex!';

  @override
  String newJobMatches(int count) {
    return 'You have $count new job matches today.';
  }

  @override
  String get matchesToday => 'Matches Today';

  @override
  String get avgMatchScore => 'Avg Match Score';

  @override
  String get activeProposals => 'Active Proposals';

  @override
  String get profileViews => 'Profile Views';

  @override
  String get recentJobMatches => 'Recent Job Matches';

  @override
  String get recentProjectMatches => 'Recent Project Matches';

  @override
  String get viewAll => 'View all';

  @override
  String get applyNow => 'Apply Now';

  @override
  String get viewMatchAndApply => 'View Match & Apply';

  @override
  String get home => 'Home';

  @override
  String get jops => 'JOPS';

  @override
  String get projects => 'Projects';

  @override
  String get cv => 'CV';

  @override
  String get profile => 'Profile';

  @override
  String get jopMatchesTitle => 'Jop Matches';

  @override
  String get searchMatchedJobs => 'Search matched jobs';

  @override
  String get allMatches => 'All Matches';

  @override
  String get highScore => 'High Score';

  @override
  String get remote => 'Remote';

  @override
  String get topMatchesForYou => 'Top Matches for You';

  @override
  String foundCount(int count) {
    return '$count Found';
  }

  @override
  String get matchBreakdown => 'Match Breakdown';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Good';

  @override
  String get moderate => 'Moderate';

  @override
  String skillsMatched(int matched, int total) {
    return '$matched/$total Skills matched';
  }

  @override
  String get preferredTimezone => 'Preferred timezone';

  @override
  String get budgetRangeMatch => 'Budget range match';
}
