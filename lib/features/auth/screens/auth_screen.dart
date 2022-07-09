import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);
  static const routeName = '/auth-screen';
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupGlobalKey = GlobalKey<FormState>();
  final _signinGlobalKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _pwdController.dispose();
    _nameController.dispose();
  }

  void signupUser() {
    authService.signupUser(
        name: _nameController.text,
        context: context,
        email: _emailController.text,
        password: _pwdController.text);
  }

  void signInUser(){
    authService.signInUser(
        email: _emailController.text,
        password: _pwdController.text,
        context: context
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Authentication',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Expanded(child:
             SingleChildScrollView(
               child: Column(
                 children: [
                   ListTile(
                     tileColor: _auth == Auth.signup
                         ? GlobalVariables.backgroundColor
                         : GlobalVariables.greyBackgroundCOlor,
                     leading: Radio(
                         value: Auth.signup,
                         groupValue: _auth,
                         activeColor: GlobalVariables.secondaryColor,
                         onChanged: (Auth? val) => setState(() {
                           _auth = val!;
                         })),
                     title: const Text(
                       'Create Account',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                   if (_auth == Auth.signup)
                     Container(
                       padding: const EdgeInsets.all(8),
                       color: GlobalVariables.backgroundColor,
                       child: Form(
                           key: _signupGlobalKey,
                           child: Column(
                             children: [
                               CustomTextFied(
                                 controller: _nameController,
                                 hint: 'Name',
                                 isObscureTxt: false,
                               ),
                               const SizedBox(height: 10.0),
                               CustomTextFied(
                                 controller: _emailController,
                                 hint: 'Email',
                                 isObscureTxt: false,
                               ),
                               const SizedBox(height: 10.0),
                               CustomTextFied(
                                 controller: _pwdController,
                                 hint: 'Password',
                                 isObscureTxt: true,
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               CustomButton(
                                   value: 'Sign Up',
                                   ontap: () {
                                     if (_signupGlobalKey.currentState!.validate())
                                     {
                                       signupUser();
                                     }
                                   })
                             ],
                           )),
                     ),
                   ListTile(
                     tileColor: _auth == Auth.signin
                         ? GlobalVariables.backgroundColor
                         : GlobalVariables.greyBackgroundCOlor,
                     leading: Radio(
                         value: Auth.signin,
                         activeColor: GlobalVariables.secondaryColor,
                         groupValue: _auth,
                         onChanged: (Auth? val) => setState(() {
                           _auth = val!;
                         })),
                     title: const Text(
                       'Sign-In',
                       style: TextStyle(fontWeight: FontWeight.bold),
                     ),
                   ),
                   if (_auth == Auth.signin)
                     Container(
                       padding: const EdgeInsets.all(8),
                       color: GlobalVariables.backgroundColor,
                       child: Form(
                           key: _signinGlobalKey,
                           child: Column(
                             children: [
                               const SizedBox(height: 10.0),
                               CustomTextFied(
                                 controller: _emailController,
                                 hint: 'Email',
                                 isObscureTxt: false,
                               ),
                               const SizedBox(height: 10.0),
                               CustomTextFied(
                                 controller: _pwdController,
                                 hint: 'Password',
                                 isObscureTxt: true,
                               ),
                               const SizedBox(
                                 height: 10,
                               ),
                               CustomButton(value: 'Sign In', ontap: () {
                                 if(_signinGlobalKey.currentState!.validate())
                                 {
                                   signInUser();
                                 }
                               })
                             ],
                           )),
                     )
                 ],
               ),
             )
             )
            ],
        ),
      )),
    );
  }
}
