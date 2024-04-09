import 'package:flutter/material.dart';

class SalesGraphWidget extends StatefulWidget {
  const SalesGraphWidget({Key? key}) : super(key: key);

  @override
  _SalesGraphWidgetState createState() => _SalesGraphWidgetState();
}

class _SalesGraphWidgetState extends State<SalesGraphWidget> {
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
                  borderRadius: BorderRadius.circular(4),
                ),
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
                  borderRadius: BorderRadius.circular(4),
                ),
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
                  borderRadius: BorderRadius.circular(4),
                ),
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
