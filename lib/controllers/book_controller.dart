import 'package:book_nest/models/book_model.dart';
import 'package:book_nest/repositories/book_api.dart';

class BookController {
  final BookApi bookApi;
  BookController({required this.bookApi});

  Future<List<Map<String, dynamic>>> getCategories() async {
    List<Map<String, dynamic>> categories = await bookApi.getCategories();
    return categories;
  }

  Future<List<BookModel>> getBooks() async {
    List<BookModel> books = await bookApi.getBooks();
    return books;
  }

  Future<List<BookModel>> getFamousBooks() async {
    List<BookModel> books = await bookApi.getFamousBooks();
    return books;
  }

  Future<BookModel> getBookById(int id) async {
    BookModel book = await bookApi.getBookById(id);
    return book;
  }

  Future<List<BookModel>> searchBooks(String query) async {
    List<BookModel> books = await bookApi.searchBooks(query);
    return books;
  }

  Future<String> incrementReadCount(int id) async {
    return await bookApi.incrementReadCount(id);
  }

  Future<List<BookModel>> getSavedBooks() async {
    return await bookApi.getSavedBooks();
  }

  Future<void> saveBook(int bookId) async {
    await bookApi.saveBook(bookId);
  }

  Future<void> removeSavedBook(int bookId) async {
    await bookApi.removeSavedBook(bookId);
  }

  Future<List<BookModel>> getBooksByCategory(int categoryId) async {
    return await bookApi.getBooksByCategory(categoryId);
  }
}
