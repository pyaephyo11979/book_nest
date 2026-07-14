# Book Nest

A Flutter e-book reader and catalog application.

## Features

- **User Authentication**: Secure Login & Sign Up.
- **Home Feed**: Book carousels, categories, and recommendation sections.
- **Search**: Dynamic book search and filtering.
- **Library Page**: Keep track of your reading progress.
- **EPUB Reader**: Built-in EPUB reader for an immersive reading experience.
- **Profile Management**: Customize user profiles, track reading goals, and manage app preferences.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Routing**: `go_router`
- **Networking**: `dio`
- **State Management & Storage**: `shared_preferences`, `flutter_secure_storage`
- **UI Elements**: `carousel_slider`, `skeletonizer`, `smooth_page_indicator`, `font_awesome_flutter`
- **EPUB Engine**: `flutter_epub_viewer`

## Getting Started

### Prerequisites

- Flutter SDK (version `^3.12.2`)
- Android Studio / VS Code with Flutter extension
- Xcode (for iOS development)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/book_nest.git
   cd book_nest
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the application:
   ```bash
   flutter run
   ```
