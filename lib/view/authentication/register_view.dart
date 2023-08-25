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
import 'package:road_safety/view/authentication/login_view.dart';
import 'package:road_safety/view/authentication/userType/usertype_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  final String userType;
  const RegisterView({super.key, required this.userType});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailAddressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  ValueNotifier obsecurePassword = ValueNotifier(true);

  MethodsHandler _methodsHandler = MethodsHandler();
  InputValidator _inputValidator = InputValidator();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool _isVisible = false;
  bool _isVisibleC = false;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _isVisible = false;
      _isVisibleC = false;
      _isLoading = false;
    });
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
                child: Stack(
              children: <Widget>[
                //stack overlaps widgets
                Opacity(
                  //semi red clippath with more height and with 0.5 opacity
                  opacity: 0.5,
                  child: ClipPath(
                    clipper: WaveClipper(), //set our custom wave clipper
                    child: Container(
                      color: AppColors.greenColor2,
                      height: 300,
                    ),
                  ),
                ),

                ClipPath(
                  //upper clippath with less height
                  clipper: WaveClipper(), //set our custom wave clipper.
                  child: Container(
                    padding: EdgeInsets.only(bottom: 50),
                    color: AppColors.purpleColor,
                    height: 280,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Text('ROAD SAFETY',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ],
            )),
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
                          AppText.register,
                          style: TextStyle(
                              fontSize: TextStylesData.titleFontSize,
                              color: AppColors.darkGreenColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  child: TextFormField(
                    controller: _fullNameController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
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
                      labelText: 'Full Name',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightGreyColor, width: 1.0),
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
                  height: size.height * 0.01,
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
                            color: AppColors.greenColor,
                            size: 20,
                          )),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                      //add prefix icon

                      // errorText: "Error",

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightGreyColor, width: 1.0),
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
                  height: size.height * 0.01,
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  child: TextFormField(
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.phone,
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
                      labelText: 'Phone',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightGreyColor, width: 1.0),
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
                  height: size.height * 0.01,
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
                                  obsecurePassword.value =
                                  !obsecurePassword.value;
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
                                color: AppColors.lightGreyColor,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppColors.lightGreyColor,
                                width: 1,
                              ),
                            ),
                            contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.lightGreyColor, width: 1.0),
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
                  height: size.height * 0.01,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
                  child: TextFormField(
                    controller: _addressController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.streetAddress,
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
                      labelText: 'Address',
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: AppColors.lightGreyColor,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.lightGreyColor, width: 1.0),
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
                _isLoading
                    ? CircularProgressIndicator(
                        color: AppColors.purpleColor,
                        strokeWidth: 2,
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: RoundButton(
                          width: size.width,
                          //isLoading: authViewModel.loading,
                          round: 30.0,
                          color: AppColors.darkGreenColor,
                          title: 'Register',
                          onPress: () async {
                            if (_inputValidator.validateName(
                                        _fullNameController.text) !=
                                    'success' &&
                                _fullNameController.text.isNotEmpty) {
                              Utils.flushBarErrorMessage("Invalid User Name",
                                  context, AppColors.darkRedColor, 'Error', 2);
                            } else if (_inputValidator.validateEmail(
                                        _emailAddressController.text) !=
                                    'success' &&
                                _emailAddressController.text.isNotEmpty) {
                              Utils.flushBarErrorMessage("Wrong email address",
                                  context, AppColors.darkRedColor, 'Error', 2);
                            } else if (_inputValidator.validateMobile(
                                        _phoneController.text) !=
                                    'success' &&
                                _phoneController.text.isNotEmpty) {
                              Utils.flushBarErrorMessage(
                                  "Phone Number Starts with + followed by code then number (Hint +923346567876)",
                                  context,
                                  AppColors.darkRedColor,
                                  'Error',
                                  2);
                            } else if ((_passwordController.text.length < 7 &&
                                    _passwordController.text.isNotEmpty)
                                // &&
                                // (_confirmPasswordControoler.text.length < 7 &&
                                // _confirmPasswordControoler
                                //     .text.isNotEmpty)
                                ) {
                              Utils.flushBarErrorMessage(
                                  "Password length must be greater than 6",
                                  context,
                                  AppColors.darkRedColor,
                                  'Error',
                                  2);
                            } else {
                              if (_fullNameController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    "User Name is required",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);
                              } else if (_emailAddressController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    "Email Address is required",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);
                              } else if (_phoneController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    "Phone number is required",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);
                              } else if (_passwordController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    "Password is required",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);
                              } else if (_addressController.text.isEmpty) {
                                Utils.flushBarErrorMessage(
                                    "Enter Address",
                                    context,
                                    AppColors.darkRedColor,
                                    'Error',
                                    2);
                              } else {
                                setState(() {
                                  _isLoading = true;
                                  print('We are in loading');
                                  //  state = ButtonState.loading;
                                });

                                //createAccount();
                                //_methodsHandler.createAccount(name: _controllerClinic.text, email: _controller.text, password: _controllerPass.text, context: context);
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();

                                FirebaseFirestore.instance
                                    .collection(widget.userType.toString())
                                    .where("email",
                                        isEqualTo:
                                            _emailAddressController.text.trim())
                                    .get()
                                    .then((value) async {
                                  if (value.docs.isNotEmpty) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Utils.flushBarErrorMessage(
                                        "Sorry email account already exists",
                                        context,
                                        AppColors.darkRedColor,
                                        'Error',
                                        2);
                                  } else {
                                    try {
                                      User? result1 = (await _auth
                                              .createUserWithEmailAndPassword(
                                                  email: _emailAddressController
                                                      .text
                                                      .trim(),
                                                  password: _passwordController
                                                      .text
                                                      .trim()))
                                          .user;

                                      if (result1 != null) {
                                        var user = result1;

                                        FirebaseFirestore.instance
                                            .collection(
                                                widget.userType.toString())
                                            .doc()
                                            .set({
                                          "email": _emailAddressController.text
                                              .trim(),
                                          "password":
                                              _passwordController.text.trim(),
                                          "uid": user.uid,
                                          "status": "Pending",
                                          "name": _fullNameController.text,
                                          "phone": _phoneController.text,
                                          "userType":
                                              widget.userType.toString(),
                                          "address": _addressController.text
                                              .toString(),
                                        }).then((value) => print('success'));

                                        prefs.setString('userType',
                                            widget.userType.toString());
                                        prefs.setString(
                                            'userEmail',
                                            _emailAddressController.text
                                                .trim());
                                        prefs.setString('userPassword',
                                            _passwordController.text.trim());
                                        prefs.setString('name',
                                            _fullNameController.text.trim());
                                        prefs.setString('userId', user.uid);
                                        print('Account creation successful');
                                        setState(() {
                                          _isLoading = false;
                                        });

                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                LoginView(
                                              userType: widget.userType,
                                            ),
                                            transitionsBuilder:
                                                (c, anim, a2, child) =>
                                                    FadeTransition(
                                                        opacity: anim,
                                                        child: child),
                                            transitionDuration:
                                                Duration(milliseconds: 100),
                                          ),
                                        );

                                        Utils.flushBarErrorMessage(
                                            "Account Created Successfully. Please wait for your account approval",
                                            context,
                                            AppColors.greenColor2,
                                            'Success',
                                            4);
                                      } else {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        print('error');
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (e.code == 'email-already-in-use') {
                                        _methodsHandler.showAlertDialog(
                                            context,
                                            'Sorry',
                                            'The email address is already in use by another account.');
                                      }
                                      print(e.message);
                                      print(e.code);
                                    }

                                    await Future.delayed(Duration(seconds: 1));
                                  }
                                });
                              }
                            }
                          },
                        ),
                      ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginView(
                                  userType: widget.userType,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppText.loginLine,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: TextStylesData.smallFontSize,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        " Sign in",
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
