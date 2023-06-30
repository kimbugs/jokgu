import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_application_firebase/models/user_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class GameDetailScreen extends StatefulWidget {
  const GameDetailScreen({super.key});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  int _selectedIndex = 0;
  bool isWinA = false;
  String stateA = '';
  String stateB = '';

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
  List<UserModel> allUsers = users;
  List<UserModel> usersA = teamA;
  List<UserModel> selectedUsersA = [];
  List<UserModel> usersB = teamB;
  List<UserModel> selectedUsersB = [];

  List<MultiSelectItem<UserModel?>> _itemUsersA = users
      .map((user) => MultiSelectItem<UserModel?>(user, user.name))
      .toList();
  List<MultiSelectItem<UserModel?>> _itemUsersB = users
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restart_alt_rounded), label: 'Random'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1_rounded), label: 'A'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_2_rounded), label: 'B'),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              showRandomDialog(context);
              break;
            case 1:
              isWinA = true;
              setState(() {
                stateA = 'Win';
                stateB = 'Loss';
              });
              break;
            case 2:
              isWinA = false;
              setState(() {
                stateA = 'Loss';
                stateB = 'Win';
              });
              break;
          }
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: teamCard('A', stateA, _itemUsersA, selectedUsersA),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 20,
              endIndent: 0,
              height: 20,
            ),
            Expanded(
              child: teamCard('B', stateB, _itemUsersB, selectedUsersB),
            ),
          ],
        ),
      ),
    );
  }

  void showRandomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Random'),
        content: const Text(''),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Close'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              List<UserModel> randomItem = (users..shuffle());
              int len = randomItem.length ~/ 2;
              Iterable<List<UserModel>> randomUsers = randomItem.slices(len);
              setState(() {
                selectedUsersA = randomUsers.first;
                selectedUsersB = randomUsers.last;
                _itemUsersA = selectedUsersA
                    .map((user) => MultiSelectItem<UserModel?>(user, user.name))
                    .toList();

                _itemUsersB = selectedUsersB
                    .map((user) => MultiSelectItem<UserModel?>(user, user.name))
                    .toList();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Card teamCard(String teamName, String stateWin,
      List<MultiSelectItem<UserModel?>> items, List<UserModel?> selectedUsers) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: Text(
              teamName,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                MultiSelectChipField<UserModel?>(
                  items: items,
                  scroll: false,
                  title: const Text('Player'),
                  initialValue: selectedUsers,
                  onTap: (List<UserModel?> values) {
                    selectedUsers = values;
                    setState(() {
                      _itemUsersA = users
                          .map((user) =>
                              MultiSelectItem<UserModel?>(user, user.name))
                          .toList();
                    });
                    print(items.length);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      stateWin,
                      style: const TextStyle(fontSize: 35),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
