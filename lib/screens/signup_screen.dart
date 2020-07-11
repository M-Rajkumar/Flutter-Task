import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappsampletask/utils/common_utils.dart';
import 'package:flutterappsampletask/utils/string_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String _userName;
  String _password;
  String _email;
  String _phoneNumber;
  String _domain;
  String _errorUserNameMessage;
  String _errorPasswordMessage;
  String _errorEmailMessage;
  String _errorDomainMessage;
  String _errorPhoneMessage;
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _domainController = new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  FocusNode focusUserName = FocusNode();
  FocusNode focusPhoneName = FocusNode();
  FocusNode focusEmailName = FocusNode();
  FocusNode focusPasswordName = FocusNode();
  FocusNode focusDomainName = FocusNode();

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
      } else if (_phoneNumber.isEmpty) {
        setState(() {
          _errorPhoneMessage = StringConstants.phoneEmpty;
        });
        return false;
      } else if (_email.isEmpty) {
        setState(() {
          _errorEmailMessage = StringConstants.emailEmpty;
        });
        return false;
      } else if (_password.isEmpty) {
        setState(() {
          _errorPasswordMessage = StringConstants.passwordEmpty;
        });
        return false;
      } else if (_domain.isEmpty) {
        setState(() {
          _errorDomainMessage = StringConstants.domainEmpty;
        });
        return false;
      }

      setState(() {
        _errorUserNameMessage = null;
        _errorPhoneMessage = null;
        _errorEmailMessage = null;
        _errorPasswordMessage = null;
        _errorDomainMessage = null;
      });
      return true;
    }
    return false;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _errorUserNameMessage = null;
    _errorPhoneMessage = null;
    _errorEmailMessage = null;
    _errorPasswordMessage = null;
    _errorDomainMessage = null;
    super.initState();
  }

  Future<void> savePrefValues() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();

    if (validateAndSave()) {
      myPrefs.setString('regName', _userName);
      myPrefs.setString('regPhone', _phoneNumber);
      myPrefs.setString('regEmail', _email);
      myPrefs.setString('regDomain', _domain);
    }
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
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15, right: 32),
                        child: Text(
                          'Staff Register',
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
//                    nameBgContainer(
//                        context,
//                        "Full Name",
//                        _userName,
//                        focusUserName,
//                        _errorUserNameMessage,
//                        _userNameController),
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
                          hintText: "Full Name",
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
                    SizedBox(
                      height: 15,
                    ),
//                    nameBgContainer(context, "Phone Number", _phoneNumber,
//                        focusPhoneName, _errorPhoneMessage, _phoneController),
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
                          _phoneNumber = val;
                        },
                        focusNode: focusPhoneName,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorPhoneMessage = null;
                              });
                            }
                          });
                        },
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorPhoneMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorPhoneMessage ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
//                    nameBgContainer(context, "Email", _email, focusEmailName,
//                        _errorEmailMessage, _emailController),
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
                          _email = val;
                        },
                        focusNode: focusEmailName,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorEmailMessage = null;
                              });
                            }
                          });
                        },
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorEmailMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorEmailMessage ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
//                    nameBgContainer(
//                        context,
//                        "Password",
//                        _password,
//                        focusPasswordName,
//                        _errorPasswordMessage,
//                        _passwordController),
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
                          _password = val;
                        },
                        focusNode: focusPasswordName,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorPasswordMessage = null;
                              });
                            }
                          });
                        },
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorPasswordMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorPasswordMessage ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
//                    nameBgContainer(context, "Domain", _domain, focusDomainName,
//                        _errorDomainMessage, _domainController),
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
                          _domain = val;
                        },
                        focusNode: focusDomainName,
                        onChanged: (value) {
                          setState(() {
                            if (value.length > 0) {
                              setState(() {
                                _errorDomainMessage = null;
                              });
                            }
                          });
                        },
                        controller: _domainController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Domain",
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _errorDomainMessage != null ?? false,
                      child: Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 5.0),
                        child: Text(
                          _errorDomainMessage ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 12.0),
                        ),
                      ),
                    ),

                    Container(
                      child: InkWell(
                        onTap: () {
                          if (validateAndSave()) {
                            savePrefValues();
                            Navigator.pushNamed(context, '/login');
                          }
                        },
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.only(top: 20.0),
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
                              'Sign Up'.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Have an account ?"),
                      Text(
                        "Login",
                        style: TextStyle(color: Color(0xff6bceff)),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameBgContainer(
      BuildContext context,
      String hintText,
      String userText,
      FocusNode getFocusNode,
      String errorMessage,
      TextEditingController getEditingController) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: 45,
      padding: EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: TextFormField(
        onSaved: (String val) {
          userText = val;
        },
        focusNode: getFocusNode,
        onChanged: (value) {
          setState(() {
            if (value.length > 0) {
              setState(() {
                errorMessage = null;
              });
            }
          });
        },
        controller: getEditingController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "---",
        ),
      ),
    );
  }
}
