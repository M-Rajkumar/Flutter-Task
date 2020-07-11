import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterappsampletask/help_widgets/fallback_avatar.dart';
import 'package:flutterappsampletask/screens/staff_information_list.dart';
import 'package:flutterappsampletask/utils/common_utils.dart';

// ignore: must_be_immutable
class CustomStaffListItem extends StatefulWidget {
  CustomStaffListItem({
    Key key,
    @required this.staffInformationList,
    this.isAvatarVisible = false,
    this.colorAvatarBg,
    this.height = 45,
    this.containerColor,
    this.containerPadding,
    this.isItemEnabled = true,
  }) : super(key: key);

  final bool isAvatarVisible;
  final Color colorAvatarBg;
  final Color containerColor;
  final double height;
  final bool isItemEnabled;
  final EdgeInsetsGeometry containerPadding;

  final StaffInformationList staffInformationList;

  @override
  _UserCheckBoxListItemState createState() => _UserCheckBoxListItemState();
}

class _UserCheckBoxListItemState extends State<CustomStaffListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.containerColor ?? Colors.white,
      padding: widget.containerPadding ??
          EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
      child: ListTile(
//        checkColor: Colors.white,
//        activeColor: Theme.of(context).buttonColor,
        dense: true,
        title: Row(
          children: <Widget>[
            Visibility(
              visible: widget.isAvatarVisible,
              child: Row(
                children: <Widget>[
                  FallBackAvatar(
                    image: widget.staffInformationList.photo ?? '',
                    initials: widget.staffInformationList.shortName ?? '',
                    heightWeight: widget.height ?? 45,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0),
                    circleBackground: widget.colorAvatarBg ?? Colors.green,
                    radius: widget.height / 2 ?? 27.5,
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.staffInformationList.displayName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
//                          style: CustomAppTheme.textTheme.headline.copyWith(fontWeight: FontWeight.w400)
                          style: TextStyle(
                            color: widget.isItemEnabled
                                ? Colors.black
                                : null ?? Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 5.0, top: 5.0, left: 3.0),
                    child: Text(
                      widget.staffInformationList.domain ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
//                          style: CustomAppTheme.textTheme.headline.copyWith(fontWeight: FontWeight.w400)
                      style: TextStyle(
                        color: widget.isItemEnabled
                            ? Colors.black
                            : null ?? Colors.black,
                        fontWeight: FontWeight.w200,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: new Image.asset(
          CommonUtils.assetsImage(widget.staffInformationList.logo),
          width: 40,
          height: 40,
        ),
        enabled: widget.isItemEnabled,
      ),
    );
  }
}
