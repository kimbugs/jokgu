import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
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

enum MoreItem { edit, delete }

class _UsersScreenState extends State<UsersScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  Widget buildUser(User user) {
    MoreItem? selectedMenu;
    final controller = TextEditingController();

    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name)),
        title: Text(user.name),
        subtitle: Text(user.id),
        subtitleTextStyle: const TextStyle(fontSize: 10),
        trailing: PopupMenuButton<MoreItem>(
          initialValue: selectedMenu,
          onSelected: (MoreItem item) {
            switch (item) {
              case MoreItem.edit:
                controller.text = user.name;
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Edit'),
                    content: TextField(controller: controller),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            updateUser(id: user.id, name: controller.text);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK')),
                    ],
                  ),
                );
                break;
              case MoreItem.delete:
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Delete'),
                    content: const Text('Are you sure?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                          onPressed: () {
                            deleteUser(id: user.id);
                            Navigator.pop(context, 'OK');
                          },
                          child: const Text('OK')),
                    ],
                  ),
                );
                break;
            }
          },
          itemBuilder: (context) => <PopupMenuEntry<MoreItem>>[
            const PopupMenuItem<MoreItem>(
              value: MoreItem.edit,
              child: Text('Edit'),
            ),
            const PopupMenuItem<MoreItem>(
              value: MoreItem.delete,
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  Future updateUser({required String id, required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(id);

    await docUser.update({'name': name});
  }

  Future deleteUser({required String id}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(id);

    await docUser.delete();
  }

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((event) => event.docs.map((e) => User.fromJson(e.data())).toList());

  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final user = User(id: docUser.id, name: name);
    await docUser.set(user.toJson());
  }
}
