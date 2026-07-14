import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'We are a digital reading platform designed for the modern reader. Our mission is to make reading an effortless, beautiful, and deeply personal experience. In a fast-paced world, we provide a curated space where stories come alive. We bridge the gap between brilliant authors and passionate readers by offering a seamless user experience, thoughtful book collections, and features that fit perfectly into your daily lifestyle.',
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
              SizedBox(height: 20),
              Text(
                'Why Read With Us?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  '),
                  Expanded(
                    child: Text(
                      'Curated Just for You: From international bestsellers to hidden literary gems, we find the books that matter.',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  '),
                  Expanded(
                    child: Text(
                      'Read Anywhere, Anytime: A fully optimized, distraction-free reading environment right in the palm of your hand.',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('•  '),
                  Expanded(
                    child: Text(
                      'More Than Just Words: We don\'t just host books—we cultivate a community where stories spark meaningful connections.',
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
