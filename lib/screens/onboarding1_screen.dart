import 'package:flutter/material.dart';
import 'package:vending_machines_app/const/app_images.dart';
import 'package:vending_machines_app/const/app_styles.dart';

class OnBoardingWidgetOne extends StatefulWidget {
  const OnBoardingWidgetOne({super.key});

  @override
  State<OnBoardingWidgetOne> createState() => _OnBoardingWidgetOneState();
}

class _OnBoardingWidgetOneState extends State<OnBoardingWidgetOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 100),
          Image(
            image: AssetImage(onboardingimg1),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 25),
          Container(
            width: 276,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Track the rest of \n   the products',
                  style: boldstyle,
                ),
                SizedBox(height: 10),
                Text(
                  '    Add all products and get \nnotifications when they run out',
                  style: opacitystyle,
                ),
              ],
            ),
          ),
          SizedBox(height: 90),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Color(0xFF8670E1),
                borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              child: Text(
                'Continue',
                style: btntextstyle,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/onboarding2');
              },
            ),
          )
        ]),
      ),
    );
  }
}
