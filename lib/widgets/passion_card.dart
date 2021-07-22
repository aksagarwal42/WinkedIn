import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PassionCard extends StatelessWidget {
  PassionCard({required this.passion});
  final String passion;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8, bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(passion,),
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white),
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
    );
  }
}
