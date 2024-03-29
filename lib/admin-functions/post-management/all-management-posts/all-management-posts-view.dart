import 'package:flutter_html/flutter_html.dart';
import '../../../index.dart';
import '../../../social-post/all-posts/all-posts-model.dart';
import '../../../themes/theme.dart';
import 'package:flutter/material.dart';
import '../../../user-profile/profile-controller.dart';
import 'all-management-posts-controller.dart';

class postsNewWidget extends StatefulWidget {
  final String speciality;
  const postsNewWidget({Key key, this.speciality}) : super(key: key);

  @override
  _postsNewWidgetState createState() => _postsNewWidgetState();
}

class _postsNewWidgetState extends State<postsNewWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Future<List<Post>> futurePosts;
  PostMan postServices = PostMan();
  String searchString = "";
  TextEditingController SearchtextController;
  String _futureRoleValue;
  ProfilingMan apiUser = ProfilingMan();
  int itemCount = 2;
  ScrollController _scrollController = ScrollController();

  Future<String> _getCurrentUserRole() async {
    return apiUser.GetCurrentUserRole();
  }

  void _getFutureRoleValue() async {
    String value = await _getCurrentUserRole();
    setState(() {
      _futureRoleValue = value;
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      setState(() {
        itemCount += 3;
      });
    }
  }

  Future<void> _refreshList() async {
    setState(() {
      futurePosts = postServices.getAllListingsNew();
    });
  }

  @override
  void initState() {
    super.initState();
    _getFutureRoleValue();
    futurePosts = postServices.getAllListingsNew();
    _scrollController.addListener(_scrollListener);
    SearchtextController = TextEditingController();
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
        child: appbar(text: 'Post Management'),
      ),
      floatingActionButton: _futureRoleValue == "admin" ? 
        floatingActionButtonWidget(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => addNewPostWidget()),
            );
          },
          icon: Icons.add,
        )
        : null,
      drawer: Drawerr(),
      body: SingleChildScrollView(
        child: Column( mainAxisSize: MainAxisSize.max,
          children: [
            Align(
              alignment: AlignmentDirectional(0.5, 6.41),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormFieldWidget(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    hintText: "Search..",
                    controller: SearchtextController,
                  ),
                ],
              ),
            ),
            RefreshIndicator(
              onRefresh: _refreshList,
              child: Padding( 
                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                child: FutureBuilder<List<Post>>(
                  future: futurePosts,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) => ((snapshot.data[index].contenu.toLowerCase().contains(searchString)) ||
                        (snapshot.data[index].title.toLowerCase().contains(searchString)))
                        ? Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(8,12,8,0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: FlutterAppTheme.of(context).secondaryText,
                                                            width: 0.5,
                                                          ),
                                                          borderRadius: BorderRadius.circular(8.0),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 8),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  children: [
                                                                    Expanded(
                                                                      child: Row(
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 0, 2),
                                                                            child: Text(
                                                                              '${snapshot.data[index].title}',
                                                                              style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: 'Roboto',
                                                                                fontSize: 20
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(16, 2, 0, 15),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                        '${snapshot.data[index].date}',
                                                                        textAlign: TextAlign.left,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.normal,
                                                                          color: Colors.grey
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              ),
                                                              ClipRRect(
                                                                child: Image.network(
                                                                  '${snapshot.data[index].files[0].downloadURL}',
                                                                  loadingBuilder: (context, child, loadingProgress) {
                                                                  if (loadingProgress == null) {
                                                                    return child;
                                                                  }
                                                                  return LinearProgressIndicator();
                                                                  },
                                                                  errorBuilder: (context, error, stackTrace) {
                                                                    return Text('Failed to load image');
                                                                  },
                                                                  height: 300,
                                                                  fit: BoxFit.fill,
                                                                ),
                                                              ),
                                                               Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(12, 13, 12, 10),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Row(
                                                                        children: [
                                                                          InkWell(
                                                                            onTap: () async {
                                                                              await Navigator.push(
                                                                                context,
                                                                                MaterialPageRoute(
                                                                                  builder: (context) => postDetailsWidget( id: snapshot.data[index].id.toString()),
                                                                                ),
                                                                              );
                                                                            },
                                                                            child: Container(
                                                                              width: 40,
                                                                              height: 30,
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.blue[50],
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                child: Icon(
                                                                                    Icons.remove_red_eye_outlined,
                                                                                    color: Colors.blue,
                                                                                    size: 20,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                            child: InkWell(
                                                                              onTap: () async {
                                                                                var confirmDialogResponse =
                                                                                  await showDialog<bool>(
                                                                                    context: context,
                                                                                    builder: (alertDialogContext) {
                                                                                      return alertDialogWidget(
                                                                                        title: 'Delete post',
                                                                                        content: 'Are you sure to delete this post ?',
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                            child: Text('Cancel'),
                                                                                          ),
                                                                                          TextButton(
                                                                                            onPressed: () => {
                                                                                              postServices.deletePost(snapshot.data[index].id.toString()),
                                                                                              Navigator.push(context,
                                                                                                MaterialPageRoute(
                                                                                                  builder: (context) => postsNewWidget(),
                                                                                                ),
                                                                                              ),
                                                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                                                SnackbarWidget(
                                                                                                  content: Text('Successfully post deleted!',
                                                                                                  ),
                                                                                                ),
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
                                                                                width: 40,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color:Color.fromARGB(255, 245, 210,207),
                                                                                  borderRadius:BorderRadius.circular(8),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                  child: Icon(
                                                                                    Icons.delete,
                                                                                    color: Color.fromARGB(255, 163, 32, 23),
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                            child: InkWell(
                                                                              onTap: () async {
                                                                                await Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => editPostDetailsWidget(
                                                                                      id: snapshot.data[index].id.toString(),
                                                                                      title: snapshot.data[index].title,
                                                                                      contenu: snapshot.data[index].contenu,
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                              child: Container(
                                                                                width: 40,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color:Color.fromARGB(214, 241, 228, 200),
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                  child: Icon(
                                                                                    Icons.update,
                                                                                    color: Color.fromARGB(255, 214, 116, 36),
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          snapshot.data[index].visibility.toString() == "true"
                                                                        ? Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(5,0, 0, 0),
                                                                            child: InkWell(
                                                                              onTap: () async {
                                                                                var confirmDialogResponse =  await showDialog<bool>(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                    return alertDialogWidget(
                                                                                      title: 'Hide post',
                                                                                      content: 'Are you sure to hide this post ?',
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                          child: Text('Cancel'),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () => {
                                                                                            postServices.HidePost(snapshot.data[index].id.toString()),
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => HomeWidget(),
                                                                                              ),
                                                                                            ),
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackbarWidget(
                                                                                                content: Text('Successfully post hide!',),
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
                                                                                width: 40,
                                                                                height: 30,
                                                                                decoration:BoxDecoration(
                                                                                  color: Colors.red[100],
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4,4,4,4),
                                                                                  child: Icon(
                                                                                    Icons.lock_outline,
                                                                                    color: Colors.red,
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        : Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB( 5,0,0,0),
                                                                            child: InkWell(
                                                                              onTap: () async {
                                                                                var confirmDialogResponse = await showDialog<bool>(
                                                                                  context: context,
                                                                                  builder: (alertDialogContext) {
                                                                                    return alertDialogWidget(
                                                                                      title: 'restore post',
                                                                                      content: 'Are you sure to restore this post ?',
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                          child: Text('Cancel'),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () => {
                                                                                            postServices.RestorePost(snapshot.data[index].id.toString()),
                                                                                            Navigator.push(
                                                                                              context,
                                                                                              MaterialPageRoute(
                                                                                                builder: (context) => HomeWidget(),
                                                                                              ),
                                                                                            ),
                                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                                              SnackbarWidget(
                                                                                                content: Text( 'Successfully post restored!',
                                                                                                ),
                                                                                              ),
                                                                                            )
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
                                                                                width: 40,
                                                                                height: 30,
                                                                                decoration: BoxDecoration(
                                                                                  color: Colors.green[50],
                                                                                  borderRadius:BorderRadius.circular(8),
                                                                                  border: Border.all(
                                                                                    color: Colors.green[50],
                                                                                    width: 0,
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
                                                                                  child: Icon(
                                                                                    Icons.remove_red_eye_outlined,
                                                                                    color: Colors.green,
                                                                                    size: 20,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ]
                                                                      )
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsetsDirectional.fromSTEB(8, 0, 10, 0),
                                                                child: Html(data: snapshot.data[index].contenu, style: {
                                                                  '#': Style(
                                                                    maxLines: 3,
                                                                    textOverflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  }
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  GestureDetector(
                                                                    child: Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                                                                      child: Text(
                                                                        "Read more",
                                                                        style: TextStyle(
                                                                          color: Colors.blue,
                                                                          decoration: TextDecoration.underline,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onTap: () {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(builder: (context) => postDetailsWidget(id: snapshot.data[index].id)),
                                                                      );
                                                                    },
                                                                  ),
                                                                  Container( width: 160,),
                                                                  ]
                                                              ),
                                                              ],
                                                          )
                                                        ),
                                                      ),
                                                    )
                          : Container()
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error);
                    }
                    return Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 280, 0, 0),
                      child: CircularProgressIndicatorWidget(),
                    );
                  }
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
