import '../authentification/login/login-controller.dart';
import '../index.dart';
import 'profile-controller.dart';
import 'profile-model.dart';
import '../../themes/theme.dart';
import 'package:flutter/material.dart';

class MyprofilWidget extends StatefulWidget {
  final String id;
  const MyprofilWidget({Key key, this.id}) : super(key: key);

  @override
  _MyprofilWidgetState createState() => _MyprofilWidgetState();
}

class _MyprofilWidgetState extends State<MyprofilWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProfilingMan profilingUserServices = ProfilingMan();
  SigninMan signinUserServices = SigninMan();
  Future<User> _futureUser;
  @override
  void initState() {
    super.initState();
    _futureUser = profilingUserServices.GetCurrentUser();
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
        child: appbar(text: 'My profil'),
      ),
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            FutureBuilder<User>(
              future: _futureUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: FlutterAppTheme.of(context).TransparentColor,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional.fromSTEB(16, 20,16, 0),
                                                  child: Text(
                                                    '${snapshot.data.displayName}',
                                                    style: TextStyle(
                                                      fontSize: 23,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Center(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(16, 5, 16, 15),
                                                    child: Text(
                                                      '${snapshot.data.email}',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(context,
                                        MaterialPageRoute(
                                            builder: (context) => editprofilWidget( id: snapshot.data.id,name: snapshot.data.displayName, email: snapshot.data.email, photourl: snapshot.data.photoURL)),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterAppTheme.of(context)
                                            .TransparentColor,
                                        borderRadius:
                                            BorderRadius.circular(12),
                                        border: Border.all(
                                          color: FlutterAppTheme.of(context)
                                              .lineColor,
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional
                                                .fromSTEB(8, 12, 8, 12),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              8, 0, 0, 0),
                                                  child: Icon(
                                                    Icons
                                                        .account_circle_outlined,
                                                    color: FlutterAppTheme.of(
                                                            context)
                                                        .Grey,
                                                    size: 24,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                              12, 0, 0, 0),
                                                  child: Text(
                                                    'Account Details',
                                                    style: FlutterAppTheme.of(
                                                            context)
                                                        .bodyText2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        await Navigator.push( context,
                                          MaterialPageRoute(
                                            builder: (context) => changePasswordWidget()),
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterAppTheme.of(context).TransparentColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: FlutterAppTheme.of(context).lineColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.lock_outlined,
                                                      color: FlutterAppTheme.of(context).Grey,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                    child: Text('Change password',
                                                      style: FlutterAppTheme.of(context).bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        var confirmDialogResponse =  await showDialog<bool>( context: context,  builder:
                                          (alertDialogContext) {
                                            return alertDialogWidget(
                                              title: 'Block account',
                                              content: 'You will be blocked permanently, you can only restore your account after a request to the admin',
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(alertDialogContext,false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    profilingUserServices.BlockCurrentUser(),
                                                    Navigator.push(context,
                                                      MaterialPageRoute(
                                                        builder: (context) => SigninWidget(),
                                                      ),
                                                    ),
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackbarWidget(
                                                        content: Text('Successfully account blocked!',
                                                      ))
                                                    ),
                                                  },
                                                  child:
                                                    Text('Confirm'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                        false;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterAppTheme.of(context).TransparentColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: FlutterAppTheme.of(context).lineColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.block_flipped,
                                                      color: FlutterAppTheme.of(context).Grey,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                                    child: Text(
                                                      'Deactivate my account',
                                                      style: FlutterAppTheme.of(context).bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 1, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                                    child: InkWell(
                                      onTap: () async {
                                        var confirmDialogResponse = await showDialog<bool>(
                                          context: context, 
                                          builder:
                                          (alertDialogContext) {
                                            return alertDialogWidget(
                                              title: 'Delete account',
                                              content: 'Are you sure to delete your account?',
                                              actions: [
                                                TextButton(
                                                  onPressed: () =>  Navigator.pop(alertDialogContext, false),
                                                  child: Text('Cancel'),
                                                ),
                                                TextButton(
                                                  onPressed: () => {
                                                    profilingUserServices.DeleteCurrentUser(),
                                                    Navigator.push(context,
                                                      MaterialPageRoute(
                                                        builder: (context) => SigninWidget(),
                                                      ),
                                                    ),
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackbarWidget(
                                                        content: Text('Successfully account deleted!',
                                                        ),
                                                      )
                                                    ),
                                                  },
                                                  child: Text('Confirm'),
                                                ),
                                              ],
                                            );
                                          },
                                        ) ??
                                      false;
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterAppTheme.of(context).TransparentColor,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: FlutterAppTheme.of(context).lineColor,
                                            width: 2,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB( 8, 0, 0, 0),
                                                    child: Icon(
                                                      Icons.delete_outlined,
                                                      color: FlutterAppTheme.of(context).Grey,
                                                      size: 24,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB( 12, 0, 0, 0),
                                                    child: Text('Delete my account',
                                                      style: FlutterAppTheme.of(context).bodyText2,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 10, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomButton(
                                onPressed: () async {
                                  bool response = await signinUserServices.LogoutUser();
                                  if (response)
                                    await Navigator.push( context,
                                      MaterialPageRoute(
                                        builder: (context) => SigninWidget(),
                                      ),
                                    );
                                  },
                                text: 'Log Out',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 300, 0, 0),
                  child: CircularProgressIndicatorWidget()
                );
              }
            )
          ]
        ),
      )
    );
  }
}
