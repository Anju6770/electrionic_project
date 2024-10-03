import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(
      String email,
      String password,
      String firstName,
      String location,
      String number,
      ) async {
    try {
      // Try to create user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        // Save user details to Firestore only after successful registration
        await _firestore.collection('users').doc(user.uid).set({
          'firstName': firstName,
          'location': location,
          'number': number,
          'email': email,
          'createdAt': DateTime.now(),
        });
      }

      return user;
    } catch (e) {
      print('Error in registration: $e');
      return null; // Return null to indicate failure
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      debugPrint("Some error happened");
    }
    return null;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> updateProfile(String displayName) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await user.updateProfile(displayName: displayName);
      await user.reload();
      user = FirebaseAuth.instance.currentUser; // Reload user to get updated data
    }
  }

  void signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.offAllNamed('/button');
  }


  void google_signout() async {
    if (GoogleSignIn().currentUser != null) {
      await GoogleSignIn().signOut();
    }
    try {
      await GoogleSignIn().disconnect();
    } catch (e) {
      debugPrint("Something is wrong: $e");
    }
  }


  void sendOtp(String phone) {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (e) {
        debugPrint("Error: $e");
      },
      codeSent: (String verificationID, int? forceResendingToken) {
        Get.toNamed('/otp', arguments: verificationID);
      },
      codeAutoRetrievalTimeout: (verificationID) {
        debugPrint("Code timeout");
      },
    );
  }
  void verifyNumber(String verificationCode, String otp) {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationCode,
        smsCode: otp,
      );
      _auth.signInWithCredential(credential);
      Get.offAllNamed('/cover');
    }catch(e) {
      debugPrint('Error happened: $e');
    }
  }


}
