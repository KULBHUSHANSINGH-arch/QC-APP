import 'dart:convert';
import 'dart:io';
// import 'package:QCM/CommonDrawer.dart';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/Welcomepage.dart';
// import 'package:QCM/capaList.dart';
// import 'package:QCM/components/app_button_widget.dart';
// import 'package:QCM/components/app_loader.dart';
// import 'package:QCM/ipqcTestList.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:qcmapp/Welcomepage.dart';
import 'package:qcmapp/capaList.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:qcmapp/components/app_loader.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:dio/src/response.dart' as Response;
import '../components/appbar.dart';
import '../constant/app_assets.dart';
import '../constant/app_color.dart';
import '../constant/app_fonts.dart';
import '../constant/app_helper.dart';

import '../constant/app_styles.dart';

class CapaReport extends StatefulWidget {
  final String? id;
  CapaReport({this.id});

  @override
  _CapaReportState createState() => _CapaReportState();
}

class _CapaReportState extends State<CapaReport> {
  final _capareportFormKey = GlobalKey<FormState>();
  final TextEditingController teamMembersController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<TextEditingController> nameControllers = [];
  List<TextEditingController> departmentControllers = [];
  List<TextEditingController> emailControllers = [];
  List<TextEditingController> contactControllers = [];

  // TextEditingController shiftController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController dProblemController = TextEditingController();

  TextEditingController problemDController = TextEditingController();
  TextEditingController whenProblemController = TextEditingController();
  TextEditingController wProblemController = TextEditingController();
  TextEditingController hProblemController = TextEditingController();
  TextEditingController partAffectedController = TextEditingController();

  TextEditingController investigationController = TextEditingController();
  TextEditingController cActionConformanceController = TextEditingController();
  TextEditingController cActionImproveController = TextEditingController();
  TextEditingController cActionAvoidController = TextEditingController();

  TextEditingController cActionResolveController = TextEditingController();
  TextEditingController pActionAController = TextEditingController();
  TextEditingController pActionBController = TextEditingController();
  TextEditingController pActionCController = TextEditingController();

  TextEditingController pActionDController = TextEditingController();
  TextEditingController iPlanAController = TextEditingController();
  TextEditingController iPlanBController = TextEditingController();
  TextEditingController iPlanCController = TextEditingController();

  TextEditingController verificationAController = TextEditingController();
  TextEditingController verificationBController = TextEditingController();
  TextEditingController documentationAController = TextEditingController();
  TextEditingController documentationBController = TextEditingController();

  TextEditingController documentationCController = TextEditingController();

  bool menu = false, user = false, face = false, home = false;
  bool _isLoading = false;
  String selectedShift = "Day Shift";
  String setPage = '',
      pic = '',
      site = '',
      designation = '',
      status = '',
      BomId = '',
      token = '',
      personid = '',
      bomCardDate = '',
      whereDate = '',
      approvalStatus = "Approved",
      department = '';
  String invoiceDate = '';
  late String dateOfQualityCheck;

  List<int>? referencePdfFileBytes;
  late String sendStatus;
  bool? isCycleTimeTrue;
  bool? isBacksheetCuttingTrue;
  Response.Response? _response;
  final _dio = dio.Dio();
  List shiftList = [
    {"key": 'Day Shift', "value": 'Day Shift'},
    {"key": 'Night Shift', "value": 'Night Shift'},
  ];
  List teamMembers = [];

  @override
  void initState() {
    super.initState();
    store();
  }

  @override
  void dispose() {
    teamMembersController.dispose();
    for (var controller in nameControllers) {
      controller.dispose();
    }
    for (var controller in departmentControllers) {
      controller.dispose();
    }
    for (var controller in emailControllers) {
      controller.dispose();
    }
    for (var controller in contactControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // void _updateTeamMemberFields(int count) {
  //   setState(() {
  //     teamMemberCount = count;
  //     nameControllers =
  //         List.generate(count, (index) => TextEditingController());
  //     departmentControllers =
  //         List.generate(count, (index) => TextEditingController());
  //     emailControllers =
  //         List.generate(count, (index) => TextEditingController());
  //     contactControllers =
  //         List.generate(count, (index) => TextEditingController());
  //   });
  // }

  void store() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      pic = prefs.getString('pic')!;
      personid = prefs.getString('personid')!;
      site = prefs.getString('site')!;
      designation = prefs.getString('designation')!;
      department = prefs.getString('department')!;
      token = prefs.getString('token')!;
    });
    print("designation");
    print(designation);

    _get();
  }

  Future _get() async {
    print("idddd");
    print(widget.id);
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site')!;
    });

    final AllSolarData = ((site!) + 'Maintenance/getKapaReport');
    final allSolarData = await http.post(
      Uri.parse(AllSolarData),
      body: jsonEncode(
          <String, String>{"reportId": widget.id ?? '', "status": "Pending"}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _isLoading = false;
    });

    var resBody = json.decode(allSolarData.body);

    if (mounted) {
      setState(() {
        if (resBody != '') {
          var resData = resBody['data'][0];

// Handling `date`

          status = resData['status'] ?? '';
          bomCardDate = resData['problem_description']['date'] ?? '';
          dateController.text = bomCardDate != ''
              ? DateFormat("EEE MMM dd, yyyy")
                  .format(DateTime.parse(bomCardDate.toString()))
              : '';

// Binding problem-related fields
          problemController.text =
              resData['problem_description']['problem'] ?? '';
          problemDController.text = resData['detected_by'] ?? '';
          dProblemController.text = resData['detected_where'] ?? '';
          whereDate = resData['detected_when'] ?? '';
          whenProblemController.text = whereDate != ''
              ? DateFormat("EEE MMM dd, yyyy")
                  .format(DateTime.parse(whereDate.toString()))
              : '';

// Root cause analysis and corrective actions
          wProblemController.text =
              resData['problem_description']['whyProblem'] ?? '';
          hProblemController.text =
              resData['problem_description']['detectedHow'] ?? '';
          partAffectedController.text =
              resData['problem_description']['partsAffected'] ?? '';
          investigationController.text = resData['root_cause_analysis'] ?? '';
          cActionConformanceController.text =
              resData['corrective_actions']['nonConformance'] ?? '';
          cActionImproveController.text =
              resData['corrective_actions']['improveDetection'] ?? '';
          cActionAvoidController.text =
              resData['corrective_actions']['avoidProblem'] ?? '';
          cActionResolveController.text =
              resData['corrective_actions']['resolveProblem'] ?? '';

// Preventive actions
          pActionAController.text =
              resData['preventive_actions']['preventiveActionsA'] ?? '';
          pActionBController.text =
              resData['preventive_actions']['preventiveActionsB'] ?? '';
          pActionCController.text =
              resData['preventive_actions']['preventiveActionsC'] ?? '';
          pActionDController.text =
              resData['preventive_actions']['preventiveActionsD'] ?? '';

// Implementation plans
          iPlanAController.text = resData['implementation_evidence'] ?? '';
          iPlanBController.text = resData['implementation_timeline'] ?? '';
          iPlanCController.text = resData['implementation_resources'] ?? '';

// Verification plan
          verificationAController.text = resData['verification_plan'] ?? '';
          verificationBController.text = resData['verification_kpis'] ?? '';

// Documentation
          documentationAController.text = resData['incident_reports'] ?? '';
          documentationBController.text = resData['data_analysis'] ?? '';
          documentationCController.text = resData['testing_results'] ?? '';

// Bind team members
          print("team member");
          print(resData['team_members']);

          for (int i = 0; i < resData['team_members'].length; i++) {
            setState(() {
              nameControllers.add(TextEditingController());
              departmentControllers.add(TextEditingController());
              emailControllers.add(TextEditingController());
              contactControllers.add(TextEditingController());
            });
          }
          print(teamMembers.length);
// Bind team members to UI (nameControllers, departmentControllers, etc.)
          for (int i = 0; i < resData['team_members'].length; i++) {
            print(nameControllers.length);
            print(i);
            print(resData['team_members'][i]['name']);

            nameControllers[i].text = resData['team_members'][i]['name'] ?? '';
            departmentControllers[i].text =
                resData['team_members'][i]['department'] ?? '';
            emailControllers[i].text =
                resData['team_members'][i]['email'] ?? '';
            contactControllers[i].text =
                resData['team_members'][i]['contact'] ?? '';
          }
        }
      });
    }
  }

  Future setApprovalStatus() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    final url = (site! + "Maintenance/updatekapaStatus");

    var params = {
      "approvedBy": personid,
      "status": approvalStatus,
      "reportId": widget.id ?? ""
    };

    var response = await http.post(
      Uri.parse(url),
      body: json.encode(params),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
      });
      var objData = json.decode(response.body);
      if (objData['message'] != "success") {
        Toast.show("Please Try Again.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        Toast.show("Capa Report Test $approvalStatus .",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => capaList()));
      }
    } else {
      Toast.show("Error In Server",
          duration: Toast.lengthLong, gravity: Toast.center);
    }
  }

  Future<void> _pickReferencePDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File pdffile = File(result.files.single.path!);
      setState(() {
        referencePdfFileBytes = pdffile.readAsBytesSync();
        // referencePdfController.text = result.files.single.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  Future findData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    List<Map<String, String>> teamMembers = [];
    for (int i = 0; i < nameControllers.length; i++) {
      teamMembers.add({
        "name": nameControllers[i].text,
        "department": departmentControllers[i].text,
        "email": emailControllers[i].text,
        "contact": contactControllers[i].text,
      });
    }
    var Bom = [
      {
        "reportId": BomId != '' && BomId != null
            ? BomId
            : widget.id != '' && widget.id != null
                ? widget.id
                : '',
        "createdBy": personid,
        "email": "johndoe@example.com",
        "status": sendStatus,
        "updatedBy": "",
        "approvedBy": "",
        // "createdOn": "2024-09-13",
        // "updatedOn": "2024-09-13",
        "type": "IQPC"
      },
      {
        "teamFormation": {"teamMembers": teamMembers},
        "problemDescription": {
          "problem": problemController.text,
          "detectedBy": problemDController.text,
          "detectedWhere": dProblemController.text,
          "detectedWhen": whereDate,
          "whyProblem": wProblemController.text,
          "detectedHow": hProblemController.text,
          "partsAffected": partAffectedController.text,
          "documentNo": "GSPL/CAPA/RE-01",
          "revDate": "2024-09-13",
          "shift": selectedShift,
          "date": bomCardDate,
        },
        "rootCauseAnalysis": investigationController.text,
        "correctiveActions": {
          "nonConformance": cActionConformanceController.text,
          "improveDetection": cActionImproveController.text,
          "avoidProblem": cActionAvoidController.text,
          "resolveProblem": cActionResolveController.text
        },
        "preventiveActions": {
          "preventiveActionsA": pActionAController.text,
          "preventiveActionsB": pActionBController.text,
          "preventiveActionsC": pActionCController.text,
          "preventiveActionsD": pActionDController.text,
        },
        "implementationPlan": {
          "evidence": iPlanAController.text,
          "timeline": iPlanBController.text,
          "resources": iPlanCController.text
        },
        "verificationEffectiveness": {
          "plan": verificationAController.text,
          "kpis": verificationBController.text,
        },
        "documentation": {
          "incidentReports": documentationAController.text,
          "dataAnalysis": documentationBController.text,
          "testingResults": documentationCController.text
        },
        "reviewAndApproval": {
          "qualityHead": "Alice Johnson",
          "departmentHead": "Bob Brown",
          "regulatoryBodies": "N/A"
        }
      }
    ];
    print('Sending data to backend: $Bom');
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();

    final url = (site! + "Maintenance/uploadKapa");
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(Bom),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("response");
    print(response.body);

    if (response.statusCode == 200) {
      var objData = json.decode(response.body);
      setState(() {
        BomId = objData['reportId'];
        _isLoading = false;
      });
      print(objData);
      print(BomId);
      if (objData['message'] != "success") {
        Toast.show(objData['message'],
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        if (sendStatus == '') {
          // uploadPDF((referencePdfFileBytes ?? []));
        } else {
          Toast.show("Data has been saved.",
              duration: Toast.lengthLong,
              gravity: Toast.center,
              backgroundColor: AppColors.blueColor);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => capaList()));
        }
      }
    } else {
      Toast.show("Error In Server",
          duration: Toast.lengthLong, gravity: Toast.center);
    }
  }

  Widget _getFAB() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: FloatingActionButton(
        onPressed: () {
          setState(() {
            sendStatus = 'Pending';
          });
          findData();
        },
        child: ClipOval(
          child: Image.asset(
            AppAssets.save,
            height: 70,
            width: 60,
          ),
        ),
      ),
    );
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
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.white,
          appBar: GautamAppBar(
            organization: "organizationtype",
            isBackRequired: true,
            memberId: personid,
            imgPath: "ImagePath",
            memberPic: pic,
            logo: "logo",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return widget.id != "" && widget.id != null
                    ? capaList()
                    : WelcomePage();
              }));
            },
          ),
          body: _isLoading
              ? AppLoader()
              : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: _capareportFormKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AppAssets.imgLogo,
                                            height: 100,
                                            width: 230,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text("CAPA Report ",
                                          style: TextStyle(
                                              fontSize: 27,
                                              color: AppColors.black,
                                              fontFamily: appFontFamily,
                                              fontWeight: FontWeight.w700)))),
                              const Center(
                                  child: Text("(CAPA Report )",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.black,
                                          fontFamily: appFontFamily,
                                          fontWeight: FontWeight.w700))),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Document No : ',
                                    style: AppStyles.textfieldCaptionTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'GSPL/CAPA/RE-01',
                                    style: AppStyles.textfieldCaptionTextStyle,
                                  ),
                                ],
                              ),

                              // *************************** Revisional Number ********************
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rev.No./Dated : ',
                                    style: AppStyles.textfieldCaptionTextStyle,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    'Ver.2.0 & 13-03-2024',
                                    style: AppStyles.textfieldCaptionTextStyle,
                                  ),
                                ],
                              ),

                              // ************ Date *********
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Date",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                  controller: dateController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: AppStyles.textFieldInputDecoration
                                      .copyWith(
                                          hintText: "Please Enter Date",
                                          counterText: '',
                                          suffixIcon: Image.asset(
                                            AppAssets.icCalenderBlue,
                                            color: AppColors.primaryColor,
                                          )),
                                  style: AppStyles.textInputTextStyle,
                                  // readOnly:
                                  //     status == 'Pending' && designation != "QC"
                                  //         ? true
                                  //         : false,
                                  onTap: () async {
                                    DateTime date = DateTime(2021);
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    date = (await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2024),
                                        lastDate: DateTime.now()))!;
                                    dateController.text =
                                        DateFormat("EEE MMM dd, yyyy").format(
                                            DateTime.parse(date.toString()));
                                    setState(() {
                                      bomCardDate = DateFormat("yyyy-MM-dd")
                                          .format(
                                              DateTime.parse(date.toString()));
                                    });
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please Enter Date")
                                  ])),
                              const SizedBox(
                                height: 15,
                              ),
                              // ******************** Shift *********************
                              Text(
                                "Shift",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              DropdownButtonFormField<String>(
                                decoration: AppStyles.textFieldInputDecoration
                                    .copyWith(
                                        hintText: "Please Select Shift",
                                        counterText: '',
                                        contentPadding: EdgeInsets.all(10)),
                                borderRadius: BorderRadius.circular(20),
                                items: shiftList
                                    .map((label) => DropdownMenuItem(
                                          child: Text(label['key'],
                                              style:
                                                  AppStyles.textInputTextStyle),
                                          value: label['value'].toString(),
                                        ))
                                    .toList(),
                                onChanged:
                                    designation != "QC" && status == "Pending"
                                        ? null
                                        : (val) {
                                            setState(() {
                                              selectedShift = val!;
                                            });
                                          },
                                value:
                                    selectedShift != '' ? selectedShift : null,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a Shift';
                                  }
                                  return null; // Return null if the validation is successful
                                },
                              ),
                              // *********** Line ********

                              const SizedBox(
                                height: 15,
                              ),

                              Text(
                                "Team Members",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),

                              const SizedBox(height: 15),

// List of Team Member Fields
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: nameControllers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Member ${index + 1}"),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          controller: nameControllers[index],
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Enter Team Member Name",
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the name';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        DropdownButtonFormField<String>(
                                          value: departmentControllers[index]
                                                  .text
                                                  .isNotEmpty
                                              ? departmentControllers[index]
                                                  .text
                                              : null,
                                          onChanged: (String? newValue) {
                                            departmentControllers[index].text =
                                                newValue!;
                                          },
                                          items: [
                                            DropdownMenuItem(
                                                value: "QC", child: Text("QC")),
                                            DropdownMenuItem(
                                                value: "IPQC",
                                                child: Text("IPQC")),
                                            DropdownMenuItem(
                                                value: "FQC",
                                                child: Text("FQC")),
                                          ],
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Select Department",
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select a department';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          controller: emailControllers[index],
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Enter Email ID",
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the email';
                                            } else if (!RegExp(
                                                    r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                                                .hasMatch(value)) {
                                              return 'Enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(height: 5),
                                        TextFormField(
                                          controller: contactControllers[index],
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Enter Contact Number",
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter the contact number';
                                            } else if (!RegExp(r'^[0-9]{10}$')
                                                .hasMatch(value)) {
                                              return 'Enter a valid contact number';
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Floating action button to add more team members
                                  FloatingActionButton(
                                    onPressed: () {
                                      setState(() {
                                        nameControllers
                                            .add(TextEditingController());
                                        departmentControllers
                                            .add(TextEditingController());
                                        emailControllers
                                            .add(TextEditingController());
                                        contactControllers
                                            .add(TextEditingController());
                                      });
                                    },
                                    child: Icon(Icons.add),
                                  ),

                                  const SizedBox(
                                      width:
                                          10), // Add some spacing between buttons

                                  // Floating action button to remove the last team member
                                  if (nameControllers.length >
                                      1) // Allow removal only if more than 1 member exists
                                    FloatingActionButton(
                                      onPressed: () {
                                        setState(() {
                                          if (nameControllers.length > 1) {
                                            nameControllers.removeLast();
                                            departmentControllers.removeLast();
                                            emailControllers.removeLast();
                                            contactControllers.removeLast();
                                          }
                                        });
                                      },
                                      child: Icon(Icons.remove),
                                    ),
                                ],
                              ),
                              //  ********   BOM Verification Check sheet ********************

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "PROBLEM DESCRIPTION ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // *************  Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "What is the Problem",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: problemController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Problem",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText: "Please Enter Supplier",
                                    ),
                                  ],
                                ),
                              ),

                              // ********** Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Who detected the Problem.",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: dProblemController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter Who detected the Problem",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Please Enter Who detected the Problem",
                                    ),
                                  ],
                                ),
                              ),

                              // ************* Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Where is the Problem Detected",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: problemDController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Where is the Problem Detected",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Where is the Problem Detected",
                                    ),
                                  ],
                                ),
                              ),

                              // *************************** Remark *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "When is the Problem Detected",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextFormField(
                                  controller: whenProblemController,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  decoration: AppStyles.textFieldInputDecoration
                                      .copyWith(
                                          hintText: "Please Problem Date",
                                          counterText: '',
                                          suffixIcon: Image.asset(
                                            AppAssets.icCalenderBlue,
                                            color: AppColors.primaryColor,
                                          )),
                                  style: AppStyles.textInputTextStyle,
                                  // readOnly:
                                  //     status == 'Pending' && designation != "QC"
                                  //         ? true
                                  //         : false,
                                  onTap: () async {
                                    if (status != 'Pending') {
                                      DateTime date = DateTime(2021);
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      date = (await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2024),
                                          lastDate: DateTime.now()))!;
                                      whenProblemController.text =
                                          DateFormat("EEE MMM dd, yyyy").format(
                                              DateTime.parse(date.toString()));
                                      setState(() {
                                        whereDate = DateFormat("yyyy-MM-dd")
                                            .format(DateTime.parse(
                                                date.toString()));
                                      });
                                    }
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "Please Problem Date")
                                  ])),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Why is it Problem ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: wProblemController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Why is it Problem ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                maxLines: 3,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Please Enter Why is it Problem",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "How is Problem Detected",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: hProblemController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter How is Problem Detected ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                maxLines: 3,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Please Enter How is Problem Detected ",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "How Many Parts affected",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: partAffectedController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter How Many Parts affected",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                maxLines: 3,
                                validator: MultiValidator(
                                  [
                                    RequiredValidator(
                                      errorText:
                                          "Please Enter How Many Parts affected",
                                    ),
                                  ],
                                ),
                              ),

                              // *********** Flux *********************

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Investigation and Root Cause Analysis ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // *********************  Flux-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "investigative steps taken to identify the root cause of the problem? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: investigationController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter investigative steps taken to identify the root cause of the problem?",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter investigative steps taken to identify the root cause of the problem?",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // **************** Flux-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),

                              // ############   Ribbon ########################################

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Corrective Actions  ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // ****  ribbon-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "What are your Corrective Action to address Non-conformance ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: cActionConformanceController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter What are your Corrective Action to address Non-conformance ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter What are your Corrective Action to address Non-conformance ",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ********* ribbon-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "What are your Corrective Action to improve Detection",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: cActionImproveController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter .What are your Corrective Action to improve Detection",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter What are your Corrective Action to improve Detection.",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ********************* ribbon-Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                " What are the changes you will implement in your system to avoid this problem?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: cActionAvoidController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter  What are the changes you will implement in your system to avoid this problem?",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter  What are the changes you will implement in your system to avoid this problem?",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // *************************** ribbon-Remark *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "specific actions taken to address the immediate issue and resolve any immediate risks or problems? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: cActionResolveController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter specific actions taken to address the immediate issue and resolve any immediate risks or problems? ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // maxLines: 3,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enterspecific actions taken to address the immediate issue and resolve any immediate risks or problems? ",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ################   Interconnector-Bus-bar ######################

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Preventive Actions:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // *********************  Interconnector-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "  The report should outline the preventive measures put in place,such as process improvements, updated standard operating  procedures (SOPs), additional training, or quality control enhancements",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: pActionAController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter Preventive Action",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter Preventive Action",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // *********  Interconnector-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Identify and Implement Permanent Preventive Actions ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: pActionBController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter.Identify and Implement Permanent Preventive Actions ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter .Identify and Implement Permanent Preventive Actions ",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // *******  Interconnector-Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "How will you Prevent Occurrence of this Problem ? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: pActionCController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter How will you Prevent Occurrence of this Problem ? ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter How will you Prevent Occurrence of this Problem ? ",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ********** Interconnector-Remark *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Does this problem has a potential to happen in other product you supply to Customer?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: pActionDController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please EnterDoes this problem has a potential to happen in other product you supply to Customer?",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // maxLines: 3,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter Does this problem has a potential to happen in other product you supply to Customer?",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ########   Glass ########

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Implementation Plan ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // ***************  Glass-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Provide evidences of implementation of Corrective Actions above ? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: iPlanAController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter Provide evidences of implementation of Corrective Actions above ? ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter Provide evidences of implementation of Corrective Actions above ? ",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ************ Glass-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "timeline or schedule for implementing the corrective and preventive actions?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: iPlanBController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Entern timeline or schedule for implementing the corrective and preventive actions?",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter timeline or schedule for implementing the corrective and preventive actions?.",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // ******* Glass-Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "any necessary resources or support required for successful implementation?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: iPlanCController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter any necessary resources or support required for successful implementation?",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter any necessary resources or support required for successful implementation?",
                                //     ),
                                //   ],
                                // ),
                              ),

                              // *************** Glass-Remark *********************

                              // ########  Eva Glass side(FrontEVA)  ##########

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Verification and Effectiveness ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                              // *********************  Eva-Glass-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "should include a plan for verifying the effectiveness of the implemented actions.? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: verificationAController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter should include a plan for verifying the effectiveness of the implemented actions.? ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter should include a plan for verifying the effectiveness of the implemented actions.? ",
                                //     ),
                                //   ],
                                // ),
                              ),

// *************************** Eva-Glass-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "This can involve monitoring and measuring key performance indicators (KPIs),  conducting follow-up inspections, or peforming audits to ensure sustained improvement. ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: verificationBController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter This can involve monitoring and measuring key performance indicators (KPIs),  conducting follow-up inspections, or performing audits to ensure sustained improvement. ",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter This can involve monitoring and measuring key performance indicators (KPIs),  conducting follow-up inspections, or performing audits to ensure sustained improvement. ",
                                //     ),
                                //   ],
                                // ),
                              ),

// ####################################  Eva Glass side(rear EVA)  ########################################

                              const SizedBox(
                                height: 15,
                              ),
                              const Center(
                                child: Text(
                                  "Documentation and Records(The report should include references to supporting documents)",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.primaryColor,
                                    fontFamily: appFontFamily,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

// ********************* EvaGlassSide-Supplier ************************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "incident reports?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: documentationAController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter incident reports",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter incident reports",
                                //     ),
                                //   ],
                                // ),
                              ),

// *************************** EvaGlassSide-Specification / Model No. *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "data analysis? ",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: documentationBController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText: "Please Enter data analysis",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText: "Please Enter data analysis.",
                                //     ),
                                //   ],
                                // ),
                              ),

// *************************** EvaGlassSide-Lot/Batch Number *********************

                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "testing results, and any other relevant records?",
                                style: AppStyles.textfieldCaptionTextStyle,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: documentationCController,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                decoration:
                                    AppStyles.textFieldInputDecoration.copyWith(
                                  hintText:
                                      "Please Enter testing results, and any other relevant records",
                                  counterText: '',
                                ),
                                style: AppStyles.textInputTextStyle,
                                // readOnly:
                                //     status == 'Pending' && designation != "QC"
                                //         ? true
                                //         : false,
                                // validator: MultiValidator(
                                //   [
                                //     RequiredValidator(
                                //       errorText:
                                //           "Please Enter testing results, and any other relevant records?",
                                //     ),
                                //   ],
                                // ),
                              ),

// ****************** ****** *********

                              const SizedBox(
                                height: 15,
                              ),

                              const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              _isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : (widget.id == "" || widget.id == null) ||
                                          (designation == "Super Admin")
                                      ? AppButton(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                            fontSize: 16,
                                          ),
                                          onTap: () {
                                            _capareportFormKey
                                                .currentState!.save;
                                            if (_capareportFormKey.currentState!
                                                .validate()) {
                                              AppHelper.hideKeyboard(context);
                                              setState(() {
                                                sendStatus = "Pending";
                                              });
                                              findData();
                                            }
                                          },
                                          label: "Save",
                                          organization: '',
                                        )
                                      : Container(),
                              const SizedBox(
                                height: 10,
                              ),

                              if (widget.id != "" &&
                                  widget.id != null &&
                                  designation == "Super Admin")
                                Container(
                                  color: Color.fromARGB(255, 191, 226, 187),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Divider(),
                                      SizedBox(height: 15),
                                      AppButton(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.white,
                                            fontSize: 16),
                                        onTap: () {
                                          AppHelper.hideKeyboard(context);
                                          setApprovalStatus();
                                        },
                                        label: "Approve",
                                        organization: '',
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ),
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Powered By Gautam Solar Pvt. Ltd.",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: appFontFamily,
                                        color: AppColors.greyColor,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          floatingActionButton: (status == "Pending") ? null : _getFAB(),
        );
      }),
    );
  }
}
