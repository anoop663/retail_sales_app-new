import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_product_widget.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/home_notselec.png'),
            activeIcon: Image.asset('lib/assets/Home1.png'), // Different icon for selected state
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Customers1.png'),
            activeIcon: Image.asset('lib/assets/cust_select.png'), // Different icon for selected state
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Categories1.png'),
            activeIcon: Image.asset('lib/assets/cat_select.png'), // Different icon for selected state
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Product1.png'),
            activeIcon: Image.asset('lib/assets/prod_select.png'), // Different icon for selected state
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomePage()));
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
