import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:github_user/model/model.dart';
import 'package:github_user/services/userlistapi.dart';
import 'package:github_user/view/detailscreen.dart';

class Git extends StatefulWidget {
  const Git({Key? key}) : super(key: key);

  @override
  State<Git> createState() => _GitState();
}

class _GitState extends State<Git> {
  Userdata detail = Userdata();
  List<User> users = [];
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  getUsers() {
    detail.userdata().then((value) {
      setState(() {
        isloading = true;
        users.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isloading
            ? ListView.builder(
                itemCount: users.length,
                itemBuilder: (cnt, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Image.network(users[i].avatarurl.toString()),
                        ),
                        title: Text(
                          users[i].name.toString(),
                          style: const TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return Details(
                                user: users[i],
                              );
                            }),
                          );
                        },
                      ),
                    ),
                  );
                })
            : const Center(
                child: SpinKitFadingCircle(
                color: Colors.indigo,
                size: 50,
              )),
      ),
    );
  }
}
