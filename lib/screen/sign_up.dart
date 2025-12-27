import 'package:booker/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:booker/model/usermodel.dart';
import 'package:booker/screen/sign_in.dart';
import 'package:booker/screen/verify_code_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  bool _isChecked = false;
  bool _isObscure = true;

  bool _isPhoneError = false;
  bool _isPasswordError = false;

  TextEditingController Phone_Number = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ================= LOGO =================
                  Column(
                    children: [
                      Image.asset('assets/logo.png', width: 80, height: 105),
                      const SizedBox(height: 4),
                      Container(
                        width: 52,
                        height: 9,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(127, 86, 217, 0.1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ================= PHONE FIELD =================
                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      controller: Phone_Number,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                      onChanged: (value) {
                        if (_isPhoneError) {
                          setState(() {
                            _isPhoneError = false;
                          });
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _isPhoneError
                                ? Colors.red
                                : const Color.fromRGBO(127, 86, 217, 1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _isPhoneError
                                ? Colors.red
                                : const Color.fromRGBO(127, 86, 217, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ================= PASSWORD FIELD =================
                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      obscureText: _isObscure,
                      controller: Password,

                      onChanged: (value) {
                        if (_isPasswordError) {
                          setState(() {
                            _isPasswordError = false;
                          });
                        }
                      },

                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _isPasswordError
                                ? Colors.red
                                : const Color.fromRGBO(127, 86, 217, 1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: _isPasswordError
                                ? Colors.red
                                : const Color.fromRGBO(127, 86, 217, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ================= CHECKBOX =================
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isChecked = newValue!;
                          });
                        },
                      ),
                      const Text("Agree with terms and privacy"),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ================= SIGN UP BUTTON =================
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyPage(
                              phoneNumber: Phone_Number.text,
                              password: Password.text,
                              passwordConfirmation: Password.text,
                            ),
                          ),
                        );
                      } else if (state is SignUpErrorState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _isPhoneError = false;
                            _isPasswordError = false;
                          });

                          // ================= VALIDATION =================

                          if (Phone_Number.text.isEmpty ||
                              Password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all the fields"),
                              ),
                            );
                            return;
                          }

                          if (Phone_Number.text.length != 10) {
                            setState(() {
                              _isPhoneError = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Phone number must be 10 digits"),
                              ),
                            );
                            return;
                          }

                          if (!_isChecked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("You must accept the terms first"),
                              ),
                            );
                            return;
                          }

                          // ================= SEND DATA =================
                          Usermodel newUser = Usermodel(
                            phone_number: Phone_Number.text,
                            password: Password.text,
                            password_confirmation: Password.text,
                          );

                          context.read<SignUpBloc>().add(
                                SubmitSignUpEvent(user: newUser),
                              );
                        },

                        child: Container(
                          width: 327,
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(127, 86, 217, 1),
                          ),
                          child: Center(
                            child: state is SignUpLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // ================= SIGN IN AT BOTTOM =================
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: "Already have an Account? ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: const TextStyle(
                          color: Color.fromRGBO(127, 86, 217, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Sign_in(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}