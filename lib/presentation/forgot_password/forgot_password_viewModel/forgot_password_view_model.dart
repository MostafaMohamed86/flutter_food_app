import 'dart:async';

import 'package:shopping_app/app/functions.dart';
import 'package:shopping_app/domain/usecase/forgot_password_usecase.dart';
import 'package:shopping_app/presentation/base/base_view_model.dart';
import 'package:shopping_app/presentation/common/state_renderer/state_renderer.dart';
import 'package:shopping_app/presentation/common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final StreamController _emailStreamController =
      StreamController<void>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  var email = "";
  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popupLoadingState));
    (await _forgotPasswordUseCase.execute(email)).fold((failure) {
      inputState
          .add(ErrorState(StateRendererType.popupErrorState, failure.message));
    }, (supportMessage) {
      inputState.add(ContentState());
    });
  }

  @override
  // TODO: implement inputEmail
  Sink get inputEmail => _emailStreamController.sink;

  @override
  // TODO: implement inputIsAllInputValid
  Sink get inputIsAllInputValid => _isAllInputValidStreamController.sink;

  @override
  // TODO: implement outputIsEmailValid
  Stream<bool> get outputIsEmailValid => _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  // TODO: implement outputIsInputValid
  Stream<bool> get outputIsInputValid => _isAllInputValidStreamController.stream.map((isAllInputValid) => _isAllInputValid());

  _isAllInputValid() {
    return isEmailValid(email);
  }

  _validate() {
    inputIsAllInputValid.add(null);
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    _validate();
  }
}

abstract class ForgotPasswordViewModelInput {
  forgotPassword();

  setEmail(String email);

  Sink get inputEmail;

  Sink get inputIsAllInputValid;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get outputIsEmailValid;

  Stream<bool> get outputIsInputValid;
}
