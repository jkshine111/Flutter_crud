import 'package:flutter/material.dart';
import 'package:rest_api_flask/models/show_all_users.dart';
import 'package:rest_api_flask/services/userApi.dart';
import 'package:rest_api_flask/view/addUserForm.dart';
import 'package:rest_api_flask/view/updateUserForm.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ShowAllUsers>? show_users;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    show_users = await UserApi().getAllUsers();
    if (show_users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  Future<void> showMessageDialog(String title, String msg) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(msg),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Python RestAPI Flutter'),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
            itemCount: show_users?.length,
            // itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(show_users![index].name),
                subtitle: Text(show_users![index].contact),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  updateUserForm(show_users![index])),
                        ).then((data) {
                          if (data != null) {
                            showMessageDialog(
                                "Success", "$data Detail Updated Success.");
                            getRecord();
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        ShowAllUsers delete_user =
                            await UserApi().deleteUser(show_users![index].id);
                        showMessageDialog(
                            "Success", "$delete_user Detail Deleted Success.");
                        getRecord();
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const addUserForm()),
          ).then((data) {
            if (data != null) {
              showMessageDialog(
                  // "Success", data.toString() + " Detail Added Success.");
                  "Success",
                  "$data Detail Added Success.");
              getRecord();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
