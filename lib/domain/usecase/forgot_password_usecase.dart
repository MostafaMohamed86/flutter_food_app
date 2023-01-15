import 'package:shopping_app/data/network/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:shopping_app/domain/repository/repository.dart';
import 'package:shopping_app/domain/usecase/base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, String> {
  final Repository _repository;
  ForgotPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, String>> execute(String input) async{
    return await _repository.forgotPassword(input);
  }
  
}