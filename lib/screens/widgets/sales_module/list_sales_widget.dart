
import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/add_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

class ListSales extends StatefulWidget {
  const ListSales({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListSalesState createState() => _ListSalesState();
}

class _ListSalesState extends State<ListSales> {
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();
  List<SalesModel> _allSales = [];

  @override
  void initState() {
    super.initState();
    // Initialize Hive when the widget is first initialized
    initializeHiveSales();
    _allSales = salesListNotifier.value; // Store all products initially
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content:
              const Text("Are you sure you want to delete this sales entry?"),
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
                    content: Text('Sales deleted successfully!'),
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
          'Sales List',
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
                  // Filter products based on the entered text
                  filterSales(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValueListenableBuilder<List<SalesModel>>(
                valueListenable: salesListNotifier,
                builder: (context, sales, _) {
                  if (sales.isEmpty) {
                    return const Center(
                      child: Text(
                        'Sales List is Empty',
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
                        final sale = sales[index];
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
                            leading:const Padding(
                              padding:  EdgeInsets.only(
                                  top: 10), // Adjust the top padding as needed
                              child: CircleAvatar(
                                radius: 26,
                                
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 18),
                                  child: Text(
                                    sale.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Hero(
                                      tag: 'edit_icon_${sale.id}',
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, right: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSales(
                                                        sales: sale),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: const Color(0XFF98B5FF),
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
                                      padding: const EdgeInsets.only(top: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          showDeleteConfirmationDialog(
                                              sale.id!);
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
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 14),
                      itemCount: sales.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 12), // Add space between the buttons
            FloatingActionButton(
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'New Sales',
              shape: const CircleBorder(),
              onPressed: () {
                //Add sales page navigation
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const AddSales()));
              },
              child: const Icon(Icons.percent_outlined,
                  color: Colors.white, size: 28),
            ),
          ],
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

  void filterSales(String value) {
    if (value.isEmpty) {
      // If search text is empty, restore all Sales
      salesListNotifier.value = _allSales;
      return;
    }
    // Filter Sales based on the entered text
    List<SalesModel> filteredSales = _allSales.where((sales) {
      return sales.name.toLowerCase().contains(value.toLowerCase());
    }).toList();
    // Update the ValueListenable with the filtered Sales
    salesListNotifier.value = filteredSales;
  }
}
