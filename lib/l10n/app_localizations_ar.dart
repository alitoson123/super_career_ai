// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get superCareer => 'سوبر كارير';

  @override
  String get welcomeBack => 'مرحباً بعودتك، أليكس!';

  @override
  String newJobMatches(int count) {
    return 'لديك $count تطابقات وظائف جديدة اليوم.';
  }

  @override
  String get matchesToday => 'تطابقات اليوم';

  @override
  String get avgMatchScore => 'متوسط درجة التطابق';

  @override
  String get activeProposals => 'العروض النشطة';

  @override
  String get profileViews => 'مشاهدات الملف الشخصي';

  @override
  String get recentJobMatches => 'أحدث تطابقات الوظائف';

  @override
  String get recentProjectMatches => 'أحدث تطابقات المشاريع';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get applyNow => 'قدم الآن';

  @override
  String get viewMatchAndApply => 'عرض التطابق والتقديم';

  @override
  String get home => 'الرئيسية';

  @override
  String get jops => 'وظائف';

  @override
  String get projects => 'مشاريع';

  @override
  String get cv => 'السيرة الذاتية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get jopMatchesTitle => 'تطابقات الوظائف';

  @override
  String get searchMatchedJobs => 'البحث في الوظائف المطابقة...';

  @override
  String get allMatches => 'كل التطابقات';

  @override
  String get highScore => 'درجة عالية';

  @override
  String get remote => 'عن بعد';

  @override
  String get topMatchesForYou => 'أفضل التطابقات لك';

  @override
  String foundCount(int count) {
    return 'تم العثور على $count';
  }

  @override
  String get matchBreakdown => 'تحليل التطابق';

  @override
  String get excellent => 'ممتاز';

  @override
  String get good => 'جيد';

  @override
  String get moderate => 'متوسط';

  @override
  String skillsMatched(int matched, int total) {
    return '$matched/$total مهارات مطابقة';
  }

  @override
  String get preferredTimezone => 'المنطقة الزمنية المفضلة';

  @override
  String get budgetRangeMatch => 'نطاق الميزانية مطابق';
}
