import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappsampletask/screens/home_screen.dart';
import 'package:flutterappsampletask/utils/common_utils.dart';
import 'package:flutterappsampletask/utils/shared_pref.dart';
import 'package:flutterappsampletask/utils/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _userName;
  String _password;
  String _errorUserNameMessage;
  String _errorPasswordMessage;
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  FocusNode focusUserName = FocusNode();
  FocusNode focusPassword = FocusNode();

  bool validateAndSave() {
    Future.delayed(Duration(milliseconds: 50)).then((_) {
      FocusScope.of(context).requestFocus(FocusNode());
    });

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_userName.isEmpty) {
        setState(() {
          _errorUserNameMessage = StringConstants.userEmpty;
        });

        return false;
      } else if (_password.isEmpty) {
        setState(() {
          _errorPasswordMessage = StringConstants.passwordEmpty;
        });
        return false;
      }

      setState(() {
        _errorUserNameMessage = null;
        _errorPasswordMessage = null;
      });
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    if (validateAndSave()) {
      await SharedPrefUtils.putString(StringConstants.userName, _userName);
      myPrefs.setString('name', _userName);
      print('Fcm _userName --> $_userName');
//      Navigator.pushNamed(context, '/home');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(_userName)));
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _errorUserNameMessage = null;
    _errorPasswordMessage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff6bceff), Color(0xff6bceff)],
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(90))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          CommonUtils.assetsImage('app_logo'),
                        )),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 32),
                        child: Text(
                          'Staff Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 62),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        onSaved: (String val) {
                          _userName = val;
                        },
                        focusNode: focusUserName,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorUserNameMessage = null;
                              });
                            }
                          });
                        },
                        controller: _userNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.person,
                            color: Color(0xff6bceff),
                          ),
                          hintText: 'Username',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorUserNameMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorUserNameMessage ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 32),
                      padding: EdgeInsets.only(
                          top: 4, left: 16, right: 16, bottom: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 5)
                          ]),
                      child: TextFormField(
                        focusNode: focusPassword,
                        controller: _passwordController,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorPasswordMessage = null;
                              });
                            }
                          });
                        },
                        onSaved: (String val) {
                          _password = val;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.vpn_key,
                            color: Color(0xff6bceff),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorPasswordMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorPasswordMessage ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return forgotPasswordContainer(context);
                            });
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16, right: 32),
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        validateAndSubmit();
//                        if (validateAndSave()) {
//
//
//                        }
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff6bceff),
                                Color(0xFF00abff),
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child: Center(
                          child: Text(
                            'Login'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account ?"),
                    Text(
                      " Sign Up",
                      style: TextStyle(color: Color(0xff6bceff)),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/signup');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget forgotPasswordContainer(BuildContext context) {
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.pop(context);
              },
              child: CircleAvatar(
                child: Icon(
                  Icons.close,
                  color: Colors.black54,
                ),
                backgroundColor: Color(0xff6bceff),
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "We'll send instructions on how to rest your password to the email address you have registered with us.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: forgotBgContainer(context, "Email Address"),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff6bceff),
                            Color(0xFF00abff),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Center(
                      child: Text(
                        'Submit'.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container forgotBgContainer(BuildContext context, String hintText) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "---",
        ),
      ),
    );
  }
}
