
# Social Garbage – Frontend

This is the frontend of **Social Garbage**, a Flutter-based social platform that integrates real-time backend APIs, Google Sign-In authentication, content creation, notifications, and moderation features.  

---

## 📖 Table of Contents
- [Project Overview](#project-overview)
- [Features](#features)
- [Setup Instructions](#setup-instructions)
- [Folder Structure](#folder-structure)
- [Contributions](#contributions)
- [Screenshots](#screenshots)

---

## Project Overview
Social Garbage is designed as a modern social platform with integrated content safety checks. The frontend is built using **Flutter**, with seamless API integration for posts, user profiles, authentication, notifications, and search functionality.  

---

## Features
- Google Sign-In authentication with Supabase integration  
- Create, like, dislike, and comment on posts  
- Search posts with filters (Safe / Under Review / Flagged)  
- Notifications with swipe-to-dismiss support  
- Bottom navigation bar and state preservation  
- API integration with backend services for real-time data  

---

## Setup Instructions

### 1. Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed  
- Android Studio / VS Code with Flutter extensions  
- Backend server running (update the `baseUrl` in `lib/api_client.dart`)  

### 2. Clone the Repository
```bash
git clone https://github.com/shivam-purve/social_garbage.git
cd social_garbage

###3.) Install Dependencies
flutter pub get

###4.) Configure Base URL

In lib/api_client.dart, update the kBaseUrl constant with your backend API URL:

const String kBaseUrl = 'http://10.0.2.2:8000'; // Android Emulator
// or
const String kBaseUrl = '(https://hive-backend-tnmw.onrender.com)'; // Localhost (desktop/web)

5.) Run the App
  flutter run

Folder Structure

Folder Structure
 lib/
├──
│   └── api_client.dart        # Base API client
├── services/
│   ├── auth_service.dart          # Authentication API integration
│   ├── post_service.dart          # Posts API (fetch, like, comment, create)
│   ├── search_service.dart        # Search API integration
│   ├── user_service.dart          # User profile API
│   └── notification_service.dart  # Local notifications
├── widgets/
│   ├── post_card.dart             # Post UI component
│   └── notification_widget.dart   # Notification UI component
├── screens/
│   ├── home_screen.dart           # Home feed
│   ├── user.dart                  # User profile screen
│   ├── notifs.dart                # Notifications screen
│   ├── search.dart                # Search screen
│   ├── create.dart                # Create post screen
│   └── login.dart                 # Google Sign-In
└── main.dart                      # App entry point

Contributions
Shivam Purve


Developed UI Screens:
Home Screen
Comment Screen
Create Screen
Search Screen
Post Card Widget
API Integration:
Posts (fetch, like, dislike, comment)
Search functionality with filters
Create post with content analysis support


Mritunjay Tiwari

Added Bottom Navigation Bar and App Bar with design and logic

Implemented API integration for authentication (Google Sign-In with Supabase)

Integrated User Profile screen API

Added Notifications screen with local notification support

Implemented route management for multiple screens using go_router

Added state persistence for Bottom Navigation Bar

Fixed several routing and connection bugs


##  Screenshots of different pages:-

social_garbage/
├── lib/
├── screenshots/
│   ├── login.png
│   ├── home.png
│   ├── create.png
│   ├── search.png
│   └── notifs.png


## Screenshots

### Home Screen
![Home Screen](screenshots/home_screen.png)

### Login with Google
![Login Screen](screenshots/login_screen.png)

### Create Post
![Create Post](screenshots/create_post.png)

### Notifications
![Notifications](screenshots/notifications.png)

### Search
![Search](screenshots/search.png)



## Tech Stack

Clearly listing  the technologies and tools used. Example:

Tech Stack used 
- **Framework:** Flutter (Dart)  
- **State Management:** Flutter's Stateful Widgets  
- **Routing:** go_router  
- **Backend Integration:** REST APIs  
- **Authentication:** Supabase (Google Sign-In)  
- **Local Storage:** SharedPreferences  
- **Notifications:** flutter_local_notifications  
- **HTTP Client:** http package

## API Endpoints Used

Document the endpoints you integrated with. Example:

## API Endpoints
- **Auth**
  - `POST /auth/google` → Sign in with Google
- **Posts**
  - `GET /posts` → Fetch all posts
  - `POST /posts` → Create a new post
  - `POST /posts/:id/like` → Like a post
  - `POST /posts/:id/dislike` → Dislike a post
  - `POST /posts/:id/comments` → Add comment
- **User**
  - `GET /user/me` → Fetch current user profile
  - `GET /user/:id/posts` → Fetch posts by user
- **Search**
  - `GET /posts?q=term&status=flagged` → Search posts with filters




## Known Issues

Be transparent about current bugs or limitations. Example:

  Known Issues
- API sometimes returns `401 Unauthorized` if access token expires.  
- Search filtering is partially handled on client-side due to backend limitations.

 ## Support the Project

## Support

If you find this project useful, please consider giving it a on GitHub.  
Your feedback and contributions are always welcome!


## Acknowledgments

We would like to thank:  
- [Flutter](https://flutter.dev) for the cross-platform framework  
- [Supabase](https://supabase.com) for authentication and backend support  
- [Google Cloud](https://cloud.google.com) for OAuth and API integrations  

This project was developed as part of a collaborative effort to explore real-time content safety and moderation in social platforms.


























