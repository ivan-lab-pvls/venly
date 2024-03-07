
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vending_machines_app/const/model.dart';
import 'package:vending_machines_app/screens/all_vendings.dart';
import 'package:vending_machines_app/screens/main_screen.dart';
import 'package:vending_machines_app/screens/new_machine1.dart';
import 'package:vending_machines_app/screens/new_machine2.dart';
import 'package:vending_machines_app/screens/new_machine3.dart';
import 'package:vending_machines_app/screens/onboarding1_screen.dart';
import 'package:vending_machines_app/screens/onboarding2_screen.dart';
import 'package:vending_machines_app/screens/settings.dart';
import 'package:vending_machines_app/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VendingMachineProvider provider = VendingMachineProvider();
  await provider.loadVendingMachines();
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: provider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF171717),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      routes: {
        '/onboarding2': (context) => OnBoardingWidgetTwo(),
        '/welcome': (context) => WelcomeWidget(),
        '/mainscreen': (context) => MainScreenWidget(),
        '/allvendings': (context) => AllVendingMachinesWidget(),
        '/add1': (context) => NewMachineWindow1(),
        '/add2': (context) => NewMachineWindow2(),
        '/add3': (context) => NewMachineWindow3(),
        '/settings': (context) => SettingsWidget()
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences prefs;
  bool showInstructions = true;

  @override
  void initState() {
    super.initState();
    checkInstructionsStatus();
  }

  Future<void> checkInstructionsStatus() async {
    prefs = await SharedPreferences.getInstance();
    bool shouldShowInstructions = prefs.getBool('showInstructions') ?? true;

    if (mounted) {
      setState(() {
        showInstructions = shouldShowInstructions;
      });

      if (showInstructions) {
        await prefs.setBool('showInstructions', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingWidgetOne()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreenWidget()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
