import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendingMachine {
  String name;
  String location;
  String category;
  String products;
  int price;
  String consumption;
  String period;

  VendingMachine(
      {required this.name,
      required this.location,
      required this.category,
      required this.products,
      required this.price,
      required this.consumption,
      required this.period});
  VendingMachine copyWith({
    String? name,
    String? location,
    String? category,
    String? products,
    int? price,
    String? consumption,
    String? period,
  }) {
    return VendingMachine(
      name: name ?? this.name,
      location: location ?? this.location,
      category: category ?? this.category,
      products: products ?? this.products,
      price: price ?? this.price,
      consumption: consumption ?? this.consumption,
      period: period ?? this.period,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'location': location,
      'category': category,
      'products': products,
      'price': price,
      'consumption': consumption,
      'period': period,
    };
  }

  factory VendingMachine.fromJson(Map<String, dynamic> json) {
    return VendingMachine(
      name: json['name'],
      location: json['location'],
      category: json['category'],
      products: json['products'],
      price: json['price'],
      consumption: json['consumption'],
      period: json['period'],
    );
  }
}

class VendingMachineProvider extends ChangeNotifier {
  List<VendingMachine> _vendingMachines = [];
  List<Category> _categories = [
    Category(name: 'Drinks', index: 0),
    Category(name: 'Food', index: 1),
    Category(name: 'Media', index: 2),
    Category(name: 'Medicine', index: 3),
    Category(name: 'Products', index: 4),
  ];
  int _currentCategoryIndex = -1;
  List<Period> _periodic = [
    Period(name: 'Daily', index: 0),
    Period(name: 'Weekly', index: 1),
    Period(name: 'Monthly', index: 2),
    Period(name: 'Annual', index: 3),
  ];
  int _currentPeriodIndex = -1;
  List<VendingMachine> get vendingMachines => _vendingMachines;
  List<Category> get categories => _categories;
  int get currentCategoryIndex => _currentCategoryIndex;
  List<Period> get periodic => _periodic;
  int get currentPeriodIndex => _currentPeriodIndex;
  Future<void> saveVendingMachines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> machinesJsonList = vendingMachines
        .map((machine) => json.encode(machine.toJson()))
        .toList();
    prefs.setStringList('vendingMachines', machinesJsonList);
  }

  set vendingMachines(List<VendingMachine> machines) {
    _vendingMachines = machines;
    notifyListeners();
  }

  Future<void> loadVendingMachines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? machinesJsonList = prefs.getStringList('vendingMachines');
    if (machinesJsonList != null) {
      vendingMachines = machinesJsonList.map((jsonString) {
        VendingMachine machine =
            VendingMachine.fromJson(json.decode(jsonString));
        return machine;
      }).toList();

      notifyListeners();
    }
  }

  void setCurrentCategoryIndex(int index) {
    _currentCategoryIndex = index;
    notifyListeners();
  }

  void setCurrentPeriodicIndex(int index) {
    _currentPeriodIndex = index;
    notifyListeners();
  }

  VendingMachine _currentVendingMachine = VendingMachine(
    name: '',
    location: '',
    category: '',
    products: '',
    price: 0,
    consumption: '',
    period: '',
  );

  VendingMachine get currentVendingMachine => _currentVendingMachine;

  void updateCurrentVendingMachine(VendingMachine updatedVendingMachine) {
    _currentVendingMachine = _currentVendingMachine.copyWith(
      name: updatedVendingMachine.name,
      location: updatedVendingMachine.location,
      category: updatedVendingMachine.category,
      products: updatedVendingMachine.products,
      price: updatedVendingMachine.price,
      consumption: updatedVendingMachine.consumption,
      period: updatedVendingMachine.period,
    );
    notifyListeners();
  }

  void addVendingMachine() {
    _vendingMachines.add(_currentVendingMachine);
    _currentVendingMachine = VendingMachine(
      name: '',
      location: '',
      category: '',
      products: '',
      price: 0,
      consumption: '',
      period: '',
    );
    _currentCategoryIndex = -1;

    notifyListeners();
  }
}

class Period {
  String name;
  int index;

  Period({required this.name, required this.index});
}

class Category {
  String name;
  int index;

  Category({required this.name, required this.index});
}
