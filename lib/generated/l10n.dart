// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Super Career`
  String get superCareer {
    return Intl.message(
      'Super Career',
      name: 'superCareer',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back, {userName}!`
  String welcomeBack(String userName) {
    return Intl.message(
      'Welcome Back, $userName!',
      name: 'welcomeBack',
      desc: '',
      args: [userName],
    );
  }

  /// `You have {count} new job matches today.`
  String newJobMatches(int count) {
    return Intl.message(
      'You have $count new job matches today.',
      name: 'newJobMatches',
      desc: '',
      args: [count],
    );
  }

  /// `Matches Today`
  String get matchesToday {
    return Intl.message(
      'Matches Today',
      name: 'matchesToday',
      desc: '',
      args: [],
    );
  }

  /// `Avg Match Score`
  String get avgMatchScore {
    return Intl.message(
      'Avg Match Score',
      name: 'avgMatchScore',
      desc: '',
      args: [],
    );
  }

  /// `Active Proposals`
  String get activeProposals {
    return Intl.message(
      'Active Proposals',
      name: 'activeProposals',
      desc: '',
      args: [],
    );
  }

  /// `Profile Views`
  String get profileViews {
    return Intl.message(
      'Profile Views',
      name: 'profileViews',
      desc: '',
      args: [],
    );
  }

  /// `Recent Job Matches`
  String get recentJobMatches {
    return Intl.message(
      'Recent Job Matches',
      name: 'recentJobMatches',
      desc: '',
      args: [],
    );
  }

  /// `Recent Project Matches`
  String get recentProjectMatches {
    return Intl.message(
      'Recent Project Matches',
      name: 'recentProjectMatches',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message('View all', name: 'viewAll', desc: '', args: []);
  }

  /// `Apply Now`
  String get applyNow {
    return Intl.message('Apply Now', name: 'applyNow', desc: '', args: []);
  }

  /// `View the Job`
  String get viewTheJob {
    return Intl.message('View the Job', name: 'viewTheJob', desc: '', args: []);
  }

  /// `Custom CV`
  String get customCV {
    return Intl.message('Custom CV', name: 'customCV', desc: '', args: []);
  }

  /// `View the Project`
  String get viewTheProject {
    return Intl.message(
      'View the Project',
      name: 'viewTheProject',
      desc: '',
      args: [],
    );
  }

  /// `Custom Proposal`
  String get customProposal {
    return Intl.message(
      'Custom Proposal',
      name: 'customProposal',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `JOPS`
  String get jops {
    return Intl.message('JOPS', name: 'jops', desc: '', args: []);
  }

  /// `Projects`
  String get projects {
    return Intl.message('Projects', name: 'projects', desc: '', args: []);
  }

  /// `CV`
  String get cv {
    return Intl.message('CV', name: 'cv', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Job Details`
  String get jobDetails {
    return Intl.message('Job Details', name: 'jobDetails', desc: '', args: []);
  }

  /// `Project Details`
  String get projectDetails {
    return Intl.message(
      'Project Details',
      name: 'projectDetails',
      desc: '',
      args: [],
    );
  }

  /// `The Role`
  String get theRole {
    return Intl.message('The Role', name: 'theRole', desc: '', args: []);
  }

  /// `The Project`
  String get theProject {
    return Intl.message('The Project', name: 'theProject', desc: '', args: []);
  }

  /// `Requirements`
  String get requirements {
    return Intl.message(
      'Requirements',
      name: 'requirements',
      desc: '',
      args: [],
    );
  }

  /// `Technical Stack`
  String get technicalStack {
    return Intl.message(
      'Technical Stack',
      name: 'technicalStack',
      desc: '',
      args: [],
    );
  }

  /// `Create Custom CV`
  String get createCustomCV {
    return Intl.message(
      'Create Custom CV',
      name: 'createCustomCV',
      desc: '',
      args: [],
    );
  }

  /// `View Now`
  String get viewNow {
    return Intl.message('View Now', name: 'viewNow', desc: '', args: []);
  }

  /// `{score}% Match`
  String matchScore(int score) {
    return Intl.message(
      '$score% Match',
      name: 'matchScore',
      desc: '',
      args: [score],
    );
  }

  /// `CV History`
  String get cvHistory {
    return Intl.message('CV History', name: 'cvHistory', desc: '', args: []);
  }

  /// `Proposal History`
  String get proposalHistory {
    return Intl.message(
      'Proposal History',
      name: 'proposalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Download`
  String get download {
    return Intl.message('Download', name: 'download', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `No history yet`
  String get noHistory {
    return Intl.message(
      'No history yet',
      name: 'noHistory',
      desc: '',
      args: [],
    );
  }

  /// `Job Matches`
  String get jopMatchesTitle {
    return Intl.message(
      'Job Matches',
      name: 'jopMatchesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Project Matches`
  String get projectMatchesTitle {
    return Intl.message(
      'Project Matches',
      name: 'projectMatchesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Job matches`
  String get jobMatches {
    return Intl.message('Job matches', name: 'jobMatches', desc: '', args: []);
  }

  /// `Project matches`
  String get projectMatches {
    return Intl.message(
      'Project matches',
      name: 'projectMatches',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Search matched jobs`
  String get searchMatchedJobs {
    return Intl.message(
      'Search matched jobs',
      name: 'searchMatchedJobs',
      desc: '',
      args: [],
    );
  }

  /// `All Matches`
  String get allMatches {
    return Intl.message('All Matches', name: 'allMatches', desc: '', args: []);
  }

  /// `High Score`
  String get highScore {
    return Intl.message('High Score', name: 'highScore', desc: '', args: []);
  }

  /// `Remote`
  String get remote {
    return Intl.message('Remote', name: 'remote', desc: '', args: []);
  }

  /// `Top Matches for You`
  String get topMatchesForYou {
    return Intl.message(
      'Top Matches for You',
      name: 'topMatchesForYou',
      desc: '',
      args: [],
    );
  }

  /// `{count} Found`
  String foundCount(int count) {
    return Intl.message(
      '$count Found',
      name: 'foundCount',
      desc: '',
      args: [count],
    );
  }

  /// `Match Breakdown`
  String get matchBreakdown {
    return Intl.message(
      'Match Breakdown',
      name: 'matchBreakdown',
      desc: '',
      args: [],
    );
  }

  /// `Excellent`
  String get excellent {
    return Intl.message('Excellent', name: 'excellent', desc: '', args: []);
  }

  /// `Good`
  String get good {
    return Intl.message('Good', name: 'good', desc: '', args: []);
  }

  /// `Moderate`
  String get moderate {
    return Intl.message('Moderate', name: 'moderate', desc: '', args: []);
  }

  /// `{matched}/{total} Skills matched`
  String skillsMatched(int matched, int total) {
    return Intl.message(
      '$matched/$total Skills matched',
      name: 'skillsMatched',
      desc: '',
      args: [matched, total],
    );
  }

  /// `Preferred timezone`
  String get preferredTimezone {
    return Intl.message(
      'Preferred timezone',
      name: 'preferredTimezone',
      desc: '',
      args: [],
    );
  }

  /// `Budget range match`
  String get budgetRangeMatch {
    return Intl.message(
      'Budget range match',
      name: 'budgetRangeMatch',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Super Career`
  String get welcomeToSuperCareer {
    return Intl.message(
      'Welcome to Super Career',
      name: 'welcomeToSuperCareer',
      desc: '',
      args: [],
    );
  }

  /// `Personal Details`
  String get personalDetails {
    return Intl.message(
      'Personal Details',
      name: 'personalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Step 1: Personal Information`
  String get stepPersonalInformation {
    return Intl.message(
      'Step 1: Personal Information',
      name: 'stepPersonalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Step 2: Work Experience`
  String get stepWorkExperience {
    return Intl.message(
      'Step 2: Work Experience',
      name: 'stepWorkExperience',
      desc: '',
      args: [],
    );
  }

  /// `Step 3: Education`
  String get stepEducation {
    return Intl.message(
      'Step 3: Education',
      name: 'stepEducation',
      desc: '',
      args: [],
    );
  }

  /// `Step 4: Skills`
  String get stepSkills {
    return Intl.message(
      'Step 4: Skills',
      name: 'stepSkills',
      desc: '',
      args: [],
    );
  }

  /// `{current} of {total}`
  String stepOf(Object current, Object total) {
    return Intl.message(
      '$current of $total',
      name: 'stepOf',
      desc: '',
      args: [current, total],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `e.g. John Doe`
  String get fullNameHint {
    return Intl.message(
      'e.g. John Doe',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Professional Title`
  String get professionalTitle {
    return Intl.message(
      'Professional Title',
      name: 'professionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Senior Product Designer`
  String get professionalTitleHint {
    return Intl.message(
      'e.g. Senior Product Designer',
      name: 'professionalTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `john.doe@example.com`
  String get emailAddressHint {
    return Intl.message(
      'john.doe@example.com',
      name: 'emailAddressHint',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `+1 (555) 000-0000`
  String get phoneNumberHint {
    return Intl.message(
      '+1 (555) 000-0000',
      name: 'phoneNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `New York, USA`
  String get locationHint {
    return Intl.message(
      'New York, USA',
      name: 'locationHint',
      desc: '',
      args: [],
    );
  }

  /// `Professional Summary`
  String get professionalSummary {
    return Intl.message(
      'Professional Summary',
      name: 'professionalSummary',
      desc: '',
      args: [],
    );
  }

  /// `AI Suggestion`
  String get aiSuggestion {
    return Intl.message(
      'AI Suggestion',
      name: 'aiSuggestion',
      desc: '',
      args: [],
    );
  }

  /// `Briefly describe your professional background and key achievements...`
  String get professionalSummaryHint {
    return Intl.message(
      'Briefly describe your professional background and key achievements...',
      name: 'professionalSummaryHint',
      desc: '',
      args: [],
    );
  }

  /// `Next Step`
  String get nextStep {
    return Intl.message('Next Step', name: 'nextStep', desc: '', args: []);
  }

  /// `Work Experience`
  String get workExperience {
    return Intl.message(
      'Work Experience',
      name: 'workExperience',
      desc: '',
      args: [],
    );
  }

  /// `Add your work history`
  String get addWorkHistory {
    return Intl.message(
      'Add your work history',
      name: 'addWorkHistory',
      desc: '',
      args: [],
    );
  }

  /// `Start with your most recent position.`
  String get startWithMostRecent {
    return Intl.message(
      'Start with your most recent position.',
      name: 'startWithMostRecent',
      desc: '',
      args: [],
    );
  }

  /// `Job Title`
  String get jobTitle {
    return Intl.message('Job Title', name: 'jobTitle', desc: '', args: []);
  }

  /// `Remove`
  String get remove {
    return Intl.message('Remove', name: 'remove', desc: '', args: []);
  }

  /// `Company`
  String get company {
    return Intl.message('Company', name: 'company', desc: '', args: []);
  }

  /// `e.g. Google`
  String get companyHint {
    return Intl.message('e.g. Google', name: 'companyHint', desc: '', args: []);
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `I currently work here`
  String get currentlyWorkHere {
    return Intl.message(
      'I currently work here',
      name: 'currentlyWorkHere',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Describe your responsibilities and achievements...`
  String get workDescriptionHint {
    return Intl.message(
      'Describe your responsibilities and achievements...',
      name: 'workDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `+ Add Another Position`
  String get addAnotherPosition {
    return Intl.message(
      '+ Add Another Position',
      name: 'addAnotherPosition',
      desc: '',
      args: [],
    );
  }

  /// `Next: Education`
  String get nextEducation {
    return Intl.message(
      'Next: Education',
      name: 'nextEducation',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message('Education', name: 'education', desc: '', args: []);
  }

  /// `Add your education`
  String get addYourEducation {
    return Intl.message(
      'Add your education',
      name: 'addYourEducation',
      desc: '',
      args: [],
    );
  }

  /// `Details about your schooling and academic achievements.`
  String get educationDetailsHint {
    return Intl.message(
      'Details about your schooling and academic achievements.',
      name: 'educationDetailsHint',
      desc: '',
      args: [],
    );
  }

  /// `School / University`
  String get schoolUniversity {
    return Intl.message(
      'School / University',
      name: 'schoolUniversity',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Stanford University`
  String get schoolHint {
    return Intl.message(
      'e.g. Stanford University',
      name: 'schoolHint',
      desc: '',
      args: [],
    );
  }

  /// `Degree`
  String get degree {
    return Intl.message('Degree', name: 'degree', desc: '', args: []);
  }

  /// `e.g. Bachelor of Science in Computer Science`
  String get degreeHint {
    return Intl.message(
      'e.g. Bachelor of Science in Computer Science',
      name: 'degreeHint',
      desc: '',
      args: [],
    );
  }

  /// `Graduation Year`
  String get graduationYear {
    return Intl.message(
      'Graduation Year',
      name: 'graduationYear',
      desc: '',
      args: [],
    );
  }

  /// `e.g. 2022`
  String get graduationYearHint {
    return Intl.message(
      'e.g. 2022',
      name: 'graduationYearHint',
      desc: '',
      args: [],
    );
  }

  /// `Description (Optional)`
  String get descriptionOptional {
    return Intl.message(
      'Description (Optional)',
      name: 'descriptionOptional',
      desc: '',
      args: [],
    );
  }

  /// `Relevant coursework, honors, or activities...`
  String get educationDescriptionHint {
    return Intl.message(
      'Relevant coursework, honors, or activities...',
      name: 'educationDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `+ Add Education`
  String get addEducation {
    return Intl.message(
      '+ Add Education',
      name: 'addEducation',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Save & Continue`
  String get saveAndContinue {
    return Intl.message(
      'Save & Continue',
      name: 'saveAndContinue',
      desc: '',
      args: [],
    );
  }

  /// `Skills`
  String get skills {
    return Intl.message('Skills', name: 'skills', desc: '', args: []);
  }

  /// `What are your top skills?`
  String get whatAreYourTopSkills {
    return Intl.message(
      'What are your top skills?',
      name: 'whatAreYourTopSkills',
      desc: '',
      args: [],
    );
  }

  /// `Add skills to help employers find you. You can type to add your own or pick from our suggestions.`
  String get skillsInstruction {
    return Intl.message(
      'Add skills to help employers find you. You can type to add your own or pick from our suggestions.',
      name: 'skillsInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Add a skill`
  String get addASkill {
    return Intl.message('Add a skill', name: 'addASkill', desc: '', args: []);
  }

  /// `search`
  String get search {
    return Intl.message('search', name: 'search', desc: '', args: []);
  }

  /// `add`
  String get add {
    return Intl.message('add', name: 'add', desc: '', args: []);
  }

  /// `Selected skills ({count})`
  String selectedSkills(Object count) {
    return Intl.message(
      'Selected skills ($count)',
      name: 'selectedSkills',
      desc: '',
      args: [count],
    );
  }

  /// `Recommended for you`
  String get recommendedForYou {
    return Intl.message(
      'Recommended for you',
      name: 'recommendedForYou',
      desc: '',
      args: [],
    );
  }

  /// `Based on your CV and experience, you might also have these skills:`
  String get recommendedSkillsInstruction {
    return Intl.message(
      'Based on your CV and experience, you might also have these skills:',
      name: 'recommendedSkillsInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueBtn {
    return Intl.message('Continue', name: 'continueBtn', desc: '', args: []);
  }

  /// `ATS Analysis`
  String get atsAnalysis {
    return Intl.message(
      'ATS Analysis',
      name: 'atsAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Your CV is Ready!`
  String get yourCvIsReady {
    return Intl.message(
      'Your CV is Ready!',
      name: 'yourCvIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Perfectly tailored for Freelance Hub opportunities.`
  String get perfectlyTailored {
    return Intl.message(
      'Perfectly tailored for Freelance Hub opportunities.',
      name: 'perfectlyTailored',
      desc: '',
      args: [],
    );
  }

  /// `ATS MATCH`
  String get atsMatch {
    return Intl.message('ATS MATCH', name: 'atsMatch', desc: '', args: []);
  }

  /// `Excellent alignment with Freelance Hub standards`
  String get excellentAlignment {
    return Intl.message(
      'Excellent alignment with Freelance Hub standards',
      name: 'excellentAlignment',
      desc: '',
      args: [],
    );
  }

  /// `Keywords Found`
  String get keywordsFound {
    return Intl.message(
      'Keywords Found',
      name: 'keywordsFound',
      desc: '',
      args: [],
    );
  }

  /// `{found} of {total} matches`
  String matchesOfTotal(Object found, Object total) {
    return Intl.message(
      '$found of $total matches',
      name: 'matchesOfTotal',
      desc: '',
      args: [found, total],
    );
  }

  /// `Improvement Tips`
  String get improvementTips {
    return Intl.message(
      'Improvement Tips',
      name: 'improvementTips',
      desc: '',
      args: [],
    );
  }

  /// `Quantify Achievements`
  String get quantifyAchievements {
    return Intl.message(
      'Quantify Achievements',
      name: 'quantifyAchievements',
      desc: '',
      args: [],
    );
  }

  /// `Add more metrics like 'Increased conversion by 20%' to strengthen impact.`
  String get quantifyAchievementsDesc {
    return Intl.message(
      'Add more metrics like \'Increased conversion by 20%\' to strengthen impact.',
      name: 'quantifyAchievementsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Missing Core Skill`
  String get missingCoreSkill {
    return Intl.message(
      'Missing Core Skill',
      name: 'missingCoreSkill',
      desc: '',
      args: [],
    );
  }

  /// `The job description mentions 'Agile Methodology' frequently. Consider adding this to your skills.`
  String get missingCoreSkillDesc {
    return Intl.message(
      'The job description mentions \'Agile Methodology\' frequently. Consider adding this to your skills.',
      name: 'missingCoreSkillDesc',
      desc: '',
      args: [],
    );
  }

  /// `Export CV (PDF)`
  String get exportCvPdf {
    return Intl.message(
      'Export CV (PDF)',
      name: 'exportCvPdf',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Clear All`
  String get clearAll {
    return Intl.message('Clear All', name: 'clearAll', desc: '', args: []);
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `{count} minutes ago`
  String minutesAgo(int count) {
    return Intl.message(
      '$count minutes ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} hours ago`
  String hoursAgo(int count) {
    return Intl.message(
      '$count hours ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `No notifications yet`
  String get noNotifications {
    return Intl.message(
      'No notifications yet',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `You are all caught up! New matches and updates will appear here.`
  String get noNotificationsDesc {
    return Intl.message(
      'You are all caught up! New matches and updates will appear here.',
      name: 'noNotificationsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Mark all as read`
  String get markAllRead {
    return Intl.message(
      'Mark all as read',
      name: 'markAllRead',
      desc: '',
      args: [],
    );
  }

  /// `Alex`
  String get userName {
    return Intl.message('Alex', name: 'userName', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
