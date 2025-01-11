import 'package:flutter/material.dart';
import 'package:flutter_application_2/firebase_options.dart';
import 'package:flutter_application_2/screens/favorites_page.dart';
import 'screens/home.dart';
import 'screens/random_joke.dart';
import 'screens/register.dart';
import 'providers/joke_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<JokeProvider>(
          create: (_) => JokeProvider(),
        )
      ],
      child: MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurpleAccent,
        ),
        useMaterial3: true,
      ),
      home: const RegisterPage(),
      routes: {
        "/randomJoke": (context) => const RandomJoke(),
        "/favPage": (context) => const FavoritesPage(),
      },
    );
  }
}
