import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app2/features/main_screen/presentation/bloc/sending_bloc.dart';
import 'package:test_app2/features/main_screen/presentation/widgets/caption.dart';
import 'package:test_app2/features/main_screen/presentation/widgets/input_field.dart';
import 'package:test_app2/features/main_screen/presentation/widgets/send_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendingBloc, SendingDataState>(
        listener: (context, state) {
      if (state.status == SendingDataEnum.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message ?? ''),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (state.status == SendingDataEnum.success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Data sent successfully'),
          showCloseIcon: true,
          behavior: SnackBarBehavior.floating,
        ));
        nameController.clear();
        emailController.clear();
        phoneController.clear();
      }
    }, builder: (context, state) {
      return GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CaptionWidget(text: 'Welcome!'),
                        const SizedBox(height: 72),
                        InputField.name(
                          controller: nameController,
                          disabled: state.status == SendingDataEnum.inProcess,
                        ),
                        const SizedBox(height: 36),
                        InputField.email(
                          controller: emailController,
                          disabled: state.status == SendingDataEnum.inProcess,
                        ),
                        const SizedBox(height: 36),
                        InputField.phone(
                          controller: phoneController,
                          disabled: state.status == SendingDataEnum.inProcess,
                        ),
                        const SizedBox(height: 48),
                        SendButton(
                          onPressed:
                              state.status == SendingDataEnum.inProcess ||
                                      !state.validEmail ||
                                      !state.validName ||
                                      !state.validPhone
                                  ? null
                                  : _login,
                          child: state.status == SendingDataEnum.inProcess
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                )
                              : Text(
                                  'Send',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  void _login() {
    // validation is useless here. it will work correct and without "_formKey.currentState!.validate()"
    if (_formKey.currentState!.validate()) {
      context.read<SendingBloc>().sendData(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          );
    }
  }
}
