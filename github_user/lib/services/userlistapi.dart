import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:github_user/model/model.dart';
import 'package:http/http.dart' as http;

class Userdata {
  Future<List<User>> userdata() async {
    var response = await http.get(Uri.parse(
        "https://api.github.com/search/repositories?q=created:%3E2020-04-29&sort=stars&order=desc"));

    if (response.statusCode == 200) {
      debugPrint(response.statusCode.toString());
      var data = jsonDecode(response.body);
      var jsondata = data['items'];

      List<User> users = [];
      for (var u in jsondata) {
        User res = User(u['name'], u['owner']['avatar_url'], u["full_name"],
            u["stargazers_count"], u["description"]);

        users.add(res);
      }
      return users;
    } else {
      throw Exception("user data failed");
    }
  }
}
