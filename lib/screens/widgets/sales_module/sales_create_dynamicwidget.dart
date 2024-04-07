import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/homepage/barcode_scanscreen.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';

class AddSalesDynamic extends StatefulWidget {
  @override
  _AddSalesDynamicState createState() => _AddSalesDynamicState();
}

class _AddSalesDynamicState extends State<AddSalesDynamic> {
  final List<ProductModel> products = [];
  final List<TextEditingController> nosControllers = [];
  final List<TextEditingController> totalControllers = [];
  final List<TextEditingController> productsaleController = [];

  @override
  void initState() {
    super.initState();
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
    setState(() {
      nosControllers.add(TextEditingController());
      totalControllers.add(TextEditingController());
    });
  }

  void removeRow(int index) {
    setState(() {
      nosControllers.removeAt(index);
      totalControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < nosControllers.length; i++)
          Column(
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
                        onTap: () {
                          // Scan QR code
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>const BarcodeApp()));
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
                            nosControllers[i].text = '1';
                            totalControllers[i].text =
                                (value!.price * int.parse(nosControllers[i].text));
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
                        controller: nosControllers[i],
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
                        onChanged: (value) {
                          setState(() {
                            totalControllers[i].text =
                                (double.parse(value) * int.parse(nosControllers[i].text)).toStringAsFixed(2);
                          });
                        },
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
                        controller: totalControllers[i],
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
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
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
                        removeRow(i);
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
              const SizedBox(height: 10), // Add gap between rows
            ],
          ),
        const SizedBox(height: 1), // Add gap between columns
      ],
    );
  }
}
