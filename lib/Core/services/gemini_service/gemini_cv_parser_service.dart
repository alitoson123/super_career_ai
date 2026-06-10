import 'dart:convert';
import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Uses the Gemini API to parse raw CV text into the structured JSON format
/// expected by the backend.
class GeminiCvParserService {
  GeminiCvParserService._();

  //static const String _apiKey =

  static const String _prompt = '''
Extract information from the CV text below and return a JSON object with EXACTLY this structure.

{
  "Personal Details": {
    "Full Name": "",
    "Phone Number": "",
    "Professional Title": "",
    "Email Address": "",
    "Location": "",
    "Portfolio / LinkedIn URL": "",
    "Professional Summary": ""
  },
  "Experience": [
    {
      "I currently work here": false,
      "Job Title": "",
      "Company": "",
      "Start Date": "",
      "End Date": "",
      "Description": ""
    }
  ],
  "Education": [
    {
      "School / University": "",
      "Degree / Qualification": "",
      "Year of Graduation": "",
      "Additional Details": ""
    }
  ],
  "Skills": ["skill1", "skill2"]
}

Rules:
- If a field cannot be found, use an empty string "".
- For "I currently work here": set true if still employed there, false otherwise.
- Extract ALL experience and education entries found.
- Skills must be individual string items.
- Dates (Start Date, End Date) MUST be in 'YYYY-MM-DD' format. If only month and year are available, use the first day of the month (e.g., '2026-05-01'). If the end date is 'Present', use the current date '2026-06-11'.

CV Text:
''';

  /// Parses raw CV text into the structured map expected by the backend.
  static Future<Map<String, dynamic>> parseCvText(String cvText) async {
    int retryCount = 0;
    const int maxRetries = 3;

    while (true) {
      try {
        final model = GenerativeModel(
          model: 'gemini-2.5-flash', // تضمن استدعاء أحدث نسخة مستقرة من الفلاش
          apiKey: _apiKey,
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
        );

        final response = await model.generateContent([
          Content.text('$_prompt\n$cvText'),
        ]);

        final rawText = response.text;
        if (rawText == null || rawText.isEmpty) {
          throw Exception('Gemini returned an empty response.');
        }

        final cleaned = rawText
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();

        // تحويل النص الراجع إلى Map
        final Map<String, dynamic> parsedJson =
            jsonDecode(cleaned) as Map<String, dynamic>;

        // 🛠️ التعديل الجديد: تنظيف الداتا وتجهيزها لحماية الـ Backend API من الحقول الفارغة
        if (parsedJson['Education'] is List) {
          for (var edu in parsedJson['Education']) {
            // لو سنة التخرج راجعة فاضية، بنحط سنة تلقائية عشان الـ Validation في السيرفر ماينهارش
            if (edu['Year of Graduation'] == null ||
                edu['Year of Graduation'].toString().isEmpty) {
              edu['Year of Graduation'] = "2026";
            }
          }
        }

        return parsedJson;
      } catch (e) {
        final errorStr = e.toString();
        bool isServerError =
            errorStr.contains('503') ||
            errorStr.contains('429') ||
            errorStr.contains('UNAVAILABLE');

        if (isServerError && retryCount < maxRetries) {
          retryCount++;
          log(
            '⚠️ Server busy (503/429). Retrying ($retryCount/$maxRetries) in ${2 * retryCount} seconds...',
          );
          await Future.delayed(Duration(seconds: 2 * retryCount));
          continue;
        }

        log('❌ Error in GeminiCvParserService after $retryCount retries: $e');
        rethrow;
      }
    }
  }
}
