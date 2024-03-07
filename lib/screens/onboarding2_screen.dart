import 'package:flutter/material.dart';
import 'package:vending_machines_app/const/app_images.dart';
import 'package:vending_machines_app/const/app_styles.dart';

class OnBoardingWidgetTwo extends StatefulWidget {
  const OnBoardingWidgetTwo({super.key});

  @override
  State<OnBoardingWidgetTwo> createState() => _OnBoardingWidgetTwoState();
}

class _OnBoardingWidgetTwoState extends State<OnBoardingWidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(height: 100),
          Image(
            image: AssetImage(onboardingimg2),
            fit: BoxFit.cover,
          ),
          SizedBox(height: 25),
          Container(
            width: 276,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Get benefits \nfrom the sale',
                  style: boldstyle,
                ),
                SizedBox(height: 10),
                Text(
                  'Analyze the received data on the sale of products',
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
                Navigator.of(context).pushReplacementNamed('/welcome');
              },
            ),
          )
        ]),
      ),
    );
  }
}
