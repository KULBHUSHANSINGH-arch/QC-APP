import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'package:QCM/AddQuality.dart';
// import 'package:QCM/CapaReport.dart';
// import 'package:QCM/CommonDrawer.dart';
// import 'package:QCM/Fqc.dart';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/Iqcp.dart';
// import 'package:QCM/QualityPage.dart';
// import 'package:QCM/Welcomepage.dart';
// import 'package:QCM/addeditemployee.dart';
// import 'package:QCM/components/app_loader.dart';
// import 'package:QCM/components/appbar.dart';
// import 'package:QCM/constant/app_assets.dart';
// import 'package:QCM/constant/app_color.dart';
// import 'package:QCM/constant/app_fonts.dart';
// import 'package:QCM/constant/app_styles.dart';
// import 'package:QCM/directory.dart';
// import 'package:QCM/capa_list_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qcmapp/CapaReport.dart';
import 'package:qcmapp/CommonDrawer.dart';
import 'package:qcmapp/Fqc.dart';
import 'package:qcmapp/Ipqc.dart';
import 'package:qcmapp/Iqcp.dart';
import 'package:qcmapp/QualityPage.dart';
import 'package:qcmapp/Welcomepage.dart';
import 'package:qcmapp/addeditemployee.dart';
import 'package:qcmapp/capa_list_model.dart';
import 'package:qcmapp/components/app_loader.dart';
import 'package:qcmapp/components/appbar.dart';
import 'package:qcmapp/constant/app_assets.dart';
import 'package:qcmapp/constant/app_color.dart';
import 'package:qcmapp/constant/app_fonts.dart';
import 'package:qcmapp/constant/app_styles.dart';
import 'package:qcmapp/directory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

// import 'user_list_model.dart';

class capaList extends StatefulWidget {
  capaList();

  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<capaList> {
  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  TextEditingController SearchController = TextEditingController();
  // TextEditingController _paymentModeController = new TextEditingController();
  TextEditingController ExpiryDateController = new TextEditingController();
  TextEditingController PaymentDateController = new TextEditingController();

  TextEditingController NoteController = new TextEditingController();
  GlobalKey<FormState> _renewalFormkey = GlobalKey<FormState>();

  bool _isLoading = false, IN = false, OUT = false;
  bool menu = false, user = false, face = false, home = false;
  String? _paymentModeController;
  List paymentModeData = [];
  String? personid,
      token,
      vCard,
      firstname,
      lastname,
      pic,
      logo,
      site,
      designation,
      department,
      ImagePath,
      detail,
      businessname,
      organizationName,
      otherChapterName = '',
      _hasBeenPressedorganization = '',
      organizationtype,
      _hasBeenPressed = '',
      _hasBeenPressed1 = 'Pending',
      _hasBeenPressed2 = '',
      Expirydate,
      Paymentdate;
  // RoleModel? paymentModeData;
  TextEditingController AmountController = new TextEditingController();
  bool status = false, isAllowedEdit = false;
  var decodedResult;
  var rmbDropDown;
  Future? userdata;
  late UserModel aUserModel;
  List dropdownList = [];

  @override
  void initState() {
    if (mounted) {
      detail = 'hide';
      store();
    }
    super.initState();
  }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pic = prefs.getString('pic');
      personid = prefs.getString('personid');
      site = prefs.getString('site');
      designation = prefs.getString('designation');
      department = prefs.getString('department');
      token = prefs.getString('token');
    });

    userdata = getData();
  }

  Future<List<UserData>?> getData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');
    setState(() {
      _isLoading = true;
    });
    final url = (site! + 'Maintenance/getKapaReport');
    http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{"status": _hasBeenPressed1!}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          decodedResult = jsonDecode(response.body);
          print("decodedResult");
          print(decodedResult);
        });

        //  prefs.setString(DBConst.directory, response.body);
      }
    });

    return null;
  }

  void setMemberStatus(status, id) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');
    final url = (site!) + 'Employee/DeleteEmployee';
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{"PersonId": id, "Status": status}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("Response.....");
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("Employee Removed Successfully",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: AppColors.primaryColor);

      getData();

      return;
    } else {
      throw Exception('Failed To Fetch Data');
    }
  }

  Future<bool> redirectto() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                (department == 'QUALITY' && designation != 'Super Admin')
                    ? QualityPage()
                    : WelcomePage()),
        (Route<dynamic> route) => false);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        // ignore: deprecated_member_use
        child: WillPopScope(
            // ignore: missing_return
            onWillPop: redirectto,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.appBackgroundColor,
                appBar: GautamAppBar(
                  organization: "organizationtype",
                  isBackRequired: true,
                  memberId: personid,
                  imgPath: "ImagePath",
                  memberPic: pic,
                  logo: "logo",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return (department == 'QUALITY' &&
                              designation != 'Super Admin')
                          ? QualityPage()
                          : WelcomePage();
                    }));
                  },
                ),
                body: _isLoading
                    ? AppLoader(organization: organizationtype)
                    : RefreshIndicator(
                        color: Colors.white,
                        backgroundColor: AppColors.blueColor,
                        onRefresh: () async {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      capaList()),
                              (Route<dynamic> route) => false);
                          return Future<void>.delayed(
                              const Duration(seconds: 3));
                        },
                        child: Container(
                          // margin: EdgeInsets.only(bottom: 80),
                          width: MediaQuery.of(context).size.width,
                          child: Center(child: _userData()),
                        ),
                      ),
                // floatingActionButton: designation != 'Reporting Manager'
                //     ? _getFAB()
                //     : Container(),
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        (department == 'IQCP' &&
                                                designation != 'Super Admin')
                                            ? IqcpPage()
                                            : (department == 'IPQC' &&
                                                    designation !=
                                                        'Super Admin')
                                                ? IpqcPage()
                                                : (department == 'FQC' &&
                                                        designation !=
                                                            'Super Admin')
                                                    ? FqcPage()
                                                    : (department ==
                                                                'QUALITY' &&
                                                            designation !=
                                                                'Super Admin')
                                                        ? QualityPage()
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
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EmployeeList()));
                            }
                          },
                          child: Image.asset(
                              user
                                  ? AppAssets.imgSelectedPerson
                                  : AppAssets.imgPerson,
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
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PublicDrawer()));
                          },
                          child: Image.asset(
                              menu
                                  ? AppAssets.imgSelectedMenu
                                  : AppAssets.imgMenu,
                              height: 25)),
                    ],
                  ),
                ),
              ),
            )));
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => AddEditProfile()),
              (Route<dynamic> route) => false);
        },
        child: ClipOval(
          child: Image.asset(
            AppAssets.icPlusBlue,
            height: 60,
            width: 60,
          ),
        ),
      ),
    );
  }

// <List<UserData>> List<UserData>
  _userData() {
    return FutureBuilder(
      future: userdata,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          aUserModel = UserModel.fromJson(decodedResult);

          List<UserData> data = aUserModel.data!;

          return _user(aUserModel);
        } else if (snapshot.hasError) {
          return const AppLoader();
        }

        return const AppLoader();
      },
    );
  }

  Widget filter() {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //#1 Completed
            InkWell(
                onTap: () {
                  setState(() {
                    _hasBeenPressed1 = 'Pending';
                    _hasBeenPressed2 = '';
                  });
                  userdata = getData();
                },
                child: Text('Pending',
                    style: TextStyle(
                        fontFamily: appFontFamily,
                        color: _hasBeenPressed1 == 'Pending'
                            ? AppColors.blueColor
                            : AppColors.black,
                        fontWeight: _hasBeenPressed1 == 'Pending'
                            ? FontWeight.w700
                            : FontWeight.normal))),

            const Text(
              ' | ',
              style: TextStyle(
                  fontFamily: appFontFamily,
                  color: AppColors.blueColor,
                  fontWeight: FontWeight.w700),
            ),

            //#2 Inactive
            InkWell(
              onTap: () {
                setState(() {
                  _hasBeenPressed1 = 'Approved';
                });
                userdata = getData();
              },
              child: Text(
                'Approved',
                style: TextStyle(
                    fontFamily: appFontFamily,
                    color: _hasBeenPressed1 == 'Approved'
                        ? AppColors.blueColor
                        : AppColors.black,
                    fontWeight: _hasBeenPressed1 == 'Approved'
                        ? FontWeight.w700
                        : FontWeight.normal),
              ),
            ),
          ],
        ));
  }

  Column _user(UserModel data) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Padding(padding: EdgeInsets.only(top: 15, left: 10, right: 10)),
      Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text on the left
              Text(
                'Capa Report List',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.blueColor,
                ),
              ),

              Spacer(),

              // Plus icon on the right wrapped with GestureDetector
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CapaReport()), // No 'const' needed here
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.blueColor, // Background color
                    borderRadius: BorderRadius.circular(12), // Rounded border
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 12), // Button padding
                  child: Text(
                    'Add CAPA',
                    style: TextStyle(
                        fontSize: 16, color: Colors.white), // Text style
                  ),
                ),
              )
            ],
          )),

      const Padding(padding: EdgeInsets.only(top: 15, left: 10, right: 10)),
      Row(children: <Widget>[
        Container(
          child: Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: SearchController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                  hintText: "Search CapaReport",
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 25,
                    color: AppColors.lightBlackColor,
                  )),
              style: AppStyles.textInputTextStyle,
              onChanged: (value) {
                setState(() {});
              },
            ),
          )),
        ),
      ]),
      // Padding(
      //     padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       crossAxisAlignment: CrossAxisAlignment.end,
      //       children: [filter()],
      //     )),
      Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  data.data!.length > 1
                      ? '${data.data!.length} Capa Report'
                      : '${data.data!.length} Capa Report',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: appFontFamily,
                      fontSize: 15,
                      color: AppColors.greyColor)),
              filter()
            ],
          )),
      Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: data.data!.length,
                itemBuilder: (context, index) {
                  if (SearchController.text.isEmpty) {
                    return Container(
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else if ((data.data![index].type ?? '')
                          .toLowerCase()
                          .contains((SearchController.text).toLowerCase()) ||
                      data.data![index].reportId!
                          .toLowerCase()
                          .contains((SearchController.text).toLowerCase())) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else if (data.data![index].shift!
                      .toLowerCase()
                      .contains((SearchController.text).toLowerCase())) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else if (data.data![index].department!
                      .toLowerCase()
                      .contains((SearchController.text).toLowerCase())) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else if ((data.data![index].departmentName!)
                      .toLowerCase()
                      .contains((SearchController.text).toLowerCase())) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else if (data.data![index].createdBy!
                      .toLowerCase()
                      .contains((SearchController.text).toLowerCase())) {
                    return Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        child: _tile(
                            data.data![index].reportId ?? '',
                            // data.data![index].problemDescription ?? '',
                            data.data![index].type ?? '',
                            data.data![index].shift ?? '',
                            data.data![index].createdOn ?? '',
                            data.data![index].createdBy ?? '',
                            data.data![index].departmentName ?? '',
                            data.data![index].pdfUrl ?? ''));
                  } else {
                    return Container();
                  }
                })),
      ),
      const SizedBox(height: 20),

      const SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _tile(String id, String type, String shift, String createdOn,
      String CreatedBy, String department, String pdfUrl) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => DirectoryDetails(
        //               personId: id,
        //             )),
        //     (Route<dynamic> route) => false);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      child: Material(
                        shape: const CircleBorder(),
                        clipBehavior: Clip.hardEdge,
                        color: Colors.transparent,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    elevation: 0,
                                    backgroundColor:
                                        Color.fromARGB(0, 232, 131, 8),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25.0),
                                            bottomRight: Radius.circular(25.0),
                                            topRight: Radius.circular(25.0),
                                            bottomLeft: Radius.circular(25.0),
                                          )),
                                      child: CachedNetworkImage(
                                        width: 430,
                                        height: 400,
                                        imageUrl: (id),
                                        errorWidget: (context, url, error) {
                                          return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                AppAssets.profilePlaceholder,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ));
                                        },
                                        // placeholder: 'cupertinoActivityIndicator',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: CachedNetworkImage(
                            imageUrl: id,
                            height: 60,
                            width: 60,
                            placeholder: (context, url) {
                              return ClipOval(
                                child: Image.asset(
                                  AppAssets.profilePlaceholder,
                                  height: 60,
                                  width: 60,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return ClipOval(
                                child: Image.asset(
                                  AppAssets.profilePlaceholder,
                                  height: 60,
                                  width: 60,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Name
                        Row(children: <Widget>[
                          Flexible(
                            child: Text(CreatedBy,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: appFontFamily,
                                    fontSize: 16,
                                    color: AppColors.lightBlackColor)),
                          ),
                          // if (isMemberrole == 1)
                          // ClipRRect(
                          //   child: Image.asset(
                          //     'images/badge.png',
                          //     width: 20,
                          //     height: 20,
                          //   ),
                          // ),
                        ]),

                        //Occupication
                        Text(createdOn,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: appFontFamily)),

                        Row(children: <Widget>[
                          Flexible(
                            child: Text(shift,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: appFontFamily,
                                  fontSize: 12,
                                )),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 0, 0, 0), // Background color
                              borderRadius: BorderRadius.circular(
                                  10), // Optional: Add border radius for rounded corners
                            ),
                            child: Text(
                              department,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.white, // Optional: Set text color
                              ),
                            ),
                          ),
                        ]),
                        Row(children: <Widget>[
                          if (pdfUrl != null && pdfUrl != '')
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    255, 100, 243, 4), // Background color
                                borderRadius: BorderRadius.circular(
                                    10), // Optional: Add border radius for rounded corners
                              ),
                              child: const Text(
                                "PDF :",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Color.fromARGB(
                                      255, 0, 0, 0), // Optional: Set text color
                                ),
                              ),
                            ),
                          if (pdfUrl != null && pdfUrl != '')
                            const SizedBox(
                              width: 5,
                            ),
                          if (pdfUrl != null && pdfUrl != '')
                            GestureDetector(
                              onTap: () {
                                UrlLauncher.launch(pdfUrl);
                              },
                              child: ClipRRect(
                                child: Image.asset(
                                  AppAssets.icPdf,
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                        ]),
                        SizedBox(
                          width: 10,
                        ),

                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (_hasBeenPressed1 != "Approved")
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        CapaReport(id: id)),
                                (Route<dynamic> route) => false);
                          },
                          child: Image.asset(
                            AppAssets.icMemberEdit,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      // InkWell(
                      //     child: Image.asset(
                      //       AppAssets.icMemberDelete,
                      //       height: 40,
                      //       width: 40,
                      //     ),
                      //     onTap: () {
                      //       showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return Dialog(
                      //             shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(21),
                      //             ),
                      //             elevation: 0,
                      //             backgroundColor: Colors.transparent,
                      //             // child: contentBox(context, id),
                      //           );
                      //         },
                      //       );
                      //     })
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColors.dividerColor,
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget appBarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 25,
          child: ClipOval(
            child: Image.network(
                "https://st4.depositphotos.com/4329009/19956/v/600/depositphotos_199564354-stock-illustration-creative-vector-illustration-default-avatar.jpg",
                fit: BoxFit.cover,
                height: 50,
                width: 50),
          ),
        ),
        // Image.asset(
        //   AppAssets.icAppLogoHorizontal,
        //   width: 150,
        //   height: 45,
        // )
      ],
    );
  }
}
