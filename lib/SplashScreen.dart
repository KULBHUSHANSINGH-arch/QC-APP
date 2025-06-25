import 'dart:async';
import 'dart:convert';
// import 'package:QCM/Fqc.dart';
// import 'package:QCM/Fqcnew.dart';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/Iqcp.dart';
// import 'package:QCM/LoginPage.dart';
// import 'package:QCM/QualityPage.dart';
// import 'package:QCM/Welcomepage.dart';
// import 'package:QCM/constant/app_assets.dart';
// import 'package:QCM/directory.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qcmapp/Fqcnew.dart';
import 'package:qcmapp/Ipqc.dart';
import 'package:qcmapp/Iqcp.dart';
import 'package:qcmapp/LoginPage.dart';
import 'package:qcmapp/QualityPage.dart';
import 'package:qcmapp/Welcomepage.dart';
import 'package:qcmapp/constant/app_assets.dart';
// import 'package:lbn_flutter_project/LoginPage.dart';
// import 'package:lbn_flutter_project/constant/app_assets.dart';
// import 'package:lbn_flutter_project/constant/app_strings.dart';
// import 'package:lbn_flutter_project/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  final String? apptype;

  SplashScreen({this.apptype});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List splashscreen = [];
  String? screen;
  String? pic, site, designation, department, personid;
  // _get() async {
  //   print("Bhanuuuuuuuu.....>???");
  //   print(widget.apptype);
  //   final Alert = (AppStrings.path + 'login/SplashScreen');

  //   var params = {
  //     "OrganizationChapter": widget.apptype,
  //   };
  //   var response = await http.post(
  //     Uri.parse(Alert),
  //     body: json.encode(params),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     var resAlert = json.decode(response.body);
  //     print(resAlert);
  //     print(resAlert['data']);
  //     setState(() {
  //       splashscreen = resAlert['data'];
  //       screen = splashscreen[0]['stringmapname'] ?? '';
  //     });
  //   } else {
  //     print("Error");
  //   }
  // }

  @override
  void initState() {
    super.initState();

    // _get();
    Future.delayed(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? isLoggedIn = prefs.getBool('islogin');
      String? designation = prefs.getString('designation');
      String? department = prefs.getString('department');
      print("DesignationQ");
      print(designation);
      if (isLoggedIn ?? false) {
        Timer(
            Duration(seconds: 2),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => (department == 'IQCP' &&
                        designation != 'Super Admin' &&
                        designation != 'Admin')
                    ? IqcpPage()
                    : (department == 'IPQC' &&
                            designation != 'Super Admin' &&
                            designation != 'Admin')
                        ? IpqcPage()
                        : (department == 'FQC' &&
                                designation != 'Super Admin' &&
                                designation != 'Admin')
                            ? FqcNewPage()
                            : (department == 'QUALITY' &&
                                    designation != 'Super Admin' &&
                                    designation != 'Admin')
                                ? QualityPage()
                                : WelcomePage())));
      } else {
        Timer(
            Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage())));
      }
    });
    getLocalData();
  }

  void getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pic = prefs.getString('pic')!;
      personid = prefs.getString('personid')!;
      site = prefs.getString('site')!;
      designation = prefs.getString('designation')!;
      department = prefs.getString('department')!;
    });
    print(designation);
    print(department);
    print("Hi...?");
  }

  @override
  Widget build(BuildContext context) {
    String Apptype = widget.apptype ?? '';
    return Scaffold(
        backgroundColor: Colors.white,
        body: CachedNetworkImage(
          imageUrl: screen ?? '',
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.fill,
          errorWidget: (context, url, error) {
            return Image.asset(
              AppAssets.splashscreen,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill,
            );
          },
        )

        //   Image.asset(
        // AppAssets.imgSplashBg,
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        // fit: BoxFit.fill,
        // ),
        );
  }
}
