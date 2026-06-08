import 'package:flutter_test/flutter_test.dart';
import 'package:super_career_ai/Core/validators.dart';

// =====================================================
// Super Career AI - Unit Tests
// Module: Authentication (Login & SignUp Validators)
// Author: Ali Toson
// Date: 2025
// =====================================================

// calculateMatchScore موجودة هنا لأنها مش في validators.dart
double calculateMatchScore(String label) {
  switch (label.toLowerCase()) {
    case 'excellent':
      return 0.95;
    case 'good':
      return 0.75;
    case 'fair':
      return 0.55;
    default:
      return 0.0;
  }
}

// =====================================================
void main() {
  // ---- Email Validator Tests ----
  group('Email Validator Tests', () {
    test('TC-001: Valid email returns null (no error)', () {
      final result = validateEmail('test@example.com');
      expect(result, isNull);
    });

    test('TC-002: Empty email returns required error', () {
      final result = validateEmail('');
      expect(result, 'Email is required');
    });

    test('TC-003: Null email returns required error', () {
      final result = validateEmail(null);
      expect(result, 'Email is required');
    });

    test('TC-004: Email without @ returns format error', () {
      final result = validateEmail('notanemail');
      expect(result, 'Please enter a valid email address');
    });

    test('TC-005: Email without domain returns format error', () {
      final result = validateEmail('user@');
      expect(result, 'Please enter a valid email address');
    });

    test('TC-006: Email with spaces only returns required error', () {
      final result = validateEmail('   ');
      expect(result, 'Email is required');
    });

    test('TC-007: Valid email with subdomain returns null', () {
      final result = validateEmail('user@mail.example.com');
      expect(result, isNull);
    });
  });

  // ---- Password Validator Tests ----
  group('Password Validator Tests', () {
    test('TC-008: Valid password (8+ chars) returns null', () {
      final result = validatePassword('Test@1234');
      expect(result, isNull);
    });

    test('TC-009: Empty password returns required error', () {
      final result = validatePassword('');
      expect(result, 'Password is required');
    });

    test('TC-010: Null password returns required error', () {
      final result = validatePassword(null);
      expect(result, 'Password is required');
    });

    test('TC-011: Short password (less than 8 chars) returns length error', () {
      final result = validatePassword('abc123');
      expect(result, 'Password must be at least 8 characters');
    });

    test('TC-012: Password of exactly 8 characters returns null', () {
      final result = validatePassword('Abcde123');
      expect(result, isNull);
    });

    test('TC-013: Very long password returns null (no max limit)', () {
      final result = validatePassword('A' * 100);
      expect(result, isNull);
    });
  });

  // ---- Full Name Validator Tests ----
  group('Full Name Validator Tests', () {
    test('TC-014: Valid full name returns null', () {
      final result = validateFullName('Alex Johnson');
      expect(result, isNull);
    });

    test('TC-015: Empty full name returns required error', () {
      final result = validateFullName('');
      expect(result, 'Full name is required');
    });

    test('TC-016: Null full name returns required error', () {
      final result = validateFullName(null);
      expect(result, 'Full name is required');
    });

    test('TC-017: Single character name returns format error', () {
      final result = validateFullName('A');
      expect(result, 'Please enter a valid full name');
    });

    test('TC-018: Name with spaces only returns required error', () {
      final result = validateFullName('   ');
      expect(result, 'Full name is required');
    });
  });

  // ---- Match Score Calculator Tests ----
  group('Match Score Calculator Tests', () {
    test('TC-019: Excellent match returns score >= 0.9', () {
      final score = calculateMatchScore('Excellent');
      expect(score, greaterThanOrEqualTo(0.9));
    });

    test('TC-020: Good match returns score between 0.6 and 0.9', () {
      final score = calculateMatchScore('Good');
      expect(score, greaterThan(0.6));
      expect(score, lessThan(0.9));
    });

    test('TC-021: Fair match returns score between 0.4 and 0.7', () {
      final score = calculateMatchScore('Fair');
      expect(score, greaterThan(0.4));
      expect(score, lessThan(0.7));
    });

    test('TC-022: Unknown label returns 0.0', () {
      final score = calculateMatchScore('Unknown');
      expect(score, equals(0.0));
    });

    test('TC-023: Case-insensitive match label (excellent) works', () {
      final score = calculateMatchScore('excellent');
      expect(score, greaterThanOrEqualTo(0.9));
    });
  });
}