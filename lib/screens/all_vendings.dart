import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';
import 'package:vending_machines_app/screens/product_card.dart';

class AllVendingMachinesWidget extends StatefulWidget {
  const AllVendingMachinesWidget({super.key});

  @override
  State<AllVendingMachinesWidget> createState() =>
      _AllVendingMachinesWidgetState();
}

class _AllVendingMachinesWidgetState extends State<AllVendingMachinesWidget> {
  @override
  Widget build(BuildContext context) {
    List<VendingMachine> machinesToDisplay;

    var vendingMachineProvider = Provider.of<VendingMachineProvider>(context);
    machinesToDisplay = vendingMachineProvider.vendingMachines;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
            ],
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                'Vending machines',
                style: boldstyle,
              ),
            ],
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: machinesToDisplay.length,
            itemBuilder: (context, index) {
              VendingMachine machine = machinesToDisplay[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductCardWidget(machine: machine),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: double.infinity,
                    decoration: styleContainer,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                machine.name,
                                style: inputtxtfield,
                              ),
                              Text(
                                machine.location,
                                style:
                                    inputtxtfield.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            Icons.chevron_right,
                            color: Color(0xff8670E1),
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
