import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:piece_of_happiness/features/authentication/models/field_type.dart';
import 'package:piece_of_happiness/features/authentication/models/screen_type.dart';
import 'package:piece_of_happiness/features/authentication/view_models/auth_view_model.dart';
import 'package:piece_of_happiness/features/authentication/views/widgets/auth_bottom_app_bar.dart';
import 'package:piece_of_happiness/features/authentication/views/widgets/auth_button.dart';
import 'package:piece_of_happiness/common/widgets/rounded_stick.dart';
import 'package:piece_of_happiness/common/widgets/rounded_triangle.dart';
import 'package:piece_of_happiness/features/authentication/views/widgets/sign_in_text_field.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeUrl = "/sign-in";
  static const routeName = "sign-in";

  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Map<String, String> _formData = {};

  void _onSignInTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(authProvider.notifier).signIn(
              form: _formData,
              context: context,
            );
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(
          ThemeColors.white,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height - 52,
                    width: size.width,
                    color: const Color(
                      ThemeColors.white,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(
                          ThemeColors.lightBlue,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            40,
                          ),
                          bottomRight: Radius.circular(
                            40,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Gap(size.height * 0.1),
                              Stack(
                                children: [
                                  SizedBox(
                                    width: size.width,
                                    height: size.height * 0.1,
                                  ),
                                  Positioned(
                                    top: size.width * 0.005,
                                    left: size.width * 0.26,
                                    child: Transform.rotate(
                                      angle: math.pi / 5,
                                      child: CustomPaint(
                                        size: Size(size.width * 0.07, 0),
                                        painter: RoundedStick(
                                          color: const Color(
                                            ThemeColors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 15,
                                    left: (size.width / 2) - size.width * 0.13,
                                    child: Transform.rotate(
                                      angle: math.pi / 12,
                                      child: CustomPaint(
                                        size: Size(
                                          size.width * 0.17,
                                          (math.sqrt(3) / 2) *
                                              size.width *
                                              0.17,
                                        ),
                                        painter: RoundedTriangle(
                                          color: const Color(
                                            ThemeColors.white,
                                          ),
                                          radius: 10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Text(
                                      "행복\n조각",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: size.width * 0.08,
                                        color: const Color(
                                          ThemeColors.coral,
                                        ),
                                        height: 1.2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 14,
                                      ),
                                      child: Text(
                                        "이메일",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Gap(4),
                                    SignInTextField(
                                      type: FieldType.email,
                                      controller: _emailController,
                                      formData: _formData,
                                    ),
                                    const Gap(26),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        left: 14,
                                      ),
                                      child: Text(
                                        "비밀번호",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Gap(4),
                                    SignInTextField(
                                      type: FieldType.password,
                                      controller: _passwordController,
                                      formData: _formData,
                                    ),
                                  ],
                                ),
                              ),
                              Gap(size.height * 0.15),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.665,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                      ),
                      child: AuthButton(
                        text: "로그인",
                        authFunc: _onSignInTap,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: const AuthBottomAppBar(
          text: "새로운 계정이 필요해요",
          type: ScreenType.signIn,
        ),
      ),
    );
  }
}
