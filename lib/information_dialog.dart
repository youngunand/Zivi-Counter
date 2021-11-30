import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class InformationDialog extends StatelessWidget {

  double screenHeight = 1;
  double screenWidth = 1;

  TextStyle infoStyle = TextStyle(fontSize: 20, color: Colors.white60);

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth= MediaQuery.of(context).size.width;
    

    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
        height: 0.5 * screenHeight,
        width: 0.8 * screenWidth,
        color: Theme.of(context).shadowColor,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Icon(
                  Icons.info_outline_rounded,
                  color: Colors.white,
                  size: 50,
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  'Tippe auf das Menü links, um den Counter einzustellen.',
                  style: infoStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                AutoSizeText(
                  'Dort kannst du Anfangsdatum und Dauer auswählen.',
                  style: infoStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
