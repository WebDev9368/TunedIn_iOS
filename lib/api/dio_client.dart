import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunedln/modules/main/tabs/search/model/playlist_model.dart';

import '../modules/main/tabs/search/model/songList_model.dart';
import '../modules/main/tabs/search/model/song_list_model.dart';
import '../modules/main/tabs/search/model/song_model.dart';

class DioClient {
  final Dio _dio = Dio();
  SharedPreferences? sharedPreferences;

  late String token;
  late String refreshToken;
  late String appleToken;
  late String spotifyToken;
  late String spotifyRefreshToken;

  late String localId;
  late String email;
  final _baseUrl = 'https://wordcoach.app/api.php';

  getJWTToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token").toString();
    appleToken = sharedPreferences!.getString("appleToken").toString();
    localId = sharedPreferences!.getString("localId").toString();
    spotifyToken = sharedPreferences!.getString("spotifyToken").toString();
    spotifyRefreshToken =
        sharedPreferences!.getString("spotifyRefreshToken").toString();
    refreshToken = sharedPreferences!.getString("refreshToken").toString();
  }

  setJWTToken(
      String token,
      String refreshToken,
      String localId,
      String appleToken,
      String spotifyToken,
      String spotifyRefreshToken) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("localId", localId);
    sharedPreferences.setString("refreshToken", refreshToken);
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("appleToken", appleToken);
    sharedPreferences.setString("spotifyToken", spotifyToken);
    sharedPreferences.setString("spotifyRefreshToken", spotifyRefreshToken);
  }

  connect(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences!.getString("token").toString();
    _dio
        .get('https://wordcoach.app/api.php?action=connect',
            queryParameters: body,
            options: Options(
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer $token",
                "Content-Type": 'application/json'
              },
              method: "GET",
            ))
        .then((response) async {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        final result = json.decode(response.data);
        var url = result['url'];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("url", url);
        onSuccess(url);
      }
    }).catchError((error) async {
      onError('');
    });
  }

  setApiToken(
      {required Map<String, dynamic> body,
      required void Function() onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    _dio
        .get('https://wordcoach.app/api.php',
            queryParameters: body,
            options: Options(
                headers: headers,
                method: "GET",
                contentType: "application/json"))
        .then((response) async {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        onSuccess();
      } else {
        onError('');
      }
    }).catchError((error) async {
      if (error is DioError) {
        print(error);
      }
      onError('');
    });
  }

  getDeveloperToken(
      {required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    var headers = {
      'content-Type': 'application/json',
      "authorization": "Bearer $token",
    };
    _dio.get(
            'https://wordcoach.app/api.php?action=get_developer_token&source=apple',
            options: Options(headers: headers, method: "GET"))
        .then((response) async {
      final result = json.decode(response.data);
      appleToken = result['token'];
      onSuccess(appleToken);
    }).catchError((error) {
      onError('');
    });
  }

  registration(
      {required String email,
      required Map<String, dynamic> body,
      required void Function(dynamic apple, dynamic spotify) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await _dio
        .get("$_baseUrl?action=register",
            queryParameters: body,
            options: Options(
                headers: {'content-Type': 'application/json'},
                method: "POST",
                contentType: "application/json"))
        .then((response) async {
      final result = json.decode(response.data);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      if (response.statusCode == 201 || result['success'] == true) {
        sharedPreferences.setString("localId", result['localId']);
        sharedPreferences.setString("refreshToken", result['refreshToken']);
        sharedPreferences.setString("token", result['idToken']);
        result['appleToken'] != null
            ? sharedPreferences.setString("appleToken", result['appleToken'])
            : {sharedPreferences.setString("appleToken", "null")};
        result['spotifyToken'] != null
            ? sharedPreferences.setString(
                "spotifyToken", result['spotifyToken'])
            : {sharedPreferences.setString("spotifyToken", "null")};
        result['spotifyRefreshToken'] != null
            ? sharedPreferences.setString(
                "spotifyRefreshToken", result['spotifyRefreshToken'])
            : {sharedPreferences.setString("spotifyRefreshToken", "null")};
        onSuccess(result['appleToken'], result['spotifyToken']);
      } else {
        onError("${result['message']}");
      }
    }).catchError((error) {
      if (error is DioError) {
        print(error);
        //handle DioError here by error type or by error code='
        if (error.response?.statusCode == 400) {
          onError("User with this email is already registered");
        } else {
          onError('Sign Up successfully.');
        }
      }
    });
  }

  uploadImage(
      {required Map<String, dynamic> body,
        required void Function( dynamic url) onSuccess,
        required void Function(dynamic errorCode) onError}) async {
    await _dio
        .get("$_baseUrl?action=upload",
        queryParameters: body,
        options: Options(
            headers: {'content-Type': 'application/json'},
            method: "POST",
            contentType: "application/json"))
        .then((response) async {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        onSuccess(result['url']);
      } else {
        onError("${result['message']}");
      }
    }).catchError((error) {
      if (error is DioError) {
        print(error);
          onError('Error.');
      }
    });
  }


  refreshTokenRequest(
      {required void Function(dynamic accessToken, dynamic refreshToken)
          onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();

    await _dio
        .get("$_baseUrl?action=register",
            options: Options(
                headers: {'content-Type': 'application/json'},
                method: "POST",
                contentType: "application/json"))
        .then((response) async {
      final result = json.decode(response.data);

      if (response.statusCode == 200) {
        sharedPreferences?.setString("refreshToken", result['refreshToken']);
        sharedPreferences?.setString("token", result['idToken']);
        onSuccess(token, result['refreshToken']);
      } else if (response.statusCode == 203) {
        onError("${response.statusCode}");
      } else {
        onError("${response.statusCode}");
      }
    }).catchError((error) {
      print("Error: $error");
    });
  }

  login(
      {required Map<String, dynamic> body,
      required void Function(dynamic apple, dynamic spotify) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    _dio
        .get(
            '$_baseUrl?action=auth&email=${body['email']}&password=${body['password']}',
            options: Options(
                headers: {'content-Type': 'application/json'},
                method: "POST",
                contentType: "application/json"))
        .then((response) async {
      final result = json.decode(response.data);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (response.statusCode == 201 || result['success'] == true) {
        sharedPreferences.setString("localId", result['localId']);
        sharedPreferences.setString("refreshToken", result['refreshToken']);
        sharedPreferences.setString("token", result['idToken']);
        result['appleToken'] != null
            ? sharedPreferences.setString("appleToken", result['appleToken'])
            : {sharedPreferences.setString("appleToken", "null")};
        result['spotifyToken'] != null
            ? sharedPreferences.setString(
                "spotifyToken", result['spotifyToken'])
            : {sharedPreferences.setString("spotifyToken", "null")};
        result['spotifyRefreshToken'] != null
            ? sharedPreferences.setString(
                "spotifyRefreshToken", result['spotifyRefreshToken'])
            : {sharedPreferences.setString("spotifyRefreshToken", "null")};
        onSuccess(result['appleToken'], result['spotifyToken']);
      } else {
        onError("${result['message']}");
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          onError("User with this email is already registered");
        } else {
          onError('Sign Up successfully.');
        }
      }
    });
  }

  searchText(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };
    _dio
        .get("https://wordcoach.app/api.php",
            queryParameters: body,
            options: Options(
                headers: {
                  "Authorization": "Bearer $token",
                },
                method: "GET"))
        .then((response) async {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        var list = SongListModel.fromJson(result);
        print(list.accessToken);
        list.accessToken != null && list.accessToken != ''
            ? sharedPreferences?.setString("spotifyToken", list.accessToken!)
            : {sharedPreferences?.setString("spotifyToken", "null")};
        list.refreshToken != null && list.refreshToken != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", list.refreshToken!)
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
        onSuccess(list.tracks);
      } else {
        onError(result['message']);
        result['accessToken'] != null && result['accessToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyToken", result['accessToken'])
            : {sharedPreferences?.setString("spotifyToken", "null")};
        result['refreshToken'] != null && result['refreshToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", result['refreshToken'])
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
      }
    }).catchError((error) {
      print(error);
    });
  }

  searchAllText(
      {required Map<String, dynamic> body,
      required void Function(dynamic code, dynamic codes) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    await _dio
        .get("https://wordcoach.app/api.php",
            queryParameters: body,
            options: Options(headers: {
              "Content-type": "application/json",
              "Authorization": "Bearer $token",
            }, contentType: "application/json", method: "GET"))
        .then((response) {
      final result = json.decode(response.data);
      if (result['success'] == true) {
        var list = SongsListModel.fromJson(result);
        var lists = result['tracks']['apple']
            .map<SongModel>((x) => SongModel.fromJson(x))
            .toList();
        var lists1 = result['tracks']['spotify']
            .map<SongModel>((x) => SongModel.fromJson(x))
            .toList();
        onSuccess(lists, lists1);
        list.accessToken != null && list.accessToken != ''
            ? sharedPreferences?.setString("spotifyToken", list.accessToken!)
            : {sharedPreferences?.setString("spotifyToken", "null")};
        list.refreshToken != null && list.refreshToken != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", list.refreshToken!)
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
      } else {
        onError(result['message']);
        result['accessToken'] != null && result['accessToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyToken", result['accessToken'])
            : {sharedPreferences?.setString("spotifyToken", "null")};
        result['refreshToken'] != null && result['refreshToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", result['refreshToken'])
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
      }
    }).catchError((error) {
      onError(error);
    });
  }

  addToPlaylists(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    await _dio
        .get("https://wordcoach.app/api.php",
            queryParameters: body,
            options: Options(headers: {
              "Content-type": "application/json",
              "Authorization": "Bearer $token",
            }, contentType: "application/json", method: "GET"))
        .then((response) {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        onSuccess(result['playlist_id']);
      } else {
        result['accessToken'] != null && result['accessToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyToken", result['accessToken'])
            : {sharedPreferences?.setString("spotifyToken", "null")};
        result['refreshToken'] != null && result['refreshToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", result['refreshToken'])
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
        onError(result['message']);
      }
    }).catchError((error) {
    });
  }

  createPlaylists(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    await _dio
        .get("https://wordcoach.app/api.php",
            queryParameters: body,
            options: Options(headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer $token",
              "Connection": "keep-alive"
            }, contentType: "application/json", method: "GET"))
        .then((response) {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        var list = result['playlist_id'];
        onSuccess(list);
      } else {
        onError(result['message']);
       result['accessToken'] != null && result['accessToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyToken", result['accessToken'])
            : {sharedPreferences?.setString("spotifyToken", "null")};
        result['refreshToken'] != null && result['refreshToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", result['refreshToken'])
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
      }
    }).catchError((error) {
      print(error);
    });
  }

  getPlaylists(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await getJWTToken();
    await _dio
        .get("https://wordcoach.app/api.php",
            queryParameters: body,
            options: Options(headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer $token",
             "Connection": "keep-alive"
            }, contentType: "application/json", method: "GET"))
        .then((response) {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        var list = result["playlists"]
            .map<Playlists>((x) => Playlists.fromJson(x))
            .toList();
        onSuccess(list);
      } else {
        result['accessToken'] != null && result['accessToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyToken", result['accessToken'])
            : {sharedPreferences?.setString("spotifyToken", "null")};
        result['refreshToken'] != null && result['refreshToken'] != ''
            ? sharedPreferences?.setString(
                "spotifyRefreshToken", result['refreshToken'])
            : {sharedPreferences?.setString("spotifyRefreshToken", "null")};
        onError(result['message']);
      }
    }).catchError((error) {
      print(error);
    });
  }

  resetPassword(
      {required Map<String, dynamic> body,
      required void Function(dynamic code) onSuccess,
      required void Function(dynamic errorCode) onError}) async {
    await _dio
        .get('https://wordcoach.app/api.php',
            queryParameters: body,
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ))
        .then((response) {
      final result = json.decode(response.data);
      if (response.statusCode == 201 || result['success'] == true) {
        onSuccess('');
      } else {
        onError(result['message']);
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          onError("This account does not exist");
        }
      }
    });
  }
}
