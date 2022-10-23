import 'package:booking_services_riverpod/app/constant.dart';
import 'package:booking_services_riverpod/model/user_model.dart';
import 'package:booking_services_riverpod/repository/base_repository.dart';

class AuthRepository extends BaseRepository {
  AuthRepository({required super.dio});

  Future<AuthModel> login({
    required String username,
    required String password,
  }) async {
    final service = "${Constant.baseWithoutURLToken}login";
    final body = {"username": username, "password": password};

    final resp = await post(body: body, service: service);
    print("resp");
    final authUserModel = User.fromJson(resp["data"]);
    final authModel = AuthModel(token: resp["data"]["token"], model: authUserModel);
    return authModel;
  }
}
