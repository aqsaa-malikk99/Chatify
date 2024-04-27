import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}



/*class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue, // Adjust to your preference
    accentColor: Colors.lightBlue, // Adjust to your preference
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue, // Adjust to your preference
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: Colors.black, // Adjust to your preference
      ),
      bodyText1: TextStyle(
        fontSize: 16.0,
        color: Colors.black, // Adjust to your preference
      ),
      button: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.grey.shade200, // Adjust to your preference
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.grey.shade400), // Adjust to your preference
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(color: Colors.blue), // Adjust to your preference
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: 10.0,
        ),
        side: BorderSide(color: Colors.blue), // Adjust to your preference
      ),
    ),
    chatBubbleTheme: ChatBubbleThemeData(
      senderChatBubbleColor: Colors.blue.withOpacity(0.2), // Adjust to your preference
      receiverChatBubbleColor: Colors.grey.shade200, // Adjust to your preference
    ),
  );

  static final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.teal, // Adjust to your preference
  accentColor: Colors.tealAccent, // Adjust to your preference
  colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.teal, // Adjust to your preference
  ),
  textTheme: TextTheme(
  headlineLarge: TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.bold,
  color: Colors.white, // Adjust to your preference
  ),
  bodyText1: TextStyle(
  fontSize: 16.0,
  color: Colors.white, // Adjust to your preference
  ),
  button: TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
  ),
  ),
  inputDecorationTheme: InputDecorationTheme(
  fillColor: Colors.grey.shade800, // Adjust to your preference
  filled: true,
  border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(color: Colors.grey.shade600), // Adjust to your preference
  ),
  focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10.0),
  borderSide: BorderSide(color: Colors.teal), // Adjust to your preference
  ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10.0),
  ),
  ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: 10.0,
  ),
  side: BorderSide(color: Colors.teal), // Adjust to your preference
  ),
  ),
  chatBubbleTheme: ChatBubbleThemeData(
  senderChatBubbleColor: Colors.teal.withOpacity(0.2), // Adjust to your preference
  receiverChatBubbleColor: Colors.grey.shade800, // Adjust to your preference
  ),

}*/
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.pinkAccent,
        ),
        child: const Center(child: Text("Chatify",style: TextStyle(color: Colors.white,fontSize: 22),)),
      ),
    );
  }
}

