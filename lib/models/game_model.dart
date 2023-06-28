import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

class GameModel {
  String title;
  bool win;

  GameModel(this.title, this.win);
}

Map<DateTime, dynamic> eventSource = {
  DateTime(2023, 6, 26): [
    GameModel('1 set', false),
    GameModel('2 set', true),
    GameModel('3 set', false),
    GameModel('4 set', false),
    GameModel('5 set', false),
    GameModel('6 set', false),
    GameModel('7 set', false),
    GameModel('8 set', false),
    GameModel('9 set', false),
    GameModel('10 set', false),
    GameModel('11 set', false),
    GameModel('12 set', false),
    GameModel('13 set', false),
  ]
};

final events = LinkedHashMap(
  equals: isSameDay,
)..addAll(eventSource);

// class WebtoonDetailModel {
//   final String title, about, genre, age;

//   WebtoonDetailModel(Map<String, dynamic> json)
//       : title = json['title'],
//         about = json['about'],
//         genre = json['genre'],
//         age = json['age'];
// }

