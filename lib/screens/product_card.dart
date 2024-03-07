import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';
import 'package:vending_machines_app/screens/new_machine1.dart';

class ProductCardWidget extends StatefulWidget {
  final VendingMachine machine;
  const ProductCardWidget({super.key, required this.machine});

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    final machine = widget.machine;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                        style: btntextstyle.copyWith(color: Color(0xFF8670E1)))
                  ])),
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              NewMachineWindow1(existingMachine: machine),
                        ),
                      );
                    },
                    child: Text('Edit',
                        style: btntextstyle.copyWith(color: Color(0xFF8670E1))))
              ],
            ),
            Text(
              'Product card',
              style: boldstyle,
            ),
            SizedBox(height: 15),
            Text(
              'Product name',
              style: boldstyle2,
            ),
            SizedBox(height: 5),
            Container(
              height: 52,
              decoration: styleContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      machine.name,
                      style: inputtxtfield,
                    )),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Price (\$) per thing',
              style: boldstyle2,
            ),
            SizedBox(height: 5),
            Container(
              height: 52,
              decoration: styleContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${machine.price}\$',
                      style: inputtxtfield,
                    )),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Type of product',
              style: boldstyle2,
            ),
            SizedBox(height: 5),
            Container(
              height: 52,
              decoration: styleContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      machine.category,
                      style: inputtxtfield,
                    )),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Consumption time',
              style: boldstyle2,
            ),
            SizedBox(height: 5),
            Container(
              height: 52,
              decoration: styleContainer,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      machine.period,
                      style: inputtxtfield,
                    )),
              ),
            ),
            Spacer(),
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                  color: Color(0xFF8670E1),
                  borderRadius: BorderRadius.circular(8)),
              child: TextButton(
                child: Text('Replenish', style: btntextstyle),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/mainscreen');
                },
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
