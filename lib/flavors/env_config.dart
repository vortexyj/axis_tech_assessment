

class EnvConfig {
  final String appName;
  final String baseUrl;
  final String loyaltyBaseUrl;
  final String magicoBaseUrl;
  final String clientId;
  final bool shouldCollectCrashLog;
  Map<String, Map<String, String>>? remoteKeys;
  // List<BottomNavItem>? navBarTabs;
  // late final Logger logger;

  EnvConfig({
    required this.appName,
    required this.baseUrl,
    required this.clientId,
    required this.magicoBaseUrl,
    required this.loyaltyBaseUrl,
    required this.remoteKeys,
    // required navBarTabs,
    this.shouldCollectCrashLog = false,
  }) {
    // logger = Logger(
    //   printer: PrettyPrinter(
    //       methodCount: AppValues.loggerMethodCount,
    //       // number of method calls to be displayed
    //       errorMethodCount: AppValues.loggerErrorMethodCount,
    //       // number of method calls if stacktrace is provided
    //       lineLength: AppValues.loggerLineLength,
    //       // width of the output
    //       colors: true,
    //       // Colorful log messages
    //       printEmojis: true,
    //       // Print an emoji for each log message
    //       printTime: true // Should each log print contain a timestamp
    //       ),
    // );
  }
}
