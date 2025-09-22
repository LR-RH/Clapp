import 'package:clapp/cloudlearning.dart';
import 'package:flutter/material.dart';
import 'cloudquiz.dart';
import 'login.dart';
import 'weather.dart';
import 'noticeboard.dart';
import 'blogposts.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(), // Show the login page first
    );
  }
}
class App extends StatefulWidget {
  const App({super.key, required this.username});
  final String username;

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  int selectedIndex = 0;
  static const List<Widget> navbarOptions =
  <Widget>[
    Text('Index 0: Weather', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Index 1: View Posts', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Index 2: Notice Board', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Index 3: Cloud Quiz', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    Text('Index 4: Cloud Learning', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
  ];

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [ const Weather(), BlogPosts(username : widget.username), const NoticeBoard(), const CloudQuiz(), const CloudLearning()];
  }

  void navbarTapped(int index) {
    Vibration.vibrate(duration: 25);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.cloud), label: 'Weather'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Blog Posts'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Notice Board'),
            BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'Cloud Quiz'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Cloud Learning')
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.lightBlue[200],
          onTap: navbarTapped,
        ),
      ),
    );
  }
}

