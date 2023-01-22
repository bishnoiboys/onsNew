import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'user_record.g.dart';

abstract class UserRecord implements Built<UserRecord, UserRecordBuilder> {
  static Serializer<UserRecord> get serializer => _$userRecordSerializer;

  @BuiltValueField(wireName: 'display_name')
  String? get displayName;

  String? get bio;

  String? get email;

  @BuiltValueField(wireName: 'photo_url')
  String? get photoUrl;

  String? get uid;

  @BuiltValueField(wireName: 'created_time')
  DateTime? get createdTime;

  @BuiltValueField(wireName: 'phone_number')
  String? get phoneNumber;

  int? get age;

  String? get city;

  String? get gender;

  BuiltList<String>? get rejected;

  String? get intrestedin;

  BuiltList<String>? get matches;

  @BuiltValueField(wireName: 'user_blocked')
  BuiltList<DocumentReference>? get userBlocked;

  @BuiltValueField(wireName: 'CountClics')
  int? get countClics;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(UserRecordBuilder builder) => builder
    ..displayName = ''
    ..bio = ''
    ..email = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..age = 0
    ..city = ''
    ..gender = ''
    ..rejected = ListBuilder()
    ..intrestedin = ''
    ..matches = ListBuilder()
    ..userBlocked = ListBuilder()
    ..countClics = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('user');

  static Stream<UserRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<UserRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  UserRecord._();
  factory UserRecord([void Function(UserRecordBuilder) updates]) = _$UserRecord;

  static UserRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createUserRecordData({
  String? displayName,
  String? bio,
  String? email,
  String? photoUrl,
  String? uid,
  DateTime? createdTime,
  String? phoneNumber,
  int? age,
  String? city,
  String? gender,
  String? intrestedin,
  int? countClics,
}) {
  final firestoreData = serializers.toFirestore(
    UserRecord.serializer,
    UserRecord(
      (u) => u
        ..displayName = displayName
        ..bio = bio
        ..email = email
        ..photoUrl = photoUrl
        ..uid = uid
        ..createdTime = createdTime
        ..phoneNumber = phoneNumber
        ..age = age
        ..city = city
        ..gender = gender
        ..rejected = null
        ..intrestedin = intrestedin
        ..matches = null
        ..userBlocked = null
        ..countClics = countClics,
    ),
  );

  return firestoreData;
}
