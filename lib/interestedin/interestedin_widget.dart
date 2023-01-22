import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestedinWidget extends StatefulWidget {
  const InterestedinWidget({Key? key}) : super(key: key);

  @override
  _InterestedinWidgetState createState() => _InterestedinWidgetState();
}

class _InterestedinWidgetState extends State<InterestedinWidget> {
  String? dropDownValue;
  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          child: Text(
            'I Am Interested In ',
            style: FlutterFlowTheme.of(context).title2.override(
                  fontFamily: 'Righteous',
                  color: FlutterFlowTheme.of(context).background,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  useGoogleFonts: false,
                ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                      child: FlutterFlowDropDown<String>(
                        options: ['Male', 'Female'],
                        onChanged: (val) => setState(() => dropDownValue = val),
                        width: 180,
                        height: 70,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.of(context).background,
                              fontSize: 16,
                            ),
                        hintText: 'Please select...',
                        fillColor: Colors.white,
                        elevation: 2,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 10,
                        margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                        hidesUnderline: true,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              FFButtonWidget(
                onPressed: () async {
                  if (dropDownValue != '') {
                    final userUpdateData = createUserRecordData(
                      intrestedin: dropDownValue,
                    );
                    await currentUserReference!.update(userUpdateData);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            NavBarPage(initialPage: 'HomeCategories'),
                      ),
                    );
                    return;
                  } else {
                    await showDialog(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: Text('Gender Required'),
                          content: Text('Please enter the gender you like'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext),
                              child: Text('Ok'),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }
                },
                text: 'Okk, Let\'s Start',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 70,
                  color: Color(0xFF34E0D8),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Righteous',
                        color: Colors.white,
                        fontSize: 24,
                        useGoogleFonts: false,
                      ),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
