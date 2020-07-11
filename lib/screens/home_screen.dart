import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterappsampletask/help_widgets/custom_staff_list_item.dart';
import 'package:flutterappsampletask/screens/profile_screen.dart';
import 'package:flutterappsampletask/screens/staff_information_list.dart';
import 'package:flutterappsampletask/utils/marquee_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  String getUserName;

  HomeScreen(this.getUserName);
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<StaffInformationList> _list;
  String userUser;
  String regUserName = '', regPhone = '', regEmail = '', regDomain = '';

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    _list = new List();
//    userUser = SharedPrefUtils.getString(StringConstants.userName);
    print('userrr $userUser');
    Future.delayed(Duration.zero, () {
      this.getStaffList();
      getPrefName();
    });
  }

  getPrefName() async {
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    userUser = myPrefs.getString('name');
    regUserName = myPrefs.getString('regName');
    regPhone = myPrefs.getString('regPhone');
    regEmail = myPrefs.getString('regEmail');
    regDomain = myPrefs.getString('regDomain');
    print('namename $userUser');
    print('regDomain $regDomain');
  }

  void getStaffList() async {
    String list = await DefaultAssetBundle.of(context)
        .loadString("assets/userListCustom.json");
    List<dynamic> lists = json.decode(list);
    setState(() {
      lists.forEach((f) {
        StaffInformationList s = StaffInformationList.fromMap(f);
        _list.add(s);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50.0,
                  ),
                ),
                accountName: Text(widget.getUserName),
                accountEmail: Text("${widget.getUserName}@gmail.com"),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF00abff),
                  child: Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                title: Text("Profile"),
                onTap: () {
//                  Navigator.pushNamed(context, '/profile');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(
                              regUserName, regPhone, regEmail, regDomain)));
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF00abff),
                  child: Icon(
                    Icons.settings,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                title: Text("Home"),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF00abff),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
                title: Text("Logout"),
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
        ),
        body: Container(
            child: Column(children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Center(
            child: SizedBox(
                width: 400.0,
                child: MarqueeWidget(
                    direction: Axis.horizontal,
                    child: Text(
                        "Welcome to the Great Innovus Solutions Staff Portal.",
                        style: TextStyle(color: Colors.red, fontSize: 20.0)))),
          ),
          SizedBox(
            height: 30,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _list == null ? 0 : _list.length,
              itemBuilder: (context, index) {
                StaffInformationList staffList = _list[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CustomStaffListItem(
                      isAvatarVisible: true,
                      height: 40,
                      containerPadding: EdgeInsets.only(
                        left: 0.0,
                        right: 0.0,
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      staffInformationList: staffList,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 55.0),
                      child: Divider(
                        height: 0.0,
                        thickness: 1.0,
                      ),
                    ),
                  ],
                );
              }),
        ])));
  }
}
