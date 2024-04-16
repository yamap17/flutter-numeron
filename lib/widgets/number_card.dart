import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({
    super.key,
    this.height = 80,
    this.fontSize = 45,
    this.splashColor = const Color.fromARGB(255, 222, 206, 251),
    this.number,
    required this.onTap,
  });

  final double height;
  final double fontSize;
  final Color splashColor;
  final int? number;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      alignment: Alignment.center,
      child: Card(
          margin: const EdgeInsets.all(5),
          elevation: 5,
          child: InkWell(
            splashColor: splashColor,
            onTap: onTap,
            child: SizedBox(
              height: 80,
              width: 50,
              child: Text(
                number == null ? '?' : number.toString(),
                style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: 'Jersey_10',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}
