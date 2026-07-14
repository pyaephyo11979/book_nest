import 'package:book_nest/controllers/book_controller.dart';
import 'package:book_nest/core/widgets/book_card.dart';
import 'package:book_nest/core/widgets/nav_bar.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:book_nest/repositories/book_api.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Search extends StatefulWidget {
  const Search({required this.searchQuery, super.key});

  final String searchQuery;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final List<BookModel> _searchResults = [];
  bool _isLoading = false;

  Future<void> _performSearch() async {
    setState(() {
      _isLoading = true;
    });
    String query = _searchController.text.toLowerCase();
    List<BookModel> results = await BookController(
      bookApi: BookApi(),
    ).searchBooks(query);
    setState(() {
      _searchResults.clear();
      _searchResults.addAll(results);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.searchQuery;
    _performSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: navBar(context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            KeyboardListener(
              autofocus: true,
              focusNode: FocusNode(),
              onKeyEvent: (event) {
                if (event.logicalKey.keyLabel == 'Enter') {
                  _performSearch();
                }
              },
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _performSearch();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: _isLoading == false && _searchResults.isEmpty
                  ? Center(
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
                            'No results found for "${_searchController.text}"',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : Skeletonizer(
                      enabled: _isLoading,
                      child: ListView.builder(
                        itemCount: _searchResults.isNotEmpty
                            ? _searchResults.length
                            : 1,
                        itemBuilder: (context, index) {
                          if (_searchResults.isEmpty) {
                            List<BookModel> dummyBooks = List.generate(
                              5,
                              (index) => BookModel(
                                id: index,
                                title: 'Loading...',
                                author: 'Loading...',
                                price: 0,
                                description: 'Loading...',
                                coverImage:
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4Gu3g6VFFG3HksfbH4YXt8XWW98bxSf_1_w&s',
                                language: 'Loading...',
                                publicationYear: 0,
                                publisher: 'Loading...',
                                rating: 0.0,
                                readCount: 0,
                                epubFile: '',
                                bookCategories: [],
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                isFamous: false,
                                isPopular: false,
                              ),
                            );
                            _searchResults.addAll(dummyBooks);
                          }
                          return BookCard(book: _searchResults[index]);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
