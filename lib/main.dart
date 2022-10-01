import 'dart:developer';

import 'package:files/file_handler/file_handler.dart';
import 'package:files/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Files',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Files'),
      ),
      body: const Center(
        child: Text('Files'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Address address = const Address(
            houseNo: '1',
            locality: 'Cairo',
            city: 'Giza',
            state: 'Dokki',
          );
          User user = User(
            id: 4,
            email: 'm.saeed.fci@gmail.com',
            name: 'Mo Saeed',
            phone: '01277364554',
            userAddress: address,
          );
          //await FileHandler.instance.writeUser( user);
        },
        tooltip: 'Test',
        child: const Icon(Icons.add),
      ),
    );
  }
}
