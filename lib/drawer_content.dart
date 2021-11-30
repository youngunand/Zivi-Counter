import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerContent extends StatefulWidget {
  @override
  _DrawerContentState createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  late SharedPreferences _sharedPreferences;

  DateTime selectedStartDate = DateTime.now();
  int? selectedDuration = 9;

  double screenWidth = 1;
  double screenHeight = 1;

  List<DropdownMenuItem<int>> dropdownMenuItems = [];

  TextStyle drawerHeaderStyle = TextStyle(fontSize: 21, color: Colors.white);

  TextStyle drawerStyle = TextStyle(fontSize: 19, color: Colors.white);

  void buildDropDownMenuItems() {
    for (int i = 1; i < 13; i++) {
      final item = DropdownMenuItem<int>(
          value: i,
          child: Text(
            '$i',
            style: drawerStyle,
          ));
      dropdownMenuItems.add(item);
    }
  }

  void showDurationSelectorDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              color: Theme.of(context).canvasColor,
              height: 0.3 * screenHeight,
              width: 0.8 * screenWidth,
              padding: EdgeInsets.all(15),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<int>(
                          items: dropdownMenuItems,
                          value: selectedDuration,
                          onChanged: (value) {
                            selectedDuration = value;
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Monate',
                          style: drawerStyle,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.check_circle_outline_outlined),
                      onPressed: () {
                        Navigator.of(context).pop();

                        _sharedPreferences.setInt(
                            'duration', selectedDuration!);
                      },
                      color: Theme.of(context).focusColor,
                      iconSize: 35,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    buildDropDownMenuItems();
    initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      children: [
        DrawerHeader(
          child: Text(
            'Einstellungen',
            style: drawerHeaderStyle,
          ),
          decoration: BoxDecoration(color: Colors.grey[700]),
        ),
        ListTile(
          title: Text(
            'Startdatum auswählen',
            style: drawerStyle,
          ),
          onTap: () async {
            selectedStartDate = (await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime(2119)))!;
            _sharedPreferences.setInt(
                'startDate', selectedStartDate.millisecondsSinceEpoch);
          },
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          title: Text(
            'Dauer auswählen',
            style: drawerStyle,
          ),
          onTap: () {
            showDurationSelectorDialog();
          },
        ),
        Divider(
          indent: 10,
          endIndent: 10,
        ),
        ListTile(
          title: Text(
            'zurück',
            style: drawerStyle,
          ),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/HomePage');
          },
        )
      ],
    );
  }
}
