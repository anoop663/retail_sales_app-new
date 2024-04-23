import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_controller.dart'; // Import the provided controller class
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_screen.dart';

class MyDrawer2 extends StatefulWidget {
  const MyDrawer2({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyDrawer2State createState() => _MyDrawer2State();
}

class _MyDrawer2State extends State<MyDrawer2> {
  final BusinussController _businessController = BusinussController();

  @override
  void initState() {
    super.initState();
    _businessController.getAllBusines();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFFF1F5F9),
        child:
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 8, right: 8),
              child: ValueListenableBuilder<List<RetailModel2>>(
                valueListenable: _businessController.businessListNotifier,
                builder: (context, businessList, _) {
                  // ignore: avoid_print
                  print('Business length: ${businessList.length}');
                  if (businessList.isEmpty) {
                    // ignore: sized_box_for_whitespace
                    return Container(
                      height: 20,
                      width: 20,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BusinessProfile(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor:
                              const Color(0xFFF1F5F9), // Background color
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10, // Adjust horizontal padding
                            vertical: 5, // Adjust vertical padding
                          ),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            'Create New Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (ctx, index) {
                        final business = businessList[index];
                        return Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF6968),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 10, left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     const Text(
                                      'Retail Sales Helper App',
                                      style:  TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                       
                                      ),
                                    ),
                                    Text(
                                      'Business Name: ${business.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Phone: ${business.phone}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Address: ${business.address}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessProfile(business: business),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    backgroundColor:
                                        const Color(0XFF4B4B87), // Background color
                                  ),
                                  child: Container(
                                    width: 80,
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1,
                                        vertical: 1), // Adjust padding here
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Update',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 14),
                      itemCount: 1,
                    );
                  }
                },
              ),
            ),
      ),
    );
  }
}
