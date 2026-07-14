import 'package:book_nest/models/user_model.dart';

class Category {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
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

class Book {
  final int id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String coverImage;
  final String epubFile;
  final String language;
  final int publicationYear;
  final String publisher;
  final double rating;
  final int readCount;
  final bool isFamous;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SavedBook>? bookmarks;
  final List<BookCategory>? bookCategories;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.coverImage,
    required this.epubFile,
    required this.language,
    required this.publicationYear,
    required this.publisher,
    this.rating = 0,
    this.readCount = 0,
    this.isFamous = false,
    required this.createdAt,
    required this.updatedAt,
    this.bookmarks,
    this.bookCategories,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      coverImage: json['cover_image'] as String? ?? '',
      epubFile: json['epub_file'] as String? ?? '',
      language: json['language'] as String? ?? '',
      publicationYear: json['publication_year'] as int? ?? 0,
      publisher: json['publisher'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      readCount: json['read_count'] as int? ?? 0,
      isFamous: json['isFamous'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      bookmarks: json['bookmarks'] != null
          ? (json['bookmarks'] as List)
                .map((e) => SavedBook.fromJson(e))
                .toList()
          : null,
      bookCategories: json['bookCategories'] != null
          ? (json['bookCategories'] as List)
                .map((e) => BookCategory.fromJson(e))
                .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'price': price,
      'cover_image': coverImage,
      'epub_file': epubFile,
      'language': language,
      'publication_year': publicationYear,
      'publisher': publisher,
      'rating': rating,
      'read_count': readCount,
      'isFamous': isFamous,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'bookmarks': bookmarks?.map((e) => e.toJson()).toList(),
      'bookCategories': bookCategories?.map((e) => e.toJson()).toList(),
    };
  }
}

class BookCategory {
  final int id;
  final int bookId;
  final int categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Book? book;
  final Category? category;

  BookCategory({
    required this.id,
    required this.bookId,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.book,
    this.category,
  });

  factory BookCategory.fromJson(Map<String, dynamic> json) {
    return BookCategory(
      id: json['id'] as int,
      bookId: json['bookId'] as int,
      categoryId: json['categoryId'] as int,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      book: json['book'] != null ? Book.fromJson(json['book']) : null,
      category: json['category'] != null
          ? Category.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookId': bookId,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'book': book?.toJson(),
      'category': category?.toJson(),
    };
  }
}

class CategoryModel extends Category {
  CategoryModel({required super.id, required super.name})
    : super(createdAt: DateTime.now(), updatedAt: DateTime.now());

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'] as int, name: json['name'] as String);
  }
}

class BookModel extends Book {
  final bool isPopular;
  bool? isBookmarked;

  BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.price,
    required super.description,
    required super.coverImage,
    required super.isFamous,
    required super.language,
    required super.bookCategories,
    required super.publicationYear,
    required super.rating,
    required super.readCount,
    required super.publisher,
    required super.epubFile,
    required super.createdAt,
    required super.updatedAt,
    required this.isPopular,
    this.isBookmarked,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      price: (json['price'] as num).toDouble(),
      coverImage: json['cover_image'] as String,
      isFamous:
          json['isFamous'] as bool? ?? json['is_famous'] as bool? ?? false,
      isPopular: json['is_popular'] as bool? ?? false,
      language: json['language'] as String? ?? '',
      publicationYear: json['publication_year'] as int? ?? 0,
      publisher: json['publisher'] as String? ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      readCount: json['read_count'] as int? ?? 0,
      epubFile: json['epub_file'] as String? ?? '',
      isBookmarked: json['isBookmarked'] as bool? ?? false,
      description: json['description'] as String? ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      bookCategories: json['bookCategories'] != null
          ? (json['bookCategories'] as List)
                .map((e) => BookCategory.fromJson(e))
                .toList()
          : null,
    );
  }
}

extension BookCompatibility on Book {
  String get imagePath => coverImage;
  bool get isPopular => readCount > 10;
}
