# flutter_application_firebase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## firebase flutter 연동

[firebase flutter 연동](https://www.youtube.com/watch?v=RiViG-3GHig)

[firebase flutter 연동 추가](https://firebase.google.com/docs/flutter/setup?hl=ko&platform=ios)

[달력](https://velog.io/@jun7332568/%ED%94%8C%EB%9F%AC%ED%84%B0flutter-%EB%8B%AC%EB%A0%A5-Event-%EA%B5%AC%ED%98%84%ED%95%B4%EB%B3%B4%EA%B8%B0-Tablecalendar-%EB%9D%BC%EC%9D%B4%EB%B8%8C%EB%9F%AC%EB%A6%AC)

[firebase firestorage](https://funncy.github.io/flutter/2021/03/06/firestore/)

firebase main page에 추가
```
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
```

### 페이지 route
```
ElevatedButton(
  child: const Text('Basics'),
  onPressed: () => Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const TableBasicsExample()),
  ),
),
```
