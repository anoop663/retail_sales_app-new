import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
        grand: '0',
        id: id,
      );

      print(sales);
      try {
        await salesBox.add(sales).then((value) {
          print(value);
        });

        getAllSales();
      } catch (e) {
        print(e);
      }
    } catch (error) {
      // Handle error
    }
  }
}
