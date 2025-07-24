// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rastgele_antreman/models/user_model.dart';

class UserService {
  final String baseUrl = "https://reqres.in/api/";
  final String endpoint = "users?page=2";

  Future<UserModel?> fetchUser() async {
    try {
      final res = await http.get(Uri.parse("$baseUrl$endpoint"));
      if (res.statusCode == 200) {
        var jsonBody = UserModel.fromJson(json.decode(res.body));
        return jsonBody;
      } else {
        print("bir hata oluştu");
      }
      return null;
    } catch (e) {
      throw Exception("hata kodu $e");
    }
  }
}
