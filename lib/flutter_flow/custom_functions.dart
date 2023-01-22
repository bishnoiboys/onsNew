import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

List<DocumentReference> createChatUserList(
  DocumentReference userRef1,
  DocumentReference userRef2,
) {
  return [userRef1, userRef2];
}

List<String> combineLists(
  List<String>? matches,
  List<String>? rejected,
) {
  // combine two lists
  final List<String> newList = <String>[""];

  if (matches != null) {
    matches.forEach((matches) => newList.add(matches));
  }

  if (rejected != null) {
    rejected.forEach((rejected) => newList.add(rejected));
  }

  return newList;
}

bool? whenUserInBlockList(
  List<DocumentReference> userblocked,
  DocumentReference user,
  DocumentReference authUser,
) {
  bool ifUserinBlockedList(
    List<DocumentReference> userblocked,
    DocumentReference user,
    DocumentReference authUser,
  ) {
    if (user == authUser) {
      return true;
    } else {
      if (userblocked.contains(user)) {
        return false;
      } else {
        return true;
      }
    }
  }
}

int? numbercount() {
  // count number of button clicks
  int counter = 0;
  counter = counter + 10;
  return counter;
}
