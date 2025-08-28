# 📰 News App

A modern Flutter news application that provides real-time news from various categories and sources
using the NewsAPI. The app features a clean Material Design 3 interface with dark/light theme
support and seamless navigation.

## 📱 Screenshots

![Alt text](https://github.com/ammareldesouki/news_app/blob/d19a1b794ba7eaa68f56ad305293407e8f3f8309/ui.png)

---

## ✨ Features

### 🏠 Home Screen

- **Category Selection**: Static categories displayed as interactive cards
- **Dynamic Content**: When a category is selected, the app fetches news sources for that category
- **Search Functionality**: Built-in search bar for finding specific news content
- **Responsive Design**: Adaptive layout that works on different screen sizes

### 📊 News Categories

The app includes the following news categories:

- **General** - Top headlines and general news
- **Business** - Business and financial news
- **Entertainment** - Entertainment and celebrity news
- **Technology** - Tech industry and innovation news
- **Health** - Health and medical news
- **Science** - Scientific discoveries and research
- **Sports** - Sports news and updates

### 🔄 Dynamic Source Management

- **API Integration**: Fetches news sources from NewsAPI based on selected category
- **Tab Controller**: Each source gets its own tab for easy navigation
- **Real-time Updates**: Sources are loaded dynamically when categories are selected

### 📰 Article Management

- **Article Fetching**: Retrieves articles from selected news sources via API
- **Rich Content**: Articles include images, titles, descriptions, authors, and publication dates
- **Article Cards**: Beautiful card-based layout for article display
- **Summary View**: Click on article cards to see detailed summaries

### 🌐 WebView Integration

- **In-App Browsing**: Full article reading experience within the app
- **Seamless Navigation**: Smooth transition from summary to full article
- **URL Launcher**: Uses Flutter's url_launcher package for web content

### 🎨 Theme System

- **Light Theme**: Clean, bright interface for daytime use
- **Dark Theme**: Easy-on-the-eyes dark mode for night reading
- **Theme Toggle**: Easy switching between light and dark themes
- **Material Design 3**: Modern UI components and animations

### 🔍 Search & Navigation

- **Global Search**: Search across all news content
- **Side Navigation**: Drawer menu for easy app navigation
- **Breadcrumb Navigation**: Clear indication of current location in the app

## 🏗️ Architecture

### **Clean Architecture Pattern**

The app follows Flutter best practices with a well-organized structure:

```
lib/
├── core/                    # Core functionality
│   ├── constants/          # App constants and image strings
│   ├── models/             # Data models
│   ├── network/            # API integration
│   ├── services/           # App services and providers
│   ├── theme/              # UI themes and styling
│   └── route/              # Navigation and routing
├── features/               # Feature-based modules
│   ├── cubit/             # State management (BLoC pattern)
│   ├── home/              # Home screen feature
│   └── splash/            # Splash screen feature
└── main.dart              # App entry point
```

### **State Management**

- **Flutter BLoC**: Uses BLoC pattern for state management
- **Provider**: Dependency injection and app-wide state
- **Cubit**: Simplified state management for home screen

### **API Integration**

- **NewsAPI**: Primary news data source
- **HTTP Package**: Network requests and data fetching
- **JSON Parsing**: Efficient data model conversion

## 🛠️ Technical Stack

### **Core Dependencies**

- **Flutter**: ^3.8.1 - Cross-platform UI framework
- **flutter_bloc**: ^9.1.1 - State management
- **provider**: ^6.1.5 - Dependency injection
- **http**: ^1.5.0 - HTTP client for API calls
- **cached_network_image**: ^3.4.1 - Image caching and loading
- **url_launcher**: ^6.3.2 - Web content launching
- **shared_preferences**: ^2.5.3 - Local data persistence
- **animated_custom_dropdown**: ^3.1.1 - Custom dropdown components

### **Development Dependencies**

- **flutter_test**: Flutter testing framework
- **flutter_lints**: ^5.0.0 - Code quality and linting

## 🚀 Getting Started

### **Prerequisites**

- Flutter SDK ^3.8.1
- Dart SDK
- Android Studio / VS Code
- Android SDK / Xcode (for mobile development)

### **Installation**

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/news_app.git
   cd news_app
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### **API Configuration**

The app uses NewsAPI for fetching news data. Update the API key in:

```
lib/core/network/api_constants.dart
```

## 📱 App Flow

1. **Splash Screen** → App initialization and theme loading
2. **Home Screen** → Display news categories
3. **Category Selection** → User selects a news category
4. **Source Loading** → Fetch news sources for selected category
5. **Tab Navigation** → Display sources as tabs
6. **Article Loading** → Fetch articles from selected source
7. **Article Display** → Show articles in card format
8. **Article Detail** → Click to view article summary
9. **WebView** → Full article reading experience

## 🎯 Key Components

### **Models**

- `CategoryModel`: News category data structure
- `ArticleModel`: Article data structure
- `SourcesDataModel`: News source data structure

### **Services**

- `AppSettingProvider`: Theme and app settings management
- `ApiRequests`: Network request handling
- `LocalStorageServices`: Local data persistence

### **Widgets**

- `CategoryCard`: Interactive category selection cards
- `ArticleCard`: Article display cards
- `ArticleList`: Scrollable article list
- `SideBar`: Navigation drawer

## 🔧 Configuration

### **Theme Customization**

Themes can be customized in:

```
lib/core/theme/theme.dart
lib/core/theme/widget_themes/
```

### **API Endpoints**

API endpoints are defined in:

```
lib/core/network/end_point.dart
```

### **Image Assets**

All app images are stored in:

```
assets/images/
assets/icons/
```

## 📊 Data Flow

1. **User Interaction** → Category selection
2. **API Request** → Fetch sources for category
3. **Source Loading** → Display sources as tabs
4. **Tab Selection** → User selects a source
5. **Article Fetching** → Get articles from selected source
6. **Data Display** → Render articles in UI
7. **User Selection** → Article card interaction
8. **WebView Launch** → Full article display

## 🎨 UI/UX Features

- **Material Design 3**: Modern, accessible interface
- **Responsive Layout**: Adapts to different screen sizes
- **Smooth Animations**: Fluid transitions and interactions
- **Accessibility**: Screen reader support and proper contrast
- **Cross-platform**: Consistent experience on iOS and Android

## 🔒 Security Features

- **API Key Management**: Secure API key storage
- **HTTPS Only**: All network requests use secure protocols
- **Input Validation**: Proper data validation and sanitization

## 🧪 Testing

The app includes comprehensive testing:

- **Unit Tests**: Core functionality testing
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end functionality testing

## 📈 Performance Optimizations

- **Image Caching**: Efficient image loading and caching
- **Lazy Loading**: Articles loaded on demand
- **Memory Management**: Proper resource cleanup
- **Network Optimization**: Efficient API calls and data handling

## 🌟 Future Enhancements

- **Offline Support**: Cached news for offline reading
- **Push Notifications**: Breaking news alerts
- **Personalization**: User preferences and favorite categories
- **Social Sharing**: Share articles on social media
- **Bookmarks**: Save favorite articles for later reading

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:

- Create an issue in the repository
- Contact the development team
- Check the documentation

---

**Built with ❤️ using Flutter and NewsAPI**
