import 'package:flutter_test/flutter_test.dart';
import 'package:livemcq3/data/models/auth_models.dart';
import 'package:livemcq3/data/models/book_models.dart';
import 'package:livemcq3/data/models/contest_models.dart';
import 'package:livemcq3/data/models/exam_models.dart';
import 'package:livemcq3/data/models/job_models.dart';
import 'package:livemcq3/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('fromJson creates model with correct fields', () {
      final json = {
        'id': 1,
        'name': 'Test User',
        'email': 'test@example.com',
        'phone': '01700000000',
        'photo': 'https://example.com/photo.jpg',
        'is_premium': true,
        'created_at': '2026-08-17T00:00:00.000000Z',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 1);
      expect(user.name, 'Test User');
      expect(user.email, 'test@example.com');
      expect(user.phone, '01700000000');
      expect(user.photo, 'https://example.com/photo.jpg');
      expect(user.isPremium, true);
      expect(user.createdAt, '2026-08-17T00:00:00.000000Z');
    });

    test('fromJson handles missing optional fields', () {
      final json = {
        'id': 2,
        'name': 'Jane Doe',
        'email': 'jane@example.com',
      };

      final user = UserModel.fromJson(json);

      expect(user.id, 2);
      expect(user.name, 'Jane Doe');
      expect(user.phone, isNull);
      expect(user.photo, isNull);
      expect(user.isPremium, false);
    });

    test('toJson returns correct map', () {
      final user = UserModel(
        id: 3,
        name: 'Bob',
        email: 'bob@example.com',
        phone: '01800000000',
        isPremium: true,
      );

      final json = user.toJson();

      expect(json['id'], 3);
      expect(json['name'], 'Bob');
      expect(json['email'], 'bob@example.com');
      expect(json['phone'], '01800000000');
      expect(json['is_premium'], true);
    });
  });

  group('ExamCategoryModel', () {
    test('fromJson parses category correctly', () {
      final json = {
        'id': 1,
        'name': 'BCS',
        'description': 'Bangladesh Civil Service',
        'icon': 'school',
        'is_premium': false,
        'price': 0,
        'subjects_count': 10,
      };

      final category = ExamCategoryModel.fromJson(json);

      expect(category.id, 1);
      expect(category.name, 'BCS');
      expect(category.description, 'Bangladesh Civil Service');
      expect(category.isPremium, false);
      expect(category.price, 0);
      expect(category.subjectsCount, 10);
    });

    test('fromJson defaults premium to false when missing', () {
      final json = {
        'id': 2,
        'name': 'Bank',
      };

      final category = ExamCategoryModel.fromJson(json);

      expect(category.isPremium, false);
    });
  });

  group('QuestionModel', () {
    test('fromJson parses question with options', () {
      final json = {
        'id': 1,
        'exam_category_id': 1,
        'subject_id': 1,
        'text': 'What is 2+2?',
        'explanation': '2+2=4',
        'difficulty': 'easy',
        'options': [
          {'id': 1, 'question_id': 1, 'text': '3', 'is_correct': false},
          {'id': 2, 'question_id': 1, 'text': '4', 'is_correct': true},
        ],
      };

      final question = QuestionModel.fromJson(json);

      expect(question.id, 1);
      expect(question.text, 'What is 2+2?');
      expect(question.options.length, 2);
      expect(question.options[0].isCorrect, false);
      expect(question.options[1].isCorrect, true);
    });

    test('fromJson handles empty options', () {
      final json = {
        'id': 2,
        'exam_category_id': 1,
        'subject_id': 1,
        'text': 'Test?',
      };

      final question = QuestionModel.fromJson(json);

      expect(question.options, isEmpty);
    });
  });

  group('JobCircularModel', () {
    test('fromJson parses job correctly', () {
      final json = {
        'id': 1,
        'job_category_id': 1,
        'title': 'Software Engineer',
        'company_name': 'Tech Corp',
        'description': 'Build apps',
        'requirements': 'CS degree',
        'salary_range': '50k-80k',
        'location': 'Dhaka',
        'deadline': '2026-08-25',
        'status': 'active',
        'source_name': 'BDJobs',
        'application_link': 'https://example.com/apply',
      };

      final job = JobCircularModel.fromJson(json);

      expect(job.id, 1);
      expect(job.title, 'Software Engineer');
      expect(job.companyName, 'Tech Corp');
      expect(job.location, 'Dhaka');
      expect(job.status, 'active');
    });
  });

  group('BookModel', () {
    test('fromJson parses book correctly', () {
      final json = {
        'id': 1,
        'title': 'Flutter Guide',
        'author': 'John Doe',
        'description': 'Learn Flutter',
        'price': 500,
        'cover_image': 'https://example.com/cover.jpg',
        'preview_file_path': 'https://example.com/preview.pdf',
        'is_purchased': true,
      };

      final book = BookModel.fromJson(json);

      expect(book.id, 1);
      expect(book.title, 'Flutter Guide');
      expect(book.author, 'John Doe');
      expect(book.price, 500);
      expect(book.isPurchased, true);
    });
  });

  group('LiveContestModel', () {
    test('fromJson parses contest correctly', () {
      final json = {
        'id': 1,
        'title': 'Weekly Quiz',
        'description': 'Test your skills',
        'start_time': '2026-08-17 20:00:00',
        'end_time': '2026-08-17 21:00:00',
        'is_active': true,
        'is_premium': false,
        'price': 0,
        'has_joined': true,
        'has_access': true,
      };

      final contest = LiveContestModel.fromJson(json);

      expect(contest.id, 1);
      expect(contest.title, 'Weekly Quiz');
      expect(contest.isActive, true);
      expect(contest.hasJoined, true);
    });
  });

  group('Auth Models', () {
    test('LoginRequestModel toJson is correct', () {
      final request = LoginRequestModel(email: 'test@example.com', password: 'password123');
      final json = request.toJson();

      expect(json['email'], 'test@example.com');
      expect(json['password'], 'password123');
    });

    test('RegisterRequestModel toJson includes optional phone', () {
      final request = RegisterRequestModel(
        name: 'Test',
        email: 'test@example.com',
        password: 'password123',
        phone: '01700000000',
      );
      final json = request.toJson();

      expect(json['phone'], '01700000000');
    });

    test('AuthResponseModel fromJson parses token and user', () {
      final json = {
        'token': 'abc123',
        'user': {
          'id': 1,
          'name': 'Test',
          'email': 'test@example.com',
        },
      };

      final response = AuthResponseModel.fromJson(json);

      expect(response.token, 'abc123');
      expect(response.user.id, 1);
      expect(response.user.name, 'Test');
    });
  });
}
