import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:project_fourth/screens/widgets/product_module/update_product.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNull(bool Function(T) test) {
    for (final element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  String result = '';
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _allProducts = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    initializeHive();
    _allProducts = productListNotifier.value;
    _categories = _getAllCategories();
  }

  List<String> _getAllCategories() {
    Set<String> categories = Set();
    for (var product in _allProducts) {
      categories.add(product.category);
    }
    return categories.toList();
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
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
                deleteProducts(id);
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
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
          'Product List',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(initialIndex: 0),
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
        actions: [
          IconButton(
            onPressed: _showCategoryFilterDialog,
            icon: const Icon(
              Icons.filter_list,
              color: Color(0xFF4B4B87), // Set icon color here
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
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
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  filterProducts(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValueListenableBuilder<List<ProductModel>>(
                valueListenable: productListNotifier,
                builder: (context, products, _) {
                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        'Product List is Empty',
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
                        final product = products[index];
                        return Container(
                          height: 90,
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
                                  bottom:
                                      10), // Adjust the top padding as needed
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: product.image != null
                                    ? FileImage(File(product.image!))
                                    : const AssetImage(
                                            'lib/assets/app_icon.png')
                                        as ImageProvider<Object>?,
                              ),
                            ),
                            title: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            padding: const EdgeInsets.only(
                                                top: 20, right: 8),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateProducts(
                                                            product: product),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0XFF98B5FF),
                                                  borderRadius:
                                                      BorderRadius.circular(6),
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
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: GestureDetector(
                                            onTap: () {
                                              showDeleteConfirmationDialog(
                                                  product.id!);
                                            },
                                            child: Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                color: const Color(0XFFFA3E3E),
                                                borderRadius:
                                                    BorderRadius.circular(6),
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
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Price: ${product.price}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        'Stock: ${product.stock}',
                                        style: const TextStyle(
                                          fontSize: 14,
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
                      itemCount: products.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'Scan Button',
              shape: const CircleBorder(),
              onPressed: () async {
                var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ),
                );
                if (res is String) {
                  setState(() {
                    result = res;
                  });
                  filterProducts(_searchController.text);
                }
              },
              child: const ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: ImageIcon(AssetImage('lib/assets/scan1.png')),
              ),
            ),
            const SizedBox(width: 12),
            FloatingActionButton(
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'New Product',
              shape: const CircleBorder(),
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AddProducts()));
              },
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  void filterProducts(String value) {
    if (value.isEmpty) {
      // If search text is empty, restore all products
      productListNotifier.value = _allProducts;
      return;
    }

    // Check if the scanned result matches any product code
    ProductModel? scannedProduct;
    if (result.isNotEmpty) {
      scannedProduct = _allProducts.firstWhereOrNull(
        (product) => product.code == result,
      );
    }

    // Filter products based on the entered text
    List<ProductModel> filteredProducts = _allProducts.where((product) {
      return product.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    // If the scanned product is found, show only that product
    if (scannedProduct != null) {
      filteredProducts = [scannedProduct];
    }

    // Update the ValueListenable with the filtered products
    productListNotifier.value = filteredProducts;
  }

  void _showCategoryFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF1F5F9), // Set background color here
          title: const Text('Filter by Category'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Clear All'),
                  onTap: () {
                    productListNotifier.value = _allProducts;
                    Navigator.pop(context);
                  },
                ),
                ..._categories.map(
                  (category) => ListTile(
                    title: Text(category),
                    onTap: () {
                      filterProductsByCategory(category);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void filterProductsByCategory(String category) {
    List<ProductModel> filteredProducts =
        _allProducts.where((product) => product.category == category).toList();
    productListNotifier.value = filteredProducts;
  }
}
