import 'package:flutter/material.dart';

class MatchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        children: List.generate(
          10,
          (index) {
            return Container(
              margin: EdgeInsets.all(8),
              color: Colors.blue,
              child: Image.asset(
                'assets/images/img_1.jpeg',
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
