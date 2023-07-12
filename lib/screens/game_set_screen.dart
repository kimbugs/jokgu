import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:flutter_application_firebase/models/user_model.dart';
import 'package:flutter_application_firebase/repo/game_repository.dart';
import 'package:flutter_application_firebase/repo/user_repository.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // widget.game.gameSets.length;
        },
        child: const Icon(Icons.add),
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
        ],
      ),
    );
  }
}
