import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_card.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/outofstock_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BusinessCard()));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 40,
            height: 40,
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
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                //Expanded model for cards
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListCategories()));
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
                            const Positioned(
                              left:
                                  80, // Adjust left position to align with circle
                              top: 10, // Adjust top position for alignment
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Categories',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(height: 20), // Add some spacing
                                  Text(
                                    '8',
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListProducts()));
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
                            const Positioned(
                              left:
                                  80, // Adjust left position to align with circle
                              top: 10, // Adjust top position for alignment
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Total Products',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(height: 20), // Add some spacing
                                  Text(
                                    '25',
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ListCustomer()));
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
                            const Positioned(
                              left:
                                  80, // Adjust left position to align with circle
                              top: 10, // Adjust top position for alignment
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Customers',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(height: 20), // Add some spacing
                                  Text(
                                    '100',
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
                            const Positioned(
                              left:
                                  80, // Adjust left position to align with circle
                              top: 10, // Adjust top position for alignment
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 15),
                                  Text(
                                    'Out Of Stock',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                  SizedBox(height: 20), // Add some spacing
                                  Text(
                                    '3',
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
                    // Add the page navigation to Out of stock page
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
            SizedBox(
              width: 358,
              height: 258,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 128,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..translate(0.0, 0.0)
                        ..rotateZ(-1.57),
                      child: const Text(
                        'Sales',
                        style: TextStyle(
                          color: Color(0xFF4B4B87),
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 140,
                    top: 241,
                    child: Text(
                      'Customers',
                      style: TextStyle(
                        color: Color(0xFF4B4B87),
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 27,
                    top: 205,
                    child: Text(
                      '0',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 50,
                    top: 223,
                    child: Text(
                      'Customer 1',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 130,
                    top: 223,
                    child: Text(
                      'Customer 2',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 210,
                    top: 223,
                    child: Text(
                      'Customer 3',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 290,
                    top: 223,
                    child: Text(
                      'Customer 4',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 29,
                    top: 164,
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    top: 123,
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    top: 82,
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 27,
                    top: 41,
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28,
                    top: 0,
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 8,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 49,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 90,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 131,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 172,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 40,
                    top: 213,
                    child: Container(
                      width: 318,
                      decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 1,
                            strokeAlign: BorderSide.strokeAlignCenter,
                            color: Color(0xFFE2E2E2),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 63,
                    top: 7,
                    child: Container(
                      width: 30,
                      height: 206,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF6659FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 143,
                    top: 48,
                    child: Container(
                      width: 30,
                      height: 165,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFB9EAFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 223,
                    top: 130,
                    child: Container(
                      width: 30,
                      height: 83,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFBEADFF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 303,
                    top: 130,
                    child: Container(
                      width: 30,
                      height: 83,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEB77FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
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
        currentIndex: 0, // Set the initial selected item index
        onTap: (int index) {
          // Handle navigation when items are tapped
          switch (index) {
            case 0:
              // Navigate to home page
              break;
            case 1:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListCustomer()));
              break;
            case 2:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListCategories()));
              break;
            case 3:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ListProducts()));
              break;
          }
        },
      ),
    );
  }
}
