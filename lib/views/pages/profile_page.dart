import 'package:book_nest/controllers/user_controller.dart';
import 'package:book_nest/models/user_model.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  bool isLoading = true;

  void fetchUser() async {
    final fetchedUser = await UserController().getUserData(1);
    if (mounted) {
      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
    }
  }

  void logout() async {
    await UserController().logout(context);
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  void dispose() {
    super.dispose();
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
                      'Profile',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                          child: Text(
                            user?.name.substring(0, 1) ?? 'Loading...',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Loading...',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user?.email ?? 'Loading...',
                              style: TextStyle(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 105, 104, 104),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey, thickness: 0.5, height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 150,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 10);
                        },
                        itemCount: user?.bookMarkedBooks?.length ?? 0,
                        itemBuilder: (context, index) {
                          final book = user!.bookMarkedBooks![index].book;
                          if (book == null) return const SizedBox.shrink();
                          return GestureDetector(
                            onTap: () {
                              context.push('/book/${book.id}');
                            },
                            child: SizedBox(
                              child: Image.network(
                                book.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Divider(color: Colors.grey, thickness: 0.5, height: 20),
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.info),
                      title: Text('About Us'),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        context.push('/about_us');
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () {
                        logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
