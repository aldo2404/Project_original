// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_project/constantbase/baseconstant.dart';
import 'package:fx_project/controller/login_controller.dart';
import 'package:fx_project/layout/alertbox.dart';
import 'package:fx_project/layout/buttonfield.dart';
import 'package:fx_project/layout/input_field.dart';
import 'package:fx_project/models/login_response_model.dart';
import 'package:fx_project/screens/environmentpage.dart';
import 'package:fx_project/screens/forgotpasswordpage.dart';
import 'package:fx_project/services/loginservice.dart';
import '../layout/background_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  bool _isChecked = false;
  bool passToggle = true;

  late Box table1;
  @override
  void initState() {
    super.initState();
    loginTable();
  }

  void loginTable() async {
    table1 = await Hive.openBox('logindata');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: buildBlocProvider,
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: buildBlocListener,
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                BackGroundImg().images(),
                Form(
                  key: formfield,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 160),
                        const Text("Welcome back!",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                        const SizedBox(height: 30),
                        ReuseTextFields(
                          width: 300,
                          textAlign: TextAlign.center,
                          keyboardtypes: TextInputType.emailAddress,
                          hinttext: "Username",
                          inputfieldcolor: Colors.white,
                          password: false,
                          readOnly: false,
                          maxLines: 1,
                          controller: emailcontroller,
                          helperText: '',
                          validate: ((value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(value)) {
                              return 'Enter correct email id';
                            }
                            return null;
                          }),
                        ),
                        ReuseTextFields(
                          width: 300,
                          textAlign: TextAlign.center,
                          keyboardtypes: TextInputType.visiblePassword,
                          hinttext: "Password",
                          inputfieldcolor: Colors.white,
                          password: passToggle,
                          readOnly: false,
                          maxLines: 1,
                          controller: passcontroller,
                          helperText: '',
                          suffixs: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Icon(
                                passToggle
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 16.0,
                              ),
                            ),
                          ),
                          validate: MultiValidator([
                            RequiredValidator(errorText: "*Required"),
                            MinLengthValidator(6,
                                errorText: "password lenght too short"),
                            MaxLengthValidator(15,
                                errorText: "Password length too high")
                          ]),
                        ),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.only(top: 0, bottom: 5),
                          child: GestureDetector(
                            child: Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.white,
                                  side: const BorderSide(
                                      width: 2, color: Colors.white),
                                  value: _isChecked,
                                  onChanged: (value) {
                                    _isChecked = !_isChecked;
                                    setState(() {});
                                  },
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onTap: () => setState(() {
                              _isChecked = !_isChecked;
                            }),
                          ),
                        ),
                        ClickButton(
                            child: state is LoginLoading
                                ? const SizedBox(
                                    height: 15,
                                    width: 15,
                                    child: CircularProgressIndicator.adaptive(
                                      strokeWidth: 3,
                                    ))
                                : const Text('Log In'),
                            onpressed: () {
                              if (emailcontroller.text.isEmpty ||
                                  passcontroller.text.isEmpty) {
                                ReuseAlertDialogBox().alertDialog(context,
                                    "Alert", "please enter valid data");
                              }
                              if (formfield.currentState!.validate()) {
                                context.read<LoginCubit>().onPressedLogin(
                                    emailcontroller, passcontroller);
                                login();

                                print(emailcontroller.text.toString());
                                print(passcontroller.text.toString());

                                print("data store success");
                              } else {
                                print("Enter valied data");
                              }
                            }),
                        Container(
                          width: 300,
                          padding: const EdgeInsets.only(top: 10, bottom: 0),
                          child: const Text(
                            "or",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ClickButton(
                          child: const Text("Log In with SSO"),
                          onpressed: () {},
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          heightFactor: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        const PasswordForgotPage()));
                              });
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void buildBlocListener(context, state) {
    if (state is LoginCompleted) {
      final data = state.loginModel;

      print("data error_${data.error}");
      if (data.error != null) {
        print('${data.error}');
        ReuseAlertDialogBox().alertDialog(context, "Alert", data.error!);
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (_) =>
                  EnvironmentPage(domains: data.domains as List<DomainModel>)),
        );
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Log In Success")));
      }
    }
  }

  LoginCubit buildBlocProvider(context) => LoginCubit(
        service: LoginService(
          service: Dio(BaseOptions(baseUrl: Constants.baseUrl)),
        ),
      );

  void login() {
    if (_isChecked) {
      table1.put('email', emailcontroller.text);
      table1.put('password', passcontroller.text);
    }
  }

  void getData() async {
    if (table1.get('email') != null) {
      emailcontroller.text = table1.get('email');
      _isChecked = true;
      setState(() {});
    }
    if (table1.get('password') != null) {
      passcontroller.text = table1.get('password');
      _isChecked = true;
      setState(() {});
    }
  }
}
