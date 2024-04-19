import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/hive_services.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/new_customesales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_create_dynamicwidget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:provider/provider.dart';

class AddSales extends StatefulWidget {
  final SalesModel? sales;

  const AddSales({Key? key, this.sales}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  TextEditingController _customerController = TextEditingController();
  // double grandTo tal = 0;

  @override
  void initState() {
    super.initState();
    // Provider.of<SalesControllerState>(context, listen: false).addRow();
    if (widget.sales != null) {
      _customerController.text = widget.sales!.customer;
      // selectedProducts.addAll(widget.sales!.products);
    }
  }

  @override
  Widget build(BuildContext context) {
    final salesState = Provider.of<SalesControllerState>(context);
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ListSales()));
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
                items: salesState.customers.map((customer) {
                  return DropdownMenuItem<CustomerModel>(
                    value: customer,
                    child: Text(customer.name),
                  );
                }).toList(),
                onChanged: (CustomerModel? value) {
                  _customerController =
                      TextEditingController(text: value!.name);
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

            //Create new Customer if customer is not available to select from dropdown.
            AddcustomerSale(),

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
            const AddSalesDynamic(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool canCreateSale = true;
                  for (int i = 0; i < salesState.selectedProducts.length; i++) {
                    final selectedProduct = salesState.selectedProducts[i];
                    final quantity = int.parse(selectedProduct.nos);
                    final products =
                        await hiveProducts(); // Using the hiveProducts function

                    final product = products.firstWhere(
                      (product) => product.name == selectedProduct.name,
                      //orElse: () => null,
                    );
                    // ignore: unnecessary_null_comparison
                    if (product == null) {
                      // Product not found in the database
                      canCreateSale = false;
                      break;
                    }
                    final availableStock = int.parse(product.stock);
                    if (quantity > availableStock) {
                      // Show a snackbar with the error message
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No stock available for some products'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break; // Exit loop if any product has insufficient stock
                    }
                    if (quantity == 0) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Remove products with zero stock'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break; // Exit loop if any product has zero stock
                    }
                  }

                  if (canCreateSale) {
                    await salesState.createSales(_customerController.text);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Sale created successfully!'),
                      backgroundColor: Colors.green,
                    ));
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListSales()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B4B87),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
}
