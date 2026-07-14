import 'package:book_nest/models/book_model.dart';

class Role {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Role({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class User {
  final int id;
  final String fullName;
  final String email;
  final int roleId;
  final Role? role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SavedBook>? bookmarks;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.roleId,
    this.role,
    required this.createdAt,
    required this.updatedAt,
    this.bookmarks,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      fullName: json['full_name'] as String? ?? json['name'] as String? ?? '',
      email: json['email'] as String,
      roleId: json['roleId'] as int? ?? 1,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
      bookmarks: json['bookmarks'] != null
          ? (json['bookmarks'] as List).map((e) => SavedBook.fromJson(e)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'roleId': roleId,
      'role': role?.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'bookmarks': bookmarks?.map((e) => e.toJson()).toList(),
    };
  }
}

class SavedBook {
  final int id;
  final int userId;
  final int bookId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User? user;
  final Book? book;

  SavedBook({
    required this.id,
    required this.userId,
    required this.bookId,
    required this.createdAt,
    required this.updatedAt,
    this.user,
    this.book,
  });

  factory SavedBook.fromJson(Map<String, dynamic> json) {
    return SavedBook(
      id: json['id'] as int,
      userId: json['userId'] as int,
      bookId: json['bookId'] as int,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : DateTime.now(),
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'bookId': bookId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'user': user?.toJson(),
      'book': book?.toJson(),
    };
  }
}

class BookMarkedBooksModel extends SavedBook {
  BookMarkedBooksModel({super.id = 0, super.book})
      : super(
          userId: 0,
          bookId: book?.id ?? 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  factory BookMarkedBooksModel.fromJson(Map<String, dynamic> json) {
    return BookMarkedBooksModel(
      id: json['id'] as int? ?? 0,
      book: json['book'] != null ? BookModel.fromJson(json['book']) : null,
    );
  }
}

class UserModel extends User {
  final String name;
  final String? password;
  final List<BookMarkedBooksModel>? bookMarkedBooks;

  UserModel({
    required super.id,
    required this.name,
    required super.email,
    this.password,
    this.bookMarkedBooks,
  }) : super(
          fullName: name,
          roleId: 1,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          bookmarks: bookMarkedBooks,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['full_name'] as String? ?? json['name'] as String? ?? '',
      email: json['email'] as String,
      password: json['password'] as String?,
      bookMarkedBooks: json['bookmarks'] != null
          ? (json['bookmarks'] as List).map((e) => BookMarkedBooksModel.fromJson(e)).toList()
          : json['bookmarkedBook'] != null
              ? (json['bookmarkedBook'] as List).map((e) => BookMarkedBooksModel.fromJson(e)).toList()
              : null,
    );
  }
}
