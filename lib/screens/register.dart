import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travell_app/auth_provider.dart';
import 'package:travell_app/screens/login.dart';
import 'package:travell_app/widgets/background.dart';

class RegisterScreen extends StatelessWidget {
  static const id = "RegisterScreen";

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final registerProvider =
        Provider.of<RegisterProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        top: 35,
        left: 30,
        child: Form(
          key: registerProvider.regFormKey,
          autovalidateMode: registerProvider.regAutovalidateMode,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: const Text(
                  "إنشاء حساب",
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
                      return "قم بإدخال اسم صحيح";
                    }

                    return null;
                  },
                  decoration: const InputDecoration(labelText: "الإسم"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) {
                    if (val!.length < 10) {
                      return "قم بإدخال رقم صحيح";
                    }

                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: "رقم الجوال"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                  controller: registerProvider.registerEmailController,
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
                    if (val!.length < 2) {
                      return "قم بإدخال كلمة مرور صحيحة";
                    }

                    return null;
                  },
                  controller: registerProvider.registerPasswordController,
                  decoration: const InputDecoration(labelText: "كلمة المرور"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: MaterialButton(
                  onPressed: () {
                    final email = registerProvider.registerEmailController.text;
                    final password =
                        registerProvider.registerPasswordController.text;

                    registerProvider.signup(context, email, password);
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
                      "إنشاء حساب",
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
                            builder: (context) => const LoginScreen()))
                  },
                  child: const Text(
                    "هل لديك حساب؟ دخول",
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
