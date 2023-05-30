import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:travell_app/auth_provider.dart';
import 'package:travell_app/models/app_data.dart';
import 'package:travell_app/models/trip.dart';
import 'package:travell_app/screens/category_screen.dart';
import 'package:travell_app/screens/category_trips_screen.dart';
import 'package:travell_app/screens/filters_screen.dart';
import 'package:travell_app/screens/login.dart';
import 'package:travell_app/screens/register.dart';
import 'package:travell_app/screens/tabs_screen.dart';
import 'package:travell_app/screens/trip_detail_screen.dart';
import 'package:travell_app/screens/welcom.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'summer': false,
    'winter': false,
    'family': false,
  };

  List<Trip> _availableTrips = tripsData;
  List<Trip> _favoriteTrips = [];

  void _changeFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableTrips = tripsData.where((trip) {
        if (_filters['summer'] == true && trip.isInSummer != true) {
          return false;
        }
        if (_filters['winter'] == true && trip.isInWinter != true) {
          return false;
        }
        if (_filters['family'] == true && trip.isForFamilies != true) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _manageFavorite(String tripId) {
    final existingIndex =
        _favoriteTrips.indexWhere((trip) => trip.id == tripId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteTrips.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteTrips.add(
          tripsData.firstWhere((trip) => trip.id == tripId),
        );
      });
    }
  }

  bool _isFovarite(String id) {
    return _favoriteTrips.any((trip) => trip.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RegisterProvider>(create: (_) => RegisterProvider()),
        Provider<LoginProvider>(create: (_) => LoginProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', 'AE'), // English, no country code
        ],
        title: 'Travel App',
        theme: ThemeData(
            fontFamily: 'ElMessiri',
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline5: const TextStyle(
                    color: Colors.blue,
                    fontSize: 24,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.bold,
                  ),
                  headline6: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontFamily: 'ElMessiri',
                    fontWeight: FontWeight.bold,
                  ),
                ),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                .copyWith(secondary: Colors.amber)),
        initialRoute: WelcomScreen.id,
        routes: {
          WelcomScreen.id: (context) => const WelcomScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          RegisterScreen.id: (context) => const RegisterScreen(),
          '/': (context) => TabsScreen(_favoriteTrips),
          CategoryScreen.id: (context) => const CategoryScreen(),
          CategoryTripsScreen.screenRoute: (context) =>
              CategoryTripsScreen(_availableTrips),
          TripDetailScreen.screenRoute: (context) =>
              TripDetailScreen(_manageFavorite, _isFovarite),
          FiltersScreen.id: (context) => FiltersScreen(
                _filters,
                _changeFilters,
              ),
        },
      ),
    );
  }
}
