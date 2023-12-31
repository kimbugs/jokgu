import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:intl/intl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final dateController = TextEditingController();
  final CollectionReference<Map<String, dynamic>> _userDB =
      FirebaseFirestore.instance.collection('user');
  final CollectionReference<Map<String, dynamic>> _gameDB =
      FirebaseFirestore.instance.collection('game');

  @override
  void initState() {
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: dateController,
          readOnly: true,
          decoration: const InputDecoration(
            icon: Icon(
              Icons.calendar_today,
            ),
            labelText: "Enter Date",
          ),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(), //get today's date
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);

              setState(() {
                dateController.text = formattedDate;
              });
            }
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              final day = dateController.text;
              if (day != '') {
                createGame(day: day);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<GameModel>>(
        stream: readGames(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something wet wrong! ${snapshot.error}');
          } else if (snapshot.hasData) {
            final games = snapshot.data!;

            return ListView(
              children: games.map(buildGame).toList(),
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

  Widget buildGame(GameModel game) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Text('0')),
        title: Text(game.day),
        onTap: () {},
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: () {
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
                        deleteGame(id: game.id);
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK')),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future deleteGame({required String id}) async {
    final docGame = _gameDB.doc(id);

    await docGame.delete();
  }

  Future createGame({required String day}) async {
    final docGame = _gameDB.doc(day);

    final game = GameModel(id: docGame.id, day: day);
    await docGame.set(game.toJson());
  }

  Stream<List<GameModel>> readGames() =>
      _gameDB.orderBy("id", descending: true).snapshots().map((event) =>
          event.docs.map((e) => GameModel.fromJson(e.data())).toList());
}
