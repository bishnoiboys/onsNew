import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/report_bottom_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import '../flutter_flow/custom_functions.dart' as functions;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportBlockUserWidget extends StatefulWidget {
  const ReportBlockUserWidget({
    Key? key,
    this.userprofileref,
  }) : super(key: key);

  final DocumentReference? userprofileref;

  @override
  _ReportBlockUserWidgetState createState() => _ReportBlockUserWidgetState();
}

class _ReportBlockUserWidgetState extends State<ReportBlockUserWidget> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserRecord>(
      stream: UserRecord.getDocument(widget.userprofileref!),
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
        final containerUserRecord = snapshot.data!;
        return Container(
          width: double.infinity,
          height: 280,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Color(0x3B1D2429),
                offset: Offset(0, -3),
              )
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                FFButtonWidget(
                  onPressed: () async {
                    final userUpdateData = {
                      'user_blocked': FieldValue.arrayUnion(
                          [containerUserRecord.reference]),
                    };
                    await currentUserReference!.update(userUpdateData);
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            child: ReportBottomWidget(),
                          ),
                        );
                      },
                    ).then((value) => setState(() {}));
                  },
                  text: 'Report User',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 60,
                    color: FlutterFlowTheme.of(context).tertiary400,
                    textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                          fontFamily: 'Righteous',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: false,
                        ),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                if (functions.whenUserInBlockList(
                        (currentUserDocument?.userBlocked?.toList() ?? [])
                            .toList(),
                        containerUserRecord.reference,
                        currentUserReference!) ??
                    true)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                    child: AuthUserStreamWidget(
                      builder: (context) => FFButtonWidget(
                        onPressed: () async {
                          final userUpdateData = {
                            'matches': FieldValue.arrayUnion(
                                [containerUserRecord.uid]),
                          };
                          await currentUserReference!.update(userUpdateData);
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavBarPage(initialPage: 'UserList'),
                            ),
                          );
                        },
                        text: 'Block User',
                        options: FFButtonOptions(
                          width: double.infinity,
                          height: 60,
                          color: Color(0xFFFF5963),
                          textStyle:
                              FlutterFlowTheme.of(context).subtitle2.override(
                                    fontFamily: 'Righteous',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.normal,
                                    useGoogleFonts: false,
                                  ),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 60,
                      color: FlutterFlowTheme.of(context).primaryBackground,
                      textStyle: FlutterFlowTheme.of(context).subtitle2,
                      elevation: 5,
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
