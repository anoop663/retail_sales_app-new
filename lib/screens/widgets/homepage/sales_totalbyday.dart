import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

class SalesDropdownAndTotal extends StatefulWidget {
  const SalesDropdownAndTotal({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalesDropdownAndTotalState createState() => _SalesDropdownAndTotalState();
}

class _SalesDropdownAndTotalState extends State<SalesDropdownAndTotal> {
  String dropdownValue = 'Today'; // Initial dropdown value
  double totalGrandFuture = 0.0; // Initial total sales value

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
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  calculateTotalSales(newValue);
                }
              },
              style:const TextStyle(color: Colors.black), // Dropdown text color
              icon:const Icon(Icons.arrow_drop_down), // Dropdown icon
              underline:const SizedBox(), // Remove underline
              items: <String>['Today', 'Yesterday']
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
                    Positioned(
                      left: 80,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Sales',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '₹ ${totalGrandFuture.toString()}',
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
    );
  }

  void calculateTotalSales(String newValue) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    double totalSales = 0;
    final salesBox = await Hive.openBox<SalesModel>('sales_db');

    // Iterate through each sales model to calculate total sales based on the selected time frame
    for (final sale in salesBox.values) {
      if (newValue == 'Today') {
        // Check if the sale was made today
        if (isSameDay(sale.createddate!, today)) {
          totalSales += double.parse(sale.grand);
        }
      } else if (newValue == 'Yesterday') {
        // Check if the sale was made yesterday
        if (isSameDay(sale.createddate!, yesterday)) {
          totalSales += double.parse(sale.grand);
        }
      }
    }

    setState(() {
      totalGrandFuture = totalSales;
    });
  }

  // Function to check if two dates are on the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
