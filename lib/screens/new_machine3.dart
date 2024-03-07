import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';

class NewMachineWindow3 extends StatefulWidget {
  const NewMachineWindow3({super.key});

  @override
  State<NewMachineWindow3> createState() => _NewMachineWindow3State();
}

class _NewMachineWindow3State extends State<NewMachineWindow3> {
  final firstTxtController = TextEditingController();
  final secondTxtController = TextEditingController();
  final thirdTxtController = TextEditingController();
  Color buttonColor = Color(0xFF8670E1).withOpacity(0.2);
  Color buttonTextColor = Colors.white.withOpacity(0.2);
  int selectedContainerIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      if (selectedContainerIndex != -1) {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 25),
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
                      style: btntextstyle.copyWith(color: Color(0xFF8670E1)))
                ])),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            'Product details',
            style: boldstyle,
          ),
          SizedBox(height: 10),
          Text(
            'Product name',
            style: opacitystyle,
          ),
          SizedBox(height: 3),
          TextField(
            controller: firstTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          SizedBox(height: 10),
          Text(
            'Price (\$) per thing',
            style: opacitystyle,
          ),
          SizedBox(height: 3),
          TextField(
            controller: secondTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          SizedBox(height: 10),
          Text(
            'Consumption of goods for the period',
            style: opacitystyle,
          ),
          SizedBox(height: 3),
          TextField(
            controller: thirdTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          SizedBox(height: 5),
          Text(
            'How often do you track the \nnumber of products',
            style: boldstyle2,
          ),
          Container(
            child: Column(children: [
              Row(
                children: [
                  buildContainer('Daily', 0),
                  Spacer(),
                  buildContainer('Weekly', 1)
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  buildContainer('Monthly', 2),
                  Spacer(),
                  buildContainer('Annual', 3)
                ],
              )
            ]),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(8)),
            child: TextButton(
                child: Text('Continue',
                    style: btntextstyle.copyWith(color: buttonTextColor)),
                onPressed: firstTxtController.text.isNotEmpty &&
                        secondTxtController.text.isNotEmpty
                    ? () {
                        if (firstTxtController.text.isNotEmpty &&
                            secondTxtController.text.isNotEmpty) {
                          final provider = Provider.of<VendingMachineProvider>(
                              context,
                              listen: false);
                          final price = int.tryParse(secondTxtController.text);
                          String categoryName =
                              provider.periodic[selectedContainerIndex].name;

                          // 1. Обновление currentVendingMachine
                          provider.updateCurrentVendingMachine(
                              provider.currentVendingMachine.copyWith(
                            products: firstTxtController.text,
                            price: price,
                            consumption: thirdTxtController.text,
                            period: categoryName,
                          ));

                          // 2. Добавление currentVendingMachine в список
                          provider.addVendingMachine();
                          provider.saveVendingMachines();
                          Navigator.of(context)
                              .pushReplacementNamed('/mainscreen');
                        }
                      }
                    : null),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }

  Widget buildContainer(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedContainerIndex = index;
          updateButtonState();
        });
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2.2,
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
          ]),
        ),
      ),
    );
  }
}
