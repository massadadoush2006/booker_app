import 'package:booker/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_event.dart';
import 'package:booker/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:booker/model/usermodel.dart';
import 'package:booker/screen/verify_code_page.dart';
import 'package:booker/screen/sign_in.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  bool _isChecked = false;
  bool _isObscure = true;

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
                  Column(
                    children: [
                      Image.asset('assets/logo.png', width: 80, height: 105),
                      SizedBox(height: 4),
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
                  SizedBox(height: 40),

                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      controller: Phone_Number,
                      //كيبورد أرقام بس
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(127, 86, 217, 1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(127, 86, 217, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      obscureText: _isObscure,
                      controller: Password,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(127, 86, 217, 1),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(127, 86, 217, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

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
                      Text("Agree with terms and privacy"),
                    ],
                  ),
                  SizedBox(height: 40),

                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                        print("📌 Current state: $state");

                      if (state is SignUpSuccessState) {
                         print("✅ Success state reached");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            
                                VerifyPage(
                                  phoneNumber: Phone_Number.text,
                                  password: Password.text,
                                  passwordConfirmation: Password.text,
  
                                  ),
                          ),
                        );
                      } else if (state is SignUpErrorState) {
                           print("❌ Error state reached: ${state.error}");

                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          if (Phone_Number.text.isEmpty ||
                              Password.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please fill in all the fields"),
                              ),
                            );
                            return;
                          }

                          if (!_isChecked) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "You must accept the terms first",
                                ),
                              ),
                            );
                            return;
                          }

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
                                builder: (context) => Sign_in(),
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
