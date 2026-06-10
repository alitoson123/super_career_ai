import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/base_cv_model.dart';
import 'package:super_career_ai/Features/jobs/Data/models/base_cv_model/personal_details.dart';

/// Generates a professional-looking PDF from [BaseCvModel] data
/// entirely on-device — no backend API required.
class CvPdfGenerator {
  CvPdfGenerator._();

  // ── Brand colours ──────────────────────────────────────────────────────────
  static final PdfColor _primaryBlue = PdfColor.fromHex('#2563EB');
  static final PdfColor _lightBlue = PdfColor.fromHex('#EFF6FF');
  static final PdfColor _textPrimary = PdfColor.fromHex('#1F2937');
  static final PdfColor _textSecondary = PdfColor.fromHex('#6B7280');
  static final PdfColor _dividerColor = PdfColor.fromHex('#E5E7EB');

  // ── Public API ─────────────────────────────────────────────────────────────

  /// Builds the PDF and returns the raw bytes for previewing.
  static Future<Uint8List> buildPdf(BaseCvModel cv) async {
    final doc = await _createPdfDocument(cv);
    return await doc.save();
  }

  /// Builds the PDF and returns the path to the saved file for downloading.
  static Future<String> generate(BaseCvModel cv) async {
    final doc = await _createPdfDocument(cv);
    final bytes = await doc.save();
    
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/cv_${cv.id ?? 'generated'}.pdf');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  // ── Private document builder ───────────────────────────────────────────────

  static Future<pw.Document> _createPdfDocument(BaseCvModel cv) async {
    final boldFont = await PdfGoogleFonts.cairoBold();
    final regularFont = await PdfGoogleFonts.cairoRegular();
    final italicFont = await PdfGoogleFonts.cairoLight();

    final details = cv.personalDetails;
    final experiences = cv.experience ?? [];
    final educations = cv.education ?? [];
    final skills = (cv.skills ?? []).map((e) => e.toString()).toList();

    final doc = pw.Document(
      title: '${details?.fullName ?? 'CV'} - Resume',
      author: details?.fullName ?? 'Unknown',
    );

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 36, vertical: 36),
        build: (context) => [
          _buildHeader(details, boldFont, regularFont),
          pw.SizedBox(height: 18),
          if (_hasText(details?.professionalSummary)) ...[
            _buildSectionHeader('Professional Summary', boldFont),
            pw.SizedBox(height: 6),
            pw.Text(
              details!.professionalSummary!,
              style: pw.TextStyle(
                font: italicFont,
                fontSize: 10,
                color: _textPrimary,
                lineSpacing: 4,
              ),
            ),
            pw.SizedBox(height: 16),
          ],
          if (experiences.isNotEmpty) ...[
            _buildSectionHeader('Work Experience', boldFont),
            pw.SizedBox(height: 8),
            ...experiences.map(
              (e) => _buildExperienceItem(e.toJson(), boldFont, regularFont, italicFont),
            ),
            pw.SizedBox(height: 8),
          ],
          if (educations.isNotEmpty) ...[
            _buildSectionHeader('Education', boldFont),
            pw.SizedBox(height: 8),
            ...educations.map(
              (e) => _buildEducationItem(e.toJson(), boldFont, regularFont, italicFont),
            ),
            pw.SizedBox(height: 8),
          ],
          if (skills.isNotEmpty) ...[
            _buildSectionHeader('Skills', boldFont),
            pw.SizedBox(height: 8),
            _buildSkillsSection(skills, regularFont),
          ],
        ],
      ),
    );

    return doc;
  }

  // ── Private builders ───────────────────────────────────────────────────────

  static pw.Widget _buildHeader(
    PersonalDetails? d,
    pw.Font bold,
    pw.Font regular,
  ) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(20),
      decoration: pw.BoxDecoration(
        color: _primaryBlue,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            _hasText(d?.fullName) ? d!.fullName! : 'Unnamed',
            style: pw.TextStyle(
              font: bold,
              fontSize: 22,
              color: PdfColors.white,
            ),
          ),
          if (_hasText(d?.professionalTitle)) ...[
            pw.SizedBox(height: 3),
            pw.Text(
              d!.professionalTitle!,
              style: pw.TextStyle(
                font: regular,
                fontSize: 12,
                color: PdfColor(1, 1, 1, 0.8),
              ),
            ),
          ],
          pw.SizedBox(height: 12),
          pw.Wrap(
            spacing: 20,
            runSpacing: 5,
            children: [
              if (_hasText(d?.emailAddress))
                _contactChip('Email: ${d!.emailAddress!}', regular),
              if (_hasText(d?.phoneNumber))
                _contactChip('Phone: ${d!.phoneNumber!}', regular),
              if (_hasText(d?.location))
                _contactChip('Location: ${d!.location!}', regular),
              if (_hasText(d?.portfolioLinkedInUrl))
                _contactChip(d!.portfolioLinkedInUrl!, regular),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _contactChip(String text, pw.Font font) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        font: font,
        fontSize: 9,
        color: PdfColor(1, 1, 1, 0.8),
      ),
    );
  }

  static pw.Widget _buildSectionHeader(String title, pw.Font bold) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          title.toUpperCase(),
          style: pw.TextStyle(
            font: bold,
            fontSize: 9,
            letterSpacing: 1.5,
            color: _primaryBlue,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Divider(color: _dividerColor, thickness: 1),
      ],
    );
  }

  static pw.Widget _buildExperienceItem(
    Map<String, dynamic> e,
    pw.Font bold,
    pw.Font regular,
    pw.Font italic,
  ) {
    final title = e['Job Title'] as String? ?? '';
    final company = e['Company'] as String? ?? '';
    final startDate = e['Start Date'] as String? ?? '';
    final endDate = e['End Date'] as String? ?? '';
    final isCurrent = e['I currently work here'] == true;
    final description = e['Description'] as String? ?? '';

    final dateLabel = _buildDateRange(
      startDate,
      isCurrent ? 'Present' : endDate,
    );

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.only(left: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: _primaryBlue, width: 2)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(
                  font: bold,
                  fontSize: 11,
                  color: _textPrimary,
                ),
              ),
              if (dateLabel.isNotEmpty)
                pw.Text(
                  dateLabel,
                  style: pw.TextStyle(
                    font: italic,
                    fontSize: 9,
                    color: _textSecondary,
                  ),
                ),
            ],
          ),
          if (company.isNotEmpty) ...[
            pw.SizedBox(height: 2),
            pw.Text(
              company,
              style: pw.TextStyle(
                font: regular,
                fontSize: 10,
                color: _primaryBlue,
              ),
            ),
          ],
          if (description.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              description,
              style: pw.TextStyle(
                font: regular,
                fontSize: 9,
                color: _textPrimary,
                lineSpacing: 3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildEducationItem(
    Map<String, dynamic> e,
    pw.Font bold,
    pw.Font regular,
    pw.Font italic,
  ) {
    final school = e['School / University'] as String? ?? '';
    final degree = e['Degree / Qualification'] as String? ?? e['Degree'] as String? ?? '';
    final year = e['Year of Graduation'] as String? ?? e['Graduation Year'] as String? ?? '';
    final description = e['Additional Details'] as String? ?? e['Description'] as String? ?? '';

    return pw.Container(
      margin: const pw.EdgeInsets.only(bottom: 12),
      padding: const pw.EdgeInsets.only(left: 10),
      decoration: pw.BoxDecoration(
        border: pw.Border(left: pw.BorderSide(color: _primaryBlue, width: 2)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                degree,
                style: pw.TextStyle(
                  font: bold,
                  fontSize: 11,
                  color: _textPrimary,
                ),
              ),
              if (year.isNotEmpty)
                pw.Text(
                  year,
                  style: pw.TextStyle(
                    font: italic,
                    fontSize: 9,
                    color: _textSecondary,
                  ),
                ),
            ],
          ),
          if (school.isNotEmpty) ...[
            pw.SizedBox(height: 2),
            pw.Text(
              school,
              style: pw.TextStyle(
                font: regular,
                fontSize: 10,
                color: _primaryBlue,
              ),
            ),
          ],
          if (description.isNotEmpty) ...[
            pw.SizedBox(height: 4),
            pw.Text(
              description,
              style: pw.TextStyle(
                font: regular,
                fontSize: 9,
                color: _textPrimary,
                lineSpacing: 3,
              ),
            ),
          ],
        ],
      ),
    );
  }

  static pw.Widget _buildSkillsSection(List<String> skills, pw.Font font) {
    return pw.Wrap(
      spacing: 6,
      runSpacing: 6,
      children: skills.map((skill) => _buildSkillChip(skill, font)).toList(),
    );
  }

  static pw.Widget _buildSkillChip(String skill, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: pw.BoxDecoration(
        color: _lightBlue,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(12)),
        border: pw.Border.all(color: _primaryBlue, width: 0.5),
      ),
      child: pw.Text(
        skill,
        style: pw.TextStyle(font: font, fontSize: 9, color: _primaryBlue),
      ),
    );
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static bool _hasText(String? value) =>
      value != null && value.trim().isNotEmpty;

  static String _buildDateRange(String start, String end) {
    if (start.isEmpty && end.isEmpty) return '';
    if (start.isEmpty) return end;
    if (end.isEmpty) return start;
    return '$start – $end';
  }
}
