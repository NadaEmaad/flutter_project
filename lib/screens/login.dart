import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travell_app/auth_provider.dart';
import 'package:travell_app/screens/register.dart';
import 'package:travell_app/widgets/background.dart';

class LoginScreen extends StatelessWidget {
  static const id = "LoginScreen";

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<LoginProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        top: 70,
        left: 30,
        child: Form(
          key: authProvider.loginFormKey,
          autovalidateMode: authProvider.loginAutovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: const Text(
                  "تسجيل دخول",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 32),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) {
                    if (val!.length < 2) {
                      return "قم بإدخال ايميل صحيح";
                    }
                    if (!val.contains("@")) {
                      return "قم بإدخال ايميل صحيح";
                    }
                    if (!val.contains(".com")) {
                      return "قم بإدخال ايميل صحيح";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: authProvider.loginEmailController,
                  decoration:
                      const InputDecoration(labelText: "البريد الإلكتروني"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) {
                    if (val!.length < 4) {
                      return "قم بإدخال كلمة مرور قوية";
                    }
                    return null;
                  },
                  controller: authProvider.loginPasswordController,
                  decoration: const InputDecoration(labelText: "كلمة المرور"),
                  obscureText: true,
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: const Text(
                  "هل نسيت كلمة المرور؟",
                  style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: MaterialButton(
                  onPressed: () async {
                    final email = authProvider.loginEmailController.text;
                    final password = authProvider.loginPasswordController.text;

                    authProvider.signIn(
                        context: context,
                        emailAddress: email,
                        password: password);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: const Text(
                      "دخول",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterScreen()))
                  },
                  child: const Text(
                    "هل أنت مستخدم جديد ؟ سجل الآن",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
