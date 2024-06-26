import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddSalesDynamic extends StatefulWidget {
  const AddSalesDynamic({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesDynamicState createState() => _AddSalesDynamicState();
}

class _AddSalesDynamicState extends State<AddSalesDynamic> {
  final List<ProductModel> products = [];

  double grandTotal = 0;

  @override
  void initState() {
    super.initState();
    loadProducts();
    //addRow();
  }

  Future<void> loadProducts() async {
    final productBox = await Hive.openBox<ProductModel>('product_db2');
    setState(() {
      products.addAll(productBox.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    final salesState = Provider.of<SalesControllerState>(context);
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: salesState.selectedProducts.length,
            itemBuilder: (b, i) {
              return productIncrement(i, salesState);
            }),

        // for (int i = 0; i < salesState.selectedProducts.length; i++)
        //   productIncrement(i, salesState),
        const SizedBox(height: 10), // Add gap between rows
        buildGrandTotalField(salesState), // Add grand total field
      ],
    );
  }

  Widget buildGrandTotalField(SalesControllerState salesState) {
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
            readOnly: true,
            controller: salesState.grandTotalController,
            decoration: InputDecoration(
              hintText: "Grand Total",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
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
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget productIncrement(int i, SalesControllerState state) {
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
                      );

                      // Set the scanned product in the dropdown
                      setState(() {
                        // selectedProducts1[i] = scannedProduct;
                        // Update other fields as necessary
                        // For example, if you want to set the quantity to 1:
                        state.nosControllers[i].text = '1';
                        double price1 = double.parse(scannedProduct.price);
                        state.totalControllers[i].text = price1.toString();
                        // updateGrandTotal();
                      });
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
                      child: Text(
                        product.name,
                        textScaleFactor: .7,
                        overflow: TextOverflow.clip,
                      ),
                    );
                  }).toList(),
                  onChanged: (ProductModel? value) {
                    double price1 = double.parse(value!.price);

                    state.selectedProducts[i] = ProductSale(
                        name: value.name, nos: '1', total: value.price);

                    state.nosControllers[i].text = '1';

                    int nos1 = int.parse(state.nosControllers[i].text);
                    state.totalControllers[i].text = (nos1 * price1).toString();
                    state.updateGrandTotal();
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
                  controller: state.nosControllers[i],
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
                    //  final ProductModel? selectedProduct = state. selectedProducts[i];
                    int nos1 = int.parse(state.nosControllers[i].text);
                    final double price1 =
                        double.parse(state.selectedProducts[i].total);
                    final double newTotalPrice = price1 * nos1;
                    state.totalControllers[i].text = newTotalPrice.toString();
                    //  widget.getNos(i, nos1);
                    //  widget.getTotal(i, newTotalPrice);
                    state.updateGrandTotal();
                    // widget.getGrandTotal(grandTotal);
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
                  controller: state.totalControllers[i],
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
                  onChanged: (_) => state.updateGrandTotal(),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  state.addRow();
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
                  state.removeRow(i);
                  // updateGrandTotal();
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
    );
  }
}