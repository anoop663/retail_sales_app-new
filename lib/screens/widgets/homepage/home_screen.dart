import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/sales_graph_widget.dart';
import 'package:provider/provider.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/homepage/navigation_drawerscreen2.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/outofstock_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/add_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Load counts from shared preferences when the home page is opened
    Provider.of<CountProvider>(context, listen: false).loadCounts();
  }

  @override
  Widget build(BuildContext context) {
    // Obtain the counts from the CountProvider

    final _catCount = Provider.of<CountProvider>(context).catCount;
    final _productCount = Provider.of<CountProvider>(context).proCount;
    final _outofstockCount = Provider.of<CountProvider>(context).outCount;
    final _customerCount = Provider.of<CountProvider>(context).custCount;

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
                                  _catCount.toString(),
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
                                  _productCount.toString(),
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
                                  _customerCount.toString(),
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
                                  _outofstockCount.toString(),
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
          SizedBox(
            height: 30, // Set the desired height here
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButton<String>(
                value: 'This Week',
                onChanged: (String? newValue) {
                  // Implement onChanged function to handle dropdown value changes
                  // You can navigate or update state based on the selected value
                },
                items: <String>['This Week', 'This Month']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ListSales(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: double.infinity, // Remove the height property here
                  decoration: ShapeDecoration(
                    color: const Color(0xFF2AC3FF),
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
                            color: Color(0xFF38D3FD),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset('lib/assets/Vector5.png'),
                        ),
                      ),
                      const Positioned(
                        left: 80, // Adjust left position to align with circle
                        top: 10, // Adjust top position for alignment
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              'Sales',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                            SizedBox(height: 20), // Add some spacing
                            Text(
                              '₹324',
                              style: TextStyle(
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
          const SizedBox(height: 20),
          const SalesGraphWidget()
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
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
