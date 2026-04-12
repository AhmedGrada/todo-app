class AppKeys {
  AppKeys._();

  // Env keys
  static const String baseUrl = 'BASE_URL';
  static const String papsUrl = 'PAPS_BASE_URL';
  static const String stgUrl = 'STG_BASE_URL';
  static const String testUrl = 'TEST_BASE_URL';

  // App keys
  static const String prodEnv = '.env.prod';
  static const String testEnv = '.env.test';
  static const String stgEnv = '.env.stg';
  static const String language = 'language';
  static const String themeMode = 'theme_mode';
  static const String isFirstTime = 'is_first_time';
  static const String credentials = 'credentials';
  static const String loginPrefill = 'login_prefill';
  static const String supsCartKey = 'cart_items';
  static const String anisCartKey = 'anis_cards_items';

  //Journey Status Keys
  static const String onGoing = 'رحلة جارية';
  static const String completed = 'مكتملة';
  static const String preparing = 'تحت التجهيز';

  //Package Status Keys
  static const String onGoingPkg = 'قيد الشحن';
  static const String completedPkg = 'مكتملة';
  static const String pendingPkg = 'متعذر توصيلها';
  static const String backShipmentPkg = 'راجعة';

  // Remote Config
  static const iosBuildNumber = 'driver_ios_build_number';
  static const androidBuildNumber = 'driver_android_build_number';
  static const appStore = 'driver_app_store';
  static const playStore = 'driver_play_store';
  static const isManintance = 'driver_is_maintance';
  static const maintanceMessage = 'driver_maintance_message';
  static const isForcedUpdate = 'driver_force_update';

  // Firebase keys
  static const String firebaseApiKeyIos = 'FIREBASE_API_KEY_IOS';
  static const String firebaseApiKeyAndroid = 'FIREBASE_API_KEY_ANDROID';
}
