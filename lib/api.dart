import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class api extends StatefulWidget {
  @override
  _apiState createState() => _apiState();
}

// ignore: camel_case_types
class _apiState extends State<api> {
  getuser() async {
    var users = [];
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsondata = jsonDecode(response.body);

    for (var i in jsondata) {
      UserModel user = UserModel(i["name"], i["username"], i["email"]);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getuser(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Text("Nothing i api"),
            );
          } else
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return ListTile(
                    title: Text(snapshot.data[i].name),
                    subtitle: Text(
                      snapshot.data[i].username,
                    ));
              },
            );
        },
      ),
    );
  }
}

class UserModel {
  var name;
  var username;
  var email;

  UserModel(this.name, this.username, this.email);
}
