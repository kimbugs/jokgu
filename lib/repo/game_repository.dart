import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_firebase/models/game_model.dart';
import 'package:flutter_application_firebase/models/user_model.dart';

class GameRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future updateGame(GameModel game) async {
    final docGame = _db.collection('game').doc(game.id);

    await docGame.update(game.toJson());
  }

  Future deleteGame({required String id}) async {
    final docGame = _db.collection('game').doc(id);

    await docGame.delete();
  }

  Future createGame({required String day}) async {
    bool exist = await checkExist(day);
    if (!exist) {
      final docGame = _db.collection('game').doc(day);

      final game = GameModel(
          id: docGame.id,
          day: day,
          gameSets: <GameSetModel>[],
          users: <UserModel>[]);
      await docGame.set(game.toJson());
    }
  }

  static Future<bool> checkExist(String docID) async {
    bool exist = false;
    try {
      await FirebaseFirestore.instance.doc("game/$docID").get().then((doc) {
        exist = doc.exists;
      });
      return exist;
    } catch (e) {
      // If any error
      return false;
    }
  }

  Stream<List<GameSetModel>> readGameSets(String id) => _db
      .collection('game')
      .doc(id)
      .snapshots()
      .map((event) => GameModel.fromJson(event.data()!).gameSets!);

  Stream<List<GameModel>> readGames() => _db
      .collection('game')
      .orderBy("id", descending: true)
      .snapshots()
      .map((event) =>
          event.docs.map((e) => GameModel.fromJson(e.data())).toList());
}
