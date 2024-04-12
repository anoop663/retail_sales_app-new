import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddSales1 extends StatefulWidget {
  final SalesModel? sales;

  const AddSales1({Key? key, this.sales}) : super(key: key);

  @override
  _AddSalesState1 createState() => _AddSalesState1();
}

class _AddSalesState1 extends State<AddSales1> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _grandTotalController = TextEditingController();

  double grandTotal = 0;

  final List<ProductModel> products = [];
  final List<TextEditingController> productnameControllers = [];
  final List<TextEditingController> nosControllers = [];
  final List<TextEditingController> totalControllers = [];
  final List<ProductModel?> selectedProducts = [];

  @override
  void initState() {
    super.initState();

    if (widget.sales != null) {
      _customerController.text = widget.sales!.customer;
      _grandTotalController.text = widget.sales!.grand;
    }

    loadProducts();
    addRow();
  }

  Future<void> loadProducts() async {
    final productBox = await Hive.openBox<ProductModel>('product_db2');
    setState(() {
      products.addAll(productBox.values);
    });
  }

  void addRow() {
    final newNosController = TextEditingController();
    final newTotalController = TextEditingController();
    setState(() {
      nosControllers.add(newNosController);
      totalControllers.add(newTotalController);
      selectedProducts.add(null);
      newTotalController.addListener(() => updateGrandTotal());
    });
  }

  void removeRow(int index) {
    setState(() {
      if (index == 0) {
        // Clear text fields instead of removing controllers
        nosControllers[index].clear();
        totalControllers[index].clear();
        selectedProducts[index] = null;
      } else {
        // Remove controllers from lists
        nosControllers.removeAt(index);
        totalControllers[index].removeListener(() => updateTotal(index));
        totalControllers.removeAt(index);
        selectedProducts.removeAt(index);
      }
      updateGrandTotal();
    });
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CustomerModel>('customer_db'),
      builder: (context, AsyncSnapshot<Box<CustomerModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final customerBox = snapshot.data!;
          final customers = customerBox.values.toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Create Sales',
                style: TextStyle(
                  color: Color(0xff4B4B87),
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListSales(),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 16),
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/Back1.png'),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: const Color(0xFFF1F5F9),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Select Customer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<CustomerModel>(
                      items: customers.map((customer) {
                        return DropdownMenuItem<CustomerModel>(
                          value: customer,
                          child: Text(customer.name),
                        );
                      }).toList(),
                      onChanged: (CustomerModel? value) {
                        _customerController.text = value!.name;
                      },
                      decoration: InputDecoration(
                        hintText: "Select Customer",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w400,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    'Products',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      for (int i = 0; i < nosControllers.length; i++)
                        productIncrement(i),
                      const SizedBox(height: 10),
                      buildGrandTotalField(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await createSales(
                          _customerController.text,
                          selectedProducts.cast<ProductSale>(),
                          grandTotal.toString(),
                        );

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListSales(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B4B87),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 12),
                      ),
                      child: Text(
                        widget.sales != null ? 'Update' : 'Create',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildGrandTotalField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Grand Total',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextFormField(
            controller: _grandTotalController,
            enabled: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget productIncrement(int index) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    var scanResult = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    if (scanResult != null) {
                      // Find the product from ProductModel using product code
                      ProductModel? scannedProduct = products.firstWhere(
                        (product) => product.code == scanResult,
                        //orElse: () => null,
                      );

                      if (scannedProduct != null) {
                        // Set the scanned product in the dropdown
                        setState(() {
                          selectedProducts[index] = scannedProduct;
                          // Update other fields as necessary
                          // For example, if you want to set the quantity to 1:
                          nosControllers[index].text = '1';
                          double price1 = double.parse(scannedProduct.price);
                          totalControllers[index].text = price1.toString();
                          updateTotal(index);
                        });
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product not found'),
                          ),
                        );
                      }
                    }
                  },
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'lib/assets/scan2.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<ProductModel>(
                  items: products.map((product) {
                    return DropdownMenuItem<ProductModel>(
                      value: product,
                      child: Text(product.name),
                    );
                  }).toList(),
                  onChanged: (ProductModel? value) {
                    setState(() {
                      selectedProducts[index] = value;
                      
                      // Assuming you want to set the quantity to 1 and calculate total based on that
                      nosControllers[index].text = '1';
                      double price = double.parse(value!.price);
                      totalControllers[index].text =
                          (1 * price).toStringAsFixed(2);
                      updateGrandTotal();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Products",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: nosControllers[index],
                  decoration: InputDecoration(
                    hintText: "Nos",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => updateTotal(index),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: totalControllers[index],
                  decoration: InputDecoration(
                    hintText: "Total",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.none,
                  onChanged: (_) => updateGrandTotal(),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  addRow();
                },
                child: Material(
                  color: const Color(0xFF4B4B87),
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'lib/assets/plus5.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () {
                  removeRow(index);
                  updateGrandTotal();
                },
                child: Material(
                  color: const Color(0xFF4B4B87),
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'lib/assets/minus.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void updateTotal(int index) {
    if (selectedProducts[index] != null &&
        nosControllers[index].text.isNotEmpty) {
      final int nos = int.parse(nosControllers[index].text);
      final double total = nos * double.parse(selectedProducts[index]!.price);
      totalControllers[index].text = total.toStringAsFixed(2);
      updateGrandTotal();
    }
  }

  void updateGrandTotal() {
    double total = 0;
    for (int i = 0; i < totalControllers.length; i++) {
      if (totalControllers[i].text.isNotEmpty) {
        total += double.parse(totalControllers[i].text);
      }
    }
    _grandTotalController.text = total.toStringAsFixed(2);
  }
}
