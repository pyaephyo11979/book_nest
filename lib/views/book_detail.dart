import 'package:book_nest/controllers/book_controller.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookDetail extends StatefulWidget {
  const BookDetail({required this.id, super.key});
  final int id;

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  BookModel? book;
  bool isReadLater = false;
  void fetchBook() async {
    final fetchedBook = await BookController().getBookById(widget.id);
    setState(() {
      book = fetchedBook;
      isReadLater = fetchedBook.isBookmarked ?? false;
    });
  }

  void toggleReadLater() async {
    if (book == null) return;
    final controller = BookController();
    if (isReadLater) {
      await controller.removeSavedBook(book!.id);
    } else {
      await controller.saveBook(book!.id);
    }
    setState(() {
      isReadLater = !isReadLater;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBook();
  }

  @override
  Widget build(BuildContext context) {
    final book = this.book;
    if (book == null) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            onPressed: () {
              toggleReadLater();
            },
            icon: Icon(isReadLater ? Icons.bookmark : Icons.bookmark_border),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                book.imagePath,
                width: 200,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              book.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              book.author,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              book.publicationYear.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Text(
              book.publisher,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              book.bookCategories?.isNotEmpty == true
                  ? book.bookCategories!.map((c) => c.category?.name).join(', ')
                  : 'No category',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 95, 157, 25),
              ),
            ),
            SizedBox(height: 10),
            Text(
              book.price > 0 ? '${book.price.toString()} MMK' : 'Free',
              style: TextStyle(
                fontSize: 18,
                color: const Color.fromARGB(255, 140, 108, 11),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              book.description.isNotEmpty
                  ? book.description
                  : 'No description available',
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ElevatedButton(
            onPressed: () {
              context.push('/epub_reader/${book.id}');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  book.price > 0 ? Icons.shopping_cart : Icons.menu_book,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  book.price > 0 ? 'Buy Now' : 'Read Now',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
