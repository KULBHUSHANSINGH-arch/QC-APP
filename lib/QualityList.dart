import 'dart:async';
import 'dart:convert';
import 'dart:ui';
// import 'package:QCM/AddQuality.dart';
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
// import 'package:QCM/quality_list_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qcmapp/AddQuality.dart';
import 'package:qcmapp/CommonDrawer.dart';
import 'package:qcmapp/Fqc.dart';
import 'package:qcmapp/Ipqc.dart';
import 'package:qcmapp/Iqcp.dart';
import 'package:qcmapp/QualityPage.dart';
import 'package:qcmapp/Welcomepage.dart';
import 'package:qcmapp/addeditemployee.dart';
import 'package:qcmapp/components/app_loader.dart';
import 'package:qcmapp/components/appbar.dart';
import 'package:qcmapp/constant/app_assets.dart';
import 'package:qcmapp/constant/app_color.dart';
import 'package:qcmapp/constant/app_fonts.dart';
import 'package:qcmapp/constant/app_styles.dart';
import 'package:qcmapp/directory.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;

import 'quality_list_model.dart';

class QualityList extends StatefulWidget {
  QualityList();

  @override
  _DirectoryState createState() => _DirectoryState();
}

class _DirectoryState extends State<QualityList> {
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
  List locationList = [];
  String? personid,
      token,
      vCard,
      firstname,
      lastname,
      WorkLocation,
      pic,
      locationController,
      workLocations,
      logo,
      site,
      designation,
      department,
      ImagePath,
      WorkLocationName,
      detail,
      businessname,
      organizationName,
      otherChapterName = '',
      _hasBeenPressedorganization = '',
      organizationtype,
      _hasBeenPressed = '',
      _hasBeenPressed1 = 'Completed',
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
      workLocations = prefs.getString('workLocation');
      print("rrreeeee");
      print(prefs.getString('workLocation'));
      WorkLocation = prefs.getString("workLocation");
      WorkLocationName = prefs.getString('WorkLocationName');
      // locationController = "fc9c8db9-e817-11ee-b439-0ac93defbbf1";
    });

    userdata = getData(WorkLocation);
    getLocationData();
  }

  getLocationData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');
    print("site URL: $site");

    if (site == null) {
      print('Site URL is null or empty.');
      return;
    }

    final url = (site! + 'Employee/WorkLocationList');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var designationBody = jsonDecode(response.body);
        print("Location List: $designationBody");

        if (mounted) {
          setState(() {
            locationList = designationBody['data'];
          });
          print("locationList: $locationList");
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print('Error fetching location data: $e');
    }
  }

  Future<List<UserData>?> getData(WorkLocation) async {
    print("WorkLocation.......?");
    print(WorkLocation);
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');
    setState(() {
      _isLoading = true;
    });
    final url = (site! + 'Quality/QualityList');
    http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{
        "Status": _hasBeenPressed1!,
        "token": token!,
        "WorkLocation": WorkLocation
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          decodedResult = jsonDecode(response.body);
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

      getData(WorkLocation);

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
                                      QualityList()),
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
                    _hasBeenPressed1 = 'Completed';
                    _hasBeenPressed2 = '';
                  });
                  userdata = getData(WorkLocation);
                },
                child: Text('Completed',
                    style: TextStyle(
                        fontFamily: appFontFamily,
                        color: _hasBeenPressed1 == 'Completed'
                            ? AppColors.blueColor
                            : AppColors.black,
                        fontWeight: _hasBeenPressed1 == 'Completed'
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
                  _hasBeenPressed1 = 'Inprogress';
                });
                userdata = getData(WorkLocation);
              },
              child: Text(
                'Inprogress',
                style: TextStyle(
                    fontFamily: appFontFamily,
                    color: _hasBeenPressed1 == 'Inprogress'
                        ? AppColors.blueColor
                        : AppColors.black,
                    fontWeight: _hasBeenPressed1 == 'Inprogress'
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
      const Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Quality List',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: AppColors.blueColor)),
            ],
          )),
      const Padding(padding: EdgeInsets.only(top: 15, left: 10, right: 10)),
      // Row(children: <Widget>[
      //   Container(
      //     child: Expanded(
      //         child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 10),
      //       child: TextField(
      //         controller: SearchController,
      //         textAlignVertical: TextAlignVertical.center,
      //         keyboardType: TextInputType.text,
      //         textInputAction: TextInputAction.next,
      //         decoration: AppStyles.textFieldInputDecoration.copyWith(
      //             hintText: "Search Quality",
      //             prefixIcon: const Icon(
      //               Icons.search,
      //               size: 25,
      //               color: AppColors.lightBlackColor,
      //             )),
      //         style: AppStyles.textInputTextStyle,
      //         onChanged: (value) {
      //           setState(() {});
      //         },
      //       ),
      //     )),
      //   ),
      // ]),
      Row(children: <Widget>[
        Expanded(
          flex: 3, // Larger flex value to increase size
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: TextField(
              controller: SearchController,
              textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                hintText: "Search IPQC List ",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 25,
                  color: AppColors.lightBlackColor,
                ),
              ),
              style: AppStyles.textInputTextStyle,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ),

        // Space between TextField and Dropdown
        // SizedBox(width: 10),

        // Unit DropdownButtonFormField inside Expanded with smaller flex
        if (designation == "Super Admin")
          Expanded(
            flex: 3, // Smaller flex value to decrease size
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButtonFormField<String>(
                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                    hintText: "ALL",
                    counterText: '',
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Rounded borders
                    ),
                  ),
                  // items: locationList
                  //     .map((label) => DropdownMenuItem(
                  //           child: Text(
                  //             label['workLocationName'],
                  //             style: AppStyles.textInputTextStyle,
                  //           ),
                  //           value: label['workLocationId'].toString(),
                  //         ))
                  //     .toList(),
                  items: [
                    // Static "Select All" Item
                    DropdownMenuItem<String>(
                      value: '', // Unique static value
                      child: Text(
                        'All',
                        style: AppStyles.textInputTextStyle,
                      ),
                    ),
                    // Dynamically populated items from locationList
                    ...locationList.map((label) => DropdownMenuItem<String>(
                          value: label['workLocationId'].toString(),
                          child: Text(
                            label['workLocationName'],
                            style: AppStyles.textInputTextStyle,
                          ),
                        )),
                  ],
                  onChanged: designation != "Super Admin"
                      ? null
                      : (val) {
                          setState(() {
                            WorkLocation = val!;
                          });
                          getData(WorkLocation);
                          // getData(DesigantionId, locationController);
                        },
                  value: WorkLocation != '' ? WorkLocation : null,
                )),
          ),
      ]),

      Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  data.data!.length > 1
                      ? '${data.data!.length} Qualities'
                      : '${data.data!.length} Quality',
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
            itemCount: data.data?.length ?? 0, // Null safety check
            itemBuilder: (context, index) {
              final item = data.data?[index];

              if (item == null) return Container(); // Handle null item

              // Get the search text
              final searchText = SearchController.text.toLowerCase();

              // Safely extract values with null-aware operators
              final qualityId = item.qualityId ?? '';
              final shift = item.shift ?? '';
              final line = item.line ?? '';
              final modulePicture = item.modulePicture ?? '';
              final elModuleImage = item.ElModuleImage ?? '';
              final productBarCode = item.productBarCode ?? '';
              final modelName = item.modelName ?? '';
              final issue = item.issue ?? '';
              final stage = item.stage ?? '';
              final responsiblePerson = item.resposiblePerson ?? '';
              final reasonOfIssue = item.reasonOfIssue ?? '';
              final createdOn = item.createdOn ?? '';
              final createdBy = item.createdBy ?? '';

              // Filtering logic
              final bool matchesSearch = searchText.isEmpty ||
                  modelName.toLowerCase().contains(searchText) ||
                  productBarCode.toLowerCase().contains(searchText) ||
                  createdBy.toLowerCase().contains(searchText) ||
                  issue.toLowerCase().contains(searchText);

              if (matchesSearch) {
                return Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: _tile(
                    qualityId,
                    shift,
                    modulePicture,
                    elModuleImage,
                    productBarCode,
                    modelName,
                    issue,
                    stage,
                    responsiblePerson,
                    reasonOfIssue,
                    createdOn,
                    createdBy,
                    line,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),

      const SizedBox(
        height: 20,
      )
    ]);
  }

  Widget _tile(
      String id,
      String shift,
      String modulePicture,
      String elModuleImage,
      String productBarCode,
      String modelNumber,
      String issueType,
      String stage,
      String resposiblePerson,
      String reasonOfIssue,
      String createdOn,
      String createdBy,
      String line) {
    return InkWell(
      // onTap: () {
      //   // Navigator.of(context).pushAndRemoveUntil(
      //   //     MaterialPageRoute(
      //   //         builder: (BuildContext context) => DirectoryDetails(
      //   //               personId: id,
      //   //             )),
      //   //     (Route<dynamic> route) => false);
      // },
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
                                        height: 450,
                                        imageUrl: (modulePicture),
                                        errorWidget: (context, url, error) {
                                          return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                AppAssets.imgModule,
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
                            imageUrl: modulePicture,
                            height: 60,
                            width: 60,
                            placeholder: (context, url) {
                              return ClipOval(
                                child: Image.asset(
                                  AppAssets.imgModule,
                                  height: 60,
                                  width: 60,
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return ClipOval(
                                child: Image.asset(
                                  AppAssets.imgModule,
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
                            child: Text(productBarCode,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: appFontFamily,
                                    fontSize: 16,
                                    color: AppColors.lightBlackColor)),
                          ),
                        ]),
                        SizedBox(
                          height: 5,
                        ),
                        Row(children: <Widget>[
                          Flexible(
                            child: Text(modelNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: appFontFamily,
                                    fontSize: 14,
                                    color: AppColors.lightBlackColor)),
                          ),
                        ]),

                        //Occupication
                        Text(issueType,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: appFontFamily)),
                        const SizedBox(
                          height: 2,
                        ),
                        if (WorkLocation ==
                            "hc9c9178-e816-11ee-g439-0ac93defbbf1")
                          Row(children: <Widget>[
                            Flexible(
                              child: Text("Line: $line",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: appFontFamily,
                                    fontSize: 12,
                                  )),
                            ),
                          ]),

                        Row(children: <Widget>[
                          Flexible(
                            child: Text("Found By: $createdBy",
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
                                  255, 3, 96, 150), // Background color
                              borderRadius: BorderRadius.circular(
                                  10), // Optional: Add border radius for rounded corners
                            ),
                            child: Text(
                              createdOn,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.white, // Optional: Set text color
                              ),
                            ),
                          ),
                        ]),

                        const SizedBox(
                          height: 2,
                        ),
                        if (elModuleImage != '' && elModuleImage != null)
                          Row(children: <Widget>[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (elModuleImage != '' && elModuleImage != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                      255, 192, 148, 4), // Background color
                                  borderRadius: BorderRadius.circular(
                                      10), // Optional: Add border radius for rounded corners
                                ),
                                child: const Text(
                                  "El Picture :",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Color.fromARGB(255, 0, 0,
                                        0), // Optional: Set text color
                                  ),
                                ),
                              ),
                            const SizedBox(
                              width: 5,
                            ),
                            if (elModuleImage != '' && elModuleImage != null)
                              GestureDetector(
                                onTap: () {
                                  UrlLauncher.launch(elModuleImage);
                                },
                                child: ClipRRect(
                                  child: Image.asset(
                                    AppAssets.icPdf,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ),
                            SizedBox(
                              width: 10,
                            ),
                          ]),
                      ],
                    )),
                  ),
                  if (_hasBeenPressed1 == "Inprogress" &&
                      designation != "Super Admin")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        AddQuality(id: id)),
                                (Route<dynamic> route) => false);
                          },
                          child: Image.asset(
                            AppAssets.icMemberEdit,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ],
                    ),
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
