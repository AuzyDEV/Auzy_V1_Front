import 'package:new_mee/authentification/create-account/create-account-controller.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';

import '../../../themes/alert-popup.dart';
import '../../../themes/custom-button-widget.dart';
import '../../../themes/theme.dart';
import '../../index.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';

import '../login/login-view.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({Key key}) : super(key: key);

  @override
  _CreateAccountWidgetState createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  TextEditingController emailAddressController;
  TextEditingController fullnameController;
  TextEditingController photourlController;
  TextEditingController passwordController;
  bool passwordVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static final RegExp emailReg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final formKey = GlobalKey<FormState>();
  bool futurepost;
  CreateAccountMan api = CreateAccountMan();

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    fullnameController = TextEditingController();
    passwordController = TextEditingController();
    photourlController = TextEditingController();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 40, 16, 25),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Color(0xff132137),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 25, 16, 30),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create',
                    style: FlutterAppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                        ),
                  ),
                  Text(
                    'Account',
                    style: FlutterAppTheme.of(context).bodyText1.override(
                          fontFamily: 'Open Sans',
                          fontSize: 30,
                        ),
                  ),
                  Divider(
                    thickness: 3,
                    indent: 5,
                    endIndent: 200,
                    color: FlutterAppTheme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Full Name'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: fullnameController,
                              isRequired: true,
                              isString: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Photo url'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: photourlController,
                              isRequired: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Email'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: emailAddressController,
                              isRequired: true,
                              isEmail: true,
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
                            child: LabeledRowWidget(text: 'Password'),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              controller: passwordController,
                              isRequired: true,
                              isPassword: true,
                              obscureText: !passwordVisibility,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 30, 16, 10),
                            child: Row(children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  child: buttonWidget(
                                    onPressed: () async {
                                      if (formKey.currentState.validate()) {
                                        String response = await api.signupUser(
                                            emailAddressController.text,
                                            passwordController.text,
                                            fullnameController.text,
                                            photourlController.text);
                                        print(response);
                                        response ==
                                                "User registred & email send successfully"
                                            ? showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Succes!",
                                                    content:
                                                        "Registration completed successfully! please check your email to verify your email adress",
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Ok"),
                                                        onPressed: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SigninWidget(),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    ],
                                                  );
                                                })
                                            : showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Error!",
                                                    content: "$response",
                                                  );
                                                });
                                      }
                                    },
                                    text: 'create',
                                  ),
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
