import 'package:flutter_test/flutter_test.dart';
import 'package:livemcq3/data/models/exam_models.dart';
import 'package:livemcq3/data/models/book_models.dart';

void main() {
  group('Exam Submit Result - Scoring', () {
    test('ExamSubmitResultModel calculates score correctly', () {
      final json = {
        'correct': 8,
        'wrong': 2,
        'total': 10,
        'score': 80.0,
        'session': {
          'id': 1,
          'user_id': 1,
          'exam_category_id': 1,
          'type': 'practice',
          'total_questions': 10,
          'correct_answers': 8,
          'wrong_answers': 2,
          'score': 80.0,
        },
      };

      final result = ExamSubmitResultModel.fromJson(json);

      expect(result.correct, 8);
      expect(result.wrong, 2);
      expect(result.total, 10);
      expect(result.score, 80.0);
      expect(result.session!.correctAnswers, 8);
      expect(result.session!.wrongAnswers, 2);
    });

    test('ExamSubmitResultModel handles missing session', () {
      final json = {
        'correct': 5,
        'wrong': 5,
        'total': 10,
        'score': 50.0,
      };

      final result = ExamSubmitResultModel.fromJson(json);

      expect(result.correct, 5);
      expect(result.wrong, 5);
      expect(result.total, 10);
      expect(result.score, 50.0);
      expect(result.session, isNull);
    });

    test('ExamSubmitResultModel handles default values', () {
      final json = <String, dynamic>{};

      final result = ExamSubmitResultModel.fromJson(json);

      expect(result.correct, 0);
      expect(result.wrong, 0);
      expect(result.total, 0);
      expect(result.score, 0.0);
      expect(result.session, isNull);
    });

    test('toJson returns correct map', () {
      final result = ExamSubmitResultModel(
        correct: 7,
        wrong: 3,
        total: 10,
        score: 70.0,
      );

      final json = result.toJson();

      expect(json['correct'], 7);
      expect(json['wrong'], 3);
      expect(json['total'], 10);
      expect(json['score'], 70.0);
      expect(json['session'], isNull);
    });
  });

  group('Exam Session - Timer Fields', () {
    test('ExamSessionModel tracks correct and wrong answers', () {
      final json = {
        'id': 42,
        'user_id': 5,
        'exam_category_id': 3,
        'type': 'mcq',
        'total_questions': 20,
        'correct_answers': 15,
        'wrong_answers': 5,
        'score': 75.0,
      };

      final session = ExamSessionModel.fromJson(json);

      expect(session.id, 42);
      expect(session.userId, 5);
      expect(session.examCategoryId, 3);
      expect(session.type, 'mcq');
      expect(session.totalQuestions, 20);
      expect(session.correctAnswers, 15);
      expect(session.wrongAnswers, 5);
      expect(session.score, 75.0);
    });

    test('ExamSessionModel fromJson handles int score', () {
      final json = {
        'id': 1,
        'user_id': 1,
        'exam_category_id': 1,
        'type': 'practice',
        'total_questions': 10,
        'correct_answers': 8,
        'wrong_answers': 2,
        'score': 80,
      };

      final session = ExamSessionModel.fromJson(json);
      expect(session.score, 80.0);
    });
  });

  group('Payment Status Handling', () {
    test('PurchaseModel fromJson parses payment correctly', () {
      final json = {
        'id': 1,
        'user_id': 1,
        'book_id': 5,
        'transaction_id': 'txn_12345',
        'amount': 500,
        'status': 'completed',
        'created_at': '2026-08-17T10:00:00.000000Z',
        'book': {
          'id': 5,
          'title': 'Flutter Guide',
          'author': 'John',
          'price': 500,
          'is_purchased': true,
        },
      };

      final purchase = PurchaseModel.fromJson(json);

      expect(purchase.id, 1);
      expect(purchase.userId, 1);
      expect(purchase.bookId, 5);
      expect(purchase.transactionId, 'txn_12345');
      expect(purchase.amount, 500.0);
      expect(purchase.status, 'completed');
      expect(purchase.book!.title, 'Flutter Guide');
    });

    test('PurchaseModel handles different statuses', () {
      final statuses = ['pending', 'completed', 'failed', 'cancelled'];

      for (final status in statuses) {
        final purchase = PurchaseModel.fromJson({
          'id': 1,
          'user_id': 1,
          'book_id': 1,
          'transaction_id': 'txn',
          'amount': 100,
          'status': status,
        });

        expect(purchase.status, status);
      }
    });

    test('OrderModel fromJson parses order correctly', () {
      final json = {
        'id': 1,
        'type': 'book',
        'item_id': 5,
        'item_title': 'Flutter Guide',
        'amount': 500,
        'status': 'paid',
        'transaction_id': 'txn_999',
        'created_at': '2026-08-17T10:00:00.000000Z',
      };

      final order = OrderModel.fromJson(json);

      expect(order.id, 1);
      expect(order.type, 'book');
      expect(order.itemId, 5);
      expect(order.itemTitle, 'Flutter Guide');
      expect(order.amount, 500.0);
      expect(order.status, 'paid');
      expect(order.transactionId, 'txn_999');
    });

    test('OrderModel handles missing transaction_id', () {
      final json = {
        'id': 2,
        'type': 'book',
        'item_id': 3,
        'item_title': 'Dart Guide',
        'amount': 300,
        'status': 'pending',
      };

      final order = OrderModel.fromJson(json);

      expect(order.transactionId, isNull);
      expect(order.status, 'pending');
    });

    test('BookModel isPurchased flag reflects purchase state', () {
      final purchasedJson = {
        'id': 1,
        'title': 'Guide',
        'author': 'Author',
        'price': 500,
        'is_purchased': true,
        'purchased_at': '2026-08-17T10:00:00.000000Z',
      };

      final purchasedBook = BookModel.fromJson(purchasedJson);

      expect(purchasedBook.isPurchased, true);
      expect(purchasedBook.purchasedAt, isNotNull);
    });

    test('BookModel handles unpaid state', () {
      final unpaidJson = {
        'id': 1,
        'title': 'Guide',
        'author': 'Author',
        'price': 500,
        'is_purchased': false,
      };

      final book = BookModel.fromJson(unpaidJson);

      expect(book.isPurchased, false);
      expect(book.purchasedAt, isNull);
    });
  });
}
