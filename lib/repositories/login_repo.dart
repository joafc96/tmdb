import 'dart:io';

import '../models/user_info_model.dart';
import '../services/network/network_service.dart';
import '../utils/urls.dart';

class LoginRepo  {

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  Future<UserInfoModel> login({String username, String password}) async {
    try {
      final requestToken = await _createRequestToken;
      final verifiedToken =
          await _verifyToken(requestToken, username, password);
      final sessionId = await _createSessionId(verifiedToken);
      final accountDetails = await _getAccountDetails(sessionId);
      return UserInfoModel(
          userId: int.tryParse(accountDetails['id'].toString()),
          userName: accountDetails['username'].toString(),
          sessionId: sessionId);
    } catch (error) {
      rethrow;
    }
  }

  Future<String> get _createRequestToken async {
    final json =
        await ApiService.get(uri: URLS.createRequestToken);
    final requestToken = json['request_token'];
    return requestToken.toString();
  }

  Future<String> _verifyToken(
      String token, String username, String password) async {
    final String body =
        '{"username": "$username","password": "$password","request_token": "$token"}';
    final json = await ApiService.post(
        uri: URLS.verifyRequestToken,
        headers: headers,
        stringBody: body);
    final verifiedToken = json['request_token'];
    return verifiedToken.toString();
  }

  Future<String> _createSessionId(String verifiedToken) async {
    final String body = '{"request_token":"$verifiedToken"}';
    final json = await ApiService.post(
        uri: URLS.createSessionId,
        stringBody: body,
        headers: headers);
    final sessionId = json['session_id'];
    return sessionId.toString();
  }

  Future<dynamic> _getAccountDetails(String sessionId) async {
    final json = await ApiService.get(
        uri: URLS.accountDetails(sessionId));
    return json;
  }
}
