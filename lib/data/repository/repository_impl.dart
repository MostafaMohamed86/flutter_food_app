import 'package:shopping_app/data/data_source/remote_data_source.dart';
import 'package:shopping_app/data/mapper/mapper.dart';
import 'package:shopping_app/data/network/error_handler.dart';
import 'package:shopping_app/data/network/network_info.dart';
import 'package:shopping_app/domain/model/models.dart';
import 'package:shopping_app/data/network/requests.dart';
import 'package:shopping_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shopping_app/domain/repository/repository.dart';

class RepositoryImpl implements Repository{
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImpl(this._remoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async{
    if(await _networkInfo.isConnected){

      try{
        final response = await _remoteDataSource.login(loginRequest);

      if(response.status == ApiInternalStatus.SUCCESS){
        return Right(response.toDomain());
      }else{
        return Left(Failure(ApiInternalStatus.FAILURE,response.message ?? ResponseMessage.DEFAULT));
      }
      }catch(error){
         return Left(ErrorHandler.handle(error).failure);
      }
      
    }else{
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if(await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await _remoteDataSource.forgotPassword(email);
        
        if(response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
          response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
  
}