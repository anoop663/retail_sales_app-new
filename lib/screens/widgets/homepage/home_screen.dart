import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/sales_graph_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/sales_totalbyday.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:provider/provider.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/homepage/navigation_drawerscreen2.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/outofstock_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/add_sales_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var totalGrandFuture;
  String dropdownValue = 'This Week';

  @override
  void initState() {
    super.initState();
    calculateTotalGrandHive().then((value) {
      setState(() {
        totalGrandFuture = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context);
    // Obtain the counts from the CountProvider
    countProvider.loadCounts();

    final catCount = Provider.of<CountProvider>(context).catCount;
    final productCount = Provider.of<CountProvider>(context).proCount;
    final outofstockCount = Provider.of<CountProvider>(context).outCount;
    final customerCount = Provider.of<CountProvider>(context).custCount;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold, // Make text bold
          ),
        ),
        centerTitle: true,
        leading: Builder(
          // Wrap leading with Builder
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              width: 40,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('lib/assets/Vector1.png'),
                ),
              ),
            ),
          ),
        ),
      ),
      drawer: const MyDrawer2(), // Use MyDrawer as the drawer

      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Column(children: [
          Row(
            children: [
              //Expanded model for cards
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigation(initialIndex: 1),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF6968),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 10,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF8280),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('lib/assets/Vector2.png'),
                            ),
                          ),
                          Positioned(
                            left:
                                80, // Adjust left position to align with circle
                            top: 10, // Adjust top position for alignment
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'Categories',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 20), // Add some spacing
                                Text(
                                  catCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigation(initialIndex: 3),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF7A54FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 10,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFF926AFF),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('lib/assets/Vector3.png'),
                            ),
                          ),
                          Positioned(
                            left:
                                80, // Adjust left position to align with circle
                            top: 10, // Adjust top position for alignment
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'Total Products',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 20), // Add some spacing
                                Text(
                                  productCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomNavigation(initialIndex: 2),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF8F61),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 10,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFEA776),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('lib/assets/Vector4.png'),
                            ),
                          ),
                          Positioned(
                            left:
                                80, // Adjust left position to align with circle
                            top: 10, // Adjust top position for alignment
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'Customers',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 20), // Add some spacing
                                Text(
                                  customerCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OutofStock()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 120,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFF61C0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 16,
                            top: 10,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF8DDF),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('lib/assets/Vector3.png'),
                            ),
                          ),
                          Positioned(
                            left:
                                80, // Adjust left position to align with circle
                            top: 10, // Adjust top position for alignment
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'Out Of Stock',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                                const SizedBox(height: 20), // Add some spacing
                                Text(
                                  outofstockCount.toString(),
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SalesDropdownAndTotal(),
          const SizedBox(height: 20),
          const SalesGraphWidgetBackup1(),
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: generateRandomString(1),
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'Sales Button',
              shape: const CircleBorder(),
              onPressed: () {
                //Need to Add Navigation to Sale create Page
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddSales()));
              },
              child: const Icon(Icons.percent, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12), // Add space between the buttons
            FloatingActionButton(
              heroTag: generateRandomString(2),
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'New Product',
              shape: const CircleBorder(),
              onPressed: () {
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
}
