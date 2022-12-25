import 'package:dartz/dartz.dart';
import 'package:shopping_app/data/network/failure.dart';
import 'package:shopping_app/data/network/requests.dart';
import 'package:shopping_app/domain/model/models.dart';

abstract class Repository{
  Future<Either<Failure, Authentication>>login(LoginRequest loginRequest);
}

