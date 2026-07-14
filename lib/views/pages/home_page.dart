import 'package:book_nest/controllers/book_controller.dart';
import 'package:book_nest/core/widgets/book_card.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onCategorySelected;
  const HomePage({this.onCategorySelected, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> categories = [];
  List<BookModel> books = [];
  List<BookModel> famousBooks = [];

  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  int currentIndex = 0;
  List<String> imagePaths = [];

  void fetchAll() async {
    final controller = BookController();
    final fetchedCategories = await controller.getCategories();
    final fetchedBooks = await controller.getBooks();
    final fetchedFamousBooks = await controller.getFamousBooks();
    if (mounted) {
      setState(() {
        categories = fetchedCategories;
        books = fetchedBooks;
        famousBooks = fetchedFamousBooks;
        imagePaths = famousBooks.map((book) => book.imagePath).toList();
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          KeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            onKeyEvent: (event) {
              if (event.logicalKey.keyLabel == 'Enter' ||
                  event.logicalKey.keyLabel == 'Numpad Enter' ||
                  event.logicalKey.keyLabel == 'Return') {
                String searchText = _searchController.text;
                context.push('/search?query=$searchText');
              }
            },
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search Books by name or author namek',
                hintStyle: TextStyle(color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    String searchText = _searchController.text;
                    context.push('/search?query=$searchText');
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          CarouselSlider(
            items: [
              for (var book in famousBooks)
                Skeletonizer(
                  enabled: isLoading,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/book/${book.id}');
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage(book.imagePath),
                          fit: BoxFit.cover,
                          opacity: 0.8,
                        ),
                      ),
                      child: Image.network(book.imagePath, fit: BoxFit.contain),
                    ),
                  ),
                ),
            ],
            options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: currentIndex,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              onPageChanged: (index, reason) =>
                  setState(() => currentIndex = index),
            ),
          ),
          SizedBox(height: 10),
          SmoothPageIndicator(
            controller: PageController(initialPage: currentIndex),
            count: famousBooks.length,
            effect: WormEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotColor: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  widget.onCategorySelected?.call(0);
                },
                child: Text('See All'),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 40,
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      final categoryId = categories[index]['id'];
                      if (categoryId != null) {
                        widget.onCategorySelected?.call(categoryId);
                      }
                    },
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.all(5),
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(categories[index]['name'] ?? ''),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Skeletonizer(
              enabled: isLoading,
              child: ListView.builder(
                itemCount: books.isNotEmpty ? books.length : 10,
                itemBuilder: (context, index) {
                  if (books.isEmpty) {
                    List<BookModel> dummyBooks = List.generate(
                      10,
                      (index) => BookModel(
                        id: index,
                        title: 'Loading...',
                        author: 'Loading...',
                        bookCategories: [
                          BookCategory(
                            id: 0,
                            bookId: 0,
                            categoryId: 0,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            category: CategoryModel(id: 0, name: 'Loading...'),
                          ),
                        ],
                        price: 0,
                        coverImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Gu3g6VFFG3HksfbH4YXt8XWW98bxSf_1_w&s',
                        isFamous: false,
                        isPopular: false,
                        language: 'Loading...',
                        publicationYear: 0,
                        publisher: 'Loading...',
                        rating: 0.0,
                        readCount: 0,
                        description: 'Loading...',
                        epubFile: '',
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      ),
                    );
                    return BookCard(book: dummyBooks[index]);
                  }
                  return BookCard(book: books[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
