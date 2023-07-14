import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:flutter_application_firebase/models/user_model.dart';
import 'package:flutter_application_firebase/repo/game_repository.dart';
import 'package:flutter_application_firebase/repo/user_repository.dart';
import 'package:flutter_application_firebase/screens/game_set_detail_screen.dart';

class GameSetScreen extends StatefulWidget {
  final GameModel game;

  const GameSetScreen({
    super.key,
    required this.game,
  });

  @override
  State<GameSetScreen> createState() => _GameSetScreenState();
}

class _GameSetScreenState extends State<GameSetScreen> {
  final userRepository = UserRepository();
  final gameRepository = GameRepository();
  final userController = TextEditingController();
  final Map<String, UserModel> _selectedUsers = <String, UserModel>{};
  late Future<List<UserModel>> _users;

  @override
  void initState() {
    if (widget.game.users != null) {
      _selectedUsers.addAll({for (var e in widget.game.users!) e.name: e});
    }
    _users = userRepository.getAllUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game ${widget.game.day}'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: () {
              int gameLen = widget.game.gameSets!.length;
              String title = "Set ${gameLen + 1}";

              if (widget.game.users!.isNotEmpty) {
                List<UserModel> randomItem = widget.game.users!..shuffle();
                int len = randomItem.length ~/ 2;
                Iterable<List<UserModel>> randomUsers = randomItem.slices(len);

                final gameSet = GameSetModel(
                  id: gameLen + 1,
                  isWinA: false,
                  title: title,
                  teamA: randomUsers.first,
                  teamB: randomUsers.last,
                );

                widget.game.gameSets!.add(gameSet);
                gameRepository.updateGame(widget.game);
              } else {}
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: 'delete',
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete last game set'),
                  content: const Text('Are you sure?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                        onPressed: () {
                          if (widget.game.gameSets!.isNotEmpty) {
                            widget.game.gameSets!.removeLast();
                          }

                          gameRepository.updateGame(widget.game);
                          Navigator.pop(context, 'OK');
                        },
                        child: const Text('OK')),
                  ],
                ),
              );
            },
            child: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              // leading: const Icon(Icons.account_circle_rounded),
              title: const Text('Player'),
              subtitle: FutureBuilder<List<UserModel>>(
                future: _users,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return Wrap(
                      spacing: 3,
                      children: users.map((UserModel user) {
                        return FilterChip(
                          label: Text(user.name),
                          selected: _selectedUsers.containsKey(user.name),
                          onSelected: (bool value) {
                            setState(() {
                              if (value) {
                                _selectedUsers[user.name] = user;
                              } else {
                                _selectedUsers.remove(user.name);
                              }

                              widget.game.users = [
                                for (var e in _selectedUsers.values) e
                              ];
                              gameRepository.updateGame(widget.game);
                            });
                          },
                        );
                      }).toList(),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          StreamBuilder(
            stream: gameRepository.readGameSets(widget.game.id),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something wet wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final gameSets = snapshot.data!;
                // sorting
                gameSets.sort((a, b) => b.id.compareTo(a.id));
                return Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: gameSets.map(buildGame).toList(),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildGame(GameSetModel gameSet) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Text('A')),
        title: Text(gameSet.title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GameSetDetailScreen(
                game: widget.game,
                gameSet: gameSet,
              ),
              //fullscreenDialog: true,
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.delete_rounded),
          onPressed: () {},
        ),
      ),
    );
  }
}
