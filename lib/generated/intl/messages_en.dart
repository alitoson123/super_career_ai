// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "${count} Found";

  static String m1(count) => "${count} hours ago";

  static String m2(score) => "${score}% Match";

  static String m3(found, total) => "${found} of ${total} matches";

  static String m4(count) => "${count} minutes ago";

  static String m10(count) => "You have ${count} new opportunities today.";

  static String m5(count) => "Selected skills (${count})";

  static String m6(matched, total) => "${matched}/${total} Skills matched";

  static String m7(current, total) => "${current} of ${total}";

  static String m8(userName) => "Welcome Back, ${userName}!";

  static String m9(count) => "${count} words";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "activeLead": MessageLookupByLibrary.simpleMessage("ACTIVE LEAD"),
        "activeProposals":
            MessageLookupByLibrary.simpleMessage("Active Proposals"),
        "add": MessageLookupByLibrary.simpleMessage("add"),
        "addASkill": MessageLookupByLibrary.simpleMessage("Add a skill"),
        "addAnotherPosition":
            MessageLookupByLibrary.simpleMessage("+ Add Another Position"),
        "addEducation": MessageLookupByLibrary.simpleMessage("+ Add Education"),
        "addWorkHistory":
            MessageLookupByLibrary.simpleMessage("Add your work history"),
        "addYourEducation":
            MessageLookupByLibrary.simpleMessage("Add your education"),
        "aiSuggestion": MessageLookupByLibrary.simpleMessage("AI Suggestion"),
        "allMatches": MessageLookupByLibrary.simpleMessage("All Matches"),
        "applyNow": MessageLookupByLibrary.simpleMessage("Apply Now"),
        "atsAnalysis": MessageLookupByLibrary.simpleMessage("ATS Analysis"),
        "atsMatch": MessageLookupByLibrary.simpleMessage("ATS MATCH"),
        "avgMatchScore":
            MessageLookupByLibrary.simpleMessage("Avg Match Score"),
        "back": MessageLookupByLibrary.simpleMessage("Back"),
        "budgetRangeMatch":
            MessageLookupByLibrary.simpleMessage("Budget range match"),
        "clearAll": MessageLookupByLibrary.simpleMessage("Clear All"),
        "company": MessageLookupByLibrary.simpleMessage("Company"),
        "companyHint": MessageLookupByLibrary.simpleMessage("e.g. Google"),
        "continueBtn": MessageLookupByLibrary.simpleMessage("Continue"),
        "copy": MessageLookupByLibrary.simpleMessage("Copy"),
        "copyProposal": MessageLookupByLibrary.simpleMessage("Copy Proposal"),
        "createCustomCV":
            MessageLookupByLibrary.simpleMessage("Create Custom CV"),
        "currentlyWorkHere":
            MessageLookupByLibrary.simpleMessage("I currently work here"),
        "customCV": MessageLookupByLibrary.simpleMessage("Custom CV"),
        "customProposal":
            MessageLookupByLibrary.simpleMessage("Custom Proposal"),
        "cv": MessageLookupByLibrary.simpleMessage("CV"),
        "cvHistory": MessageLookupByLibrary.simpleMessage("CV History"),
        "degree": MessageLookupByLibrary.simpleMessage("Degree"),
        "degreeHint": MessageLookupByLibrary.simpleMessage(
            "e.g. Bachelor of Science in Computer Science"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "descriptionOptional":
            MessageLookupByLibrary.simpleMessage("Description (Optional)"),
        "download": MessageLookupByLibrary.simpleMessage("Download"),
        "education": MessageLookupByLibrary.simpleMessage("Education"),
        "educationDescriptionHint": MessageLookupByLibrary.simpleMessage(
            "Relevant coursework, honors, or activities..."),
        "educationDetailsHint": MessageLookupByLibrary.simpleMessage(
            "Details about your schooling and academic achievements."),
        "emailAddress": MessageLookupByLibrary.simpleMessage("Email Address"),
        "emailAddressHint":
            MessageLookupByLibrary.simpleMessage("john.doe@example.com"),
        "endDate": MessageLookupByLibrary.simpleMessage("End Date"),
        "excellent": MessageLookupByLibrary.simpleMessage("Excellent"),
        "excellentAlignment": MessageLookupByLibrary.simpleMessage(
            "Excellent alignment with Freelance Hub standards"),
        "exportCvPdf": MessageLookupByLibrary.simpleMessage("Export CV (PDF)"),
        "failedToGenerateProposal":
            MessageLookupByLibrary.simpleMessage("Failed to generate proposal"),
        "failedToOpenLink":
            MessageLookupByLibrary.simpleMessage("Could not open the link"),
        "foundCount": m0,
        "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
        "fullNameHint": MessageLookupByLibrary.simpleMessage("e.g. John Doe"),
        "generatingProposal":
            MessageLookupByLibrary.simpleMessage("Generating proposal..."),
        "good": MessageLookupByLibrary.simpleMessage("Good"),
        "graduationYear":
            MessageLookupByLibrary.simpleMessage("Graduation Year"),
        "graduationYearHint": MessageLookupByLibrary.simpleMessage("e.g. 2022"),
        "highScore": MessageLookupByLibrary.simpleMessage("High Score"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "hoursAgo": m1,
        "improvementTips":
            MessageLookupByLibrary.simpleMessage("Improvement Tips"),
        "jobDetails": MessageLookupByLibrary.simpleMessage("Job Details"),
        "jobMatches": MessageLookupByLibrary.simpleMessage("Job matches"),
        "jobTitle": MessageLookupByLibrary.simpleMessage("Job Title"),
        "jopMatchesTitle": MessageLookupByLibrary.simpleMessage("Job Matches"),
        "jops": MessageLookupByLibrary.simpleMessage("JOPS"),
        "keywordsFound": MessageLookupByLibrary.simpleMessage("Keywords Found"),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "locationHint": MessageLookupByLibrary.simpleMessage("New York, USA"),
        "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all as read"),
        "matchBreakdown":
            MessageLookupByLibrary.simpleMessage("Match Breakdown"),
        "matchScore": m2,
        "matchesInJobsToday":
            MessageLookupByLibrary.simpleMessage("Matched Jobs "),
        "matchesInProjectsToday":
            MessageLookupByLibrary.simpleMessage("Matched Projects "),
        "matchesOfTotal": m3,
        "minutesAgo": m4,
        "missingCoreSkill":
            MessageLookupByLibrary.simpleMessage("Missing Core Skill"),
        "missingCoreSkillDesc": MessageLookupByLibrary.simpleMessage(
            "The job description mentions \'Agile Methodology\' frequently. Consider adding this to your skills."),
        "moderate": MessageLookupByLibrary.simpleMessage("Moderate"),
        "newOpportunities": m10,
        "nextEducation":
            MessageLookupByLibrary.simpleMessage("Next: Education"),
        "nextStep": MessageLookupByLibrary.simpleMessage("Next Step"),
        "noHistory": MessageLookupByLibrary.simpleMessage("No history yet"),
        "noNewMatches": MessageLookupByLibrary.simpleMessage(
            "You have no new matches today."),
        "noNotifications":
            MessageLookupByLibrary.simpleMessage("No notifications yet"),
        "noNotificationsDesc": MessageLookupByLibrary.simpleMessage(
            "You are all caught up! New matches and updates will appear here."),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "optimizeAi": MessageLookupByLibrary.simpleMessage("Optimize AI"),
        "perfectlyTailored": MessageLookupByLibrary.simpleMessage(
            "Perfectly tailored for Freelance Hub opportunities."),
        "personalDetails":
            MessageLookupByLibrary.simpleMessage("Personal Details"),
        "phoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "phoneNumberHint":
            MessageLookupByLibrary.simpleMessage("+1 (555) 000-0000"),
        "preferredTimezone":
            MessageLookupByLibrary.simpleMessage("Preferred timezone"),
        "professionalSummary":
            MessageLookupByLibrary.simpleMessage("Professional Summary"),
        "professionalSummaryHint": MessageLookupByLibrary.simpleMessage(
            "Briefly describe your professional background and key achievements..."),
        "professionalTitle":
            MessageLookupByLibrary.simpleMessage("Professional Title"),
        "professionalTitleHint": MessageLookupByLibrary.simpleMessage(
            "e.g. Senior Product Designer"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileViews": MessageLookupByLibrary.simpleMessage("Profile Views"),
        "projectDetails":
            MessageLookupByLibrary.simpleMessage("Project Details"),
        "projectMatches":
            MessageLookupByLibrary.simpleMessage("Project matches"),
        "projectMatchesTitle":
            MessageLookupByLibrary.simpleMessage("Project Matches"),
        "projects": MessageLookupByLibrary.simpleMessage("Projects"),
        "proposalCopied": MessageLookupByLibrary.simpleMessage(
            "Proposal copied to clipboard"),
        "proposalHistory":
            MessageLookupByLibrary.simpleMessage("Proposal History"),
        "proposalTitle": MessageLookupByLibrary.simpleMessage("Proposal"),
        "quantifyAchievements":
            MessageLookupByLibrary.simpleMessage("Quantify Achievements"),
        "quantifyAchievementsDesc": MessageLookupByLibrary.simpleMessage(
            "Add more metrics like \'Increased conversion by 20%\' to strengthen impact."),
        "recentJobMatches":
            MessageLookupByLibrary.simpleMessage("Recent Job Matches"),
        "recentProjectMatches":
            MessageLookupByLibrary.simpleMessage("Recent Project Matches"),
        "recommendedForYou":
            MessageLookupByLibrary.simpleMessage("Recommended for you"),
        "recommendedSkillsInstruction": MessageLookupByLibrary.simpleMessage(
            "Based on your CV and experience, you might also have these skills:"),
        "remote": MessageLookupByLibrary.simpleMessage("Remote"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "requirements": MessageLookupByLibrary.simpleMessage("Requirements"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "saveAndContinue":
            MessageLookupByLibrary.simpleMessage("Save & Continue"),
        "schoolHint":
            MessageLookupByLibrary.simpleMessage("e.g. Stanford University"),
        "schoolUniversity":
            MessageLookupByLibrary.simpleMessage("School / University"),
        "search": MessageLookupByLibrary.simpleMessage("search"),
        "searchMatchedJobs":
            MessageLookupByLibrary.simpleMessage("Search matched jobs"),
        "selectedSkills": m5,
        "skills": MessageLookupByLibrary.simpleMessage("Skills"),
        "skillsInstruction": MessageLookupByLibrary.simpleMessage(
            "Add skills to help employers find you. You can type to add your own or pick from our suggestions."),
        "skillsMatched": m6,
        "startDate": MessageLookupByLibrary.simpleMessage("Start Date"),
        "startWithMostRecent": MessageLookupByLibrary.simpleMessage(
            "Start with your most recent position."),
        "stepEducation":
            MessageLookupByLibrary.simpleMessage("Step 3: Education"),
        "stepOf": m7,
        "stepPersonalInformation": MessageLookupByLibrary.simpleMessage(
            "Step 1: Personal Information"),
        "stepSkills": MessageLookupByLibrary.simpleMessage("Step 4: Skills"),
        "stepWorkExperience":
            MessageLookupByLibrary.simpleMessage("Step 2: Work Experience"),
        "superCareer": MessageLookupByLibrary.simpleMessage("Super Career"),
        "technicalStack":
            MessageLookupByLibrary.simpleMessage("Technical Stack"),
        "theProject": MessageLookupByLibrary.simpleMessage("The Project"),
        "theRole": MessageLookupByLibrary.simpleMessage("The Role"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "topMatchesForYou":
            MessageLookupByLibrary.simpleMessage("Top Matches for You"),
        "userName": MessageLookupByLibrary.simpleMessage("Alex"),
        "viewAll": MessageLookupByLibrary.simpleMessage("View all"),
        "viewTheJob": MessageLookupByLibrary.simpleMessage("View the Job"),
        "viewTheProject":
            MessageLookupByLibrary.simpleMessage("View the Project"),
        "welcomeBack": m8,
        "welcomeToSuperCareer":
            MessageLookupByLibrary.simpleMessage("Welcome to Super Career"),
        "whatAreYourTopSkills":
            MessageLookupByLibrary.simpleMessage("What are your top skills?"),
        "wordCount": m9,
        "workDescriptionHint": MessageLookupByLibrary.simpleMessage(
            "Describe your responsibilities and achievements..."),
        "workExperience":
            MessageLookupByLibrary.simpleMessage("Work Experience"),
        "yesterday": MessageLookupByLibrary.simpleMessage("Yesterday"),
        "yourCvIsReady":
            MessageLookupByLibrary.simpleMessage("Your CV is Ready!"),
        "yourProposal": MessageLookupByLibrary.simpleMessage("YOUR PROPOSAL")
      };
}
