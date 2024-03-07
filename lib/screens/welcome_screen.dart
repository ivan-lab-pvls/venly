import 'package:flutter/material.dart';
import 'package:vending_machines_app/const/app_styles.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {
  final firstTxtController = TextEditingController();
  final secondTxtController = TextEditingController();
  int selectedContainerIndex = -1;
  Color buttonColor = Color(0xFF8670E1).withOpacity(0.2);
  Color buttonTextColor = Colors.white.withOpacity(0.2);
  @override
  void initState() {
    super.initState();

    firstTxtController.addListener(updateButtonState);
    secondTxtController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      if (firstTxtController.text.isNotEmpty &&
          secondTxtController.text.isNotEmpty &&
          selectedContainerIndex != -1) {
        buttonColor = Color(0xFF8670E1);
        buttonTextColor = Colors.white;
      } else {
        buttonColor = Color(0xFF8670E1).withOpacity(0.2);
        buttonTextColor = Colors.white.withOpacity(0.2);
      }
    });
  }

  @override
  void dispose() {
    firstTxtController.dispose();
    secondTxtController.dispose();
    super.dispose();
  }

  List<bool> isSelected = [false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 45),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: Color(0xff8670E1),
                  ),
                  Text(
                    'Back',
                    style: btntextstyle.copyWith(color: Color(0xFF8670E1)),
                  )
                ],
              ),
            ),
          ),
          Text(
            'Lets start',
            style: boldstyle,
          ),
          SizedBox(height: 15),
          Text(
            'Your name',
            style: opacitystyle,
          ),
          SizedBox(height: 5),
          TextField(
            controller: firstTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          SizedBox(height: 15),
          Text(
            'Your field of activity',
            style: opacitystyle,
          ),
          SizedBox(height: 5),
          TextField(
            controller: secondTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          SizedBox(height: 15),
          Text(
            'How often do you track the \nnumber of products?',
            style: boldstyle2,
          ),
          Container(
            child: Column(children: [
              Row(
                children: [
                  buildContainer('Daily', '4-7 days per week', 0),
                  Spacer(),
                  buildContainer('Weekly', '4-7 days per week', 1)
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  buildContainer('Monthly', '5-7 days per month', 2),
                  Spacer(),
                  buildContainer('Rarely', '1 day per month', 3)
                ],
              )
            ]),
          ),
          SizedBox(height: 180),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              child: Text(
                'Continue',
                style: btntextstyle.copyWith(color: buttonTextColor),
              ),
              onPressed: selectedContainerIndex != -1 &&
                      firstTxtController.text.isNotEmpty &&
                      secondTxtController.text.isNotEmpty
                  ? () {
                      if (firstTxtController.text.isNotEmpty &&
                          secondTxtController.text.isNotEmpty &&
                          selectedContainerIndex != -1) {
                        Navigator.of(context).pushNamed('/mainscreen');
                      }
                    }
                  : null,
            ),
          )
        ]),
      ),
    );
  }

  Widget buildContainer(String name, String discription, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedContainerIndex = index;
          updateButtonState();
        });
      },
      child: Container(
        width: 183,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFF212121),
          border: Border.all(
            color: index == selectedContainerIndex
                ? Color(0xFF8670E1)
                : Colors.transparent,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(children: [
            Text(
              name,
              style: btntextstyle,
            ),
            Text(
              discription,
              style: containertext,
            ),
          ]),
        ),
      ),
    );
  }
}
