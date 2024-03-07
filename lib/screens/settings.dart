import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      child: Row(children: [
                    Icon(
                      Icons.chevron_left,
                      color: Color(0xff8670E1),
                    ),
                    Text('Back',
                        style: btntextstyle.copyWith(color: Color(0xFF8670E1))),
                  ])),
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Settings',
              style: boldstyle,
            ),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: styleContainer,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/image 3.png'),
                      width: 220,
                      height: 230,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Your opinion is important!',
                      style: boldstyle2,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'We need your feedback to get better',
                      style: btntextstyle.copyWith(
                          color: Colors.white.withOpacity(0.4)),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                          color: Color(0xFF8670E1),
                          borderRadius: BorderRadius.circular(8)),
                      child: TextButton(
                        child: Text('Rate app', style: btntextstyle),
                        onPressed: () {
                          final InAppReview inAppReview = InAppReview.instance;
                          inAppReview.openStoreListing(appStoreId: '6479026115');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _launchURL('https://docs.google.com/document/d/1VvSUpkmOQA47fK2g0DCQ2KsYK3nR0iB6c73xSsLJbyM/edit?usp=sharing');
              },
              child: Container(
                decoration: styleContainer,
                width: double.infinity,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Terms of use',
                        style: inputtxtfield,
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xff8670E1),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _launchURL('https://docs.google.com/document/d/1xM3XLbFFQUf_4XUD82VtTuJDW1nuf0_mcCI237U9Ee0/edit?usp=sharing');
              },
              child: Container(
                decoration: styleContainer,
                width: double.infinity,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Privacy Policy',
                        style: inputtxtfield,
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xff8670E1),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _launchURL('https://docs.google.com/forms/d/e/1FAIpQLSdkyxr4ZUBssCU_6sPsgyh8vLhN5z_IlAF4rOusA-YxR9WGcQ/viewform?usp=sf_link');
              },
              child: Container(
                decoration: styleContainer,
                width: double.infinity,
                height: 56,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        'Support page',
                        style: inputtxtfield,
                      ),
                      Spacer(),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xff8670E1),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
