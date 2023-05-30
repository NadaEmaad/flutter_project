import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travell_app/screens/welcom.dart';
import 'package:travell_app/widgets/showgialog.dart';

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey();
  AutovalidateMode loginAutovalidateMode = AutovalidateMode.disabled;

  Future<void> signIn({
    required String emailAddress,
    required String password,
    required context,
  }) async {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();

      try {
        showLoading(context);
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress.trim(),
          password: password.trim(),
        );
        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, "/");
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();

        String errorMessage = '';

        if (e.code == 'user-not-found') {
          errorMessage = 'الحساب غير موجود.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'كلمة المرور خاطئة.';
        } else {
          errorMessage = e.toString();
        }

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('تنبيه'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      } catch (e) {
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('تنبيه'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      }
    } else {
      loginAutovalidateMode = AutovalidateMode.always;
      notifyListeners();
    }
  }
}

class RegisterProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController registerEmailController = TextEditingController();
  final TextEditingController registerPasswordController =
      TextEditingController();
  GlobalKey<FormState> regFormKey = GlobalKey();
  AutovalidateMode regAutovalidateMode = AutovalidateMode.disabled;

  Future<void> signup(context, String emailAddress, String password) async {
    if (regFormKey.currentState!.validate()) {
      regFormKey.currentState!.save();

      try {
        showLoading(context);
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress.trim(),
          password: password.trim(),
        );

        Navigator.of(context).pop();
        Navigator.pushReplacementNamed(context, "/");
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();

        String errorMessage = '';

        if (e.code == 'weak-password') {
          errorMessage = 'كلمة المرور ضعيفة.';
        } else if (e.code == 'email-already-in-use') {
          errorMessage = 'يوجد حساب بالفعل.';
        } else {
          errorMessage = e.toString();
        }

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('تنبيه'),
            content: Text(errorMessage),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      } catch (e) {
        Navigator.of(context).pop();

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('تنبيه'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text('موافق'),
              ),
            ],
          ),
        );
      }
    } else {
      regAutovalidateMode = AutovalidateMode.always;
      notifyListeners();
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // Handle password reset errors
      print('Password reset error: $e');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();

      Navigator.of(context).pushReplacementNamed(WelcomScreen.id);
    } catch (e) {
      print(e.toString());
    }
  }
}
