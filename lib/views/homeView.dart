import 'package:flutter/material.dart';
import 'package:local_storage_app_theme/views/theme/services.dart';

import '../customWidgets/myAppBar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: myAppBar('Home'),
      body: const Center(
        child: Text('Home View',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      ),
    );
  }
}
