import 'dart:collection';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

String encryptPassword(String password) {
  final bytes = utf8.encode(password);
  final hash = sha256.convert(bytes);
  return hash.toString();
}

Future<String> get _getDocumentsPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _getLoginFile async {
  final String path = await _getDocumentsPath;
  print("$path/login.txt");

  final file = File("$path/login.txt");

  if (!await file.exists()) {
    await file.create();
  }

  return file;
}

Future<File> get _getBlogFile async {
  final path = await _getDocumentsPath;
  final file = File('$path/blogs.txt');

  //creates the file if it cant be found
  if (!await file.exists()) {
    await file.create();
  }

  return file;
}

Future<File> writeToBlogs(String title, String location, String description, String author) async {
  final file = await _getBlogFile;
  return file.writeAsString("$title,$location,$description,$author\n", mode: FileMode.append);
}

Future<List> readBlogs() async {
  final file = await _getBlogFile;
  final contents = await file.readAsString();
  final List blogData = contents.split('\n');
  return blogData;
}

Future<bool> signUp(String usernameField, String passwordField) async {
  final file = await _getLoginFile;
  var password = encryptPassword(passwordField);
  HashMap loginData = await readLogin();
  if (!loginData.containsKey(usernameField)) {
    file.writeAsString("$usernameField $password\n", mode: FileMode.append);
    return true;
  } else {
    return false;
  }
}

Future<HashMap> readLogin() async {
  final file = await _getLoginFile;

  if (!await file.exists()) {
    return HashMap();
  }

  final contents = await file.readAsString();
  final List lines = contents.split("\n");
  HashMap loginData = HashMap();
  for (int i=0; i<lines.length;i++) {
    var line = lines[i].split(" ");
    if (line[0] != "" && line[1] != "") {
      loginData.addAll({line[0]: line[1]});
    }
  }
  return loginData;
}

Future<bool> logIn(String usernameField, String passwordField) async {
  var password = encryptPassword(passwordField);
  HashMap loginData = await readLogin();
  if (loginData.containsKey(usernameField)) {
    if (loginData[usernameField] == password) {
      return true;
    }
  }
  return false;
}