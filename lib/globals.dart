import 'package:logger/logger.dart';

//String top_level_api = "http://192.168.1.21:5100/api/";
String top_level_api = "http://57.129.15.180:5100/api/";

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0, // number of method calls to be displayed
    errorMethodCount: 5, // number of method calls if stacktrace is provided
    lineLength: 120, // width of the output
    colors: true, // Colorful log messages
    printEmojis: true, // Print an emoji for each log message
    printTime: false, // Should each log print contain a timestamp
  ),
);
