import 'package:shopping_app/data/data_source/remote_data_source.dart';
import 'package:shopping_app/data/mapper/mapper.dart';
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
      final response = await _remoteDataSource.login(loginRequest);

      if(response.status == 0){
        return Right(response.toDomain());
      }else{
        return Left(Failure(409,response.message ?? "business error message"));
      }
    }else{
      return Left(Failure(501, "Please check your internet connection!"));
    }
  }
  
}