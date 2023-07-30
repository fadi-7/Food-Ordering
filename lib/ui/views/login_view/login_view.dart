import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_orders_proj/app/core/translations/app_translation.dart';
import 'package:food_orders_proj/app/my_app.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_button.dart';
import 'package:food_orders_proj/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:food_orders_proj/ui/shared/utils.dart';
import 'package:food_orders_proj/ui/views/login_view/login_controller.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.language,
                  ),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Change Language',
                        content: Column(
                          children: [
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage('en');
                                  Get.updateLocale(getLocale());
                                  Get.back();
                                },
                                child: Text('English')),
                            TextButton(
                                onPressed: () {
                                  storage.setAppLanguage('ar');
                                  Get.updateLocale(getLocale());
                                  Get.back();
                                },
                                child: Text('العربية')),
                          ],
                        ));
                  },
                ),
                SizedBox(
                  height: size.width * 0.25,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackMainColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.01, bottom: size.width * 0.1),
                  child: Text(
                    'Add your details to login',
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyMainColor),
                  ),
                ),
                CustomTextField(
                  hintText: 'Your Email',
                  controller: controller.emailController,
                  validator: (value) {
                    if (value!.isEmpty || !GetUtils.isEmail(value)) {
                      return 'please check your email';
                    }
                  },
                ),
                CustomTextField(
                  hintText: 'password',
                  controller: controller.passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter your password';
                    }
                  },
                ),
                CustomButton(
                    text: tr('key_login'),
                    onPressed: () {
                      controller.login();
                      //  customLoader();
                    }),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.1),
                  child: Text(
                    'Forget password',
                    style: TextStyle(
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.normal,
                        color: AppColors.greyMainColor),
                  ),
                ),
                Text(
                  'or Login With',
                  style: TextStyle(
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.normal,
                      color: AppColors.greyMainColor),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: size.width * 0.06, bottom: size.width * 0.06),
                  child: CustomButton(
                    text: 'Login with Facebook',
                    backgroundColor: AppColors.blueFacebookButton,
                    svgName: 'Facebook',
                    onPressed: () {},
                  ),
                ),
                CustomButton(
                  text: 'Login with Google',
                  backgroundColor: AppColors.blueFacebookButton,
                  svgName: 'google-plus-logo',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   TextEditingController emailControler = TextEditingController();
//   TextEditingController passwordControler = TextEditingController();
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   bool isLoading = false; //to show the loader spankit of the button Login
//   String email = 'Fadialhakim@gmai.com';
//   String password = '112233Ff@';

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 (size.width * 0.2).ph,
//                 CustomText(
//                     text: 'Login',
//                     textColor: AppColors.blackMainColor,
//                     textSize: size.width * 0.1,
//                     fontWeight: FontWeight.normal),
//                 (size.width * 0.03).ph,
//                 CustomText(
//                   text: 'Add your details to login',
//                 ),
//                 (size.width * 0.1).ph,
//                 CustomTextField(
//                   hintText: 'your Email',
//                   controller: emailControler,
//                   validator: (value) {
//                     /*if (value!.isEmpty || !isEmail(value))
//                       return 'Please check email';
//                     else
//                       return null;*/
//                     return value!.isEmpty || !isEmail(value)
//                         ? 'please check Email'
//                         : null;
//                   },
//                 ),
//                 (size.width * 0.08).ph,
//                 CustomTextField(
//                   hintText: 'Password',
//                   controller: passwordControler,
//                   validator: (value) {
//                     /*if (value!.isEmpty) {
//                       return 'please Enter password';
//                     } else if (!isPassword(value)) {
//                       return 'Invalid Password';
//                     } else {
//                       return null;
//                     }*/
//                     return value!.isEmpty || !isPassword(value)
//                         ? 'please check Password'
//                         : null;
//                   },
//                 ),
//                 (size.width * 0.08).ph,
//                 isLoading
//                     ? SpinKitCircle(
//                         color: AppColors.orangeMainColor,
//                       )
//                     : CustomButton(
//                         text: 'Login',
//                         onPressed: () {
//                           setState(() {
//                             isLoading = true;
//                           });

//                           UserRepository()
//                               .login(
//                                   email: emailControler.text,
//                                   password: passwordControler.text)
//                               .then((value) {
//                             value.fold((l) {
//                               //to reach the Either object we used .fold - (l) => left tube
//                               setState(() {
//                                 isLoading = false;
//                               });
//                               CustomToast.showMessage(
//                                   context: context,
//                                   message: l,
//                                   messageType: MessageType.REJECTED);
//                             }, (r) {
//                               sharedPreferenceRepository.setLoggedIn(true);
//                               sharedPreferenceRepository.setTokenInfo(r);

//                               Navigator.pushReplacement(context,
//                                   MaterialPageRoute(
//                                 builder: (context) {
//                                   return MainView();
//                                 },
//                               ));
//                             });
//                           });

//                           // if (_formKey.currentState!.validate()) {
//                           //   if (emailControler.text == email &&
//                           //       passwordControler.text == password) {
//                           //     sharedPreferenceRepository.setLoggedIn(true);
//                           //     Navigator.pushReplacement(
//                           //         context,
//                           //         MaterialPageRoute(
//                           //             builder: (context) => MainView()));
//                           //   }
//                           // }
//                           /* CustomToast.showMessage(
//                                 context: context,
//                                 message: 'every thing is OK',
//                                 messageType: MessageType.SUCCSESS);*/

//                           /* setState(() {
//                               isLoading = true;
//                             });
//                             Future.delayed(Duration(seconds: 5))
//                                 .then((value) => {
//                                       setState(() {
//                                         isLoading = false;
//                                       })
//                                     });*/
//                         }),
//                 (size.width * 0.1).ph,
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ResetPassword()));
//                     },
//                     child: CustomText(
//                       text: 'Forgot your password?',
//                     )),
//                 (size.width * 0.14).ph,
//                 CustomText(text: 'or login with'),
//                 (size.width * 0.06).ph,
//                 CustomButton(
//                   text: 'Login with facebook',
//                   onPressed: () {},
//                   svgName: 'ic_facebook',
//                   backgroundColor: AppColors.blueFacebookButton,
//                 ),
//                 (size.width * 0.08).ph,
//                 CustomButton(
//                   text: 'Login with Google',
//                   onPressed: () {},
//                   svgName: 'ic_google_plus',
//                   backgroundColor: AppColors.redGoogleButton,
//                 ),
//                 Spacer(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CustomText(text: "Don't have an Account? "),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => SignUpView()));
//                       },
//                       child: CustomText(
//                         text: 'Sign Up',
//                         fontWeight: FontWeight.bold,
//                         textColor: AppColors.orangeMainColor,
//                       ),
//                     ),
//                     (size.width * 0.2).ph,
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
extension EmptyPadding on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
