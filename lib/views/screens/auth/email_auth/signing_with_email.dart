import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopee_seller_app/controllers/auth/phone_auth_controller.dart';
import 'package:shopee_seller_app/views/screens/auth/email_auth/signup_with_email.dart';
import 'package:shopee_seller_app/views/screens/auth/phone_auth/phone_auth_screen.dart';
import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
import 'package:shopee_seller_app/views/screens/profile/registration_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SigningWithEmail extends StatelessWidget {
   SigningWithEmail({super.key});
   TextEditingController signingEmailController = TextEditingController();
   TextEditingController signingPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeInUp(
                            duration: Duration(seconds: 1),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1200),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1300),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeInUp(
                            duration: Duration(milliseconds: 1600),
                            child: Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1800),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color.fromRGBO(143, 148, 251, 1)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color.fromRGBO(
                                                  143, 148, 251, 1)))),
                                  child: TextField(
                                    controller: signingEmailController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email or Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: signingPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1900),
                          child: InkWell(
                            onTap: (){
                              signingWithEmail(context);
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(colors: [
                                    Color.fromRGBO(143, 148, 251, 1),
                                    Color.fromRGBO(143, 148, 251, .6),
                                  ])),
                              child: Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      FadeInUp(
                          duration: const Duration(milliseconds: 2000),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an Account? ",
                                  style: TextStyle(color: Color.fromRGBO(143, 148, 251, 76))),
                              InkWell(
                                 onTap: () {
                                   context.push(SignupWithEmail());
                                 }, child: Text("Signup",style: TextStyle(
                                    color: Color.fromRGBO(113, 148, 251, 1,), fontWeight: FontWeight.w400),),
                              ),

                              // FadeInUp(
                              //   duration: Duration(milliseconds: 2000),
                              //     child: Row(
                              //   children: [
                              //     Container(
                              //
                              //     )
                              //   ],
                              // ))

                            ],
                          )),
                      15.height,
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.grey),
                                height: 1,
                                margin: EdgeInsets.symmetric(horizontal: 14 ),
                              ),
                            ),
                            Text(
                              "OR",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.grey),
                                height: 1,
                                margin: EdgeInsets.symmetric(horizontal: 14 ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      15.height,
                      FadeInUp(
                        duration: Duration(milliseconds: 2000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(onPressed: (){signInWithGoogle();}, icon: Image.asset("assets/images/google_auth_image.png",height: 50,)),
                            IconButton(onPressed: (){
                              context.push(PhoneAuthScreen());
                            }, icon: Image.asset("assets/images/phone_auth_image.png",height: 35,))
                          ],
                        ),
                      )
                      // Divider()
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

   void signingWithEmail(BuildContext context) async {
     try {
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: signingEmailController.text.trim(),
         password: signingPasswordController.text.trim(),
       );
       // Navigate to home screen or dashboard after successful sign-in
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('SuccessFully login with email'),
       ));
       AuthController.navigateUser(uid: userCredential.user?.uid);
     } catch (e) {
       // Handle sign-in errors
       print('Error signing in: $e');
       // You can provide feedback to the user here (e.g., show a snackbar)
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
         content: Text('Failed to sign in. Please check your credentials.'),
       ));
     }
   }

   Future<UserCredential> signInWithGoogle() async {
     // Trigger the authentication flow
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

     // Obtain the auth details from the request
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     // Create a new credential
     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );

     // Once signed in, return the UserCredential
     UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);
     Get.off(HomeScreen());
     return userCredential;
   }
}
