import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserIdUtils {
  static String get currentUserId {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    final userIdErrorMessage = "Firebase UserId: userId is NULL or EMPTY";
    if (userId == null || userId.isEmpty) {
      throw Exception(userIdErrorMessage);
    } else {
      if (kDebugMode) print("Firebase UserId: $userId");
    
    }  
    return userId;
  }
}