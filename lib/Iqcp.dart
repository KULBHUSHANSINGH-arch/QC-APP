// import 'package:QCM/AluminiumFrame.dart';
// import 'package:QCM/Backsheet.dart';
// import 'package:QCM/CommonDrawer.dart';
// import 'package:QCM/Encapsulant.dart';
// import 'package:QCM/Flux.dart';
// import 'package:QCM/Fqc.dart';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/JunctionBox.dart';
// import 'package:QCM/Ribbon.dart';
// import 'package:QCM/Sealant.dart';
// import 'package:QCM/SolarCell.dart';
// import 'package:QCM/SolarGlass.dart';
// import 'package:QCM/Welcomepage.dart';
// import 'package:QCM/components/appbar.dart';
// import 'package:QCM/constant/app_color.dart';
// import 'package:QCM/constant/app_fonts.dart';
// import 'package:QCM/constant/app_styles.dart';
// import 'package:QCM/directory.dart';
// import 'package:QCM/testingEquipList.dart';
// import 'package:QCM/testingequipment.dart';
import 'package:flutter/material.dart';
import 'package:qcmapp/AluminiumFrame.dart';
import 'package:qcmapp/Backsheet.dart';
import 'package:qcmapp/CommonDrawer.dart';
import 'package:qcmapp/Encapsulant.dart';
import 'package:qcmapp/Flux.dart';
import 'package:qcmapp/Fqc.dart';
import 'package:qcmapp/Ipqc.dart';
import 'package:qcmapp/JunctionBox.dart';
import 'package:qcmapp/Ribbon.dart';
import 'package:qcmapp/Sealant.dart';
import 'package:qcmapp/SolarCell.dart';
import 'package:qcmapp/SolarGlass.dart';
import 'package:qcmapp/Welcomepage.dart';
import 'package:qcmapp/components/appbar.dart';
import 'package:qcmapp/constant/app_color.dart';
import 'package:qcmapp/constant/app_fonts.dart';
import 'package:qcmapp/constant/app_styles.dart';
import 'package:qcmapp/directory.dart';
import 'package:qcmapp/testingEquipList.dart';
import 'package:qcmapp/testingequipment.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../BoxCricket.dart';
import '../constant/app_assets.dart';
import '../main.dart';

class IqcpPage extends StatefulWidget {
  IqcpPage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<IqcpPage> {
  String? firstname,
      designation,
      department,
      lastname,
      personid,
      pic,
      VersionNo,
      ImagePath,
      site,
      businessname,
      clubname,
      organizationName,
      organizationtype,
      vCard,
      userGuideLink;
  bool isAllowedEdit = false,
      menu = false,
      user = false,
      face = false,
      home = true;
  var decodedResult;
  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      designation = prefs.getString('designation');
      department = prefs.getString('department');
      personid = prefs.getString('personid');
      firstname = prefs.getString('firstname');
      lastname = prefs.getString('lastname');
      pic = prefs.getString('pic');
      VersionNo = prefs.getString('versionNo');
      clubname = prefs.getString('clubname');
      businessname = prefs.getString('businessname');
      organizationName = prefs.getString('organizationName');
      organizationtype = prefs.getString('organizationtype');
      site = prefs.getString('site');
      ImagePath = prefs.getString('imagePath');
      vCard = prefs.getString('Vcard');
    });
    // getFromStringmap();
  }

  @override
  void initState() {
    super.initState();
    store();
  }

  adminbuttons() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // buttonAttendance(),
        // buttonReport(),
      ],
    );
  }

  Future<bool> redirectto() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => WelcomePage()),
        (Route<dynamic> route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBlack,
      appBar: GautamAppBar(
        organization: "organizationtype",
        isBackRequired:
            department == 'IQCP' && designation != 'Super Admin' ? false : true,
        memberId: personid,
        imgPath: "ImagePath",
        memberPic: pic,
        logo: "logo",
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return WelcomePage();
          }));
        },
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard('Solar Cell', AppAssets.solarcell, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SolarCell(id: "")),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard('Solar Glass', AppAssets.planet, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SolarGlass(id: "")),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            //1st row
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard('Encapsulant/EVA', AppAssets.eva, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Encapsulant(id: "")),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard('Ribbon', AppAssets.icDirectory, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Ribbon(id: "")),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard(
                        'Junction Box', AppAssets.imgAttendanceReport, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => JunctionBox()),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard(
                        'Aluminium Frame', AppAssets.imgSalaryReport, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => AluminiumFrame()),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard('Flux', AppAssets.flux, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Flux()),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard(
                        'Backsheet', AppAssets.imgAttendanceList, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Backsheet()),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child:
                        tabDashboard('Sealant/Poating', AppAssets.Poating, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Sealant()),
                      (Route<dynamic> route) => false);
                })),
                const SizedBox(
                  width: 10,
                ),
                // Expanded(
                //     child: tabDashboard(
                //         'Testing Equipment', AppAssets.testingeqipment, () {
                //   Navigator.of(context).pushAndRemoveUntil(
                //       MaterialPageRoute(
                //           builder: (BuildContext context) =>
                //               TestingEquipment()),
                //       (Route<dynamic> route) => false);
                // })),
                // const SizedBox(
                //   width: 10,
                // ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard(
                        'Testing Equipment', AppAssets.testingeqipment, () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              TestingEquipment()),
                      (Route<dynamic> route) => false);
                })),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: tabDashboard(
                        'Testing Equipment List', AppAssets.testingeqipment,
                        () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              testingEquipList()),
                      (Route<dynamic> route) => false);
                })),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )),
      bottomNavigationBar: Container(
        height: 60,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 245, 203, 19),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          (department == 'IQCP' && designation != 'Super Admin')
                              ? IqcpPage()
                              : (department == 'IPQC' &&
                                      designation != 'Super Admin')
                                  ? IpqcPage()
                                  : (department == 'FQC' &&
                                          designation != 'Super Admin')
                                      ? FqcPage()
                                      : WelcomePage()));
                },
                child: Image.asset(
                    home
                        ? AppAssets.icHomeSelected
                        : AppAssets.icHomeUnSelected,
                    height: 25)),
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  if (designation == 'Super Admin') {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => EmployeeList()));
                  }
                },
                child: Image.asset(
                    user ? AppAssets.imgSelectedPerson : AppAssets.imgPerson,
                    height: 25)),
            const SizedBox(
              width: 8,
            ),
            InkWell(
                // onTap: () {
                //   Navigator.of(context).pushReplacement(MaterialPageRoute(
                //       builder: (BuildContext context) => Attendance()));
                // },
                child: Image.asset(
                    face
                        ? AppAssets.icSearchSelected
                        : AppAssets.icSearchUnSelected,
                    height: 25)),
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => PublicDrawer()));
                },
                child: Image.asset(
                    menu ? AppAssets.imgSelectedMenu : AppAssets.imgMenu,
                    height: 25)),
          ],
        ),
      ),
    );
  }

  InkWell buttonDashboard() {
    return InkWell(
        onTap: () {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => WelcomePage()),
          //     (Route<dynamic> route) => false);
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Material(
                  shape: RoundedRectangleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: new Image.asset(AppAssets.icDashboard,
                      height: 18.0, width: 18.0, color: AppColors.greyColor),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text("Dashboard", style: AppStyles.drawerMenuTextStyle),
            ]));
  }

  InkWell buttonDirectory() {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => EmployeeList()),
              (Route<dynamic> route) => false);
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 12),
                child: Material(
                  shape: RoundedRectangleBorder(),
                  clipBehavior: Clip.hardEdge,
                  child: Image.asset(AppAssets.icDirectory,
                      height: 18.0, width: 18.0, color: AppColors.greyColor),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Text("Directory", style: AppStyles.drawerMenuTextStyle),
            ]));
  }

  Item? selectedUser;
  List<Item> users = <Item>[
    const Item('1-2-1', "images/drawer-p2p.png"),
    const Item('Referral', "images/drawer-referral.png"),
    const Item('TYN', "images/drawer-tyn.png"),
    const Item('Testimonial', "images/drawer-testimonials.png"),
    const Item('Visitor', "images/drawer-visitors.png"),
  ];

  Item1? selectedUser1;
  List<Item1> users1 = <Item1>[
    const Item1('Meeting', "images/drawer-add-meeting.png"),
    const Item1('Training', "images/drawer-training.png"),
  ];

  Item2? selectedUser2;
  List<Item2> users2 = <Item2>[
    const Item2('Activity', "images/drawer-referral.png"),
    const Item2('1-2-1', "images/drawer-p2p.png"),
    const Item2('Referral', "images/drawer-referral.png"),
    const Item2('TYN', "images/drawer-tyn.png"),
    const Item2('Attendance', 'icons/attendance.png'),
  ];
  Item3? selectedUser3;
  List<Item3> users3 = <Item3>[
    const Item3('TYN', "images/drawer-tyn.png"),
    const Item3('Referral', "images/drawer-referral.png"),
    const Item3('1-2-1', "images/drawer-p2p.png"),
    const Item3('Overall', "images/drawer-visitors.png"),
  ];
}

class Item {
  const Item(this.name, this.path);
  final String name;
  final String path;
}

class Item1 {
  const Item1(this.name, this.path);
  final String name;
  final String path;
}

class Item2 {
  const Item2(this.name, this.path);
  final String name;
  final String path;
}

class Item3 {
  const Item3(this.name, this.path);
  final String name;
  final String path;
}

Widget tabDashboard(String title, String img, final Function onPressed) {
  return InkWell(
    onTap: () {
      onPressed();
    },
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 115,
      child: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                height: 50,
                width: 155,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage(
                          AppAssets.icEllipse,
                        ),
                        fit: BoxFit.fill)),
                // child: Image.asset(
                //   AppAssets.icEllipse,
                //   fit: BoxFit.fill,
                //   height: 50,
                //   width: 155,
                // ),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 15),
                child: Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: appFontFamily,
                        fontSize: 16,
                        color: AppColors.textFieldCaptionColor)),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Container(
                      height: 36,
                      width: 36,
                      child: Image.asset(
                        img,
                        height: 36,
                        width: 36,
                        //fit: BoxFit.cover,
                      )))
            ],
          )
        ],
      ),
    ),
  );
}
