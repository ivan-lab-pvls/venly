import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:vending_machines_app/const/app_styles.dart';
import 'package:vending_machines_app/const/model.dart';
import 'package:vending_machines_app/screens/product_card.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  @override
  Widget build(BuildContext context) {
    var vendingMachineProvider = Provider.of<VendingMachineProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 25),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/settings');
                  },
                  child: Text(
                    'Settings',
                    style: btntextstyle.copyWith(color: Color(0xFF8670E1)),
                  )),
              Spacer(),
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
          Consumer<VendingMachineProvider>(
            builder: (context, vendingMachineProvider, child) {
              return Center(
                child: vendingMachineProvider.vendingMachines.isEmpty
                    ? NoInfo()
                    : YourVendingMachineWidget(),
              );
            },
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: Color(0xFF8670E1),
                borderRadius: BorderRadius.circular(8)),
            child: TextButton(
              child: Text('Add now', style: btntextstyle),
              onPressed: () {
                Navigator.of(context).pushNamed('/add1');
              },
            ),
          ),
          SizedBox(height: 15),
        ]),
      ),
    );
  }
}

class NoInfo extends StatelessWidget {
  const NoInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No added info yet',
            style: boldstyle2.copyWith(color: Color(0xFF8670E1)),
          ),
          Center(
              child: Text(
            'Add the first vending machine',
            style: opacitystyle,
          )),
        ],
      ),
    );
  }
}

class YourVendingMachineWidget extends StatefulWidget {
  const YourVendingMachineWidget({super.key});

  @override
  State<YourVendingMachineWidget> createState() =>
      _YourVendingMachineWidgetState();
}

class _YourVendingMachineWidgetState extends State<YourVendingMachineWidget> {
  @override
  void initState() {
    super.initState();

    Provider.of<VendingMachineProvider>(context, listen: false)
        .loadVendingMachines();
  }

  bool showAllMachines = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<VendingMachineProvider>(
      builder: (context, provider, child) {
        var vendingMachineProvider = provider;
        List<VendingMachine> machinesToDisplay;

        if (showAllMachines) {
          machinesToDisplay = vendingMachineProvider.vendingMachines;
        } else {
          machinesToDisplay =
              vendingMachineProvider.vendingMachines.take(3).toList();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: styleContainer.copyWith(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TotalEarnedWidget(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Your machines',
                  style: opacitystyle,
                ),
                Spacer(),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/allvendings');
                    },
                    child: Text(
                      'All',
                      style: btntextstyle.copyWith(color: Color(0xff8670E1)),
                    ))
              ],
            ),
            FutureBuilder(
              future: Future.value(true),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final provider = Provider.of<VendingMachineProvider>(context,
                      listen: false);
                  List<VendingMachine> machinesToDisplay = showAllMachines
                      ? provider.vendingMachines
                      : provider.vendingMachines.take(3).toList();

                  return MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: machinesToDisplay.length,
                      itemBuilder: (context, index) {
                        VendingMachine machine = machinesToDisplay[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductCardWidget(machine: machine),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Container(
                              width: double.infinity,
                              decoration: styleContainer,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          machine.name,
                                          style: inputtxtfield,
                                        ),
                                        Text(
                                          machine.location,
                                          style: inputtxtfield.copyWith(
                                              color: Colors.grey),
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
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Text(
              'Products',
              style: opacitystyle,
            ),
            Container(
              decoration: styleContainer,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cash',
                      style: inputtxtfield,
                    ),
                    Row(
                      children: [
                        Text(
                          'need to be replenished in',
                          style: inputtxtfield.copyWith(color: Colors.grey),
                        ),
                        Spacer(),
                        Text(
                          'Daily',
                          style: inputtxtfield.copyWith(color: Colors.grey),
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 4,
                      decoration: BoxDecoration(
                          color: Color(0xff8670E1),
                          borderRadius: BorderRadius.circular(2)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color(0xff171717),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Beer', style: inputtxtfield),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class TotalEarnedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VendingMachineProvider>(
      builder: (context, provider, child) {
        int totalEarned = provider.vendingMachines
            .map((machine) => machine.price)
            .fold(0, (sum, price) => sum + price);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have earned this month',
              style: btntextstyle,
            ),
            Text(
              '\$$totalEarned',
              style: boldstyle2,
            ),
            SizedBox(height: 7),
            Text(
              'From all your machines',
              style: inputtxtfield.copyWith(color: Colors.grey),
            ),
            SizedBox(height: 7),
          ],
        );
      },
    );
  }
}
