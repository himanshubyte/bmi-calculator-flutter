import 'package:flutter/material.dart';
import 'constants.dart';

// ignore: camel_case_types
class bottomContainer extends StatelessWidget {
  bottomContainer({@required this.label, @required this.ontap});

  final Function ontap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 10.0),
        height: kBottomContainerHeight,
        width: double.infinity,
      ),
    );
  }
}
