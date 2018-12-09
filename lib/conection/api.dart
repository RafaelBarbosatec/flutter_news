import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

//Classe responsavel por realizar conexões com API
class Api{

  final String urlBase;

  Api(this.urlBase);

  /// Método que executa chamada de conexão do tipo GET
  /// @params uri
  /// @params headers (opcional)
  Future <dynamic> get(String uri, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.get(urlBase+uri, headers: headers);

      final statusCode = response.statusCode;
      final String jsonBody = response.body;

      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Método que executa chamada de conexão do tipo POST
  /// @params uri
  /// @params body
  /// @params headers (opcional)
  Future <dynamic> post(String uri,dynamic body, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.post(urlBase+uri, body: body, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Método que executa chamada de conexão do tipo PUT
  /// @params uri
  /// @params body
  /// @params headers (opcional)
  Future <dynamic> put(String uri,dynamic body, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.put(urlBase+uri, body: body, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

  /// Método que executa chamada de conexão do tipo DELETE
  /// @params uri
  /// @params headers (opcional)
  Future <dynamic> delete(String uri, {Map<String,String> headers}) async{

    try{

      http.Response response = await http.delete(urlBase+uri, headers:headers);

      final statusCode = response.statusCode;

      if(statusCode < 200 || statusCode >= 300) {
        throw new FetchDataException("Error request:",statusCode);
      }

      const JsonDecoder decoder = const JsonDecoder();
      return decoder.convert(response.body);

    } on Exception catch(e){
      throw new FetchDataException(e.toString(),0);
    }

  }

}

class FetchDataException implements Exception {
  String _message;
  int _code;

  FetchDataException(this._message,this._code);

  String toString() {
    return "Exception: $_message/$_code";
  }

  int code(){
    return _code;
  }
}