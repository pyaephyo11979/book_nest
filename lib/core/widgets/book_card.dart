import 'package:book_nest/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BookCard extends StatelessWidget {
  final BookModel book;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/book/${book.id}');
      },
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.coverImage, width: 100, height: 150),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(book.author, style: const TextStyle(fontSize: 15)),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Text(
                          book.bookCategories?.isNotEmpty == true
                              ? book.bookCategories!
                                    .map((c) => c.category?.name)
                                    .join(', ')
                              : 'No category',
                          style: const TextStyle(color: Colors.lightGreen),
                        ),
                        const Spacer(),
                        Text(
                          book.price > 0
                              ? '${book.price.toString()} MMK'
                              : 'Free',
                          style: const TextStyle(color: Colors.amber),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
