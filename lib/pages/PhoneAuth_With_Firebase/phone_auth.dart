import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'simplephonelogin.dart';

class AuthServic {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static String verifyid = "";

  static Future sentOTP(
      {required String phone,
      required Function errorStep,
      required Function nextStep}) async {
    await firebaseAuth
        .verifyPhoneNumber(
            timeout: Duration(seconds: 30),
            phoneNumber: PhoneSignIn.phone,
            verificationCompleted: (phoneAuthCredential) async {
              return;
            },
            verificationFailed: (error) async {
              return;
            },
            codeSent: (verificationId, forceResendingToken) async {
              verifyid = verificationId;
              nextStep();
            },
            codeAutoRetrievalTimeout: (verificationId) async {
              return;
            })
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  static Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyid, smsCode: otp);
    try {
      final user = await firebaseAuth.signInWithCredential(cred);
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp Login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      print("nichaaaaaaaaaaaaaaaaaaaaaaaaaaaan");
      return e.toString();
    }
  }

  static Future logout() async {
    if (firebaseAuth.currentUser != null) {
      firebaseAuth.signOut();
    }
  }

  static Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }
}
