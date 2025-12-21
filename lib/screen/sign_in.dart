import 'package:booker/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:booker/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:booker/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:booker/model/usermodel.dart';
import 'package:booker/screen/forgot_password.dart';
import 'package:booker/service/sign_in_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class Sign_in extends StatefulWidget {
  const Sign_in({super.key});

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  bool _isChecked = false;
  bool _isObscure = true;
  bool _isPhoneError = false;
  bool _isPasswordError = false;

  TextEditingController Phone_Number = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(SignInAuthService()),
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

                
                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      controller: Phone_Number,
                      onChanged: (value) {
                        if (_isPhoneError) {
                          setState(() {
                            _isPhoneError = false;
                          });
                        }
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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

                  
                  SizedBox(
                    width: 327,
                    height: 50,
                    child: TextField(
                      obscureText: _isObscure,
                      controller: Password,
                      onChanged: (value) {
                        if (_isPhoneError) {
                          setState(() {
                            _isPasswordError = false;
                          });
                        }
                      },
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

                  
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Color.fromRGBO(127, 86, 217, 1),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Row(
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
                    ),
                  ),
                  const SizedBox(height: 40),

                  
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (context, state) {
                      if (state is SignInSuccessState) {
                        setState(() {
                          _isPhoneError = false;
                          _isPasswordError = false;
                        });
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.message)));
                      } else if (state is SignInErrorState) {
                        
                        if (state.error.contains(
                          "Invalid phone_number or password",
                        )) {
                          setState(() {
                            _isPhoneError = true;
                            _isPasswordError = true;
                          });
                        }
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },

                    builder: (context, state) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _isPhoneError = false;
                            _isPasswordError = false;
                          });

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
                                  "Please agree to terms and privacy",
                                ),
                              ),
                            );
                            return;
                          }

                          Usermodel user = Usermodel(
                            phone_number: Phone_Number.text,
                            password: Password.text,
                          );

                          context.read<SignInBloc>().add(
                            SubmitSignInEvent(user: user),
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
                            child: state is SignInLoadingState
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Sign In",
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
          ],
        ),
      ),
    );
  }
}
