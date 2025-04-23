import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/home_page.dart';
import 'pages/trip_form_page.dart';
import 'pages/trip_summary_page.dart';
import 'pages/login_page.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(            
      options: const FirebaseOptions(
        apiKey: "AIzaSyDpyyENR7hGeU6a1TRbcrQKAvU1irjKNRU",
        appId: "1:236916425802:web:43cef8a031b0a333e752b3",
        messagingSenderId: "236916425802",
        projectId: "trip-planner-58768",
        storageBucket: "trip-planner-58768.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(TravelPlannerApp());
}

class TravelPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: AuthGate(),
      routes: {
        '/home': (context) => HomePage(),
        '/trip-form': (context) => TripFormPage(),
        '/summary': (context) => TripSummaryPage(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage(); // 👇 Login page defined below
        }
      },
    );
  }
}
