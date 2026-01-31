import 'package:flutter/foundation.dart';
import 'package:vink_sim/core/services/firebase_helper.dart';

class UserIdUtils {
  static String? get currentUserIdOrNull {
    if (!FirebaseHelper.isAvailable) {
      if (kDebugMode) print("Firebase UserId: Firebase not available");
      return null;
    }
    return FirebaseHelper.authInstance?.currentUser?.uid;
  }

  static String get currentUserId {
    final userId = currentUserIdOrNull;
    final userIdErrorMessage = "Firebase UserId: userId is NULL or EMPTY";
    if (userId == null || userId.isEmpty) {
      throw Exception(userIdErrorMessage);
    } else {
      if (kDebugMode) print("Firebase UserId: $userId");
    }
    return userId;
  }
}
