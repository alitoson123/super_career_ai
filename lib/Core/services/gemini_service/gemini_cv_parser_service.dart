import 'dart:convert';
import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiCvParserService {
  GeminiCvParserService._();

  static const String _apiKey =
      '';

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

CV Text:
''';

  static Future<Map<String, dynamic>> parseCvText(String cvText) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-2.5-flash', // تضمن استدعاء أحدث نسخة مستقرة من الفلاش
        apiKey: _apiKey,
        // ✨ إجبار الموديل على الالتزام ببنية الـ JSON
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

      return jsonDecode(cleaned) as Map<String, dynamic>;
    } catch (e) {
      log('❌ Error in GeminiCvParserService: $e');
      rethrow; // بنمرره للـ UI عشان الـ try-catch هناك يلقطه
    }
  }
}
