import 'package:book_nest/controllers/book_controller.dart';
import 'package:book_nest/models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({required this.id, super.key});

  final String id;

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  final epubController = EpubController();
  String? epubUrl;
  BookModel? book;
  bool isLoading = true;
  String? errorMessage;

  void fetchEpubData() async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final bookId = int.parse(widget.id);
      final bookController = BookController();

      final results = await Future.wait([
        bookController.getBookById(bookId),
        bookController.incrementReadCount(bookId),
      ]);

      final fetchedBook = results[0] as BookModel;
      final url = results[1] as String;
      final encodedUrl = Uri.encodeFull(url);

      if (mounted) {
        setState(() {
          book = fetchedBook;
          epubUrl = encodedUrl;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          errorMessage = e.toString().replaceAll('Exception: ', '');
          isLoading = false;
        });
        showToast(
          errorMessage ?? 'Failed to load book',
          context: context,
          animation: StyledToastAnimation.slideFromTopFade,
          reverseAnimation: StyledToastAnimation.slideToTopFade,
          position: StyledToastPosition.top,
          animDuration: const Duration(milliseconds: 200),
          duration: const Duration(seconds: 4),
          curve: Curves.easeInOut,
          backgroundColor: Colors.red,
          reverseCurve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEpubData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book?.title ?? 'Epub Reader'),
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: fetchEpubData,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: EpubViewer(
                      epubController: epubController,
                      epubSource: EpubSource.fromUrl(epubUrl ?? ''),
                      displaySettings: EpubDisplaySettings(
                        flow: EpubFlow.paginated,
                        snap: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            epubController.prev();
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Previous'),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            epubController.next();
                          },
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
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
