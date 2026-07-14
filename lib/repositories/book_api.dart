import 'dart:developer';

import 'package:book_nest/core/services/secure_storage_service.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:book_nest/models/user_model.dart';
import 'package:book_nest/core/services/api_service.dart';

class BookApi {
  Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await APIService().get(url: '/categories');
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<BookModel>> getBooks() async {
    final response = await APIService().get(url: '/books');
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<List<BookModel>> getFamousBooks() async {
    final response = await APIService().get(url: '/books/famous');
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load famous books');
    }
  }

  Future<BookModel> getBookById(int id) async {
    final response = await APIService().get(url: '/books/$id');
    if (response.statusCode == 200) {
      final book = BookModel.fromJson(response.data['data']);
      book.isBookmarked = response.data['isBookSaved'] as bool? ?? response.data['isBookmarked'] as bool? ?? false;
      return book;
    } else {
      throw Exception('Failed to load book');
    }
  }

  Future<List<BookModel>> searchBooks(String query) async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().get(
      url: '/books?search=$query',
      header: header,
    );
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to search books');
    }
  }

  Future<String> incrementReadCount(int id) async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().patch(
      url: '/books/read/$id',
      body: {},
      header: header,
    );
    log(response.data.toString());
    final data = response.data['data'] as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return data['epubUrl'] as String;
    } else {
      throw Exception('Failed to increment read count');
    }
  }

  Future<List<BookModel>> getSavedBooks() async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().get(
      url: '/saved-books',
      header: header,
    );
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list
          .map((e) => BookMarkedBooksModel.fromJson(e))
          .where((sb) => sb.book != null)
          .map((sb) {
            final book = sb.book as BookModel;
            book.isBookmarked = true;
            return book;
          })
          .toList();
    } else {
      throw Exception('Failed to load saved books');
    }
  }

  Future<void> saveBook(int bookId) async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().post(
      url: '/saved-books/$bookId',
      body: {},
      header: header,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to save book');
    }
  }

  Future<void> removeSavedBook(int bookId) async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().delete(
      url: '/saved-books/$bookId',
      header: header,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to remove saved book');
    }
  }

  Future<List<BookModel>> getBooksByCategory(int categoryId) async {
    final header = {
      'Authorization': 'Bearer ${await SecureStorageService().getAuthToken()}',
    };
    final response = await APIService().get(
      url: '/categories/$categoryId/books',
      header: header,
    );
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data['data'];
      return list.map((e) => BookModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load books by category');
    }
  }
}
