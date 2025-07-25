// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rastgele_antreman/models/user_model.dart';

// istek atacağımız url'yi belirledik ve .get metodu ile istediğimizi attık,
// burada baseUrl: ana api adresi, endpoint ise istek yapılacak bölüm.
class UserService {
  final String baseUrl = "https://reqres.in/api/";
  final String endpoint = "users?page=2";

  Future<UserModel?> fetchUser() async {
    // gelen veriyi Uri.parse metodu ile flutter'ın anlayacağı biçime çeviriyoruz.
    // ve veriyi res değişkeninine setliyoruz
    try {
      // res'e gelen veri : json verisi
      final res = await http.get(Uri.parse("$baseUrl$endpoint"));
      if (res.statusCode == 200) {
        // sonrasında gelen veri UserModel objesine dönüştüğü için dart objesine çeviriyoruz ve
        // jsonBody değişkeninde tutuyoruz
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
