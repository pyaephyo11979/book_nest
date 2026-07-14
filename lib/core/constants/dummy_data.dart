// import 'package:book_nest/models/book_model.dart';
// import 'package:book_nest/models/user_model.dart';

// class DummyData {
//   static const List<Map<String, dynamic>> categories = [
//     {'id': 1, 'name': 'Science Fiction'},
//     {'id': 2, 'name': 'Fantasy'},
//     {'id': 3, 'name': 'Mystery'},
//     {'id': 4, 'name': 'Thriller'},
//     {'id': 5, 'name': 'Romance'},
//     {'id': 6, 'name': 'Horror'},
//     {'id': 7, 'name': 'Historical Fiction'},
//     {'id': 8, 'name': 'Biography'},
//     {'id': 9, 'name': 'Self-Help'},
//     {'id': 10, 'name': 'Poetry'},
//     {'id': 11, 'name': 'Young Adult'},
//     {'id': 12, 'name': 'Children'},
//     {'id': 13, 'name': 'Travel'},
//     {'id': 14, 'name': 'Cookbooks'},
//   ];

//   static final List<BookModel> books = [
//     BookModel(
//       id: 1,
//       title: 'The Great Gatsby',
//       author: 'F. Scott Fitzgerald',
//       category: CategoryModel(id: 1, name: 'Science Fiction'),
//       price: 0,
//       coverImage: 'assets/images/book1.jpeg',
//       isFamous: true,
//       isPopular: false,
//       description:
//           'The Great Gatsby is a novel by F. Scott Fitzgerald that explores themes of wealth, love, and the American Dream in the 1920s. It tells the story of Jay Gatsby, a mysterious millionaire, and his obsession with the beautiful Daisy Buchanan.',
//     ),
//     BookModel(
//       id: 2,
//       title: 'To Kill a Mockingbird',
//       author: 'Harper Lee',
//       category: CategoryModel(id: 3, name: 'Mystery'),
//       price: 8000,
//       coverImage: 'assets/images/book2.jpeg',
//       isFamous: true,
//       isPopular: false,
//       description:
//           'To Kill a Mockingbird is a novel by Harper Lee published in 1960. It is set in the American South during the 1930s and deals with the issue of racial injustice and the loss of innocence.',
//     ),
//     BookModel(
//       id: 3,
//       title: '1984',
//       author: 'George Orwell',
//       category: CategoryModel(id: 1, name: 'Science Fiction'),
//       price: 12000,
//       imagePath: 'assets/images/book3.jpeg',
//       isFamous: false,
//       isPopular: false,
//       description:
//           '1984 is a dystopian novel by George Orwell published in 1949. It presents a terrifying vision of a totalitarian future where the government controls every aspect of life, including thoughts and beliefs.',
//     ),
//     BookModel(
//       id: 4,
//       title: 'Pride and Prejudice',
//       author: 'Jane Austen',
//       category: CategoryModel(id: 5, name: 'Romance'),
//       price: 0,
//       imagePath: 'assets/images/book4.jpeg',
//       isFamous: false,
//       isPopular: true,
//       description:
//           'Pride and Prejudice is a romantic novel by Jane Austen, first published in 1813. It follows the story of Elizabeth Bennet as she navigates issues of manners, upbringing, morality, and marriage in the society of the landed gentry of early 19th-century England.',
//     ),
//     BookModel(
//       id: 5,
//       title: 'The Hobbit',
//       author: 'J.R.R. Tolkien',
//       category: CategoryModel(id: 6, name: 'Fantasy'),
//       price: 15000,
//       imagePath: 'assets/images/book5.jpeg',
//       isFamous: true,
//       isPopular: false,
//       description:
//           'The Hobbit is a fantasy novel by J.R.R. Tolkien, first published in 1937. It follows the story of Bilbo Baggins, a hobbit who is swept into an epic quest to reclaim the lost kingdom of Erebor.',
//     ),
//   ];

//   static final List<UserModel> users = [
//     UserModel(
//       id: 1,
//       name: 'John Doe',
//       email: 'john@example.com',
//       password: 'password123',
//       bookMarkedBooks: [
//         BookMarkedBooksModel(id: 1, book: books[0]),
//         BookMarkedBooksModel(id: 2, book: books[1]),
//       ],
//     ),
//     UserModel(
//       id: 2,
//       name: 'Jane Smith',
//       email: 'jane.smith@example.com',
//       password: 'password456',
//       bookMarkedBooks: [
//         BookMarkedBooksModel(id: 3, book: books[2]),
//         BookMarkedBooksModel(id: 4, book: books[3]),
//       ],
//     ),
//   ];
// }
