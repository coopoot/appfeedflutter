import 'package:http/http.dart' as http;

const urlApi = "https://mobile.int.granito.xyz/api/feed/getposts";

class Rest {
  static Future getData() async {
    var url = urlApi;
    return await http.get(url);
  }
}