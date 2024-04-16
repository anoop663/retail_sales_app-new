import 'package:flutter/material.dart';

class SalesData {
  final String customerName;
  final double salesValue;

  SalesData(this.customerName, this.salesValue);
}

class SalesGraphWidget extends StatelessWidget {
  final List<SalesData> salesDataList;

  const SalesGraphWidget({Key? key, required this.salesDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxValue = 0;
    for (var data in salesDataList) {
      if (data.salesValue > maxValue) {
        maxValue = data.salesValue;
      }
    }

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
              top: 205 - (180 * salesDataList[i].salesValue / maxValue),
              child: Text(
                salesDataList[i].salesValue.toStringAsFixed(0),
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
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFE2E2E2),
                    ),
                  ),
                ),
              ),
            ),
          // Render colored bars
          for (int i = 0; i < salesDataList.length; i++)
            Positioned(
              left: 63 + 80 * i.toDouble(), // Adjust position dynamically
              top: 7,
              child: Container(
                width: 30,
                height: 206 * salesDataList[i].salesValue / maxValue,
                decoration: ShapeDecoration(
                  color: Color(0xFF6659FF), // You can use different colors here
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
