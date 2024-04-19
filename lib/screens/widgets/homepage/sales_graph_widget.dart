import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';

class SalesGraphWidgetBackup1 extends StatefulWidget {
  const SalesGraphWidgetBackup1({Key? key}) : super(key: key);

  @override
  _SalesGraphWidgetBackupState1 createState() => _SalesGraphWidgetBackupState1();
}

class _SalesGraphWidgetBackupState1 extends State<SalesGraphWidgetBackup1> {
  List<SalesGraphModel> salesDataList = [];
  double maxValue = 0;

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }

  Future<void> loadSalesData() async {
    final box = await Hive.openBox<SalesGraphModel>('graph_db');
    setState(() {
      salesDataList = box.values.toList();
      // Calculate the maximum sales value
      maxValue = salesDataList.isNotEmpty
          ? salesDataList.map((data) => double.parse(data.salesValue)).reduce((value, element) => value > element ? value : element)
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          // Render customer names dynamically
          for (int i = 0; i < salesDataList.length; i++)
            Positioned(
              left: 27 + 80 * i.toDouble(), // Adjust position dynamically
              top: 223,
              child: Text(
                salesDataList[i].customerName,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          // Render sales values dynamically
          for (int i = 0; i < salesDataList.length; i++)
            Positioned(
              left: 27 + 80 * i.toDouble(), // Adjust position dynamically
              top: 205 - (180 * double.parse(salesDataList[i].salesValue) / maxValue),
              child: Text(
                salesDataList[i].salesValue.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ),
          // Render horizontal lines
          for (int i = 0; i < 6; i++)
            Positioned(
              left: 40,
              top: 8 + 41 * i.toDouble(),
              child: Container(
                width: 318,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: Color(0xFFE2E2E2),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
