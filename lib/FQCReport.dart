import 'dart:convert';
import 'dart:io';
// import 'package:QCM/CommonDrawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/response.dart' as Response;
// import 'package:QCM/components/app_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qcmapp/CommonDrawer.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'components/appbar.dart';
import 'constant/app_assets.dart';
import 'constant/app_color.dart';
import 'constant/app_fonts.dart';
import 'constant/app_styles.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class FQCReport extends StatefulWidget {
  final String? id;
  FQCReport({this.id});
  _FQCReportState createState() => _FQCReportState();
}

class _FQCReportState extends State<FQCReport> {
  File? _image, personPreview;
  List<int>? personlogoBytes, pdfFileBytes, _imageBytes;
  List data = [];
  List statedata1 = [];
  List citydata1 = [];
  bool sameAsPresentAddress = false;
  final picker = ImagePicker();

  final _dio = Dio();

  // Response? _response;
  Response.Response? _response;
  int? FromDateYear,
      ToDateYear,
      FromDateMonth,
      ToDateMonth,
      FromDateDay,
      ToDateDay;
  String? fromdate,
      todate,
      _errorMessage,
      bloodGroupController,
      issueStatusType,
      token,
      barcodeScanRes,
      issuetypeController,
      issueStatus,
      shiftController,
      locationController,
      reportingManagerController,
      modelNumberController,
      profilepicture,
      personLogoname,
      personid,
      designation,
      department,
      excelReport,
      firstname,
      workLocations,
      _selectedFileName,
      lastname,
      pic,
      ImagePath,
      logo,
      site,
      businessname,
      organizationtype,
      dobdate,
      dojdate,
      doidate,
      announcementId,
      endDate,
      announcementStatus;
  bool _isLoading = false;
  List locationList = [];

  List bloodGroupList = [
    {"label": 'A+', "value": 'A+'},
    {"label": 'A-', "value": 'A-'},
    {"label": 'AB+', "value": 'AB+'},
    {"label": 'AB-', "value": 'AB-'},
    {"label": 'B+', "value": 'B+'},
    {"label": 'B-', "value": 'B-'},
    {"label": 'O+', "value": 'O+'},
    {"label": 'O-', "value": 'O-'},
  ];

  // List departmentList = [
  //       {"key": "Wire Frame", "value": "Wire Frame"},
  //       {"key": "Breakdown", "value": "Breakdown"},
  //     ],
  List issueList = [],
      modelNumberList = [],
      reportingManagerList = [],
      shiftList = [
        {"key": "Completed", "value": "Completed"},
        {"key": "Inprogress", "value": "Inprogress"},
      ];

  SharedPreferences? prefs;
  TextEditingController fromdateController = new TextEditingController();
  TextEditingController todateController = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> qualityformKey = GlobalKey<FormState>();

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pdffile = File(result.files.single.path!);
      setState(() {
        pdfFileBytes = pdffile.readAsBytesSync();
        _selectedFileName = result.files.single.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  @override
  void initState() {
    store();

    super.initState();
  }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      designation = prefs.getString('designation');
      department = prefs.getString('department');
      pic = prefs.getString('pic');
      personid = prefs.getString('personid');
      site = prefs.getString('site');
      token = prefs.getString('token');
      workLocations = prefs.getString('workLocation');
      print("rrreeeee");
      print(prefs.getString('workLocation'));
      // locationController = prefs.getString("workLocation");
      locationController =
          (designation == "Super Admin") ? "" : workLocations ?? "";
    });
    getLocationData();
  }

  Future<bool> redirectto() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PublicDrawer();
    }));
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
            child: Scaffold(
              appBar: GautamAppBar(
                organization: "organizationtype",
                isBackRequired: true,
                memberId: personid,
                imgPath: "ImagePath",
                memberPic: pic,
                logo: "logo",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PublicDrawer();
                  }));
                },
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 15),
                child: _user(),
              ),
            )));
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

  Future createData() async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'TestEquipmet/GetProductTestReports'); // Prod

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, String>{
        "CurrentUser": personid ?? '',
        "FromDate": fromdate ?? '',
        "ToDate": todate ?? '',
        "Status": issueStatus ?? "",
        "WorkLocation": locationController ?? "",
        "issueStatusType": issueStatusType ?? ""
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(jsonEncode(<String, String>{
      "CurrentUser": personid ?? '',
      "FromDate": fromdate ?? '',
      "ToDate": todate ?? '',
      "Status": issueStatus ?? "",
      "WorkLocation": locationController ?? "",
      "issueStatusType": issueStatusType ?? ""
    }));
    print("Resssssssss.....???");
    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        excelReport = data['URL'];
        _isLoading = false;
      });
      print(data["msg"]);

      if (data["msg"] == "No reports found for the given criteria") {
        Toast.show("No reports found for the given criteria",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: const Color.fromARGB(255, 176, 55, 55));
      } else {
        Toast.show("FQC Report Generated Successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.primaryColor);
      }

      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (BuildContext context) => QualityList()),
      //     (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      Toast.show("Error on Server",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
    }
  }

  Widget _user() {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: qualityformKey,
        child: ListView(
          children: [
            // Padding(padding: EdgeInsets.only(top: 10)),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0),
              ),
            ),
            //  Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.imgLogo,
                    height: 100,
                    width: 230,
                  ),
                ],
              ),
            ),

            const Center(
                child: Text("Generate FQC Reports",
                    style: TextStyle(
                        fontSize: 25,
                        color: AppColors.black,
                        fontFamily: appFontFamily,
                        fontWeight: FontWeight.w700))),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(height: 10),
            Text(
              "Work Location*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            DropdownButtonFormField<String>(
              decoration: AppStyles.textFieldInputDecoration.copyWith(
                hintText: "Unit",
                counterText: '',
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              items: [
                DropdownMenuItem(
                  child: Text(
                    "All",
                    style: AppStyles.textInputTextStyle,
                  ),
                  value: "", // ID for "All"
                ),
                ...locationList.map((label) => DropdownMenuItem(
                      child: Text(
                        label['workLocationName'] ?? 'Unknown',
                        style: AppStyles.textInputTextStyle,
                      ),
                      value: label['workLocationId']?.toString() ?? "",
                    )),
              ],
              onChanged: designation != "Super Admin"
                  ? null
                  : (val) {
                      setState(() {
                        locationController = val!;
                      });
                    },
              value: (locationController!.isNotEmpty &&
                      locationList.any((loc) =>
                          loc['workLocationId'].toString() ==
                          locationController))
                  ? locationController
                  : "", // Prevents invalid value error
            ),
            const SizedBox(height: 10),

            Text(
              "Module Type*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text("OK", style: AppStyles.textInputTextStyle),
                        value: "OK",
                        groupValue: issueStatus,
                        onChanged: (val) {
                          setState(() {
                            issueStatus = val!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title:
                            Text("Not OK", style: AppStyles.textInputTextStyle),
                        value: "Not OK",
                        groupValue: issueStatus,
                        onChanged: (val) {
                          setState(() {
                            issueStatus = val!;
                          });
                          // fetchQcApiData(productBarcodeController.text);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text("All", style: AppStyles.textInputTextStyle),
                        value: "",
                        groupValue: issueStatus,
                        onChanged: (val) {
                          setState(() {
                            issueStatus = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (issueStatus == null) // Show error if no option is selected
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Please select Ok/Not Ok.',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 15,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Issue Status*", // Label for the section
                  style: AppStyles.textfieldCaptionTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title:
                            Text("Pass", style: AppStyles.textInputTextStyle),
                        value: "Pass",
                        groupValue: issueStatusType,
                        onChanged: (val) {
                          setState(() {
                            issueStatusType = val!;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile<String>(
                        title:
                            Text("Reject", style: AppStyles.textInputTextStyle),
                        value: "Reject",
                        groupValue: issueStatusType,
                        onChanged: (val) {
                          setState(() {
                            issueStatusType = val!;
                          });
                          // fetchQcApiData(productBarcodeController.text);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RadioListTile<String>(
                        title: Text("All", style: AppStyles.textInputTextStyle),
                        value: "",
                        groupValue: issueStatusType,
                        onChanged: (val) {
                          setState(() {
                            issueStatusType = val!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // if (issueStatusType ==
                //     null) // Show error if no option is selected
                //   Padding(
                //     padding: const EdgeInsets.only(top: 8.0),
                //     child: Text(
                //       'Please select Issue Status.',
                //       style: TextStyle(color: Colors.red, fontSize: 12),
                //     ),
                //   ),
              ],
            ),

            Text(
              "From*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            TextFormField(
                controller: fromdateController,
                readOnly: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: AppStyles.textFieldInputDecoration.copyWith(
                    hintText: "Please Enter From Date",
                    counterText: '',
                    suffixIcon: Image.asset(
                      AppAssets.icCalenderBlue,
                      color: AppColors.primaryColor,
                    )),
                style: AppStyles.textInputTextStyle,
                onTap: () async {
                  DateTime date = DateTime(2021);
                  FocusScope.of(context).requestFocus(new FocusNode());
                  date = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime.now()))!;
                  FromDateYear = date.year;
                  FromDateMonth = date.month;
                  FromDateDay = date.day;
                  fromdateController.text = DateFormat("EEE MMM dd, yyyy")
                      .format(DateTime.parse(date.toString()));
                  setState(() {
                    fromdate = DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(date.toString()));
                  });
                },
                validator: MultiValidator(
                    [RequiredValidator(errorText: "Please Enter From Date")])),

            const SizedBox(
              height: 15,
            ),
            Text(
              "To*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
            const SizedBox(height: 5),
            TextFormField(
                controller: todateController,
                readOnly: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: AppStyles.textFieldInputDecoration.copyWith(
                    hintText: "Please Enter To Date",
                    counterText: '',
                    suffixIcon: Image.asset(
                      AppAssets.icCalenderBlue,
                      color: AppColors.primaryColor,
                    )),
                style: AppStyles.textInputTextStyle,
                onTap: () async {
                  DateTime date = DateTime(2021);
                  FocusScope.of(context).requestFocus(new FocusNode());
                  date = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime.now()))!;
                  ToDateYear = date.year;
                  ToDateMonth = date.month;
                  ToDateDay = date.day;
                  todateController.text = DateFormat("EEE MMM dd, yyyy")
                      .format(DateTime.parse(date.toString()));
                  setState(() {
                    todate = DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(date.toString()));
                  });
                },
                validator: MultiValidator(
                    [RequiredValidator(errorText: "Please Enter To Date")])),
            const SizedBox(height: 15),

            const SizedBox(height: 30),

            AppButton(
              organization: (organizationtype ?? ''),
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                  fontSize: 16),
              onTap: () async {
                if (qualityformKey.currentState!.validate()) {
                  qualityformKey.currentState!.save();

                  var now = DateTime.now();
                  var formatter = new DateFormat('yyyy-MM-dd');
                  var Today = formatter.format(now);

                  if (FromDateYear! > ToDateYear!) {
                    Toast.show("Invalid Date Range.",
                        duration: Toast.lengthLong,
                        gravity: Toast.center,
                        backgroundColor: Colors.red);
                  } else if (FromDateYear == ToDateYear &&
                      FromDateMonth! > ToDateMonth!) {
                    Toast.show("Invalid Date Range.",
                        duration: Toast.lengthLong,
                        gravity: Toast.center,
                        backgroundColor: Colors.red);
                  } else if (FromDateYear == ToDateYear &&
                      FromDateMonth == ToDateMonth &&
                      FromDateDay! > ToDateDay!) {
                    Toast.show("Invalid Date Range.",
                        duration: Toast.lengthLong,
                        gravity: Toast.center,
                        backgroundColor: Colors.red);
                  } else {
                    createData();
                  }
                }
              },
              label: "Generate",
            ),
            SizedBox(height: 15),
            _isLoading
                ? const Center(
                    child: Column(children: [
                    Padding(padding: EdgeInsets.only(top: 40.0)),
                    Text('Generating...',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo)),
                    CircularProgressIndicator(),
                  ]))
                : excelReport != '' && excelReport != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              UrlLauncher.launch(excelReport!);
                            },
                            child: Icon(
                              Icons.download,
                              color: AppColors.redColor,
                              size: 62,
                            ),
                          ),
                        ),
                      )
                    : Container(),
            const Divider(),
          ],
        ));
  }
}
