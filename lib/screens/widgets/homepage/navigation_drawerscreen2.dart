import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_card.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_controller.dart'; // Import the provided controller class

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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Businuess Profile'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BusinessCard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('About Us'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BusinessCard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Privacy'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BusinessCard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Terms'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BusinessCard()));
            },
          ),
          ListTile(
            //leading: const Icon(Icons.content_paste),
            title: const Text('Version 1.0'),
            onTap: () {
              
            },
          )
        ],
      ));
}
