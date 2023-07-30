import 'dart:convert';
import 'package:bot_toast/bot_toast.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import '../enums/request_type.dart';
import 'package:http_parser/http_parser.dart';

class NetworkUtil {
  static String baseUrl =
      'training.owner-tech.com'; //we intitialized the URL of the server as a string variable (it helps us to change it when ever we want)
  static var client = http.Client();

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
  }) async {
    try {
      var uri = Uri.https(baseUrl, url,
          params); // Uri.https--> SSL certificate (more reliability in browsers) - it will build the URL i want - URL is not case sensetive
      late http.Response
          response; // to indicate to the dart compiler that the variable will be declared now but used/assingned  later with out making it nullable

      Map<String, dynamic> jsonRespons = {};

      switch (type) {
        case RequestType.GET:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.POST:
          response =
              await client.post(uri, headers: headers, body: jsonEncode(body));
          break;
        case RequestType.PUT:
          response =
              await client.put(uri, headers: headers, body: jsonEncode(body));
          break;
        case RequestType.DELETE:
          response = await client.delete(uri,
              headers: headers, body: jsonEncode(body));
          break;
        case RequestType.MULTIPART:
          break;
      }

//       statusCode = response.statusCode;
//       strResponse = utf8.decode(response
//           .bodyBytes); // decoding the response of the api and putting the value (unformated json) in a string variable - first fase of decoding

//       //we started adding items to our jsonRespons map as ('key',() => value)
//       jsonRespons.putIfAbsent('statusCode', () => statusCode);
//       jsonRespons.putIfAbsent(
//           'response',
//           () => jsonDecode(
//               strResponse)); //turning the string from the first fase (unformated json) into formated json - second fase of decoding

//       return jsonRespons;
//     } catch (e) {
//       //when we have a connection or fetching data from apies => try {} catch(e) {} - because many exceptions could accur and the application will crash
//       print(e);
//     }
//   }
// }
      dynamic
          result; //we changed it from Map<String,dynamic> to dynamic because the api may return list of Json
      try {
        result = jsonDecode(utf8.decode(response.bodyBytes));
      } catch (e) {}

      jsonRespons.putIfAbsent('statusCode', () => response.statusCode);
      jsonRespons.putIfAbsent(
          'response',
          () => result != null
              ? jsonDecode(utf8.decode(response.bodyBytes))
              : {'title': utf8.decode(response.bodyBytes)});

      return jsonRespons;
    } catch (e) {
      print(e);
      BotToast.showText(text: e.toString());
    }
  }

  static Future<dynamic> sendMultipartRequest({
    required String url,
    required RequestType type,
    Map<String, String>? headers = const {},
    Map<String, String>? fields = const {},
    Map<String, String>? files = const {},
    Map<String, dynamic>? params,
  }) async {
    try {
      var request =
          http.MultipartRequest("POST", Uri.https(baseUrl, url, params));

      var _filesKeyList = files!.keys.toList();

      var _filesNameList = files.values.toList();

      for (int i = 0; i < _filesKeyList.length; i++) {
        if (_filesNameList[i].isNotEmpty) {
          var multipartFile = http.MultipartFile.fromPath(
            _filesKeyList[i],
            _filesNameList[i],
            filename: path.basename(_filesNameList[i]),
            contentType:
                MediaType.parse(lookupMimeType(_filesNameList[i]) ?? ''),
          );
          request.files.add(await multipartFile);
        }
      }
      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      var response = await request.send();

      Map<String, dynamic> responseJson = {};
      var value;
      try {
        value = await response.stream.bytesToString();
      } catch (e) {
        print(e);
      }

      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent('response', () => jsonDecode(value));

      return responseJson;
    } catch (error) {
      print(error.toString());
    }
  }

  static MediaType getContentType(String name) {
    var ext = name.split('.').last;
    if (ext == "png" || ext == "jpeg") {
      return MediaType.parse("image/jpg");
    } else if (ext == 'pdf') {
      return MediaType.parse("application/pdf");
    } else {
      return MediaType.parse("image/jpg");
    }
  }
}
