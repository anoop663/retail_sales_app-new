import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:uuid/uuid.dart';

class SalesControllerState extends ChangeNotifier {
  final List<TextEditingController> _nosControllers = [];

  List<TextEditingController> get nosControllers => _nosControllers;

  set addnosControllers(TextEditingController value) {
    _nosControllers.add(value);
  }

  final List<TextEditingController> _totalControllers = [];
  TextEditingController grandTotalController = TextEditingController();
  List<TextEditingController> get totalControllers => _totalControllers;

  set addtotalControllers(TextEditingController value) {
    _totalControllers.add(value);
  }

  final List<ProductSale> _selectedProducts = [];

  List<ProductSale> get selectedProducts => _selectedProducts;

  set addSelectedProducts(ProductSale value) {
    _selectedProducts.add(value);
    notifyListeners();
    //  notifyListeners();
  }

  void addRow() {
    addSelectedProducts = (ProductSale(name: '', nos: '', total: ''));
    addtotalControllers = TextEditingController();
    addnosControllers = TextEditingController();
    notifyListeners();
  }

  void removeRow(int index) {
    // if (index == 0) {
    //   // Clear text fields instead of removing controllers
    nosControllers.removeAt(index);
    totalControllers.removeAt(index);
    _selectedProducts.removeAt(index);
    notifyListeners();
    // } else {
    //   // Remove controllers from lists
    //   nosControllers.removeAt(index);
    //   totalControllers[index].removeListener(updateGrandTotal);
    //   totalControllers.removeAt(index);
    //   // selectedProducts1.removeAt(index);
    // }
    // updateGrandTotal();
  }

  void updateGrandTotal() {
    double total = 0;
    for (int i = 0; i < _selectedProducts.length; i++) {
      if (totalControllers[i].text.isNotEmpty) {
        total += (double.parse(_selectedProducts[i].total) *
            int.parse(nosControllers[i].text.trim()));
      }
    }

    grandTotalController =
        TextEditingController(text: total.toStringAsFixed(2));

    //print(grandTotalController.text);
    notifyListeners();
  }

  Future<void> createSales(
    String customerName,
  ) async {
    try {
      final salesBox = await Hive.openBox<SalesModel>('sales_db');
      const uuid = Uuid();
      final uuidString = uuid.v4(); // Generate UUID as a string
      final id = uuidString.hashCode.abs(); // Convert UUID string to integer
      final sales = SalesModel(

        customer: customerName,
        products: selectedProducts,
        grand: grandTotalController.text.trim(),
        createddate: DateTime.now(),
        id: id,

      );

      // ignore: avoid_print
      print(sales);
      try {
        await salesBox.add(sales).then((value) {
          // ignore: avoid_print
          print(value);
        });

        getAllSales();
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } catch (error) {
      // Handle error
    }
  }

  deleteSale(int index) async {
    final box1 = await Hive.openBox<SalesModel>('sales_db');

    box1.deleteAt(index);
    initializeHiveSales();
  }

  //////////////////////////////////////////////////////////////
  // customer list

  final List<CustomerModel> _customers = [];

  //////////////////////////////////////////////////////////////
  List<CustomerModel> get customers => _customers;

  set addCustomers(CustomerModel value) {
    _customers.add(value);
    notifyListeners();
  }

  void getCustomers() async {
    final box1 = await Hive.openBox<CustomerModel>('customer_db');
    _customers.clear();

    for (var element in box1.values) {
      addCustomers = (element);
    }
  }
}

Future<double> calculateTotalGrandHive() async {
  final box = await Hive.openBox<SalesModel>('sales_db');
  double totalGrand = 0;

  try {
    for (int i = 0; i < box.length; i++) {
      final salesModel = box.getAt(i);
      totalGrand += double.parse(salesModel?.grand ?? '0');
    }
    // ignore: avoid_print
    print('Total grand value: $totalGrand');
  } catch (e) {
    // ignore: avoid_print
    print('Error calculating total grand: $e');
  }

  return totalGrand;
}
