import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:teknoloji_kimya_servis/models/api_users.dart';
import 'package:teknoloji_kimya_servis/models/user.dart';

import '../../api/get_apis.dart';

class UserListRepository {
  ApiUsers _apiUsers;
  ApiUsers _apiUser;

  ApiUsers get apiUser => _apiUser;

  set apiUser(ApiUsers apiUser) {
    _apiUser = apiUser;
  }

  ApiUsers get apiUsers => _apiUsers;

  set apiUsers(ApiUsers apiUsers) {
    _apiUsers = apiUsers;
  }

  Future<ApiUsers> getApiUsers({String search}) async {
    final _response = await GetApi.getApiUsers(search: search);
    if (_response is ApiUsers) {
      apiUsers = _response;
      return apiUsers;
    }
    return null;
  }

  Future<ApiUsers> getApiWorkers({String search}) async {
    final _response = await GetApi.getApiWorkers(search: search);
    if (_response is ApiUsers) {
      apiUsers = _response;
      return apiUsers;
    }
    return null;
  }

  Future<ApiUsers> getApiCustomers({String search}) async {
    final _response = await GetApi.getApiCustomers(search: search);
    if (_response is ApiUsers) {
      apiUsers = _response;
      return apiUsers;
    }
    return null;
  }

  Future<ApiUsers> getSpecifiedApiUser(String userId) async {
    final _response = await GetApi.getApiUserWithId(userId);
    if (_response is ApiUsers) {
      apiUser = _response;
      print("user_list_repository _response: ${_response.toJson()}");
      print("user_list_repository user: ${apiUser.toJson()}");
      return apiUser;
    }
    return null;
  }

  final List<MyUser> _myUsers = [];

  Future<List<MyUser>> getUserList() async {
    final List<MyUser> _myUsers = [];

    final _response =
        await FirebaseFirestore.instance.collection('users').get();
    for (var item in _response.docs) {
      print(item.data());
      _myUsers.add(MyUser.fromQueryDocumentSnapshot(
        item,
      ));
    }
    this._myUsers.addAll(_myUsers);
    return _myUsers;
  }
}
