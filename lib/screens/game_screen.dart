import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:flutter_application_firebase/repo/game_repository.dart';
import 'package:flutter_application_firebase/screens/game_set_screen.dart';
import 'package:intl/intl.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final dateController = TextEditingController();
  final gameRepository = GameRepository();

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
                gameRepository.createGame(day: day);
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<GameModel>>(
        stream: gameRepository.readGames(),
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameSetScreen(
                game: game,
              ),
              //fullscreenDialog: true,
            ),
          );
        },
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
                        gameRepository.deleteGame(id: game.id);
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
}
