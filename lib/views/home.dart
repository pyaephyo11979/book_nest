import 'package:book_nest/core/widgets/nav_bar.dart';
import 'package:book_nest/views/pages/home_page.dart';
import 'package:book_nest/views/pages/library_page.dart';
import 'package:book_nest/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  int _libraryCategoryId = 0;

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        _libraryCategoryId = 0;
      }
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        onCategorySelected: (categoryId) {
          setState(() {
            _libraryCategoryId = categoryId;
            _selectedIndex = 1;
          });
        },
      ),
      LibraryPage(
        key: ValueKey(_libraryCategoryId),
        categoryId: _libraryCategoryId,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: navBar(context),
      body: pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.book),
            label: 'Library',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
