import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class ApiService {
  static const String url =
      "https://api.spaceflightnewsapi.net/v4/articles/?limit=20";

  static Future<List<ArticleModel>> getArticles() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List results = data['results'];

      return results
          .map((e) => ArticleModel.fromJson(e))
          .toList();
    }

    return [];
  }
}

class SessionService {
  static Future<void> saveLogin() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool("isLogin", true);
  }

  static Future<void> clearLogin() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }

  static Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getBool("isLogin") ?? false;
  }
}

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() async {
    await auth.signOut();

    await SessionService.clearLogin();
  }

  static Future<void> resetPassword(
    String email,
  ) async {
    await auth.sendPasswordResetEmail(
      email: email,
    );
  }
}

class FirestoreService {
  static final FirebaseFirestore firestore =
      FirebaseFirestore.instance;

  static Future<void> saveUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await firestore.collection('users').doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'instagram': '',
    });
  }

  static Future<void> addFavorite({
    required String uid,
    required ArticleModel article,
  }) async {
    await firestore.collection('favorites').add({
      'userId': uid,
      'articleId': article.id,
      'title': article.title,
      'createdAt': Timestamp.now(),
    });
  }

  static Stream<QuerySnapshot> getFavorites(
    String uid,
  ) {
    return firestore
        .collection('favorites')
        .where(
          'userId',
          isEqualTo: uid,
        )
        .snapshots();
  }

  static Stream<QuerySnapshot> getNotifications() {
    return firestore
        .collection('notifications')
        .orderBy(
          'createdAt',
          descending: true,
        )
        .snapshots();
  }
}