import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shopee_seller_app/controllers/auth/phone_auth_controller.dart';
import 'package:shopee_seller_app/views/screens/auth/email_auth/signup_with_email.dart';
import 'package:shopee_seller_app/views/screens/auth/phone_auth/phone_auth_screen.dart';
import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SigningWithEmail extends StatelessWidget {
   SigningWithEmail({super.key});
   TextEditingController signingEmailController = TextEditingController();
   TextEditingController signingPasswordController = TextEditingController();
   final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  height: context.screenHeight / 2.4,
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
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Enter Email",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[700])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: signingPasswordController,
                                    obscureText: true,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(color: Colors.grey[700])),
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
                              if(_formKey.currentState!.validate()){
                                signingWithEmail(context);
                              }
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
                                    color: Color.fromRGBO(113, 148, 251, 1), fontWeight: FontWeight.w400),),
                              ),


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
    if(signingEmailController.text.trim().isEmpty){
      showSnackBar(title: "Please fill Email", message: "");
    }else if(signingPasswordController.text.trim().isEmpty){
      showSnackBar(title: "Please fill Password", message: "");

    }
    else if(signingPasswordController.text.trim().length <=6){
      showSnackBar(title: "Password should be at least 7 characters", message: "");
    }
    else{
     try {
       UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
         email: signingEmailController.text.trim(),
         password: signingPasswordController.text.trim(),
       );


       Get.snackbar("Seller Login", "SuccessFully login with email",backgroundColor: const Color.fromRGBO(113, 148, 251, 1));

       showSnackBar(title: 'SuccessFully login with email',message: "",color: AppColor.green );

       AuthController.navigateUser(uid: userCredential.user?.uid);
     } catch (e) {
       print('Error signing in: $e');
       showSnackBar(title: 'Failed to sign in. Please check your credentials.',message: "",color: AppColor.red );
       Get.snackbar("Seller Login Failed", "Failed to sign in. Please check your credentials.l",backgroundColor: const Color.fromRGBO(113, 148, 251, 1));

     }
    }
   }

   Future<UserCredential> signInWithGoogle() async {
     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

     final credential = GoogleAuthProvider.credential(
       accessToken: googleAuth?.accessToken,
       idToken: googleAuth?.idToken,
     );
     UserCredential userCredential =  await FirebaseAuth.instance.signInWithCredential(credential);

     Get.snackbar("Seller Login", "SuccessFully login with Google",backgroundColor: const Color.fromRGBO(113, 148, 251, 1));
     Get.off(HomeScreen());
     return userCredential;
   }
}
