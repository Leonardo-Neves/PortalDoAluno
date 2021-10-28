import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Utils
import '../modules/CustomColor.dart';
import 'package:projeto/base_widget.dart';

// App
import 'package:projeto/controller/signin.controller.dart';
import 'package:flutter/services.dart';

// View Model
import 'package:projeto/view-models/signin.viewmodel.dart';

// View
import 'package:projeto/views/home.dart';

// Packages
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  var emailTextInputController, passwordTextInputController;

  var modelSignIn = new SignInViewModel();

  bool obscureTextFieldPassword = true;
  final _formSignInKey = GlobalKey<FormState>();

  void initState() {
    super.initState();

    emailTextInputController = TextEditingController();
    passwordTextInputController = TextEditingController();

    Future.delayed(Duration.zero, () async {
      SignInController signInController =
          new SignInController(api: Provider.of(context, listen: false));
      var student = signInController.getStudent();

      if (student.name != null) _navegateToHome();
    });
  }

  _navegateToHome() {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => Home(),
      ),
    );
  }

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BaseWidget<SignInController>(
      model: SignInController(api: Provider.of(context)),
      builder: (context, model, child) => Scaffold(
        body: Stack(
          children: [
            SvgPicture.asset(
              'asset/image/signup.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'asset/image/slogan.png',
                        width: size.width * 0.6,
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Text(
                        'Portal do Aluno',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20.0,
                          color: Color(CustomColor.White),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Entre em sua conta',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Color(CustomColor.White),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Form(
                        key: _formSignInKey,
                        child: Column(
                          children: [
                            Input(
                              hintText: 'Usuário/RA',
                              controller: emailTextInputController,
                              type: TextInputType.text,
                              obscureText: false,
                              suffixIcon: false,
                              functionIconButton: () {},
                            ),
                            Input(
                              hintText: 'Senha',
                              controller: passwordTextInputController,
                              type: TextInputType.text,
                              obscureText: obscureTextFieldPassword,
                              suffixIcon: true,
                              iconButton: Icons.remove_red_eye,
                              functionIconButton: () {
                                setState(() => obscureTextFieldPassword == true
                                    ? obscureTextFieldPassword = false
                                    : obscureTextFieldPassword = true);
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(0),
                              primary: Color(CustomColor.White),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Esqueceu sua senha ?',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: Color(CustomColor.White),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28.0),
                          color: Color(CustomColor.OrangeNormal),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            if (model.busy == false) {
                              if (_formSignInKey.currentState!.validate()) {
                                modelSignIn.ra = emailTextInputController.text;
                                modelSignIn.password =
                                    passwordTextInputController.text;
                                passwordTextInputController.clear();
                                FocusScope.of(context).unfocus();

                                await model.login(modelSignIn, context);
                              }
                            }
                          },
                          child: model.busy == true
                              ? SizedBox(
                                  height: 28.0,
                                  width: 28.0,
                                  child: CircularProgressIndicator(
                                    color: Color(CustomColor.White),
                                  ),
                                )
                              : Text(
                                  'Acessar',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Color(CustomColor.White),
                                  ),
                                ),
                        ),
                      )
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

class Input extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType type;
  final bool obscureText;
  final bool suffixIcon;
  final IconData iconButton;
  final functionIconButton;

  const Input({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.type,
    required this.obscureText,
    required this.suffixIcon,
    this.iconButton = Icons.account_balance,
    this.functionIconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10.0,
      ),
      height: 42.0,
      decoration: BoxDecoration(
        color: Color(CustomColor.GrayLight),
        borderRadius: BorderRadius.circular(22.0),
      ),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: type,
        controller: controller,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(CustomColor.GrayDark),
        ),
        decoration: InputDecoration(
          suffixIcon: this.suffixIcon == true
              ? IconButton(
                  onPressed: this.functionIconButton,
                  iconSize: 24.0,
                  icon: Icon(iconButton),
                  color: Color(CustomColor.GrayDark).withOpacity(0.6),
                )
              : Text(''),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(CustomColor.GrayDark),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 22.0,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(CustomColor.GrayLighter),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(22.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return null;
          }
          return null;
        },
      ),
    );
  }
}
