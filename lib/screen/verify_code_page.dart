import 'package:booker/bloc/verify_code_bloc/verify_code_bloc.dart';
import 'package:booker/bloc/verify_code_bloc/verify_code_event.dart';
import 'package:booker/bloc/verify_code_bloc/verify_code_state.dart';
import 'package:booker/screen/fill_your_profile.dart';
import 'package:booker/service/verify_code_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPage extends StatefulWidget {
  final String phoneNumber;
    final String password;

  final String passwordConfirmation;


  const VerifyPage({super.key, required this.phoneNumber, required this. password, required this.passwordConfirmation});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VerifyBloc(AuthService()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Verify Code")),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("📱 phoneNumber : ${widget.phoneNumber}"),
              const SizedBox(height: 20),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: " Enter the code (OTP)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

             BlocConsumer<VerifyBloc, VerifyState>(
  listener: (context, state) {
    if (state is VerifySuccessState) {
      
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const fill_profile (), 
        ),
      );
    } else if (state is VerifyErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  },
  builder: (context, state) {
    return ElevatedButton(
      onPressed: state is VerifyLoadingState
          ? null
          : () {
              context.read<VerifyBloc>().add(
                    SubmitVerifyOtp(
                      phone: widget.phoneNumber,
                      otp: otpController.text,
                      password: widget.password,
                      password_confirmation: widget.passwordConfirmation,
                    ),
                  );
            },
      child: state is VerifyLoadingState
          ? const CircularProgressIndicator(color: Colors.white)
          : const Text("check"),
    );
  },
)
            ],
          ),
        ),
      ),
    );
  }
}