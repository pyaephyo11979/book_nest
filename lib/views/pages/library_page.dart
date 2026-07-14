import 'package:book_nest/controllers/book_controller.dart';
import 'package:book_nest/core/widgets/book_card.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:book_nest/repositories/book_api.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({this.categoryId = 0, super.key});
  final int categoryId;
  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  List<BookModel> books = [];
  List<Map<String, dynamic>> categories = [
    {'id': 0, 'name': 'All'},
  ];
  bool isLoading = true;
  int selectedCategoryId = 0;

  void fetchBooksByCategory(int categoryId) async {
    final controller = BookController(bookApi: BookApi());
    if (categoryId == 0) {
      final fetchedBooks = await controller.getBooks();
      if (mounted) {
        setState(() {
          books = fetchedBooks;
          isLoading = false;
        });
      }
      return;
    }
    final fetchedBooks = await controller.getBooksByCategory(categoryId);
    if (mounted) {
      setState(() {
        books = fetchedBooks;
        isLoading = false;
      });
    }
  }

  void fetchAll() async {
    final controller = BookController(bookApi: BookApi());
    if (widget.categoryId != 0) {
      selectedCategoryId = widget.categoryId;
    }
    final List<BookModel> fetchedBooks;
    if (selectedCategoryId != 0) {
      fetchedBooks = await controller.getBooksByCategory(selectedCategoryId);
    } else {
      fetchedBooks = await controller.getBooks();
    }
    final fetchedCategories = await controller.getCategories();
    if (mounted) {
      setState(() {
        books = fetchedBooks;
        categories.addAll(fetchedCategories);
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Library',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategoryId = categories[index]['id'];
                                isLoading = true;
                                fetchBooksByCategory(selectedCategoryId);
                              });
                            },
                            child: Container(
                              height: 30,
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                color:
                                    selectedCategoryId ==
                                        categories[index]['id']
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                categories[index]['name'],
                                style: TextStyle(
                                  color:
                                      selectedCategoryId ==
                                          categories[index]['id']
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    if (books.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/bookNotFound.png',
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'No results found for "${categories.firstWhere((cat) => cat['id'] == selectedCategoryId)['name']}"',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: books.length,
                        itemBuilder: (context, index) {
                          return BookCard(book: books[index]);
                        },
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
