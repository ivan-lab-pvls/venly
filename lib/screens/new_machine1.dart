import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';

class NewMachineWindow1 extends StatefulWidget {
  final VendingMachine? existingMachine;
  const NewMachineWindow1({super.key, this.existingMachine});

  @override
  State<NewMachineWindow1> createState() => _NewMachineWindow1State();
}

class _NewMachineWindow1State extends State<NewMachineWindow1> {
  final firstTxtController = TextEditingController();
  final secondTxtController = TextEditingController();
  Color buttonColor = Color(0xFF8670E1).withOpacity(0.2);
  Color buttonTextColor = Colors.white.withOpacity(0.2);
  @override
  void initState() {
    super.initState();

    firstTxtController.addListener(updateButtonState);
    secondTxtController.addListener(updateButtonState);
    if (widget.existingMachine != null) {
      firstTxtController.text = widget.existingMachine!.name;
      secondTxtController.text = widget.existingMachine!.location;
    }
  }

  void updateButtonState() {
    setState(() {
      if (firstTxtController.text.isNotEmpty &&
          secondTxtController.text.isNotEmpty) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 35),
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
          Text(
            'New machine',
            style: boldstyle,
          ),
          SizedBox(height: 15),
          Text(
            'Its name',
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
            'Location',
            style: opacitystyle,
          ),
          SizedBox(height: 5),
          TextField(
            controller: secondTxtController,
            decoration: styleTextField,
            style: inputtxtfield,
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: buttonColor, borderRadius: BorderRadius.circular(8)),
            child: ClipRRect(
              child: TextButton(
                  child: Text('Continue',
                      style: btntextstyle.copyWith(color: buttonTextColor)),
                  onPressed: firstTxtController.text.isNotEmpty &&
                          secondTxtController.text.isNotEmpty
                      ? () {
                          final provider = Provider.of<VendingMachineProvider>(
                              context,
                              listen: false);

                          if (widget.existingMachine != null) {
                            final index = provider.vendingMachines.indexWhere(
                                (machine) => machine == widget.existingMachine);
                            if (index != -1) {
                              provider.vendingMachines.removeAt(index);
                            }
                            provider.updateCurrentVendingMachine(
                              provider.currentVendingMachine.copyWith(
                                name: firstTxtController.text,
                                location: secondTxtController.text,
                              ),
                            );
                          } else {
                            provider.updateCurrentVendingMachine(
                              provider.currentVendingMachine.copyWith(
                                name: firstTxtController.text,
                                location: secondTxtController.text,
                              ),
                            );
                          }
                          Navigator.of(context).pushNamed('/add2');
                        }
                      : null),
            ),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }
}
