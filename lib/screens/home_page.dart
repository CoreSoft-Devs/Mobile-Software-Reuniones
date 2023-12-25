import 'package:core_soft_meeting/config/constants/index.dart';
import 'package:core_soft_meeting/widgets/build_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home Page', style: TextStyle(color: white)),
          iconTheme: const IconThemeData(color: white),
          backgroundColor: black),
      drawer: const BuildDrawer(),
      body: const Center(
        child: Text('Pagina Principal'),
      ),
    );
  }
}
