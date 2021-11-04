import 'package:flutter/material.dart';

class SecondWeatherBox extends StatelessWidget {
  final IconData iconData;
  final String label;
  SecondWeatherBox({@required this.iconData, @required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          iconData,
          size: 35.0,
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(label, style: TextStyle(fontSize: 20.0)),
      ],
    );
  }
}
