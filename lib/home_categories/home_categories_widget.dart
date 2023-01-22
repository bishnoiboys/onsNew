import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/quick_chatting_bottom_widget.dart';
import '../flutter_flow/flutter_flow_swipeable_stack.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../free_vip_page/free_vip_page_widget.dart';
import '../premium_plans/premium_plans_widget.dart';
import '../user_profile_page/user_profile_page_widget.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

class HomeCategoriesWidget extends StatefulWidget {
  const HomeCategoriesWidget({Key? key}) : super(key: key);

  @override
  _HomeCategoriesWidgetState createState() => _HomeCategoriesWidgetState();
}

class _HomeCategoriesWidgetState extends State<HomeCategoriesWidget> {
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SwipeableCardSectionController randomSwipeableStackController;

  @override
  void initState() {
    super.initState();
    randomSwipeableStackController = SwipeableCardSectionController();
  }

  @override
  void dispose() {
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xF6FFF600),
      appBar: AppBar(
        backgroundColor: Color(0xF6FFF600),
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FreeVipPageWidget(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/icon-removebg-preview.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Hey,',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily: 'Righteous',
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: false,
                            ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                      child: AuthUserStreamWidget(
                        builder: (context) => Text(
                          currentUserDisplayName,
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Righteous',
                                color:
                                    FlutterFlowTheme.of(context).customColor4,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: false,
                              ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PremiumPlansWidget(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/225-2258934_plus-png-plus-sign-clip-art-removebg-preview.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Divider(
              thickness: 1,
              color: Color(0xF6FFF600),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    width: double.infinity,
                    height: 640,
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: AuthUserStreamWidget(
                        builder: (context) => StreamBuilder<List<UserRecord>>(
                          stream: queryUserRecord(
                            queryBuilder: (userRecord) => userRecord
                                .where('gender',
                                    isEqualTo: valueOrDefault(
                                        currentUserDocument?.intrestedin, ''))
                                .whereNotIn(
                                    'uid',
                                    (currentUserDocument?.matches?.toList() ??
                                        [])),
                            limit: 100,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: Color(0xFF3CDAE0),
                                  ),
                                ),
                              );
                            }
                            List<UserRecord>
                                randomSwipeableStackUserRecordList = snapshot
                                    .data!
                                    .where((u) => u.uid != currentUserUid)
                                    .toList();
                            return FlutterFlowSwipeableStack(
                              topCardHeightFraction: 15,
                              middleCardHeightFraction: 15,
                              bottomCardHeightFraction: 15,
                              topCardWidthFraction: 0.9,
                              middleCardWidthFraction: 0.94,
                              bottomCardWidthFraction: 0.98,
                              onSwipeFn: (index) {},
                              onLeftSwipe: (index) {},
                              onRightSwipe: (index) {},
                              onUpSwipe: (index) {},
                              onDownSwipe: (index) {},
                              itemBuilder:
                                  (context, randomSwipeableStackIndex) {
                                final randomSwipeableStackUserRecord =
                                    randomSwipeableStackUserRecordList[
                                        randomSwipeableStackIndex];
                                return Visibility(
                                  visible: functions.whenUserInBlockList(
                                          (currentUserDocument?.userBlocked
                                                      ?.toList() ??
                                                  [])
                                              .toList(),
                                          randomSwipeableStackUserRecord
                                              .reference,
                                          currentUserReference!) ??
                                      true,
                                  child: InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.bottomToTop,
                                          duration: Duration(milliseconds: 300),
                                          reverseDuration:
                                              Duration(milliseconds: 300),
                                          child: UserProfilePageWidget(
                                            userprofile:
                                                randomSwipeableStackUserRecord
                                                    .reference,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      color: Color(0xFFFEFEFE),
                                      elevation: 25,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl:
                                                randomSwipeableStackUserRecord
                                                    .photoUrl!,
                                            width: double.infinity,
                                            height: 460,
                                            fit: BoxFit.cover,
                                          ),
                                          Divider(
                                            height: 10,
                                            thickness: 1,
                                            color: Colors.white,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(10, 0, 0, 0),
                                                  child: Image.asset(
                                                    'assets/images/png-transparent-verified-check-mark-confirmation-thumbnail-removebg-preview.png',
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(8, 0, 0, 0),
                                                  child: Text(
                                                    'Verified User',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Righteous',
                                                          fontSize: 20,
                                                          useGoogleFonts: false,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  randomSwipeableStackUserRecord
                                                      .displayName!,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Righteous',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                              Text(
                                                ',',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1,
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(5, 0, 0, 0),
                                                child: Text(
                                                  randomSwipeableStackUserRecord
                                                      .age!
                                                      .toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily: 'Righteous',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        useGoogleFonts: false,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 0, 0),
                                                child: Text(
                                                  'Lives in',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(2, 0, 0, 0),
                                                child: Text(
                                                  valueOrDefault(
                                                      currentUserDocument?.city,
                                                      ''),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyText1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 10,
                                            thickness: 1,
                                            color: Color(0xFFFEFEFE),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    randomSwipeableStackController
                                                        .triggerSwipeLeft();

                                                    final userUpdateData = {
                                                      'rejected': FieldValue
                                                          .arrayUnion([
                                                        randomSwipeableStackUserRecord
                                                            .uid
                                                      ]),
                                                    };
                                                    await randomSwipeableStackUserRecord
                                                        .reference
                                                        .update(userUpdateData);
                                                  },
                                                  text: '',
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Color(0xFFFF0000),
                                                    size: 50,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 60,
                                                    color: Color(0xFFFEFEFE),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                    elevation: 0,
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFEFEFE),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            UserProfilePageWidget(
                                                          userprofile:
                                                              randomSwipeableStackUserRecord
                                                                  .reference,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  text: '',
                                                  icon: Icon(
                                                    Icons.person,
                                                    color: Color(0xFF18C5FF),
                                                    size: 50,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 60,
                                                    color: Color(0xFFFEFEFE),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                    elevation: 0,
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFEFEFE),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: FFButtonWidget(
                                                  onPressed: () async {
                                                    randomSwipeableStackController
                                                        .triggerSwipeRight();
                                                    await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      enableDrag: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return Padding(
                                                          padding:
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets,
                                                          child: Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.55,
                                                            child:
                                                                QuickChattingBottomWidget(
                                                              userquickref:
                                                                  randomSwipeableStackUserRecord
                                                                      .reference,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ).then((value) =>
                                                        setState(() {}));

                                                    final userUpdateData = {
                                                      'matches': FieldValue
                                                          .arrayUnion([
                                                        randomSwipeableStackUserRecord
                                                            .uid
                                                      ]),
                                                    };
                                                    await currentUserReference!
                                                        .update(userUpdateData);
                                                    if (randomSwipeableStackUserRecord
                                                        .matches!
                                                        .toList()
                                                        .contains(
                                                            currentUserUid)) {
                                                      final chatsCreateData = {
                                                        ...createChatsRecordData(
                                                          userA:
                                                              randomSwipeableStackUserRecord
                                                                  .reference,
                                                          userB:
                                                              currentUserReference,
                                                          lastMessage: '\"\"',
                                                          lastMessageTime:
                                                              getCurrentTimestamp,
                                                        ),
                                                        'users': functions
                                                            .createChatUserList(
                                                                randomSwipeableStackUserRecord
                                                                    .reference,
                                                                currentUserReference!),
                                                      };
                                                      await ChatsRecord
                                                          .collection
                                                          .doc()
                                                          .set(chatsCreateData);
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Congratulations! You have a new match',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                          duration: Duration(
                                                              milliseconds:
                                                                  4000),
                                                          backgroundColor:
                                                              Color(0x00000000),
                                                        ),
                                                      );
                                                      await Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  3000));
                                                    }
                                                  },
                                                  text: '',
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    color: Color(0xFFCB059F),
                                                    size: 50,
                                                  ),
                                                  options: FFButtonOptions(
                                                    width: 80,
                                                    height: 60,
                                                    color: Color(0xFFFEFEFE),
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                        ),
                                                    elevation: 0,
                                                    borderSide: BorderSide(
                                                      color: Color(0xFFFEFEFE),
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              itemCount:
                                  randomSwipeableStackUserRecordList.length,
                              controller: randomSwipeableStackController,
                              enableSwipeUp: false,
                              enableSwipeDown: false,
                            );
                          },
                        ),
                      ),
                    ),
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
