import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_firebase/models/user_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({super.key});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  static List<UserModel> teamA = [
    UserModel(1, 'a'),
    UserModel(2, 'b'),
    UserModel(3, 'c'),
    UserModel(4, 'd'),
  ];

  static List<UserModel> teamB = [
    UserModel(5, 'e'),
    UserModel(6, 'f'),
    UserModel(7, 'g'),
    UserModel(8, 'h'),
  ];
  List<UserModel> usersA = teamA;
  List<UserModel> selectedUsersA = [];
  List<UserModel> usersB = teamB;
  List<UserModel?> selectedUsersB = [];

  final _itemUsersA = teamA
      .map((user) => MultiSelectItem<UserModel?>(user, user.name))
      .toList();
  final _itemUsersB = teamB
      .map((user) => MultiSelectItem<UserModel?>(user, user.name))
      .toList();

  @override
  void initState() {
    selectedUsersA = usersA;
    selectedUsersB = usersB;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game Set")),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(color: Colors.green.shade100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 80,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Start'),
              ),
            ),
            SizedBox(
              height: 80,
              width: 150,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('stop'),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red.shade100),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('A Team'),
                          const Text('Position : '),
                          Row(
                            children: [
                              const Text('Point : '),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: TextField(
                                  textAlignVertical: TextAlignVertical.top,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              height: 20,
            ),
            Expanded(
              child: Card(
                elevation: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      title: const Text(
                        'B',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MultiSelectChipField<UserModel?>(
                            items: _itemUsersB,
                            title: const Text('Player'),
                            initialValue: [teamB[0], teamB[1]],
                            onTap: (List<UserModel?> values) {
                              selectedUsersB = values;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputChip playerChip(String name) {
    return InputChip(
      label: Text(name),
      backgroundColor: Colors.amber,
      onPressed: () {},
      onDeleted: () {
        setState(() {
          usersB.removeWhere((element) => element.name == name);
        });
      },
    );
  }
}
