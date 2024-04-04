import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodie_fly/controller/blocs/signup/signup_bloc.dart';
import 'package:foodie_fly/controller/cubits/toggle_password/toggle_password_cubit.dart';
import 'package:foodie_fly/controller/cubits/toggle_repasswod/toggle_repassword_cubit.dart';
import 'package:foodie_fly/model/user.dart';
import 'package:foodie_fly/utils/constants.dart';
import 'package:foodie_fly/utils/text_styles.dart';
import 'package:foodie_fly/utils/validaters.dart';
import 'package:foodie_fly/view/screen/main/screen_main_page.dart';
import 'package:foodie_fly/view/screen/otp/screen_otp.dart';
import 'package:foodie_fly/view/widgets/class_widgets/button_widget.dart';
import 'package:foodie_fly/view/widgets/class_widgets/demo_user.dart';
import 'package:foodie_fly/view/widgets/class_widgets/text_form_field.dart';
import 'package:foodie_fly/view/widgets/function_widgets/snackbar.dart';
import 'package:foodie_fly/view/widgets/function_widgets/toggle_password.dart';
import 'package:foodie_fly/view/widgets/function_widgets/toggle_repassword.dart';

class ScreenRegisterPage extends StatefulWidget {
  const ScreenRegisterPage({super.key});

  @override
  State<ScreenRegisterPage> createState() => _ScreenRegisterPageState();
}

class _ScreenRegisterPageState extends State<ScreenRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final rePassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.all(20),
          shadowColor: greenPointShade800,
          surfaceTintColor: greenPointShade800,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                kHight20,
                const Text("Welcome", style: bigBoldBlack),
                const Text(
                  "Sign Up to your account",
                  style: semiBoldBlack,
                ),
                kHight20,
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      kHight10,
                      TextFieldWidget(
                        userController: emailController,
                        label: 'Email-address:',
                        inputType: TextInputType.emailAddress,
                        obscureText: false,
                        validator: (value) {
                          const pattern = regexPatternForLoginAndSignUpByEmail;
                          final regex = RegExp(pattern);
                          if (value!.isEmpty || !regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      TextFieldWidget(
                        userController: firstController,
                        label: 'First name',
                        inputType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      TextFieldWidget(
                        userController: lastController,
                        label: 'Last Name',
                        inputType: TextInputType.name,
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      kHight10,
                      TextFieldWidget(
                          userController: mobileController,
                          label: "Phone number",
                          inputType: TextInputType.phone,
                          obscureText: false,
                          validator: (value) {
                            if (value!.length != 13) {
                              return 'Mobile Number must be of 13 digit with country code +91';
                            } else {
                              return null;
                            }
                          }),
                      kHight10,
                      BlocBuilder<TogglepasswordCubit, bool>(
                        builder: (context, state) {
                          return TextFieldWidget(
                            userController: passwordController,
                            label: 'Password:',
                            inputType: TextInputType.emailAddress,
                            obscureText: state,
                            suffixIcon: togglePassword(),
                            validator: (value) {
                              const pattern =
                                  regexPatternForLoginAndSignUpByPassword;
                              final regex = RegExp(pattern);
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              if (!regex.hasMatch(value)) {
                                return 'Enter valid password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      kHight10,
                      BlocBuilder<ToggleRepasswordCubit, bool>(
                        builder: (context, state) {
                          return TextFieldWidget(
                            userController: rePassController,
                            label: 'Re-enter Password:',
                            inputType: TextInputType.emailAddress,
                            obscureText: state,
                            suffixIcon: toggleRePassword(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Re-enter password';
                              }
                              if (value != passwordController.text) {
                                return 'Wrong password';
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      kHight20,
                      BlocConsumer<SignupBloc, SignupState>(
                        listener: (context, state) {
                          if (state is SuccessState) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const ScreenOTP(),
                            ));
                            showSnack(context, green, "verify otp to see home");
                          } else if (state is FailedInvalidfields) {
                            showSnack(context, amber, "failed. invalid fields");
                          } else if (state is FailedToSignupUser) {
                            showSnack(context, amber, "failed to Sign up User");
                          } else if (state is FieldToParseBodyState) {
                            showSnack(context, orange, "failed to parse body");
                          } else if (state is ErrorState) {
                            showSnack(context, red, "Error");
                          }
                        },
                        builder: (context, state) {
                          return ButtonWidget(
                            width: size * 6 / 10,
                            height: size * 2.7 / 10,
                            text: 'Sign Up',
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final email = emailController.text;
                                final fname = firstController.text;
                                final lname = lastController.text;
                                final phone = mobileController.text;
                                final password = passwordController.text;
                                final repassword = rePassController.text;
                                final user = User(
                                  fName: fname,
                                  lName: lname,
                                  email: email,
                                  phone: phone,
                                  password: password,
                                  rePassword: repassword,
                                );
                                context
                                    .read<SignupBloc>()
                                    .add(SignupEvent(user: user));
                              }
                            },
                          );
                        },
                      ),
                      kHight30,
                      const DemoUser(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
