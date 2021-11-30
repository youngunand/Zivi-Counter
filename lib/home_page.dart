import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zivi_counter_app/drawer_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences _sharedPreferences;

  double size = 300;
  double screenWidth = 1;
  double screenHeight = 1;
  double borderRadius = 20;
  double pi = 3.14;
  double progress = 1;
  int daysLeft = 1;

  int progressPercentage = 0;

  var rect;

  TextStyle numberStyle = TextStyle(fontSize: 50, color: Colors.orange[500]);
  TextStyle baseStyle = TextStyle(fontSize: 20, color: Colors.orange[500]);
  TextStyle descriptionStyle = TextStyle(fontSize: 12, color: Colors.grey[400]);

  double calculateProgress(DateTime startDate, int duration, DateTime endDate) {
    final totalDays =
        DateTimeRange(start: startDate, end: endDate).duration.inDays;
    progress = (totalDays - daysLeft) / totalDays;
    return progress;
  }

  int calculateProgressPercentage(double progress) {
    progressPercentage = (progress * 100).round();
    return progressPercentage;
  }

  DateTime getStartDate() {
    final startDate;
    if (_sharedPreferences.getInt('startDate') != null) {
      startDate = DateTime.fromMillisecondsSinceEpoch(
          _sharedPreferences.getInt('startDate')!);
    } else {
      startDate = DateTime(2021, 8, 1);
    }
    return startDate;
  }

  int getDuration() {
    final duration;
    if (_sharedPreferences.getInt('duration') != null) {
      duration = _sharedPreferences.getInt('duration') ?? 9;
    } else {
      duration = 9;
    }
    return duration;
  }

  void initDates() {
    final startDate = getStartDate();
    final duration = getDuration();
    final endDate = DateTime(startDate.year, startDate.month + duration);
    daysLeft = -DateTime.now().difference(endDate).inDays;
    progress = calculateProgress(startDate, duration, endDate);
    progressPercentage = calculateProgressPercentage(progress);
    //rebuild UI to show correct values
    setState(() {});
  }

  void initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    initDates();
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).shadowColor,
        title: Text(
          'Zivi-Countdown',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              height: 1.2 * size,
              width: 1.2 * size,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                          colors: [
                            Theme.of(context).focusColor,
                            Theme.of(context).accentColor
                          ],
                          stops: [progress, progress],
                          startAngle: pi * 3 / 2,
                          endAngle: pi * 7 / 2,
                          tileMode: TileMode.repeated,
                          center: Alignment.center,
                        ).createShader(rect);
                      },
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.5 * size),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 0.8 * size,
                      width: 0.8 * size,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0.4 * size),
                          color: Theme.of(context).shadowColor),
                      child: Text(
                        '$daysLeft',
                        style: numberStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.6 * size,
              width: 1.2 * size,
              decoration: BoxDecoration(
                  color: Theme.of(context).shadowColor,
                  borderRadius: BorderRadius.circular(borderRadius)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 0.4 * screenWidth,
                    height: 0.25 * screenHeight,
                    alignment: Alignment.center,
                    child: Text(
                      '$progressPercentage%',
                      style: numberStyle,
                    ),
                  ),
                  VerticalDivider(
                    indent: 20,
                    endIndent: 20,
                    color: Theme.of(context).accentColor,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    height: 0.25 * screenHeight,
                    width: 0.4 * screenWidth,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'noch:',
                            style: descriptionStyle,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '3 Monate',
                                style: baseStyle,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('15 Tage', style: baseStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: DrawerContent(),
      ),
    );
  }
}
