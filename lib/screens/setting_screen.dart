import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class Game {
  String? day;
  List<User>? users;
  List<GameSet>? gameSets;

  Game({
    this.day,
    this.users,
    this.gameSets,
  });

  Game.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(User.fromJson(v));
      });
    }

    if (json['gameSets'] != null) {
      gameSets = <GameSet>[];
      json['gameSets'].forEach((v) {
        gameSets!.add(GameSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class GameSet {
  String? title;
  List<User>? teamA;
  List<User>? teamB;
  bool? isWinA;

  GameSet({
    this.title,
    this.teamA,
    this.teamB,
    this.isWinA,
  });

  GameSet.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isWinA = json['isWinA'];
    if (json['teamA'] != null) {
      teamA = <User>[];
      json['teamA'].forEach((v) {
        teamA!.add(User.fromJson(v));
      });
    }

    if (json['teamB'] != null) {
      teamB = <User>[];
      json['teamB'].forEach((v) {
        teamB!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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

class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

class _SettingsState extends State<Settings> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: TextField(controller: controller),
        actions: [
          IconButton(
            onPressed: () {
              final name = controller.text;

              createUser(name: name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<User>>(
        stream: readUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;

            return ListView(
              children: users.map(buildUser).toList(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(child: Text(user.name)),
        title: Text(user.name),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((event) => event.docs.map((e) => User.fromJson(e.data())).toList());

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(name);

    final user = User(id: name, name: name);
    await docUser.set(user.toJson());
  }
}
