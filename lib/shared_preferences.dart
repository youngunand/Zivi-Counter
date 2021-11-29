import 'package:shared_preferences/shared_preferences.dart';

final _sharedPreferences = await SharedPreferences.getInstance();

class SharedPrefs {
  void saveStartDate(DateTime startDate) {
    _sharedPreferences.setInt('startDate', startDate.millisecondsSinceEpoch);
  }

  void saveDuration(int? duration) {
    _sharedPreferences.setInt('duration', duration!);
  }

  DateTime getStartDate() {
    final dateInt = _sharedPreferences.getInt('startDate');
    final dateTime = DateTime.fromMillisecondsSinceEpoch(dateInt!);
    return dateTime;
  }

  int? getDuration() {
    final duration = _sharedPreferences.getInt('duration');
    return duration;
  }
}
