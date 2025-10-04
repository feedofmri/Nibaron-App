<div align="center">

<img src="nibaron/assets/images/nibaron_icon.png" alt="Nibaron Logo" width="200"/>

# Nibaron - ClimateAI for Farmers
  ### Predict. Prevent. Protect.
  
  *Smart Climate Intelligence Platform for Bangladeshi Farmers*
  
  [![Flutter](https://img.shields.io/badge/Flutter-3.24.0+-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-3.7.2+-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
  [![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=flat&logo=firebase&logoColor=black)](https://firebase.google.com)
  [![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
</div>

---

## 🎬 Platform Showcase

<div align="center">

[![Nibaron Platform Demo](https://img.youtube.com/vi/VCbtS7w1erg/maxresdefault.jpg)](https://youtu.be/VCbtS7w1erg)

*Watch our platform in action - See how Nibaron empowers farmers with AI-driven climate insights*

</div>

<div align="center">

**[Website Demo](https://youtu.be/5-okao60db4)**

</div>

## 🌾 About Nibaron

**Nibaron** is an innovative ClimateAI platform designed specifically for farmers in Bangladesh and beyond. Unlike traditional weather apps that only show forecasts, Nibaron connects climate hazards directly to crop-specific actionable recommendations, helping farmers make informed decisions to protect their yields and livelihoods.

### 🎯 Problem Statement

Farmers face severe yield losses from:
- **Heatwaves** causing crop stress
- **Unpredictable floods** destroying harvests  
- **Irregular rainfall** disrupting growth cycles
- **Lack of actionable advice** from generic weather forecasts

Current solutions only show weather data but don't translate it into crop-specific, actionable farming decisions.

### 💡 Our Solution

Nibaron provides:
- **Climate-to-Crop Intelligence**: Links weather hazards to specific crop growth stages
- **Actionable Recommendations**: Precise irrigation amounts, fertilizer timing, protective measures
- **Bangla Voice Accessibility**: Text-to-speech for farmers with limited literacy
- **Offline Support**: Works without internet for critical decisions
- **End-to-End Ecosystem**: From farm management to marketplace integration

---

## 🏗️ Project Architecture

### Two-App Ecosystem

1. **Nibaron Mobile App** (Flutter) - *This Repository*
   - Target: Farmers & Producers
   - Features: Weather alerts, crop recommendations, farming calendar, voice assistance

2. **Nibaron Bazaar** (React + Laravel) - *Separate Repository*
   - Target: Buyers, Wholesalers, Exporters
   - Features: Marketplace, pre-orders, crop quality predictions, B2B community

### Data Flow
```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Farmer App    │───▶│  Shared Backend  │◀───│   Bazaar Web    │
│   (Flutter)     │    │   (Laravel API)  │    │  (React+Laravel)│
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
   Weather Data              Crop Data               Market Data
   Recommendations           Predictions             Pre-orders
   Action Logging            Quality Metrics         B2B Deals
```

---

## ✨ Key Features

### 🌤️ Weather & Climate Intelligence
- **Real-time Weather Forecasts** with simple, farmer-friendly icons
- **Hazard Alerts**: Heatwave, heavy rain, flood, pollution warnings
- **7-Day Extended Forecasts** for planning ahead
- **Emergency Voice Alerts** for urgent weather events

### 🌱 Crop-Specific Recommendations
- **Growth Stage Awareness**: Recommendations based on crop lifecycle
- **Precision Agriculture**: Exact irrigation amounts (mm), fertilizer timing
- **Protective Measures**: Actionable steps to prevent crop damage
- **Multi-Crop Support**: Rice, wheat, potato, mango, and more

### 🗣️ Bangla Voice Assistant
- **Text-to-Speech**: All recommendations available in Bangla voice
- **Accessibility First**: Designed for farmers with limited literacy
- **Offline Voice**: Last saved recommendations playable without internet
- **Emergency Alerts**: Auto-play loud voice for urgent situations

### 📅 Smart Farming Calendar
- **Automated Scheduling**: Tasks auto-populated based on crop type and planting date
- **Dynamic Adjustments**: Calendar updates when weather changes plans
- **Task Management**: Irrigation, fertilization, spraying, harvest reminders
- **Progress Tracking**: Visual timeline with completed/pending tasks

### 📊 Action Logging & Learning
- **Farmer Feedback Loop**: Mark actions as successful/unsuccessful
- **AI Improvement**: System learns from farmer experiences
- **Historical Data**: Track farming decisions and outcomes
- **Personalized Advice**: Recommendations improve over time

### 🔗 Government Integration
- **Direct Hotline Access**: One-tap connection to agricultural support
- **Profile Sharing**: Auto-forward farmer details to support agents
- **Extension Services**: Link to local agricultural extension officers
- **Emergency Support**: Quick access during crisis situations

### 📱 Offline Capabilities
- **Smart Caching**: Last forecast and recommendations saved locally
- **Voice Playback**: Critical advice accessible without internet
- **Auto-Sync**: Updates when connection returns
- **Battery Optimization**: Efficient offline mode

---

## 📱 App Screens & User Journey

### 🚀 Onboarding & Registration
- **Welcome Screen**: App introduction with Bangla voice
- **Phone Registration**: OTP-based secure signup
- **Language Selection**: Bangla (default) or English
- **Farm Profile Setup**: Crop type, planting date, land size, soil type, GPS location

### 🏠 Home Dashboard
- **Today's Weather**: Clear icons (☀️🌧️🔥💨) with temperature
- **Hazard Alerts**: Red/yellow banners for immediate attention
- **Daily Recommendation**: Large card with text + voice button
- **Quick Actions**: ✅ Done, 📅 Calendar, 📞 Support

### 🌦️ Weather & Alerts
- **7-Day Forecast**: Visual timeline with weather patterns
- **Detailed Hazards**: Specific impacts on crops with voice guidance
- **Alert History**: Past warnings and farmer actions
- **Weather Maps**: Visual representation of regional conditions

### 📋 Recommendations Engine
- **Crop-Wise Tasks**: Irrigation schedule with precise amounts
- **Fertilizer Calendar**: Optimal timing based on weather and growth stage
- **Pest & Disease Warnings**: Preventive measures with treatment options
- **Voice Instructions**: Every recommendation available in Bangla audio

### 📅 Farming Calendar
- **Timeline View**: Weekly/monthly task visualization
- **Auto-Scheduling**: Tasks populated based on crop cycle
- **Weather Integration**: Calendar adjusts when hazards delay activities
- **Task Details**: Each activity explained with voice instructions

### 📝 Action Logging
- **Completed Tasks**: History of farmer actions with dates
- **Success Feedback**: Rate outcomes to improve future advice
- **Notes Section**: Farmers can add personal observations
- **Learning Loop**: System adapts based on logged experiences

### 🆘 Support & Hotline
- **Government Hotline**: Direct dial to agricultural support
- **Profile Sharing**: Auto-send farmer details to support agents
- **FAQ Section**: Common questions with voice answers
- **Emergency Contacts**: Quick access to crisis support

### ⚙️ Profile & Settings
- **Farm Management**: Edit crop details, land size, soil type
- **Language Toggle**: Switch between Bangla and English
- **Notification Preferences**: Customize alert frequency and types
- **Account Security**: Phone number update, logout options

---

## 🛠️ Technical Architecture

### Frontend (Flutter)
```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Root app configuration
├── core/                     # Core utilities and services
│   ├── dependency_injection/
│   ├── constants/
│   ├── utils/
│   └── services/
├── data/                     # Data layer
│   ├── models/
│   ├── repositories/
│   └── services/
├── presentation/             # UI layer
│   ├── screens/
│   ├── widgets/
│   └── providers/
├── config/                   # App configuration
│   ├── routes/
│   ├── themes/
│   └── localization/
└── assets/                   # Static assets
    ├── animations/
    ├── fonts/
    ├── icons/
    └── images/
```

### State Management
- **Riverpod**: Modern, compile-safe state management
- **Provider Pattern**: Reactive programming with providers
- **Local State**: Hive for offline data persistence

### Key Dependencies
```yaml
# State Management
flutter_riverpod: ^2.4.10
provider: ^6.1.2

# Networking
dio: ^5.4.1
retrofit: ^4.1.0

# Local Storage
hive_flutter: ^1.1.0
shared_preferences: ^2.2.2

# Location Services
geolocator: ^10.1.0
google_maps_flutter: ^2.5.3

# Voice & Audio
flutter_tts: ^3.8.5
speech_to_text: ^7.0.0

# Firebase Services
firebase_core: ^2.24.2
firebase_messaging: ^14.7.10
firebase_analytics: ^10.8.0

# UI Components
lottie: ^2.7.0
rive: ^0.12.4
cached_network_image: ^3.3.1
```

### Backend Integration
- **API**: RESTful services with Laravel backend
- **Real-time**: Firebase for push notifications
- **Authentication**: Phone OTP with Firebase Auth
- **Analytics**: Firebase Analytics for user insights
- **Crash Reporting**: Firebase Crashlytics for stability

---

## 🚀 Getting Started

### Prerequisites
- **Flutter SDK**: 3.24.0 or higher
- **Dart SDK**: 3.7.2 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Android SDK**: API level 21+ (Android 5.0+)
- **iOS**: iOS 12.0+ (for iOS development)

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-org/nibaron-app.git
   cd nibaron-app/nibaron
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com)
   - Add Android/iOS apps to your Firebase project
   - Download `google-services.json` (Android) and place in `android/app/`
   - Download `GoogleService-Info.plist` (iOS) and place in `ios/Runner/`

4. **Environment Setup**
   - Copy `.env.example` to `.env`
   - Configure API endpoints and Firebase keys
   ```env
   API_BASE_URL=https://your-api-domain.com
   FIREBASE_PROJECT_ID=your-firebase-project
   GOOGLE_MAPS_API_KEY=your-google-maps-key
   ```

5. **Code Generation**
   ```bash
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

6. **Run the App**
   ```bash
   # Debug mode
   flutter run

   # Release mode
   flutter run --release
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**Android App Bundle:**
```bash
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 📁 Project Structure

```
nibaron/
├── android/                  # Android platform files
├── ios/                      # iOS platform files  
├── lib/                      # Flutter source code
│   ├── main.dart            # App entry point
│   ├── app.dart             # Root app widget
│   ├── core/                # Core utilities
│   │   ├── constants/       # App constants
│   │   ├── utils/           # Helper utilities
│   │   ├── services/        # Core services
│   │   └── dependency_injection/ # Service locator
│   ├── data/                # Data layer
│   │   ├── models/          # Data models
│   │   ├── repositories/    # Data repositories
│   │   ├── services/        # API services
│   │   └── local/           # Local storage
│   ├── presentation/        # UI layer
│   │   ├── screens/         # App screens
│   │   │   ├── onboarding/
│   │   │   ├── home/
│   │   │   ├── weather/
│   │   │   ├── recommendations/
│   │   │   ├── calendar/
│   │   │   ├── profile/
│   │   │   └── support/
│   │   ├── widgets/         # Reusable widgets
│   │   └── providers/       # State providers
│   ├── config/              # App configuration
│   │   ├── routes/          # Navigation routes
│   │   ├── themes/          # App themes
│   │   └── localization/    # i18n support
│   └── l10n/                # Localization files
├── assets/                  # Static assets
│   ├── images/              # Image assets
│   │   ├── logo/           # App logos
│   │   ├── onboarding/     # Onboarding images
│   │   ├── illustrations/  # UI illustrations
│   │   └── placeholders/   # Placeholder images
│   ├── icons/              # Icon assets
│   │   ├── weather/        # Weather icons
│   │   ├── tasks/          # Task icons
│   │   └── crops/          # Crop icons
│   ├── animations/         # Animation files
│   │   ├── lottie/         # Lottie animations
│   │   └── rive/           # Rive animations
│   └── fonts/              # Custom fonts
│       ├── Inter/          # Inter font family
│       └── NotoSansBengali/ # Bengali font support
├── test/                   # Unit & widget tests
├── pubspec.yaml           # Dependencies configuration
├── analysis_options.yaml # Dart analysis options
└── README.md              # This file
```

---

## 🌐 Localization

Nibaron supports multiple languages with a focus on Bangla accessibility:

### Supported Languages
- **বাংলা (Bangla)** - Primary language
- **English** - Secondary language

### Adding New Languages
1. Create new ARB files in `lib/l10n/`
2. Add translations for all keys
3. Update `l10n.yaml` configuration
4. Run `flutter gen-l10n` to generate localization classes

### Voice Support
- **Bangla TTS**: Native text-to-speech for all recommendations
- **Offline Voice**: Critical instructions cached for offline playback
- **Voice Settings**: Customizable speed and pronunciation

---

## 🧪 Testing

### Running Tests
```bash
# Unit tests
flutter test

# Integration tests
flutter test integration_test/

# Test coverage
flutter test --coverage
```

### Test Structure
```
test/
├── unit/                   # Unit tests
│   ├── models/
│   ├── services/
│   └── repositories/
├── widget/                 # Widget tests
│   ├── screens/
│   └── widgets/
└── integration/            # Integration tests
    ├── user_flows/
    └── api_integration/
```

---

## 🔧 Configuration

### Environment Variables
```env
# API Configuration
API_BASE_URL=https://api.nibaron.com
API_VERSION=v1
API_TIMEOUT=30000

# Firebase Configuration
FIREBASE_PROJECT_ID=nibaron-production
FIREBASE_APP_ID=your-app-id

# Google Services
GOOGLE_MAPS_API_KEY=your-maps-key
GOOGLE_PLACES_API_KEY=your-places-key

# Feature Flags
ENABLE_VOICE_ASSISTANT=true
ENABLE_OFFLINE_MODE=true
ENABLE_ANALYTICS=true
```

### Build Configurations
- **Debug**: Development with hot reload
- **Profile**: Performance profiling mode  
- **Release**: Production optimized build

---

## 📊 Analytics & Monitoring

### Firebase Analytics Events
- **User Registration**: Track farmer onboarding
- **Weather Alerts**: Monitor alert effectiveness
- **Recommendation Usage**: Track advice adoption
- **Voice Interactions**: Monitor accessibility usage
- **Action Logging**: Measure farmer engagement

### Performance Monitoring
- **Crash Reporting**: Firebase Crashlytics
- **Performance Metrics**: App startup, screen load times
- **Network Monitoring**: API response times
- **Battery Usage**: Optimize for long-term usage

---

## 🔐 Security & Privacy

### Data Protection
- **Local Encryption**: Sensitive data encrypted with Hive
- **API Security**: HTTPS with certificate pinning
- **Authentication**: Secure OTP-based phone verification
- **Privacy First**: Minimal data collection, user consent required

### Permissions
- **Location**: For weather and crop recommendations
- **Phone**: For OTP verification
- **Storage**: For offline functionality
- **Microphone**: For voice input (optional)
- **Camera**: For crop photo logging (optional)

---

## 🤝 Contributing

We welcome contributions from the community! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Workflow
1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code Standards
- Follow [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Write comprehensive tests for new features
- Update documentation for API changes
- Use meaningful commit messages

---


## 🙏 Acknowledgments

- **Farmers of Bangladesh** - For inspiring this solution
- **Bangladesh Agricultural Research Institute** - Technical guidance
- **Flutter Community** - Open source contributions
- **Firebase Team** - Backend infrastructure support
- **OpenWeather API** - Weather data services

---

## 🗓️ Roadmap

### Version 2.0 (Q1 2026)
- [ ] AI-powered crop disease detection
- [ ] Drone integration for field monitoring
- [ ] Blockchain-based supply chain tracking
- [ ] Multi-country expansion (India, Pakistan)

### Version 1.5 (Q4 2025)
- [ ] Enhanced offline capabilities
- [ ] Weather station integration
- [ ] Advanced analytics dashboard
- [ ] Cooperative farming features

### Version 1.0 (Current)
- [x] Core weather and recommendations
- [x] Bangla voice assistant
- [x] Farming calendar
- [x] Government hotline integration
- [x] Offline support

---

<div align="center">
  <p><strong>Made with ❤️ for the farmers of Bangladesh</strong></p>
  <p>© 2025 Nibaron. All rights reserved.</p>
</div>
