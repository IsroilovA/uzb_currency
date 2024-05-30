import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uzb_currency/home/cubit/pinned_cubit.dart';
import 'package:uzb_currency/home/cubit/rates_cubit.dart';
import 'package:uzb_currency/service/currencies_repository.dart';
import 'package:uzb_currency/service/hive_initialiser.dart';
import 'package:uzb_currency/service/locator.dart';
import 'package:uzb_currency/tabs/cubit/tabs_cubit.dart';
import 'package:uzb_currency/tabs/tabs_screen.dart';

// Theme for the light mode
final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        255, 86, 38, 190), // Primary color for the light theme
    brightness: Brightness.light, // Brightness setting for the light theme
  ),
  textTheme:
      GoogleFonts.poppinsTextTheme(), // Using Poppins font for the light theme
);

// Theme for the dark mode
final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(
        230, 98, 14, 14), // Primary color for the dark theme
    brightness: Brightness.dark, // Brightness setting for the dark theme
  ),
  textTheme:
      GoogleFonts.poppinsTextTheme(), // Using Poppins font for the dark theme
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initialiseHive();
  await initialiseLocator();
  runApp(const App());
}

// Root widget of the application
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: lightTheme, // Applying the light theme
        darkTheme: darkTheme, // Applying the dark theme
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TabsCubit(),
            ),
            BlocProvider(
              create: (context) => RatesCubit(
                  currenciesRepository: locator<CurrenciesRepository>()),
            ),
            BlocProvider(
              create: (context) => PinnedCubit(
                  currenciesRepository: locator<CurrenciesRepository>()),
            ),
          ],
          child: const TabsScreen(),
        ));
  }
}
