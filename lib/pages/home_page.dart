import 'package:admob_tutorial_app/widget/banner_Ad_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Column(
        children: [
          Center(
            child: Text('Welcome to the Home Page!'),
          ),
          Column(
  children: [
    // Your content
    const SizedBox(height: 20),
    const BannerAdWidget(),
  ],
)
        ],
      )  ,
      
    );
  }
}