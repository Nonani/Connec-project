import 'package:http/http.dart' as http;
class ConnecRequest {
  final String rootUri;
  ConnecRequest(this.rootUri);

  Future sendGet(String resource, Map<String, dynamic> params) async{
    //http.get();
  }
  Future sendPost(String uri, Map<String, dynamic> body) async {
  }
}