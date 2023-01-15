import 'package:shopping_app/data/network/app_api.dart';
import 'package:shopping_app/data/network/requests.dart';
import 'package:shopping_app/data/response/responses.dart';

abstract class RemoteDataSource{
  Future<AuthenticationResponse>login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> forgotPassword(String email);
}

class RemoteDataSourceImpl implements RemoteDataSource{
  final AppServicesClient _appServicesClient;
  RemoteDataSourceImpl(this._appServicesClient);
  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async{
    return await _appServicesClient.login(loginRequest.email, loginRequest.password);
  }
  
  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async{
    return await _appServicesClient.forgotPassword(email);
    
  }

 
}