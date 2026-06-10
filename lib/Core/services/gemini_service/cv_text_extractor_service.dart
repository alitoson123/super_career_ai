import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CvTextExtractorService {
  CvTextExtractorService._();

  static Future<String> extractFromPdf(String filePath) async {
    final bytes = await File(filePath).readAsBytes();
    final document = PdfDocument(inputBytes: bytes);

    final extractor = PdfTextExtractor(document);
    final text = extractor.extractText();

    document.dispose();

    // ✨ حماية: لو الـ PDF عبارة عن صور ممسوحة ومطلعتش نص، ارمي Exception واضح
    if (text.trim().isEmpty) {
      throw Exception('Could not extract text from this PDF. It might be scanned or empty.');
    }

    return text;
  }
}