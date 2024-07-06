import 'package:basecode/firebase_options.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
import 'package:basecode/services/auth/screen/log_in_screen.dart';
import 'package:basecode/services/home/screen/home_screen.dart';
import 'package:basecode/services/on_boarding/screen/on_boarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isWatchedOnBoard = prefs.getBool('home') ?? false;
  runApp(MyApp(
    isWatchedOnBoard: isWatchedOnBoard,
  ));
}

class MyApp extends StatelessWidget {
  final bool isWatchedOnBoard;
  MyApp({
    super.key,
    required this.isWatchedOnBoard,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
            create: (_) => AuthRepository(FirebaseAuth.instance)),
        
      ],
      child: MaterialApp(
        title: 'Track it',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: isWatchedOnBoard ? AuthGate() : OnBoardingScreen(),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    print("yo");
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LogInScreen();
          }
        },
      ),
    );
  }
}
