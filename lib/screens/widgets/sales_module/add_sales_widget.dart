import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_create_dynamicwidget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart'; // Assuming SalesModel is imported from an external file

class AddSales extends StatefulWidget {
  final SalesModel? sales;

  const AddSales({Key? key, this.sales}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _grandTotalController = TextEditingController();
  final List<ProductModel> products = [];
  final List<TextEditingController> nosControllers = [];
  final List<TextEditingController> totalControllers = [];
  final List<ProductModel?> selectedProducts = [];
  double grandTotal = 0;
  final TextEditingController grandTotalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.sales != null) {
      _customerController.text = widget.sales!.customer;
      // _nameController.text = widget.sales!.name;
      // _phoneController.text = widget.sales!.phone;
      // _addressController.text = widget.sales!.address;
      _grandTotalController.text = widget.sales!.grand;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CustomerModel>('customer_db'),
      builder: (context, AsyncSnapshot<Box<CustomerModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final customerBox = snapshot.data!;
          final customers = customerBox.values.toList();

          return FutureBuilder(
            future: Hive.openBox<ProductModel>('product_db2'),
            builder: (context, AsyncSnapshot<Box<ProductModel>> snapshot1) {
              if (snapshot1.connectionState == ConnectionState.done) {
                final productBox = snapshot1.data!;
                // ignore: unused_local_variable
                final products = productBox.values.toList();

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
                                builder: (context) => const ListSales()));
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
                              // Do something with the selected category
                              // ignore: avoid_print
                              print('Selected Customer: ${value?.name}');
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
                        //New Customer creation part if the customer is not in Dropdown
                        // AddcustomerSale(),
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
                        AddSalesDynamic(),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (widget.sales != null) {
                                widget.sales!.customer =
                                    _customerController.text;

                                // Assuming other fields like nos, total, grand are managed in the dynamic widget

                                await updateSales(widget.sales!);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Sales updated successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } else {
                                SalesModel sales = SalesModel(
                                  customer: _customerController.text,
                                  grand: _grandTotalController.text,
                                  products: [],
                                  // Assuming other fields like nos, total, grand are managed in the dynamic widget
                                );
                                await createSales(sales);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Sales created successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              }
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ListSales()),
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
              } else {
                // Show loading indicator while fetching product data
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        } else {
          // Show loading indicator while fetching customer data
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
