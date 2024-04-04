import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/barcode_scanscreen.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';

class OutofStock extends StatefulWidget {
  const OutofStock({Key? key}) : super(key: key);

  @override
  _OutofStockState createState() => _OutofStockState();
}

class _OutofStockState extends State<OutofStock> {
  @override
  void initState() {
    super.initState();
    // Initialize Hive when the widget is first initialized
    initializeHive();
  }

  Future<void> showDeleteConfirmationDialog(ProductModel pro) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                if (pro.id != null) {
                  deleteProducts(pro.id!);
                } else {
                  const Text('Product ID is null, unable to delete');
                }
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Out of Stock List',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const HomePage()));
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ValueListenableBuilder<List<ProductModel>>(
          valueListenable: productListNotifier,
          builder: (context, products, _) {
            final outOfStockProducts = products.where((product) => product.stock == null || product.stock == "0").toList();
            if (outOfStockProducts.isEmpty) {
              return const Center(
                child: Text(
                  'No Products Out of Stock',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(137, 0, 0, 0),
                  ),
                ),
              );
            } else {
              return ListView.separated(
                itemBuilder: (ctx, index) {
                  final product = outOfStockProducts[index];
                  return Container(
                    height: 85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(
                            top: 10), // Adjust the top padding as needed
                        child: CircleAvatar(
                          radius: 26,
                          backgroundImage: product.image != null
                              ? FileImage(File(
                                  product.image!)) // Load image from file path
                              : const AssetImage('lib/assets/app_icon.png')
                                  as ImageProvider<Object>?,
                        ),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Hero(
                                tag: 'edit_icon_${product.id}',
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddProducts(product: product),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: const Color(0XFF98B5FF),
                                        borderRadius: BorderRadius.circular(6),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'lib/assets/edit1.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    showDeleteConfirmationDialog(product);
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: const Color(0XFFFA3E3E),
                                      borderRadius: BorderRadius.circular(6),
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'lib/assets/delete1.png'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 14),
                itemCount: outOfStockProducts.length,
                

              );
            }
          },
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Home1.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Customers1.png'),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Categories1.png'),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Product1.png'),
            label: 'Products',
          ),
        ],
        selectedItemColor: const Color(0xFF4B4B87),
        unselectedItemColor: const Color.fromARGB(255, 121, 119, 119),
        currentIndex: 3,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ListCustomer()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ListCategories()));
              break;
            case 3:
              // Navigate to products page
              break;
          }
        },
      ),
    );
  }
}
