import '../../index.dart';
import 'login-controller.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class SigninWidget extends StatefulWidget {
  const SigninWidget({Key key}) : super(key: key);

  @override
  _SigninWidgetWidgetState createState() => _SigninWidgetWidgetState();
}

class _SigninWidgetWidgetState extends State<SigninWidget> {
  TextEditingController emailAddressController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  SigninMan signinUserServices = SigninMan();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                      child: Text( 'Sign In',
                        style: FlutterAppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                        ),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 80,
                      color: Color(0xFF9457FB)
                    ),
                    Divider(
                      thickness: 3,
                      indent: 5,
                      endIndent: 250,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        LabeledRowWidget(text: 'Email'),
                        TextFormFieldWidget(
                          controller: emailAddressController,
                          isRequired: true,
                          isEmail: true,
                        ),
                        LabeledRowWidget(text: 'Password'),
                        PasswordFormField(
                          controller: passwordController,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 20, 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>  ForgetpasswordWidget(),
                                  ),
                                );
                              },
                              child: Text( 'Forget password ?',
                                style: FlutterAppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Roboto',
                                  color: FlutterAppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                  child: Container(
                                    height: 45,
                                  child:ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:  MaterialStateProperty.all<Color>(Colors.black),
                                    ),
                                    onPressed: _isLoading ? null : _signInUser,
                                    child: _isLoading
                                    ? CircularProgressIndicator(color: Colors.white, strokeWidth: 1)
                                    : Text('Sign In',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                  ),
                                ),
                                ),
                              )
                            ]
                          )
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                                child: Text('Or connect with',
                                  style: FlutterAppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    color: FlutterAppTheme.of(context).secondaryText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                          child: SocialLoginButton(
                            buttonType: SocialLoginButtonType.google,
                            onPressed: () {
                              var result = signinUserServices.signInWithGoogle();
                              if (result != null) {}
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 10),
                          child: SocialLoginButton(
                            buttonType: SocialLoginButtonType.facebook,
                            onPressed: () {
                              var result = signinUserServices.facebookSignin();
                              if (result != null) {}
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text( "Don't have an account? ",
                                style: FlutterAppTheme.of(context).bodyText1.override(
                                  fontFamily: 'Roboto',
                                  color: FlutterAppTheme.of(context).secondaryText,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateAccountWidget(),
                                    ),
                                  );
                                },
                                child: Text("Sign Up",
                                  style: FlutterAppTheme.of(context).bodyText1.override(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9457FB),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
Future<void> _signInUser() async {
    if (formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      String response = await signinUserServices.signinUser(emailAddressController.text, passwordController.text);
      setState(() {
        _isLoading = false;
      });

      if (response == "User signin successfully") {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeWidget(),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alertDialogWidget(
              title: "Error!",
              content: "$response",
            );
          },
        );
      }
    }
  }
}
