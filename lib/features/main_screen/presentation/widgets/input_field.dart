import 'package:flutter/material.dart';
import 'package:test_app2/features/main_screen/presentation/bloc/sending_bloc.dart';
import 'package:test_app2/service_locator.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool enabled;

  const InputField({
    super.key,
    required this.enabled,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.validator,
    this.focusNode,
  });

  @override
  State<InputField> createState() => _InputFieldState();

  factory InputField.email({
    required TextEditingController controller,
    required bool disabled,
  }) =>
      InputField(
        controller: controller,
        labelText: 'Email',
        hintText: 'Enter your email',
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        enabled: !disabled,
        validator: sl<SendingBloc>().validateEmail,
      );

  factory InputField.name({
    required TextEditingController controller,
    required bool disabled,
  }) =>
      InputField(
        controller: controller,
        labelText: 'Name',
        hintText: 'Enter your name',
        obscureText: false,
        keyboardType: TextInputType.text,
        enabled: !disabled,
        validator: sl<SendingBloc>().validateName,
      );

  factory InputField.phone({
    required TextEditingController controller,
    required bool disabled,
  }) =>
      InputField(
        controller: controller,
        labelText: 'Phone',
        hintText: 'Enter phone number',
        obscureText: false,
        keyboardType: TextInputType.phone,
        enabled: !disabled,
        validator: sl<SendingBloc>().validatePhone,
      );
}

class _InputFieldState extends State<InputField> {
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        if (!value) {
          setState(() {
            errorMessage = widget.validator?.call(widget.controller.text);
          });
        } else {
          setState(() {
            errorMessage = null;
          });
        }
      },
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: widget.labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          disabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.error,
              width: 2,
            ),
          ),
          hintText: widget.hintText,
          errorText: errorMessage,
        ),
      ),
    );
  }
}
