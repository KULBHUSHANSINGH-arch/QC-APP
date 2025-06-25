// import 'package:QCM/constant/app_assets.dart';
// import 'package:QCM/constant/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qcmapp/constant/app_assets.dart';
import 'package:qcmapp/constant/app_color.dart';

class AppLoader extends StatelessWidget {
  final String? organization;
  const AppLoader({this.organization, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          // Padding(padding: EdgeInsets.only(top: 150.0)),
          ClipRRect(
            child: Image.asset(
              AppAssets.imgWelcome,
              width: 190,
              height: 260,
              // 120,
              // height: 146
            ),
          ),
          const SpinKitDoubleBounce(
            color: AppColors.primaryColor,
            size: 50.0,
          )
        ]));
  }
}
