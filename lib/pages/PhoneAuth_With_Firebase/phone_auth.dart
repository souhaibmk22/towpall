import 'dart:io' if (dart.library.html) 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
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
            timeout: Duration(seconds: 40),
            phoneNumber: PhoneSignIn.phone,
            verificationCompleted: (PhoneAuthCredential credential) async {
              await firebaseAuth.signInWithCredential(credential);
            },
            verificationFailed: (FirebaseAuthException e) async {
              if (e.code == 'invalid-phone-number') {
                print('The provided phone number is not valid.');
              }
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
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      currentUser.delete();
    }
  }

  static Future<bool> isLoggedIn() async {
    final user = firebaseAuth.currentUser;
    return user != null;
  }
}
