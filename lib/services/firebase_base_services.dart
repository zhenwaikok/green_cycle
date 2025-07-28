import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';

enum AuthType { signUp, login, logout }

mixin FirebaseBaseServices {
  Future<MyResponse> authenticate({
    required AuthType authType,
    Map<String, dynamic>? requestBody,
  }) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;

      switch (authType) {
        case AuthType.signUp:
          final userCredential = await auth.createUserWithEmailAndPassword(
            email: requestBody?['email'],
            password: requestBody?['password'],
          );
          return MyResponse.complete(userCredential.user);
        case AuthType.login:
          final userCredential = await auth.signInWithEmailAndPassword(
            email: requestBody?['email'],
            password: requestBody?['password'],
          );
          return MyResponse.complete(userCredential.user);
        case AuthType.logout:
          await auth.signOut();
          return MyResponse.complete(true);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return MyResponse.error(_handleFirebaseAuthError(e, false));
    } catch (e) {
      debugPrint(e.toString());
      return MyResponse.error('Unexpected error: $e');
    }
  }

  Future<MyResponse> uploadImage({
    required String storageRef,
    File? image,
    List<File>? images,
  }) async {
    try {
      final storageReference = FirebaseStorage.instance.ref();

      if (images != null && images.isNotEmpty) {
        List<String> imageUrls = [];
        for (var img in images) {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final imageRef = storageReference.child('$storageRef/$fileName.jpg');
          final uploadTask = await imageRef.putFile(img);
          final downloadURL = await uploadTask.ref.getDownloadURL();
          imageUrls.add(downloadURL);
        }
        return MyResponse.complete(imageUrls);
      }

      if (image != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final imageRef = storageReference.child('$storageRef/$fileName.jpg');
        final uploadTask = await imageRef.putFile(image);
        final downloadURL = await uploadTask.ref.getDownloadURL();
        return MyResponse.complete(downloadURL);
      }

      return MyResponse.error('No image provided for upload.');
    } on FirebaseException catch (e) {
      debugPrint(e.message);
      return MyResponse.error('Firebase error: ${e.message}');
    } catch (e) {
      debugPrint('Image upload error: ${e.toString()}');
      return MyResponse.error('Image upload failed: $e');
    }
  }

  Future<MyResponse> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        final credential = EmailAuthProvider.credential(
          email: user.email ?? '',
          password: oldPassword,
        );
        final reauthenticated = await user.reauthenticateWithCredential(
          credential,
        );
        if (reauthenticated.user != null) {
          await user.updatePassword(newPassword);
          return MyResponse.complete(true);
        }
      }
      return MyResponse.error(false);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      return MyResponse.error(_handleFirebaseAuthError(e, true));
    } catch (e) {
      debugPrint('Update password error: ${e.toString()}');
      return MyResponse.error('Unexpected error: $e');
    }
  }

  String _handleFirebaseAuthError(
    FirebaseAuthException e,
    bool isUpdatePassword,
  ) {
    switch (e.code) {
      case 'invalid-email':
        return 'Invalid email format';
      case 'user-disabled':
        return 'User account is disabled';
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'Email is already in use';
      case 'weak-password':
        return 'The password is too weak';
      case 'invalid-credential':
        return isUpdatePassword
            ? 'Incorrect current password, please try again'
            : 'Invalid email or password';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
