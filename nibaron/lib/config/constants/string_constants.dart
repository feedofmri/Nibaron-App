import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StringConstants {
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  // App Information
  static const String appName = 'Nibaron';
  static const String appNameBengali = 'নিবারণ';
  static const String appTaglineEnglish = 'Forecast. Prevent. Protect.';
  static const String appTaglineBengali = 'পূর্বাভাস। প্রতিরোধ। সুরক্ষা।';

  // Loading Text
  static const String loading = 'Loading...';
  static const String loadingBengali = 'লোড হচ্ছে...';

  // Legacy static getters for backwards compatibility - these will be deprecated
  static const String appDescription = 'বাংলাদেশি কৃষকদের জন্য স্মার্ট কৃষি সহায়ক';

  // Common Actions
  static const String ok = 'ঠিক আছে';
  static const String cancel = 'বাতিল';
  static const String save = 'সংরক্ষণ করুন';
  static const String edit = 'সম্পাদনা';
  static const String delete = 'মুছে ফেলুন';
  static const String share = 'শেয়ার করুন';
  static const String retry = 'আবার চেষ্টা করুন';
  static const String refresh = 'রিফ্রেশ';
  static const String next = 'এগিয়ে যান';
  static const String previous = 'পূর্ববর্তী';
  static const String done = 'সম্পন্ন';
  static const String skip = 'এড়িয়ে যান';

  // Authentication & Onboarding
  static const String welcome = 'স্বাগতম';
  static const String getStarted = 'শুরু করুন';
  static const String phoneNumber = 'মোবাইল নম্বর';
  static const String enterPhoneNumber = 'আপনার মোবাইল নম্বর দিন';
  static const String otpVerification = 'OTP যাচাইকরণ';
  static const String enterOtp = 'OTP কোড লিখুন';
  static const String resendOtp = 'OTP পুনরায় পাঠান';
  static const String verify = 'যাচাই করুন';
  static const String farmSetup = 'খামার তথ্য';
  static const String setupYourFarm = 'আপনার খামারের তথ্য দিন';

  // Onboarding Slides
  static const String onboarding1Title = 'আবহাওয়ার পূর্বাভাস পান';
  static const String onboarding1Description = 'সঠিক আবহাওয়ার তথ্য এবং বিপদের সতর্কতা পেয়ে আপনার ফসল রক্ষা করুন';
  static const String onboarding2Title = 'কৃষি পরামর্শ নিন';
  static const String onboarding2Description = 'বিশেষজ্ঞদের পরামর্শ অনুসরণ করে আপনার ফসলের যত্ন নিন';
  static const String onboarding3Title = 'সরাসরি সহায়তা পান';
  static const String onboarding3Description = 'জরুরি অবস্থায় সরকারি কৃষি হটলাইনে যোগাযোগ করুন';
  static const String listen = 'শুনুন';

  // Home Screen
  static const String goodMorning = 'সুপ্রভাত';
  static const String goodAfternoon = 'শুভ অপরাহ্ন';
  static const String goodEvening = 'শুভ সন্ধ্যা';
  static const String goodNight = 'শুভ রাত্রি';
  static const String todaysRecommendation = 'আজের পরামর্শ';
  static const String quickActions = 'দ্রুত কার্যক্রম';
  static const String calendar = 'ক্যালেন্ডার';
  static const String recommendations = 'সুপারিশ';

  // Farming Calendar - Updated to use new property name
  static const String farmingCalendar = 'কৃষি ক্যালেন্ডার';

  // Weather
  static const String weather = 'আবহাওয়া';
  static const String weatherForecast = 'আবহাওয়ার পূর্বাভাস';
  static const String currentWeather = 'বর্তমান আবহাওয়া';
  static const String humidity = 'আর্দ্রতা';
  static const String windSpeed = 'বাতাসের গতি';
  static const String pressure = 'চাপ';
  static const String visibility = 'দৃশ্যমানতা';
  static const String uvIndex = 'UV সূচক';
  static const String sunrise = 'সূর্যোদয়';
  static const String sunset = 'সূর্যাস্ত';
  static const String feelLike = 'অনুভূত হচ্ছে';

  // Date & Time
  static const String today = 'আজ';
  static const String tomorrow = 'আগামীকাল';
  static const String thisWeek = 'এই সপ্তাহ';

  // Alerts
  static const String alerts = 'সতর্কতা';
  static const String weatherAlert = 'আবহাওয়া সতর্কতা';
  static const String noAlertsTitle = 'কোন সক্রিয় সতর্কতা নেই';
  static const String noAlertsDescription = 'এই মুহূর্তে আপনার এলাকার জন্য কোন আবহাওয়া সতর্কতা নেই';

  // Settings
  static const String settings = 'সেটিংস';
  static const String profile = 'প্রোফাইল';
  static const String language = 'ভাষা';
  static const String theme = 'থিম';
  static const String notifications = 'বিজ্ঞপ্তি';
  static const String about = 'সম্পর্কে';
  static const String privacy = 'গোপনীয়তা নীতি';
  static const String terms = 'সেবার শর্তাবলি';
  static const String logout = 'লগআউট';

  // Theme options
  static const String darkMode = 'ডার্ক মোড';
  static const String lightMode = 'লাইট মোড';
  static const String systemMode = 'সিস্টেম মোড';

  // Language options
  static const String bengali = 'বাংলা';
  static const String english = 'English';

  // About
  static const String version = 'সংস্করণ';

  // Dialog titles
  static const String selectLanguage = 'ভাষা নির্বাচন করুন';
  static const String selectTheme = 'থিম নির্বাচন করুন';

  // Notification settings
  static const String pushNotifications = 'পুশ বিজ্ঞপ্তি';
  static const String weatherAlerts = 'আবহাওয়া সতর্কতা';
  static const String farmingReminders = 'কৃষি রিমাইন্ডার';
  static const String soundEnabled = 'সাউন্ড চালু';
  static const String vibrationEnabled = 'ভাইব্রেশন চালু';

  // Support & Feedback
  static const String contactSupport = 'সাপোর্টে যোগাযোগ';
  static const String rateApp = 'অ্যাপ রেট করুন';
  static const String shareApp = 'অ্যাপ শেয়ার করুন';
  static const String feedback = 'মতামত';
  static const String reportBug = 'বাগ রিপোর্ট';
  static const String helpCenter = 'সাহায্য কেন্দ্র';
  static const String faq = 'প্রশ্নোত্তর';

  // Crop management
  static const String crops = 'ফসল';
  static const String addCrop = 'ফসল যোগ করুন';
  static const String cropName = 'ফসলের নাম';
  static const String plantingDate = 'রোপণের তারিখ';
  static const String harvestDate = 'ফসল কাটার তারিখ';
  static const String cropVariety = 'ফসলের জাত';
  static const String fieldSize = 'ক্ষেতের আকার';
  static const String expectedYield = 'প্রত্যাশিত ফলন';

  // Tasks & Activities
  static const String tasks = 'কাজ';
  static const String addTask = 'কাজ যোগ করুন';
  static const String taskTitle = 'কাজের শিরোনাম';
  static const String taskDescription = 'কাজের বিবরণ';
  static const String dueDate = 'শেষ তারিখ';
  static const String priority = 'অগ্রাধিকার';
  static const String status = 'অবস্থা';
  static const String completed = 'সম্পন্ন';
  static const String pending = 'বাকি';
  static const String overdue = 'সময়সীমা অতিক্রম';

  // Priority levels
  static const String high = 'উচ্চ';
  static const String medium = 'মাঝারি';
  static const String low = 'নিম্ন';

  // Market & Prices
  static const String market = 'বাজার';
  static const String prices = 'দাম';
  static const String marketPrices = 'বাজার দর';
  static const String pricePerKg = 'প্রতি কেজি দাম';
  static const String pricePerMaund = 'প্রতি মণ দাম';

  // Units
  static const String kg = 'কেজি';
  static const String maund = 'মণ';
  static const String acre = 'একর';
  static const String bigha = 'বিঘা';
  static const String katha = 'কাঠা';

  // Location
  static const String location = 'অবস্থান';
  static const String district = 'জেলা';
  static const String upazila = 'উপজেলা';
  static const String union = 'ইউনিয়ন';
  static const String village = 'গ্রাম';

  // Farm details
  static const String farmName = 'খামারের নাম';
  static const String farmSize = 'খামারের আকার';
  static const String farmType = 'খামারের ধরন';
  static const String organicFarm = 'জৈব খামার';
  static const String conventionalFarm = 'প্রচলিত খামার';

  // Emergency
  static const String emergency = 'জরুরি';
  static const String emergencyContacts = 'জরুরি যোগাযোগ';
  static const String hotline = 'হটলাইন';
  static const String call = 'কল করুন';

  // Error messages
  static const String error = 'ত্রুটি';
  static const String networkError = 'নেটওয়ার্ক ত্রুটি';
  static const String connectionFailed = 'সংযোগ ব্যর্থ';
  static const String dataNotFound = 'তথ্য পাওয়া যায়নি';
  static const String permissionDenied = 'অনুমতি প্রত্যাখ্যাত';
  static const String locationPermissionRequired = 'অবস্থানের অনুমতি প্রয়োজন';

  // Success messages
  static const String success = 'সফল';
  static const String saved = 'সংরক্ষিত';
  static const String updated = 'আপডেট করা হয়েছে';
  static const String deleted = 'মুছে ফেলা হয়েছে';
  static const String added = 'যোগ করা হয়েছে';

  // Confirmation
  static const String confirmation = 'নিশ্চিতকরণ';
  static const String areYouSure = 'আপনি কি নিশ্চিত?';
  static const String cannotBeUndone = 'এটি পূর্বাবস্থায় ফেরানো যাবে না';
  static const String yes = 'হ্যাঁ';
  static const String no = 'না';
}
