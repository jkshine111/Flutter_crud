import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_flask/models/show_all_users.dart';

class UserApi {
  //Get all User Details
  Future<List<ShowAllUsers>?> getAllUsers() async {
    var client = http.Client();
    // http://127.0.0.1:5001/show_all_users
    var uri = Uri.parse("http://10.0.2.2:5001/show_all_users");
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return showAllUsersFromJson(json);
    }
  }

  // Add New User
  Future<ShowAllUsers> addUser(String name, String contact) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5001/add_users");
    final http.Response response = await client.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'contact': contact,
      }),
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return ShowAllUsers.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to Save User.');
    }
  }

  // Delete User
  Future<ShowAllUsers> deleteUser(int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5001/delete_user_id/$id");
    final http.Response response =
        await client.delete(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      var json = response.body;
      return ShowAllUsers.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to Delete User.');
    }
  }

  // Update User
  Future<ShowAllUsers> updateUser(String name, String contact, int id) async {
    var client = http.Client();
    var uri = Uri.parse("http://10.0.2.2:5001/update_user_id/$id");
    final http.Response response = await client.put(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'contact': contact,
      }),
    );
    if (response.statusCode == 200) {
      var json = response.body;
      return ShowAllUsers.fromJson(jsonDecode(json));
    } else {
      throw Exception('Failed to Update User.');
    }
  }
}
