import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:files/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class FileHandler {
  /*
  Makes this a singleton class, as we want only want a single
  instance of this object for the whole application
  */
  FileHandler._privateConstructor();

  static final FileHandler instance = FileHandler._privateConstructor();

  static File? _file;
  static const _fileName = 'user_file.txt';

  // Get the data file (lazy singleton)
  Future<File> get file async {
    _file ??= await _initFile();
    return _file!;
  }

  // Initialize file
  Future<File> _initFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    log('File Path: $path');
    return File('$path/$_fileName');
  }

  static final Set<User> _userSet = {};

  Future<void> writeUser(User user) async {
    final File myFile = await file;
    _userSet.add(user);
    /*
    Now convert the set to a list as the jsonEncoder cannot encode
    a set but a list.
    */
    final List<Map<String, dynamic>> userListMap =
        _userSet.map((user) => user.toJson()).toList();
    await myFile.writeAsString(jsonEncode(userListMap));
  }

  Future<List<User>> readUsers() async {
    final File myFile = await file;
    final content = await myFile.readAsString();

    final List<dynamic> jsonData = jsonDecode(content);
    final List<User> users = jsonData
        .map(
          (user) => User.fromJson(user),
        )
        .toList();
    return users;
  }

  //Delete is to delete the user from the set and then write the set again into the file.
  Future<void> deleteUser(User givenUser) async {
    final File myFile = await file;

    _userSet.removeWhere((user) => user == givenUser);
    final List<Map<String, dynamic>> userListMap =
        _userSet.map((user) => user.toJson()).toList();

    await myFile.writeAsString(jsonEncode(userListMap));
  }

  /*
  Update is to delete the user from the set and then write the update one again to the set
  then write the set again into the file
  */

  Future<void> updateUser({
    required int id,
    required User updatedUser,
  }) async {
    _userSet.removeWhere((user) => user.id == updatedUser.id);
    await writeUser(updatedUser);
  }
}
