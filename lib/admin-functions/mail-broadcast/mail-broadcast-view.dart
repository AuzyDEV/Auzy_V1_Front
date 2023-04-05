import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:new_mee/home/home-view.dart';
import 'package:new_mee/themes/label-row.dart';
import 'package:new_mee/themes/text-field.dart';

import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import '../../themes/alert-popup.dart';
import '../../themes/app-bar-widget.dart';
import '../../themes/custom-button-widget.dart';
import '../../themes/left-drawer.dart';
import 'mail-broadcast-controller.dart';

class announcementWidget extends StatefulWidget {
  const announcementWidget({Key key}) : super(key: key);

  @override
  _announcementWidgetState createState() => _announcementWidgetState();
}

class _announcementWidgetState extends State<announcementWidget> {
  TextEditingController messageController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  AnnoucementMan Annapi = AnnoucementMan();
  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterAppTheme.of(context).whiteColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appbar(text: 'Annoucement'),
        ),
        drawer: Drawerr(),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
                              child: LabeledRowWidget(text: 'Message')),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                            child: TextFormFieldWidget(
                              maxLines: 8,
                              controller: messageController,
                              isRequired: true,
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
                                        bool response =
                                            await Annapi.sendBroadcastEmail(
                                                messageController.text);
                                        print(response);
                                        response == true
                                            ? showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alertDialogWidget(
                                                    title: "Succes!",
                                                    content:
                                                        "Email was sent successfully",
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Ok"),
                                                        onPressed: () async {
                                                          await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  HomeWidget(),
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
                                                    title: "Succes!",
                                                    content: "$response",
                                                  );
                                                });
                                      }
                                    },
                                    text: 'send',
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
        ));
  }
}