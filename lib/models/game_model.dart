import 'package:flutter_application_firebase/models/user_model.dart';

class GameModel {
  String id;
  String day;
  List<UserModel>? users;
  List<GameSetModel>? gameSets;

  GameModel({
    required this.id,
    required this.day,
    this.users,
    this.gameSets,
  });

  GameModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        day = json['day'] {
    if (json['users'] != null) {
      users = <UserModel>[];
      json['users'].forEach((v) {
        users!.add(UserModel.fromJson(v));
      });
    }

    if (json['gameSets'] != null) {
      gameSets = <GameSetModel>[];
      json['gameSets'].forEach((v) {
        gameSets!.add(GameSetModel.fromJson(v));
      });
    }
  }

  // GameModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   day = json['day'];
  //   if (json['users'] != null) {
  //     users = <UserModel>[];
  //     json['users'].forEach((v) {
  //       users!.add(UserModel.fromJson(v));
  //     });
  //   }

  //   if (json['gameSets'] != null) {
  //     gameSets = <GameSetModel>[];
  //     json['gameSets'].forEach((v) {
  //       gameSets!.add(GameSetModel.fromJson(v));
  //     });
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['day'] = day;
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }

    if (gameSets != null) {
      data['gameSets'] = gameSets!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class GameSetModel {
  String? id;
  String? title;
  List<UserModel>? teamA;
  List<UserModel>? teamB;
  bool? isWinA;

  GameSetModel({
    this.id,
    this.title,
    this.teamA,
    this.teamB,
    this.isWinA,
  });

  GameSetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isWinA = json['isWinA'];
    if (json['teamA'] != null) {
      teamA = <UserModel>[];
      json['teamA'].forEach((v) {
        teamA!.add(UserModel.fromJson(v));
      });
    }

    if (json['teamB'] != null) {
      teamB = <UserModel>[];
      json['teamB'].forEach((v) {
        teamB!.add(UserModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isWinA'] = isWinA;
    if (teamA != null) {
      data['teamA'] = teamA!.map((v) => v.toJson()).toList();
    }

    if (teamB != null) {
      data['teamB'] = teamB!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

// class GameModel {
//   String title;
//   bool win;

//   GameModel(this.title, this.win);
// }

// Map<DateTime, dynamic> eventSource = {
//   DateTime(2023, 6, 26): [
//     GameModel('1 set', false),
//     GameModel('2 set', true),
//     GameModel('3 set', false),
//     GameModel('4 set', false),
//     GameModel('5 set', false),
//     GameModel('6 set', false),
//     GameModel('7 set', false),
//     GameModel('8 set', false),
//     GameModel('9 set', false),
//     GameModel('10 set', false),
//     GameModel('11 set', false),
//     GameModel('12 set', false),
//     GameModel('13 set', false),
//   ]
// };

// final events = LinkedHashMap(
//   equals: isSameDay,
// )..addAll(eventSource);


