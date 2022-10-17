import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_app_firebase_miner1/helpers/firebase_auth_helper.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String email = "";
  String password = "";
  String confirmPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 220,
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper3(),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        color: Color(0xffFFE5E8),
                      ),
                    ),
                    ClipPath(
                      clipper: MyClipper2(),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        color: Color(0xffFFBBBF).withOpacity(0.7),
                      ),
                    ),
                    ClipPath(
                      clipper: MyClipper1(),
                      child: Container(
                        height: 220,
                        width: double.infinity,
                        color: Color(0xffFF3E56),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 75,
                            ),
                            Text(
                              "Sign Up",
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  controller: emailController,
                  validator: (val) {
                    if (val == null) {
                      return "Enter valid email";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: Icon(Icons.email, color: Color(0xffFF3E56)),
                    labelText: 'Email',
                    hintText: 'Enter Your Email',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (val) {
                    if (val == null) {
                      return "Enter valid Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    password = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Color(0xffFF3E56)),
                    labelText: 'Password',
                    hintText: 'Enter Your password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: TextFormField(
                  obscureText: true,
                  controller: confirmPasswordController,
                  validator: (val) {
                    if (val == null) {
                      return "Enter valid Password";
                    }
                    return null;
                  },
                  onSaved: (val) {
                    confirmPassword = val!;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Color(0xffFF3E56)),
                    labelText: 'Re-Enter Password',
                    hintText: 'Enter Your password again',
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                    if(password == confirmPassword)
                      {
                        try {

                          await FirebaseAuthHelper.firebaseAuthHelper.signUp(email: email, password: password);

                          User? user = await FirebaseAuthHelper.firebaseAuthHelper.signIn(email: email, password: password);

                          log(user.toString(), name: "User");

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "SignUp Success",
                              ),
                            ),
                          );
                          Navigator.pushNamed(context, "/");
                        } on FirebaseException catch (e) {
                          log("$e", name: "on");

                          switch (e.code) {
                            case "invalid-email":
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Email not valid",
                                    ),
                                  ),
                                );
                              }
                              break;
                            case "weak-password":
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Password atleast 6 char",
                                    ),
                                  ),
                                );
                              }
                              break;
                            case "email-already-in-use":
                              {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.redAccent,
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      "Account already exist",
                                    ),
                                  ),
                                );
                              }
                              break;
                          }
                        }
                      }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              "Password are not same",
                            ),
                          ),
                        );
                      }
                  }
                },
                borderRadius: BorderRadius.circular(40),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(0xffFF3E56),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 19),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "FORGET PASSWORD ?",
                style: TextStyle(
                  color: Color(0xffFF3E56),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/google.png",
                height: 40,
                width: 40,
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "sign_in");
                },
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Already Have an Account ? ",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                        text: "Sign In.",
                        style: TextStyle(
                          color: Color(0xffFF3E56),
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ))
                  ]),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.58, size.width * 0.6, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.80, size.height * 0.85, size.width, size.height * 0.72);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.58, size.width * 0.6, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.80, size.height * 0.90, size.width, size.height * 0.82);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper3 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.72);
    path.quadraticBezierTo(size.width * 0.20, size.height, size.width * 0.70, size.height * 0.88);
    path.quadraticBezierTo(size.width * 0.9, size.height * 0.8, size.width, size.height * 0.82);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
