import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';

class NewMachineWindow2 extends StatefulWidget {
  const NewMachineWindow2({super.key});

  @override
  State<NewMachineWindow2> createState() => _NewMachineWindow2State();
}

class _NewMachineWindow2State extends State<NewMachineWindow2> {
  Color buttonColor = Color(0xFF8670E1).withOpacity(0.2);
  Color buttonTextColor = Colors.white.withOpacity(0.2);
  int selectedCategoryIndex = -1;
  @override
  void initState() {
    super.initState();
  }

  void updateButtonState() {
    setState(() {
      if (selectedCategoryIndex != -1) {
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
            'Product details',
            style: boldstyle,
          ),
          SizedBox(height: 15),
          Text(
            'Choose a type of product',
            style: boldstyle.copyWith(fontSize: 20),
          ),
          categorybuild('Drinks', 0),
          SizedBox(height: 7),
          categorybuild('Food', 1),
          SizedBox(height: 7),
          categorybuild('Media', 2),
          SizedBox(height: 7),
          categorybuild('Medicine', 3),
          SizedBox(height: 7),
          categorybuild('Products', 4),
          SizedBox(height: 7),
          Spacer(),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              child: TextButton(
                child:
                    Text('Continue', style: TextStyle(color: buttonTextColor)),
                onPressed: selectedCategoryIndex != -1
                    ? () {
                        final provider = Provider.of<VendingMachineProvider>(
                            context,
                            listen: false);
                        provider.setCurrentCategoryIndex(selectedCategoryIndex);
                        String categoryName =
                            provider.categories[selectedCategoryIndex].name;
                        VendingMachine updatedMachine = provider
                            .currentVendingMachine
                            .copyWith(category: categoryName);
                        provider.updateCurrentVendingMachine(updatedMachine);

                        Navigator.of(context).pushNamed('/add3');
                      }
                    : null,
              ),
            ),
          ),
          SizedBox(height: 10),
        ]),
      ),
    );
  }

  Widget categorybuild(String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
          updateButtonState();
        });
      },
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xFF212121),
            border: Border.all(
                color: selectedCategoryIndex == index
                    ? Color(0xFF8670E1)
                    : Colors.transparent)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(name, style: btntextstyle),
          ),
        ),
      ),
    );
  }
}
