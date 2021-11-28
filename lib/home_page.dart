import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double size = 300;
  double pi = 3.14;
  var rect;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zivi-Countdown'),
      ),
      body: Center(
          child: Container(
        height: 300,
        width: 300,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return SweepGradient(
                  colors: [Colors.indigo, Colors.transparent],
                  stops: [0.75, 0.75],
                  startAngle: pi * 3 / 4,
                  endAngle: pi * 11 / 4,
                  tileMode: TileMode.repeated,
                  center: Alignment.center,
                ).createShader(rect);
              },
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(150),
                    color: Colors.white),
              ),
            ),
            Center(
              child: Container(
                height: 0.8 * size,
                width: 0.8 * size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.4 * size),
                    color: Colors.white),
                child: Text('200'),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Co {}
