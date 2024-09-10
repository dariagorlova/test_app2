part of 'sending_bloc.dart';

enum SendingDataEnum { initial, inProcess, success, failure }

class SendingDataState {
  final SendingDataEnum status;
  final String? message;
  final bool validName;
  final bool validEmail;
  final bool validPhone;

  const SendingDataState({
    required this.status,
    required this.validName,
    required this.validEmail,
    required this.validPhone,
    this.message,
  });

  SendingDataState copyWith({
    SendingDataEnum? status,
    String? message,
    bool? validName,
    bool? validEmail,
    bool? validPhone,
  }) {
    return SendingDataState(
      status: status ?? this.status,
      message: message ?? this.message,
      validName: validName ?? this.validName,
      validEmail: validEmail ?? this.validEmail,
      validPhone: validPhone ?? this.validPhone,
    );
  }

  factory SendingDataState.initial() {
    return const SendingDataState(
      status: SendingDataEnum.initial,
      validName: false,
      validEmail: false,
      validPhone: false,
    );
  }
}
