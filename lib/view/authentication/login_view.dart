import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:road_safety/model/firebase_auth.dart';
import 'package:road_safety/model/input_validator.dart';
import 'package:road_safety/res/colors.dart';
import 'package:road_safety/res/components/app_text.dart';
import 'package:road_safety/res/components/round_button.dart';
import 'package:road_safety/utils/routes/routes_name.dart';
import 'package:road_safety/utils/utils.dart';
import 'package:road_safety/view/admin/adminHomeScreen/admin_home_screen.dart';
import 'package:road_safety/view/authentication/register_view.dart';
import 'package:road_safety/view/authentication/userType/usertype_screen.dart';
import 'package:road_safety/view/dashboard/dashboard_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginView extends StatefulWidget {
  final String userType;
  const LoginView({super.key, required this.userType});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  ValueNotifier obsecurePassword = ValueNotifier(true);

  bool _isLoading = false;
  bool _isVisible = false;
  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String isCreated = '',status = '';
  String isCreatedStudent = '';

  @override
  void initState() {
    print('Admin ${widget.userType}');
    setState(() {



      isCreated = '';
      status = '';
      isCreatedStudent = '';
      _isVisible = false;
      _isLoading = false;
    });
    print('userType');
    print(widget.userType.toString());
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailAddressController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final authViewModel = Provider.of<AuthViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child:Stack(children: <Widget>[ //stack overlaps widgets
                  Opacity( //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper:WaveClipper(), //set our custom wave clipper
                      child:Container(
                        color:AppColors.greenColor2,
                        height:300,
                      ),
                    ),
                  ),

                  ClipPath(  //upper clippath with less height
                    clipper:WaveClipper(), //set our custom wave clipper.
                    child:Container(
                      padding: EdgeInsets.only(bottom: 50),
                      color:AppColors.purpleColor,
                      height:280,
                      alignment: Alignment.center,
                      child:            Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset('assets/images/logo.png', height: 100,width: 100,fit: BoxFit.scaleDown,),
                          ),
                          Text('ROAD SAFETY', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center),
                        ],
                      ),

                    ),
                  ),
                ],)
            ),

            Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                    width: size.width,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Center(
                        child: Text(
                          AppText.login,
                          style: TextStyle(
                              fontSize: TextStylesData.titleFontSize,
                              color: AppColors.darkGreenColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  child: TextFormField(
                    controller: _emailAddressController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    onChanged: (value) {
                      // if(EmailValidator.validate(value)) {
                      //   setState(() {
                      //     isValid = true;
                      //   });
                      // } else {
                      //   setState(() {
                      //     isValid = false;
                      //   });
                      // }
                    },
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      fillColor: Colors.grey,
                      labelText: 'Email',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            //  obsecurePassword.value = !obsecurePassword.value;
                          },
                          child: const Icon(
                            Icons.verified_outlined,
                            color: AppColors.greenColor2,
                            size: 20,
                          )),
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                      //add prefix icon

                      // errorText: "Error",

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:  AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color:  AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide:
                         BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelStyle: const TextStyle(
                        color: AppColors.greyColor,
                        fontSize: TextStylesData.smallFontSize,
                        fontFamily: "verdana_regular",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                ValueListenableBuilder(
                    valueListenable: obsecurePassword,
                    builder: (context, value, child) {
                      return Container(
                        margin:
                        const EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: TextFormField(
                          autofocus: true,
                          keyboardType: TextInputType.text,
                          controller: _passwordController,
                          obscureText: obsecurePassword.value ? true : false,
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            focusColor: Colors.white,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  obsecurePassword.value = !obsecurePassword.value;
                                },
                                child: Icon(
                                  obsecurePassword.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility,
                                  size: 20,
                                  color: AppColors.greyColor.withOpacity(0.5),
                                )),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color:  AppColors.lightGreyColor,
                                width: 1,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color:  AppColors.lightGreyColor,
                                width: 1,
                              ),
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: AppColors.lightGreyColor, width: 1.0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: Colors.grey,
                            labelText: 'Password',
                            hintText: '************',
                            labelStyle: const TextStyle(
                              color: AppColors.greyColor,
                              fontSize: TextStylesData.smallFontSize,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: size.height * 0.05,
                ),
                _isLoading
                    ? CircularProgressIndicator(
                  color: AppColors.purpleColor,
                  strokeWidth: 2,
                )
                    :
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: RoundButton(
                    width: size.width,
                    //isLoading: authViewModel.loading,
                    round: 30.0,
                    color: AppColors.darkGreenColor,
                    title: AppText.continueText,
                    onPress: () async {



                      print(_emailAddressController.text);
                      print(_passwordController.text);
                      if (_inputValidator
                          .validateEmail(_emailAddressController.text) !=
                          'success' &&
                          _emailAddressController.text.isNotEmpty)
                      {


                        Utils.flushBarErrorMessage(
                            'Wrong email, please use a correct email',
                            context,
                            AppColors.darkRedColor,
                            'Error',
                            2);
                      }

                      else {
                        if (_emailAddressController.text.isEmpty) {


                          Utils.flushBarErrorMessage(
                              'Enter Email Address',
                              context,
                              AppColors.darkRedColor,
                              'Error',
                              2);

                        }
                        else if (_passwordController.text.isEmpty) {

                          Utils.flushBarErrorMessage(
                              'Enter Password',
                              context,
                              AppColors.darkRedColor,
                              'Error',
                              2);


                        }
                        else {
                          setState(() {
                            _isLoading = true;
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          try {
                            if (widget.userType == 'Users') {
                              final snapshot = await FirebaseFirestore.instance.collection('Users').get();
                              snapshot.docs.forEach((element) {
                                print('user data');
                                if(element['email'] == _emailAddressController.text.toString().trim()) {
                                  print('user age in if of current user ');
                                  //   print(element['age']);
                                  setState(() {
                                    isCreated = 'yes';
                                    status = element['status'];
                                  });
                                }
                              });

                              if(isCreated == 'yes' && status == 'Approved' ) {
                                final result =
                                    await _auth.signInWithEmailAndPassword(
                                    email: _emailAddressController.text
                                        .trim()
                                        .toString(),
                                    password: _passwordController.text);
                                final user = result.user;

                                prefs.setString(
                                    'userEmail', _emailAddressController.text);
                                prefs.setString(
                                    'userPassword', _passwordController.text);
                                prefs.setString('userId', user!.uid);
                                prefs.setString('userType', widget.userType.toString());
                                print('Account creation successful');
                                setState(() {
                                  _isLoading = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) =>
                                        DashboardView(),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 100),
                                  ),
                                );

                                Utils.flushBarErrorMessage(
                                    'Successfully Login',
                                    context,
                                    AppColors.greenColor2,
                                    'Success',
                                    2);

                              }
                              else if (isCreated == 'yes' && status == 'Pending') {

                                setState(() {
                                  _isLoading = false;
                                });

                                Utils.flushBarErrorMessage(
                                    'Sorry your accont approval is pending',
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);

                              }
                              else {
                                setState(() {
                                  _isLoading = false;
                                });
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'User Not Found');
                              }
                            }
                            else  if (widget.userType == 'Mechanic') {
                              print('user data here we are');
                              final snapshot = await FirebaseFirestore.instance.collection('Mechanic').get();
                              snapshot.docs.forEach((element) {
                                print('user data');
                                if(element['email'] == _emailAddressController.text.toString().trim()) {
                                  print('user age in if of current user ');
                                  //   print(element['age']);
                                  setState(() {
                                    isCreated = 'yes';
                                    status = element['status'];
                                  });
                                }
                              });

                              if(isCreated == 'yes') {
                                final result =
                                    await _auth.signInWithEmailAndPassword(
                                    email: _emailAddressController.text
                                        .trim()
                                        .toString(),
                                    password: _passwordController.text);
                                final user = result.user;

                                prefs.setString(
                                    'userEmail', _emailAddressController.text);
                                prefs.setString(
                                    'userPassword', _passwordController.text);
                                prefs.setString('userId', user!.uid);
                                prefs.setString('userType', widget.userType.toString());
                                print('Account creation successful');
                                setState(() {
                                  _isLoading = false;
                                });

                                if(status == 'Confirmed' ) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                          content:  Text('Successfully Login')
                                      )
                                  );

                                } else {

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const  SnackBar(
                                          content:  Text('Sorry, your approval is pending')
                                      )
                                  );

                                }



                              }
                              else {
                                setState(() {
                                  _isLoading = false;
                                });
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'User Not Found');
                              }
                            }
                            else {
                              if (widget.userType == 'Admin' && _emailAddressController.text == 'admin@gmail.com' && _passwordController.text == '12345678') {
                                setState(() {
                                  _isLoading = false;
                                });
                                prefs.setString(
                                    'userEmail', _emailAddressController.text);
                                prefs.setString(
                                    'userPassword', _passwordController.text);
                                print(widget.userType.toString());
                                prefs.setString('userType', 'Admin');

                                Navigator.pushReplacement(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (c, a1, a2) => AdminHomeScreen(),
                                    transitionsBuilder: (c, anim, a2, child) => FadeTransition(opacity: anim, child: child),
                                    transitionDuration: Duration(milliseconds: 100),
                                  ),
                                );


                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'User Not Found');
                              }


                            }


                          }
                          on FirebaseAuthException catch (e)
                          {
                            setState(() {
                              _isLoading = false;
                            });
                            print(e.code);
                            switch (e.code) {
                              case 'invalid-email':
                                _methodsHandler.showAlertDialog(context,
                                    'Sorry', 'Invalid Email Address');

                                setState(() {
                                  _isLoading = false;
                                });
                                break;
                              case 'wrong-password':
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'Wrong Password');
                                setState(() {
                                  _isLoading = false;
                                });
                                break;
                              case 'user-not-found':
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'User Not Found');
                                setState(() {
                                  _isLoading = false;
                                });
                                break;
                              case 'user-disabled':
                                _methodsHandler.showAlertDialog(
                                    context, 'Sorry', 'User Disabled');
                                setState(() {
                                  _isLoading = false;
                                });
                                break;
                            }
                            setState(() {
                              _isLoading = false;
                            });
                          }

                        }
                      }


                    //  Navigator.pushNamed(context, RoutesName.dashView);

                      // if (_emailAddressController.text.isEmpty) {
                      //   Utils.flushBarErrorMessage('Enter email ', context,
                      //       AppColors.darkRedColor, 'Error');
                      // } else if (_passwordController.text.isEmpty) {
                      //   Utils.flushBarErrorMessage('Enter password ', context,
                      //       AppColors.darkRedColor, 'Error');
                      // } else if (_passwordController.text.length < 6) {
                      //   Utils.flushBarErrorMessage(
                      //       'Please enter 6 digits password ',
                      //       context,
                      //       AppColors.darkRedColor,
                      //       'Error');
                      // } else {
                      //
                      // }
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),

                widget.userType == "Admin" ? Container() :
                GestureDetector(
                  onTap: () {




                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => RegisterView(userType: widget.userType,),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeIn;
                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);

                          return SlideTransition(position: offsetAnimation, child: child);
                        },
                      ),
                    );

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppText.registerLine,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: TextStylesData.smallFontSize,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        " Sign up",
                        style: TextStyle(
                            color: AppColors.greenColor2,
                            fontSize: TextStylesData.smallFontSize,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
