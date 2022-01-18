import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_ddd/domain/auth/user.dart';
import 'package:flutter_ddd/domain/core/value_object.dart';

extension FirebaseDomainUserX on firebase.User {
  User toDomain() {
    return User(id: UniqueId.fromUniqueString(uid));
  }
}
