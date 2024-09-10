import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/core/constants.dart';
import 'package:test_app2/features/main_screen/domain/repository.dart';

part 'sending_state.dart';

class SendingBloc extends Cubit<SendingDataState> {
  final Repository _repository;

  SendingBloc({required Repository repository})
      : _repository = repository,
        super(SendingDataState.initial());

  String? validateName(String? data) {
    if (data!.isEmpty) {
      emit(state.copyWith(validName: false));
      return 'Name cannot be empty';
    } else if (!RegExp(nameValidator).hasMatch(data)) {
      emit(state.copyWith(validName: false));
      return 'Name should be more than 2 characters';
    }
    emit(state.copyWith(validName: true));
    return null;
  }

  String? validateEmail(String? data) {
    if (data!.isEmpty) {
      emit(state.copyWith(validEmail: false));
      return 'Email cannot be empty';
    } else if (!RegExp(emailValidator).hasMatch(data)) {
      emit(state.copyWith(validEmail: false));
      return 'Email is incorrect';
    }
    emit(state.copyWith(validEmail: true));
    return null;
  }

  String? validatePhone(String? data) {
    if (data!.isEmpty) {
      emit(state.copyWith(validPhone: false));
      return 'Phone number cannot be empty';
    } else if (!RegExp(phoneValidator).hasMatch(data)) {
      emit(state.copyWith(validPhone: false));
      return 'Phone number is incorrect';
    }
    emit(state.copyWith(validPhone: true));
    return null;
  }

  Future<void> sendData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(state.copyWith(status: SendingDataEnum.inProcess));
    final result = await _repository.sendData(name, email, phone);
    emit(
      result
          ? state.copyWith(
              status: SendingDataEnum.success,
              validEmail: false,
              validName: false,
              validPhone: false,
            )
          : state.copyWith(
              status: SendingDataEnum.failure,
              message: 'Server error. Please try again',
            ),
    );
    // and set back an initial state
    emit(state.copyWith(status: SendingDataEnum.initial));
  }
}
