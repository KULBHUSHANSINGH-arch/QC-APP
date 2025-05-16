import 'dart:convert';
import 'dart:io';
import 'package:newqcm/Ipqc.dart';
import 'package:newqcm/components/app_button_widget.dart';
import 'package:newqcm/components/app_loader.dart';
import 'package:newqcm/ipqcTestList.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:form_field_validator/form_field_validator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:dio/src/response.dart' as Response;
import 'package:http/http.dart' as http;
import '../components/appbar.dart';
import '../constant/app_assets.dart';
import '../constant/app_color.dart';
import '../constant/app_fonts.dart';
import '../constant/app_helper.dart';
import '../constant/app_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class PreCard extends StatefulWidget {
  final String? id;
  const PreCard({super.key, this.id});
  @override
  test_PreCardState createState() => test_PreCardState();
}

class test_PreCardState extends State<PreCard> {
  final _preLamFormKey = GlobalKey<FormState>();
  TextEditingController DayController = TextEditingController();

  TextEditingController lineController = TextEditingController();
  TextEditingController PoController = TextEditingController();
  //1 & 2.

  TextEditingController shopFreController = TextEditingController();
  TextEditingController shopTempController = TextEditingController();
  TextEditingController shopAccepController = TextEditingController();
  TextEditingController shopCameraController = TextEditingController();

  TextEditingController shopFreq1Controller = TextEditingController();
  TextEditingController shopHumidityController = TextEditingController();
  TextEditingController shop1AccepController = TextEditingController();
  TextEditingController shopCamera1Controller = TextEditingController();

  TextEditingController shopRemarkController = TextEditingController();

  TextEditingController glassFrequController = TextEditingController();
  TextEditingController glassDimenController = TextEditingController();
  TextEditingController glassAccepController = TextEditingController();
  TextEditingController glassRemarkController = TextEditingController();

  //3.
  TextEditingController evaFreqController = TextEditingController();
  TextEditingController evaTypeController = TextEditingController();
  TextEditingController evaAccepController = TextEditingController();

  TextEditingController evaFreq1Controller = TextEditingController();
  TextEditingController evaDimenController = TextEditingController();
  TextEditingController evaAccep1Controller = TextEditingController();

  TextEditingController evaFreq2Controller = TextEditingController();
  TextEditingController evaStatusController = TextEditingController();
  TextEditingController evaAccep2Controller = TextEditingController();

  TextEditingController evaRemarkController = TextEditingController();

  //4

  TextEditingController cellCuttingFreqController = TextEditingController();
  TextEditingController cellCuttingMenuController = TextEditingController();
  TextEditingController cellCuttingAccepController = TextEditingController();

  TextEditingController cellCuttingFreq1Controller = TextEditingController();
  TextEditingController cellCuttingSizeController = TextEditingController();
  TextEditingController cellCuttingAccep1Controller = TextEditingController();

  TextEditingController cellCuttingFreq2Controller = TextEditingController();
  TextEditingController cellCuttingCondiController = TextEditingController();
  TextEditingController cellCuttingAccep2Controller = TextEditingController();

  TextEditingController cellCuttingFreq3Controller = TextEditingController();
  TextEditingController cellCuttingCleanController = TextEditingController();
  TextEditingController cellCuttingAccep3Controller = TextEditingController();

  TextEditingController cellCuttingFreq4Controller = TextEditingController();
  TextEditingController cellCuttingVerifiController = TextEditingController();
  TextEditingController cellCuttingAccep4Controller = TextEditingController();

  TextEditingController cellCuttingFreq5Controller = TextEditingController();

  TextEditingController cellCuttingString1Controller = TextEditingController();
  TextEditingController cellCuttingStrCam1Controller = TextEditingController();

  TextEditingController cellCuttingString2Controller = TextEditingController();
  TextEditingController cellCuttingStrCam2Controller = TextEditingController();

  TextEditingController cellCuttingString3Controller = TextEditingController();
  TextEditingController cellCuttingStrCam3Controller = TextEditingController();

  TextEditingController cellCuttingString4Controller = TextEditingController();
  TextEditingController cellCuttingStrCam4Controller = TextEditingController();

  TextEditingController cellCuttingFreq6Controller = TextEditingController();
  TextEditingController cellCuttingCell1Controller = TextEditingController();
  TextEditingController cellCuttingCellCam1Controller = TextEditingController();

  TextEditingController cellCuttingCell2Controller = TextEditingController();
  TextEditingController cellCuttingCellCam2Controller = TextEditingController();

  TextEditingController cellCuttingCell3Controller = TextEditingController();
  TextEditingController cellCuttingCellCam3Controller = TextEditingController();

  TextEditingController cellCuttingCell4Controller = TextEditingController();
  TextEditingController cellCuttingCellCam4Controller = TextEditingController();

  TextEditingController cellCuttingCellAccepController =
      TextEditingController();
  TextEditingController cellCuttingCellRemarkController =
      TextEditingController();

  //5. Tabber & Stringer
  TextEditingController tabberFreq1Controller = TextEditingController();
  TextEditingController tabberVerifController = TextEditingController();
  TextEditingController tabberAccep1Controller = TextEditingController();

  TextEditingController tabberFreq2Controller = TextEditingController();
  TextEditingController tabbervisual1Controller = TextEditingController();
  TextEditingController tabbervisualcam1Controller = TextEditingController();

  TextEditingController tabbervisual2Controller = TextEditingController();
  TextEditingController tabbervisualcam2Controller = TextEditingController();

  TextEditingController tabbervisual3Controller = TextEditingController();
  TextEditingController tabbervisualcam3Controller = TextEditingController();

  TextEditingController tabbervisual4Controller = TextEditingController();
  TextEditingController tabbervisualcam4Controller = TextEditingController();

  TextEditingController tabberAccep2Controller = TextEditingController();

  TextEditingController tabberFreq3Controller = TextEditingController();
  TextEditingController tabberEL1Controller = TextEditingController();
  TextEditingController tabberELImageCam1Controller = TextEditingController();

  TextEditingController tabberEL2Controller = TextEditingController();
  TextEditingController tabberELImageCam2Controller = TextEditingController();

  TextEditingController tabberEL3Controller = TextEditingController();
  TextEditingController tabberELImageCam3Controller = TextEditingController();

  TextEditingController tabberEL4Controller = TextEditingController();
  TextEditingController tabberELImageCam4Controller = TextEditingController();
  TextEditingController tabberAccep3Controller = TextEditingController();

  TextEditingController tabberFreq4Controller = TextEditingController();
  TextEditingController veri1Controller = TextEditingController();
  TextEditingController veriCam1Controller = TextEditingController();

  TextEditingController veri2Controller = TextEditingController();
  TextEditingController veriCam2Controller = TextEditingController();

  TextEditingController veri3Controller = TextEditingController();
  TextEditingController veriCam3Controller = TextEditingController();

  TextEditingController veri4Controller = TextEditingController();
  TextEditingController veriCam4Controller = TextEditingController();

  TextEditingController tabberAccep4Controller = TextEditingController();
  TextEditingController tabberRemarkController = TextEditingController();

  //6. Auto String Layup

  TextEditingController autoStrFreq1Controller = TextEditingController();
  TextEditingController autoStrGapController = TextEditingController();
  TextEditingController autoStrAccepController = TextEditingController();

  TextEditingController autoStrFreq2Controller = TextEditingController();
  TextEditingController autoStrCellController = TextEditingController();
  TextEditingController autoStrAccep2Controller = TextEditingController();
  TextEditingController autoStrRemark2Controller = TextEditingController();

  //7. Auto Bussing & Tapping
  TextEditingController autobussFreq1Controller = TextEditingController();
  TextEditingController autobussSoldController = TextEditingController();
  TextEditingController autobussSoldCam1Controller = TextEditingController();
  TextEditingController autobussAccep1Controller = TextEditingController();

  TextEditingController autobussFreq2Controller = TextEditingController();
  TextEditingController autobussTermController = TextEditingController();
  TextEditingController autobussAccep2Controller = TextEditingController();

  TextEditingController autobussFreq3Controller = TextEditingController();
  TextEditingController autobussSol1Controller = TextEditingController();
  TextEditingController autobussSol2Controller = TextEditingController();
  TextEditingController autobussSol3Controller = TextEditingController();
  TextEditingController autobussSol4Controller = TextEditingController();
  TextEditingController autobussAccep3Controller = TextEditingController();

  TextEditingController autobussFreq4Controller = TextEditingController();
  TextEditingController autobusstop1Controller = TextEditingController();
  TextEditingController autobusstop2Controller = TextEditingController();
  TextEditingController autobusstop3Controller = TextEditingController();
  TextEditingController autobusstop4Controller = TextEditingController();
  TextEditingController autobussAccep4Controller = TextEditingController();

  TextEditingController autobussFreq5Controller = TextEditingController();
  TextEditingController autobussQul1Controller = TextEditingController();
  TextEditingController autobussQul2Controller = TextEditingController();
  TextEditingController autobussQul3Controller = TextEditingController();
  TextEditingController autobussQul4Controller = TextEditingController();
  TextEditingController autobussAccep5Controller = TextEditingController();

  TextEditingController autobussFreq6Controller = TextEditingController();
  TextEditingController autobussPos1Controller = TextEditingController();
  TextEditingController autobussPos2Controller = TextEditingController();
  TextEditingController autobussPos3Controller = TextEditingController();
  TextEditingController autobussPos4Controller = TextEditingController();
  TextEditingController autobussAccep6Controller = TextEditingController();

  TextEditingController autobussRemarkController = TextEditingController();
  // 8. EVA/Backsheet Cutting
  TextEditingController EvaFreq1Controller = TextEditingController();
  TextEditingController EvaRearController = TextEditingController();
  TextEditingController EvaAccep1Controller = TextEditingController();

  TextEditingController EvaFreq2Controller = TextEditingController();
  TextEditingController EvaBackController = TextEditingController();
  TextEditingController EvaAccep2Controller = TextEditingController();

  TextEditingController EvaFreq3Controller = TextEditingController();
  TextEditingController EvaPOEController = TextEditingController();
  TextEditingController EvaAccep3Controller = TextEditingController();

  TextEditingController EvaRemarkController = TextEditingController();

  // 9. Pre Lamination El & Visual inspection
  TextEditingController PreFreq1Controller = TextEditingController();
  TextEditingController PreEL1Controller = TextEditingController();
  TextEditingController PreELCam1Controller = TextEditingController();
  TextEditingController PreEL2Controller = TextEditingController();
  TextEditingController PreELCam2Controller = TextEditingController();
  TextEditingController PreEL3Controller = TextEditingController();
  TextEditingController PreELCam3Controller = TextEditingController();
  TextEditingController PreEL4Controller = TextEditingController();
  TextEditingController PreELCam4Controller = TextEditingController();
  TextEditingController PreEL5Controller = TextEditingController();
  TextEditingController PreELCam5Controller = TextEditingController();
  TextEditingController PreAccep1Controller = TextEditingController();

  TextEditingController PreFreq2Controller = TextEditingController();
  TextEditingController PreVisul1Controller = TextEditingController();
  TextEditingController PreVisulCam1Controller = TextEditingController();

  TextEditingController PreVisul2Controller = TextEditingController();
  TextEditingController PreVisulCam2Controller = TextEditingController();

  TextEditingController PreVisul3Controller = TextEditingController();
  TextEditingController PreVisulCam3Controller = TextEditingController();

  TextEditingController PreVisul4Controller = TextEditingController();
  TextEditingController PreVisulCam4Controller = TextEditingController();

  TextEditingController PreVisul5Controller = TextEditingController();
  TextEditingController PreVisulCam5Controller = TextEditingController();

  TextEditingController PreAccep2Controller = TextEditingController();
  TextEditingController PreRemarkController = TextEditingController();

  // 11. String Rework Station
  TextEditingController StringAvaibilityFrequencyController =
      TextEditingController();
  TextEditingController StringAvaibilityController = TextEditingController();
  TextEditingController StringAvaibilityCriteriaController =
      TextEditingController();

  TextEditingController StringCleaningFrequencyController =
      TextEditingController();
  TextEditingController StringCleaningController = TextEditingController();
  TextEditingController StringCleaningCriteriaController =
      TextEditingController();

  TextEditingController StringReworkRemarkController = TextEditingController();

  // 12. Module Rework Station
  TextEditingController ModuleAvaibilityFrequencyController =
      TextEditingController();
  TextEditingController ModuleAvaibilityController = TextEditingController();
  TextEditingController ModuleAvaibilityCriteriaController =
      TextEditingController();

  TextEditingController ModuleMethodCleaningFrequencyController =
      TextEditingController();
  TextEditingController ModuleMethodCleaningController =
      TextEditingController();
  TextEditingController ModuleMethodCleaningCriteriaController =
      TextEditingController();

  TextEditingController ModuleHandlingFrequencyController =
      TextEditingController();
  TextEditingController ModuleHandlingController = TextEditingController();
  TextEditingController ModuleHandlingCriteriaController =
      TextEditingController();

  TextEditingController ModuleCleaningofReworkFrequencyController =
      TextEditingController();
  TextEditingController ModuleCleaningofReworkController =
      TextEditingController();
  TextEditingController ModuleCleaningofReworkCriteriaController =
      TextEditingController();

  TextEditingController ModuleCleaningRemarkController =
      TextEditingController();

  // 13. Laminator
  TextEditingController LaminatorMonitoringFrequencyController =
      TextEditingController();
  TextEditingController LaminatorMonitoringController = TextEditingController();
  TextEditingController LaminatorMonitoringCriteriaController =
      TextEditingController();

  TextEditingController LaminatorAdhesiveFrequencyController =
      TextEditingController();
  TextEditingController LaminatorAdhesiveController = TextEditingController();
  TextEditingController LaminatorAdhesiveCriteriaController =
      TextEditingController();

  TextEditingController LaminatorPeelFrequencyController =
      TextEditingController();
  TextEditingController LaminatorPeelController = TextEditingController();
  TextEditingController LaminatorPeelCriteriaController =
      TextEditingController();

  TextEditingController LaminatorGelFrequencyController =
      TextEditingController();
  TextEditingController LaminatorGelController = TextEditingController();
  TextEditingController LaminatorGelCriteriaController =
      TextEditingController();

  TextEditingController LaminatorRemarkController = TextEditingController();
  TextEditingController referencePdfController = TextEditingController();
  // TextEditingController camera1Controller = TextEditingController();
  TextEditingController camera2Controller = TextEditingController();

  TextEditingController camera3Controller = TextEditingController();
  TextEditingController camera4Controller = TextEditingController();
  TextEditingController camera5Controller = TextEditingController();
  TextEditingController camera6Controller = TextEditingController();

  TextEditingController camera7Controller = TextEditingController();
  TextEditingController camera8Controller = TextEditingController();
  TextEditingController camera9Controller = TextEditingController();
  TextEditingController camera10Controller = TextEditingController();

  bool menu = false, user = false, face = false, home = false;
  int numberOfStringers = 0;
  int numberOfStringers1 = 0;
  int numberOfStringers2 = 0;
  int numberOfStringers4 = 0;
  int numberOfStringers5 = 0;
  int numberOfStringers6 = 0;
  bool _isLoading = false;
  String setPage = '', pic = '', site = '', personid = '';
  String invoiceDate = '';
  String dateOfQualityCheck = '';
  bool? isCycleTimeTrue;
  String sendStatus = '';
  String selectedShift = "Day Shift";
  String status = '',
      prelamId = '',
      approvalStatus = "Approved",
      designation = '',
      token = '',
      department = '';
  final _dio = Dio();
  Response.Response? _response;
  List data = [];
  List shiftList = [
    {"key": 'Day Shift', "value": 'Day Shift'},
    {"key": 'Night Shift', "value": 'Night Shift'},
  ];
  List<int>? referencePdfFileBytes;

  List sample1Controller = [];
  List sample2Controller = [];
  List sample3Controller = [];
  List sample4Controller = [];
  List sample5Controller = [];
  List sample6Controller = [];

  List cellLoadingInputtext = [];
  List tabberVisual = [];
  List tabberEI = [];
  List tabberVerification = [];
  List preLaminationEi = [];
  List preLaminationVisual = [];
  List Time = [
    "(Time: 10:00)",
    "(Time: 12:00)",
    "(Time: 02:00)",
    "(Time: 04:00)",
    "(Time: 06:00)"
  ];
  List Time1 = [
    "(Time: 10:00)",
    "(Time: 12:00)",
    "(Time: 02:00)",
    "(Time: 04:00)",
    "(Time: 06:00)"
  ];
  List Time2 = [
    "(Time: 10:00)",
    "(Time: 12:00)",
    "(Time: 02:00)",
    "(Time: 04:00)",
    "(Time: 06:00)"
  ];
  List Time3 = [
    "(Time: 10:00)",
    "(Time: 12:00)",
    "(Time: 02:00)",
    "(Time: 04:00)",
    "(Time: 06:00)"
  ];
  List Time4 = [
    "(Time: 10:00)",
    "(Time: 12:00)",
    "(Time: 02:00)",
    "(Time: 04:00)",
    "(Time: 06:00)"
  ];

  Future<void> _openCamera(TextEditingController controller) async {
    try {
      final ImagePicker _picker = ImagePicker();

      // Open the camera and capture an image
      XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        setState(() {
          controller.text =
              image.path; // Update the controller with the image path
        });
      } else {
        // Notify user of cancellation
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera operation canceled')),
        );
      }
    } catch (e) {
      // Handle errors gracefully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  // void addControllers(int count) {
  //   for (int i = 0; i < count; i++) {
  //     cellLoaderVerificationControllers.add(TextEditingController());
  //     cellLoaderTimeControllers.add(TextEditingController());
  //     // cellLoaderTimeControllers[i].text = Time[i];
  //     cellLoaderTimeControllers[i].text = Time[i % Time.length];
  //     if (widget.id != "" &&
  //         widget.id != null &&
  //         cellLoadingInputtext.isNotEmpty) {
  //       cellLoaderVerificationControllers[i].text = cellLoadingInputtext[i]
  //           ['cellLoaderVerificationControllers${i + 1}'];
  //     }
  //   }
  // }

  // void addTabberVisualControllers(int count) {
  //   for (int i = 0; i < count; i++) {
  //     TabberVisualStringerControllers.add(TextEditingController());
  //     TabberVisualTimeControllers1.add(TextEditingController());
  //     TabberVisualTimeControllers1[i].text = Time1[i % Time.length];
  //     if (widget.id != "" && widget.id != null && tabberVisual.isNotEmpty) {
  //       TabberVisualStringerControllers[i].text =
  //           tabberVisual[i]['TabberVisualStringerControllers${i + 1}'];
  //     }
  //   }
  // }

  // void addTabberEImageControllers(int count) {
  //   for (int i = 0; i < count; i++) {
  //     TabberEIimageofStringerControllers.add(TextEditingController());
  //     TabberEIimageofStringerTimeControllers.add(TextEditingController());
  //     TabberEIimageofStringerTimeControllers[i].text = Time2[i % Time.length];
  //     if (widget.id != "" && widget.id != null && tabberEI.isNotEmpty) {
  //       TabberEIimageofStringerControllers[i].text =
  //           tabberEI[i]['TabberEIimageofStringerControllers${i + 1}'];
  //     }
  //   }
  // }

  // void addTabberVerificationControllers(int count) {
  //   for (int i = 0; i < count; i++) {
  //     TabberVerificationofsilderingControllers.add(TextEditingController());
  //     if (widget.id != "" &&
  //         widget.id != null &&
  //         tabberVerification.isNotEmpty) {
  //       TabberVerificationofsilderingControllers[i].text = tabberVerification[i]
  //           ['TabberVerificationofsilderingControllers${i + 1}'];
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    setState(() {
      // 8. Auto Bussing & Tapping

      // 9. EVA/Backsheet Cutting

      // 10. Pre Lamination El & Visual inspection

      // 11. String Rework Station
      StringAvaibilityFrequencyController.text = "Once per Shift";
      StringAvaibilityCriteriaController.text =
          "WI Should be available at station and operator should be aware of WI";

      StringCleaningFrequencyController.text = "Once per Shift";
      StringCleaningCriteriaController.text = "Rework Station should be Clean";

      // 12. Module Rework Station
      ModuleAvaibilityFrequencyController.text = "Once per Shift";
      ModuleAvaibilityCriteriaController.text =
          "WI Should be available at station and operator should be aware of WI";

      ModuleMethodCleaningFrequencyController.text = "Once per Shift";
      ModuleMethodCleaningCriteriaController.text = "As per WI";

      ModuleHandlingFrequencyController.text = "Once per Shift";
      ModuleHandlingCriteriaController.text =
          "Operator Should handle the rework module with both the Hands";

      ModuleCleaningofReworkFrequencyController.text = "Once per Shift";
      ModuleCleaningofReworkCriteriaController.text =
          "Rework station should be clean";
      // 13. Laminator
      LaminatorMonitoringFrequencyController.text = "Once per Shift";
      LaminatorMonitoringCriteriaController.text =
          "Laminator specification GSPL/IPQC/LM/008 |  GSPL/IPQC/LM/009 |  GSPL/IPQC/LM/010";

      LaminatorAdhesiveFrequencyController.text = "Once per Shift";
      LaminatorAdhesiveCriteriaController.text =
          "Teflon should be clean, No EVA residue is allowed ";

      LaminatorPeelFrequencyController.text =
          "All Position | All Laminator Once a Week";
      LaminatorPeelCriteriaController.text =
          "Eva to Glass = 70N/cm EVA to Backsheet >= 80N/cm";

      LaminatorGelFrequencyController.text =
          " All Position | All Laminator once a week ";
      LaminatorGelCriteriaController.text = "75 to 95% ";
    });
    store();
  }

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
    _get();
  }

  Future _get() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site')!;
    });
    final AllSolarData = ('${site!}IPQC/GetSpecificPreLam');
    final allSolarData = await http.post(
      Uri.parse(AllSolarData),
      body: jsonEncode(
          <String, String>{"JobCardDetailId": widget.id ?? '', "token": token}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _isLoading = false;
    });
    var resBody = json.decode(allSolarData.body);
    print("HiiiiiiiRes");
    print(resBody);

    if (mounted) {
      setState(() {
        if (resBody != '') {
          status = resBody['response']['Status'] ?? '';
          dateOfQualityCheck = resBody['response']['Date'] ?? '';
          DayController.text = resBody['response']['Date'] != ''
              ? DateFormat("EEE MMM dd, yyyy").format(
                  DateTime.parse(resBody['response']['Date'].toString()))
              : '';
          selectedShift = resBody['response']['Shift'] ?? '';
          lineController.text = resBody['response']['Line'] ?? '';
          PoController.text = resBody['response']['PONo'] ?? '';

          LaminatorRemarkController.text =
              resBody['response']['LaminatorRemark'] ?? '';
          referencePdfController.text = resBody['response']['PreLamPdf'] ?? '';
        }
      });
    }
  }

  Future setApprovalStatus() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    final url = ("${site!}IPQC/UpdatePreLamStatus");
    var params = {
      "Type": "Prelam",
      "token": token,
      "CurrentUser": personid,
      "ApprovalStatus": approvalStatus,
      "JobCardDetailId": widget.id ?? ""
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
      if (objData['success'] == false) {
        Toast.show("Please Try Again.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        Toast.show("Pre Lam Test $approvalStatus .",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IpqcTestList()));
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
        referencePdfController.text = result.files.single.name;
      });
    } else {
      // User canceled the file picker
    }
  }

  uploadPDF(List<int> referenceBytes) async {
    setState(() {
      _isLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;

    var currentdate = DateTime.now().microsecondsSinceEpoch;
    var formData = FormData.fromMap({
      "JobCardDetailId": prelamId,
      "PreLamPdf": MultipartFile.fromBytes(
        referenceBytes,
        filename: ('${referencePdfController.text}$currentdate.pdf'),
        contentType: MediaType("application", 'pdf'),
      ),
    });
    _response = await _dio.post(('${site!}IPQC/UploadPreLamPdf'), // Prod

        options: Options(
          contentType: 'multipart/form-data',
          followRedirects: false,
          validateStatus: (status) => true,
        ),
        data: formData);

    try {
      if (_response?.statusCode == 200) {
        setState(() {
          _isLoading = false;
        });

        Toast.show("PreLam Test Completed.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IpqcTestList()));
      } else {
        Toast.show("Error In Server",
            duration: Toast.lengthLong, gravity: Toast.center);
      }
    } catch (err) {
      print("Error");
    }
  }

  // **************  Send the Data where will be Used to Backend *****************

  Future sendDataToBackend() async {
    var data = [
      {
        "PreLamDetailId": prelamId != ''
            ? prelamId
            : widget.id != '' && widget.id != null
                ? widget.id
                : '',
        "Type": "PreLam",
        "CurrentUser": personid,
        "Status": sendStatus,
        "DocNo": "GSPL/IPQC/IPC/003",
        "RevNo": "1.0 dated 12.08.2023",
        "Date": dateOfQualityCheck,
        "Shift": selectedShift,
        "Line": lineController.text,
        "PONo": PoController.text
      },
      []
    ];
    setState(() {
      _isLoading = true;
    });
    print('teeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    print(data);
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;
    FocusScope.of(context).unfocus();

    final url = ("${site!}IPQC/AddPreLam");
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var objData = json.decode(response.body);
      setState(() {
        prelamId = objData['UUID'];

        _isLoading = false;
      });
      if (objData['success'] == false) {
        Toast.show(objData['message'],
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        if (sendStatus == 'Pending') {
          uploadPDF((referencePdfFileBytes ?? []));
        } else {
          Toast.show("Data has been saved.",
              duration: Toast.lengthLong,
              gravity: Toast.center,
              backgroundColor: AppColors.blueColor);
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
          sample1Controller = [];
          // for (int i = 0; i < numberOfStringers * 5; i++) {
          //   sample1Controller.add({
          //     "cellLoaderVerificationControllers${i + 1}":
          //         cellLoaderVerificationControllers[i].text,
          //   });
          // }

          // sample2Controller = [];
          // for (int i = 0; i < numberOfStringers1 * 5; i++) {
          //   sample2Controller.add({
          //     "TabberVisualStringerControllers${i + 1}":
          //         TabberVisualStringerControllers[i].text,
          //   });
          // }

          sample3Controller = [];
          // for (int i = 0; i < numberOfStringers2 * 5; i++) {
          //   sample3Controller.add({
          //     "TabberEIimageofStringerControllers${i + 1}":
          //         TabberEIimageofStringerControllers[i].text,
          //   });
          // }

          // sample4Controller = [];
          // for (int i = 0; i < numberOfStringers4 * 2; i++) {
          //   sample4Controller.add({
          //     "TabberVerificationofsilderingControllers${i + 1}":
          //         TabberVerificationofsilderingControllers[i].text,
          //   });
          // }

          // sample5Controller = [];
          // for (int i = 0; i < numberOfStringers5 * 5; i++) {
          //   sample5Controller.add({
          //     "PreLaminationEIinspectionrControllers${i + 1}":
          //         PreLaminationEIinspectionrControllers[i].text,
          //   });
          // }

          // sample6Controller = [];
          // for (int i = 0; i < numberOfStringers6 * 5; i++) {
          //   sample6Controller.add({
          //     "PreLaminationVisualinspectionrControllers${i + 1}":
          //         PreLaminationVisualinspectionrControllers[i].text,
          //   });
          // }

          if (status != 'Pending') {
            setState(() {
              sendStatus = 'Inprogress';
            });
            sendDataToBackend();
          }
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
                    ? IpqcTestList()
                    : IpqcPage();
              }));
            },
          ),
          body: _isLoading
              ? AppLoader()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: setPage == ''
                      ? Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            SingleChildScrollView(
                              child: Form(
                                key: _preLamFormKey,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
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
                                    const Center(
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                                "Incoming Production Quality Control",
                                                style: TextStyle(
                                                    fontSize: 27,
                                                    color: AppColors.black,
                                                    fontFamily: appFontFamily,
                                                    fontWeight:
                                                        FontWeight.w700)))),
                                    const Center(
                                        child: Text("(Pre Lam Checklist)",
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
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'GSPL/prelam/IPC/003',
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Rev.No. / Rev. Date : ',
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          'Ver.1.0 / 20-08-2023',
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Date",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: DayController,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Please Enter Date",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                        suffixIcon: Icon(Icons.calendar_month),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      onTap: () async {
                                        if (status != 'Pending') {
                                          DateTime date = DateTime(2021);
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          date = (await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2024),
                                            lastDate: DateTime.now(),
                                          ))!;
                                          DayController.text =
                                              DateFormat("EEE MMM dd, yyyy")
                                                  .format(
                                            DateTime.parse(date.toString()),
                                          );
                                          setState(() {
                                            dateOfQualityCheck =
                                                DateFormat("yyyy-MM-dd").format(
                                              DateTime.parse(date.toString()),
                                            );
                                          });
                                        }
                                      },
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText: "Please Enter Date",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    // ************************************* Shift *********************
                                    Text(
                                      "Shift",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    DropdownButtonFormField<String>(
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                              hintText: "Please Select Shift",
                                              counterText: '',
                                              contentPadding:
                                                  EdgeInsets.all(10)),
                                      borderRadius: BorderRadius.circular(20),
                                      items: shiftList
                                          .map((label) => DropdownMenuItem(
                                                value:
                                                    label['value'].toString(),
                                                child: Text(label['key'],
                                                    style: AppStyles
                                                        .textInputTextStyle),
                                              ))
                                          .toList(),
                                      onChanged: designation != "QC" &&
                                              status == "Pending"
                                          ? null
                                          : (val) {
                                              setState(() {
                                                selectedShift = val!;
                                              });
                                            },
                                      value: selectedShift != ''
                                          ? selectedShift
                                          : null,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select a Shift';
                                        }
                                        return null; // Return null if the validation is successful
                                      },
                                    ),

                                    // ********************************* Line *******************************

                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Line.",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: lineController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Please Enter Line.",
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText: "Please Enter Line.",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),

                                    // *  PO Number ***********************

                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Po Number",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),

                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: PoController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Please Po Number",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText: "Please Po Number",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),
                                    // ************** step process end *****************

                                    // **************  Shop Floor *****************
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Center(
                                        child: Text("Shop Floor",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 13, 160, 0),
                                                fontFamily: appFontFamily,
                                                fontWeight: FontWeight.w700))),

                                    // **********  step process ***********
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Frequency",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shopFreController,
                                      // GlassLoaderFreqquency1Controller,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Once a Shift",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Temperature",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shopTempController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Enter the Temperature",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText:
                                      //           "Please Enter Correct data",
                                      //     ),
                                      //   ],
                                      // )
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Acceptance Criteria",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shopAccepController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Temp. 25±2°C",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Picture",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      controller: shopCameraController,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Please Capture a Temperature Picture",
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            if (status != 'Pending') {
                                              await _openCamera(
                                                  shopCameraController);
                                            }
                                          },
                                          icon: const Icon(Icons.camera_alt),
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      readOnly: true,
                                    ),

                                    // *** second  221
                                    Divider(
                                      color: Colors.black,
                                      thickness: 2,
                                      height: 20,
                                    ),

                                    Text(
                                      "Frequency",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shopFreq1Controller,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Once a Shift",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Humidity",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shopHumidityController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Enter the Humidity",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText:
                                      //           "Please Enter Correct Avaibility of WI ",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Acceptance Criteria",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: shop1AccepController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "RH ≤ 60%",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Picture",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextFormField(
                                      controller: shopCamera1Controller,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Please Capture a Humidity Picture",
                                        counterText: '',
                                        contentPadding:
                                            const EdgeInsets.all(10),
                                        suffixIcon: IconButton(
                                          onPressed: () async {
                                            if (status != 'Pending') {
                                              await _openCamera(
                                                  shopCamera1Controller);
                                            }
                                          },
                                          icon: const Icon(Icons.camera_alt),
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      readOnly: true,
                                    ),

                                    // *** Remark
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Remark",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    TextFormField(
                                      controller: shopRemarkController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Remark ",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText:
                                      //           "Please Enter Correct data",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),

                                    // *** these data uesed to full code
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Center(
                                        child: Text("Glass Loader",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 13, 160, 0),
                                                fontFamily: appFontFamily,
                                                fontWeight: FontWeight.w700))),

                                    // **********  step process ***********
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Frequency",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: glassFrequController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Once a Shift",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),

                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "Glass Dimension {L*W*T}",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: glassDimenController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Enter the Glass Dimension ",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText:
                                      //           "Please Enter Correct data",
                                      //     ),
                                      //   ],
                                      // )
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Acceptance Criteria",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: glassAccepController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "As Per Production Order",
                                        counterText: '',
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: true,
                                    ),
                                    // *** Remark
                                    const SizedBox(
                                      height: 15,
                                    ),

                                    Text(
                                      "Remark",
                                      style:
                                          AppStyles.textfieldCaptionTextStyle,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),

                                    TextFormField(
                                      controller: glassRemarkController,
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.next,
                                      decoration: AppStyles
                                          .textFieldInputDecoration
                                          .copyWith(
                                        hintText: "Remark ",
                                        counterText: '',
                                        fillColor:
                                            Color.fromARGB(255, 215, 243, 207),
                                      ),
                                      style: AppStyles.textInputTextStyle,
                                      readOnly: status == 'Pending' &&
                                              designation != "QC"
                                          ? true
                                          : false,
                                      // validator: MultiValidator(
                                      //   [
                                      //     RequiredValidator(
                                      //       errorText:
                                      //           "Please Enter Correct data",
                                      //     ),
                                      //   ],
                                      // ),
                                    ),

                                    // *** these data uesed to full code
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                    _isLoading
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : AppButton(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.white,
                                              fontSize: 16,
                                            ),
                                            onTap: () {
                                              AppHelper.hideKeyboard(context);
                                              //500
                                              if (status != 'Pending') {
                                                setState(() {
                                                  sendStatus = 'Inprogress';
                                                });
                                                sendDataToBackend();
                                              }
                                              // _glassLoaderFormKey.currentState!.save;
                                              // if (_glassLoaderFormKey.currentState!
                                              //     .validate()) {}

                                              setState(() {
                                                setPage = "glassSide";
                                              });
                                            },
                                            label: "Next",
                                            organization: '',
                                          ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                        )
                      : setPage == "glassSide"
                          // GlassSide start
                          ? Stack(
                              alignment: Alignment.center,
                              fit: StackFit.expand,
                              children: [
                                SingleChildScrollView(
                                  child: Form(
                                    key: _preLamFormKey,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
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
                                        const Center(
                                            child: Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text(
                                                    "Incoming Production Quality Control",
                                                    style: TextStyle(
                                                        fontSize: 27,
                                                        color: AppColors.black,
                                                        fontFamily:
                                                            appFontFamily,
                                                        fontWeight:
                                                            FontWeight.w700)))),
                                        const Center(
                                            child: Text("(Pre Lam  Checklist)",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: AppColors.black,
                                                    fontFamily: appFontFamily,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Document No : ',
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'GSPL/prelam/IPC/003',
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Rev.No. / Rev. Date : ',
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Ver.1.0 / 20-08-2023',
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                          ],
                                        ),

                                        // **************  Glass1 Side EVA cutting machine *****************
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Center(
                                            child: Text(
                                                // "Glass Side EVA Cutting Machine",
                                                "EVA/POE Cutting",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color.fromARGB(
                                                        255, 13, 160, 0),
                                                    fontFamily: appFontFamily,
                                                    fontWeight:
                                                        FontWeight.w700))),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        Text(
                                          "Frequency",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaFreqController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Once a Shift",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Text(
                                          "EVA Type",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaTypeController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText:
                                                "Enter The Front EVA Type ",
                                            counterText: '',
                                            fillColor: Color.fromARGB(
                                                255, 215, 243, 207),
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: status == 'Pending' &&
                                                  designation != "QC"
                                              ? true
                                              : false,
                                          // validator: MultiValidator(
                                          //   [
                                          //     RequiredValidator(
                                          //       errorText:
                                          //           "Please Enter Correct Cutting  of Front EVA..",
                                          //     ),
                                          //   ],
                                          // ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "Acceptance Criteria ",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaAccepController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "As Per Production Order",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 2,
                                          height: 20,
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Text(
                                          "Frequency",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaFreq1Controller,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Once a Shift",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "EVA Dimension (L*W*T)",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaDimenController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText:
                                                "Enter The EVA Dimension ",
                                            counterText: '',
                                            fillColor: Color.fromARGB(
                                                255, 215, 243, 207),
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: status == 'Pending' &&
                                                  designation != "QC"
                                              ? true
                                              : false,
                                          // validator: MultiValidator(
                                          //   [
                                          //     RequiredValidator(
                                          //       errorText:
                                          //           "Please Enter Correct EVA Dimension",
                                          //     ),
                                          //   ],
                                          // ),
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Text(
                                          "Acceptance Criteria",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaAccep1Controller,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "As Per Production Order",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Divider(
                                          color: Colors.black,
                                          thickness: 2,
                                          height: 20,
                                        ),

                                        Text(
                                          "Frequency",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaFreq2Controller,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Once a Shift",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "EVA/POE Status",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaStatusController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText:
                                                "Enter The EVA/POE Status",
                                            counterText: '',
                                            fillColor: Color.fromARGB(
                                                255, 215, 243, 207),
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: status == 'Pending' &&
                                                  designation != "QC"
                                              ? true
                                              : false,
                                          // validator: MultiValidator(
                                          //   [
                                          //     RequiredValidator(
                                          //       errorText:
                                          //           "Please Enter Correct Position of front Eva...",
                                          //     ),
                                          //   ],
                                          // ),
                                        ),

                                        const SizedBox(
                                          height: 15,
                                        ),

                                        Text(
                                          "Acceptance Criteria",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextFormField(
                                          controller: evaAccep2Controller,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText:
                                                "Not allowed dust & foreign particle/Cut & non Uniform Embossing / Mfg Date",
                                            counterText: '',
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: true,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),

                                        // *** Remark

                                        Text(
                                          "Remark",
                                          style: AppStyles
                                              .textfieldCaptionTextStyle,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),

                                        TextFormField(
                                          controller: evaRemarkController,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.next,
                                          decoration: AppStyles
                                              .textFieldInputDecoration
                                              .copyWith(
                                            hintText: "Remark ",
                                            counterText: '',
                                            fillColor: Color.fromARGB(
                                                255, 215, 243, 207),
                                          ),
                                          style: AppStyles.textInputTextStyle,
                                          readOnly: status == 'Pending' &&
                                                  designation != "QC"
                                              ? true
                                              : false,
                                          // validator: MultiValidator(
                                          //   [
                                          //     RequiredValidator(
                                          //       errorText:
                                          //           "Please Enter Remark",
                                          //     ),
                                          //   ],
                                          // ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0)),
                                        _isLoading
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : AppButton(
                                                textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.white,
                                                  fontSize: 16,
                                                ),
                                                onTap: () {
                                                  AppHelper.hideKeyboard(
                                                      context);
                                                  if (status != 'Pending') {
                                                    setState(() {
                                                      sendStatus = 'Inprogress';
                                                    });
                                                    sendDataToBackend();
                                                  }

                                                  // _glassSideFormKey
                                                  //     .currentState!.save;
                                                  // if (_glassSideFormKey.currentState!
                                                  //     .validate()) {}
                                                  setState(() {
                                                    setPage =
                                                        "Cell Cutting Machine";
                                                  });
                                                  // createData();
                                                },
                                                label: "Next",
                                                organization: '',
                                              ),
                                        const SizedBox(
                                          height: 10,
                                        ),

                                        // Back button
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  setPage = '';
                                                });
                                                // Navigator.of(context).pushReplacement(
                                                //     MaterialPageRoute(
                                                //         builder: (BuildContext context) =>
                                                //             LoginPage(
                                                //                 appName: widget.appName)));
                                              },
                                              child: const Text(
                                                "BACK",
                                                style: TextStyle(
                                                    fontFamily: appFontFamily,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.redColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 25,
                                        ),

                                        Container(
                                          alignment: Alignment.center,
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                            )
                          // ***Third Next start

                          : setPage == "Cell Cutting Machine"
                              // Cell Cutting Machine start
                              ? Stack(
                                  alignment: Alignment.center,
                                  fit: StackFit.expand,
                                  children: [
                                    SingleChildScrollView(
                                      child: Form(
                                        key: _preLamFormKey,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
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
                                            const Center(
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                        "Incoming Production Quality Control",
                                                        style: TextStyle(
                                                            fontSize: 27,
                                                            color:
                                                                AppColors.black,
                                                            fontFamily:
                                                                appFontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)))),
                                            const Center(
                                                child: Text(
                                                    "(Pre Lam Checklist)",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: AppColors.black,
                                                        fontFamily:
                                                            appFontFamily,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Document No : ',
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'GSPL/prelam/IPC/003',
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Rev.No. / Rev. Date : ',
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                const SizedBox(
                                                  width: 8,
                                                ),
                                                Text(
                                                  'Ver.1.0 / 20-08-2023',
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                              ],
                                            ),
                                            // **************  Cell Cutting Machine *****************
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Center(
                                                child: Text(
                                                    "Cell Cutting Machine & Cell Loading",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255, 13, 160, 0),
                                                        fontFamily:
                                                            appFontFamily,
                                                        fontWeight:
                                                            FontWeight.w700))),
                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreqController,
                                              // CellManufactureFrequencyController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Once a shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),

                                            Text(
                                              "Cell Menufacturer & Eff.",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: TextFormField(
                                                  controller:
                                                      cellCuttingMenuController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Cell Menufacturer & Eff.  ",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator: MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Cell Menufacturer & Eff.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                )),
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingAccepController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Refer Production Order",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq1Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Once a shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Cell Size(L*W)",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: TextFormField(
                                                  controller:
                                                      cellCuttingSizeController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Cell Size(L*W)",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator: MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Cell Size(Lengthxwidth)",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                )),
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingAccep1Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Refer Production Order/(91 ± 0.25)mm",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq2Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Once a Shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),

                                            Text(
                                              "Cell Condition",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                    child: TextFormField(
                                                  controller:
                                                      cellCuttingCondiController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Cell Condition ",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator: MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Cell Color",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                )),
                                                // Add some space between the text fields
                                              ],
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingAccep2Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Free From dust , finger spot, color variation",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),
                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq3Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Once per Shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Cleanliness of Cell Loading Area",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCleanController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Cleanliness of Cell Loading Area",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingAccep3Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "No unwanted or waste material should be at Cell Loading Area",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq4Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Once per Shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Verification of Process Parameter",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingVerifiController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Verification of Process Parameter",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingAccep4Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "As per machine specification",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq5Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "1 String/Stringer/shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "String Length ",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingString1Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the String Length ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture String Length 1",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingStrCam1Controller,
                                              // controller: camera3Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Humidity Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingStrCam1Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingString2Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the String Length ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture String Length 2",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingStrCam2Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Humidity Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingStrCam2Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            TextFormField(
                                              controller:
                                                  cellCuttingString3Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the String Length ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              "Picture String Length 3",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingStrCam3Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Humidity Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingStrCam3Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingString4Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the String Length ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture String Length 4",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingStrCam4Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Humidity Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingStrCam4Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Divider(
                                              color: Colors.black,
                                              thickness: 2,
                                              height: 20,
                                            ),

                                            Text(
                                              "Frequency",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingFreq6Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "1 String/Stringer/shift",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "Cell to Cell Gap",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCell1Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Cell to Cell Gap ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture Cell to Cell Gap  1",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCellCam1Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Cell to Cell Gap Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingCellCam1Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCell2Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Cell to Cell Gap  ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture Cell to Cell Gap  2",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCellCam2Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Cell to Cell Gap  Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingCellCam2Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            TextFormField(
                                              controller:
                                                  cellCuttingCell3Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Cell to Cell Gap  ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            Text(
                                              "Picture Cell to Cell Gap  3",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCellCam3Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Cell to Cell Gap  Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingCellCam3Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCell4Controller,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Enter the Cell to Cell Gap ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct Avability of specification & WI.",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "Picture Cell to Cell Gap  4",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCellCam4Controller,
                                              decoration: InputDecoration(
                                                hintText:
                                                    "Please Capture a Cell to Cell Gap  Picture",
                                                counterText: '',
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                suffixIcon: IconButton(
                                                  onPressed: () async {
                                                    if (status != 'Pending') {
                                                      await _openCamera(
                                                          cellCuttingCellCam4Controller);
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            Text(
                                              "Acceptance Criteria",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  cellCuttingCellAccepController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText:
                                                    "Refer Production Order & Module Drawing",
                                                counterText: '',
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: true,
                                            ),

                                            const SizedBox(
                                              height: 15,
                                            ),

                                            // *** Remark

                                            Text(
                                              "Remark",
                                              style: AppStyles
                                                  .textfieldCaptionTextStyle,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),

                                            TextFormField(
                                              controller:
                                                  cellCuttingCellRemarkController,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: AppStyles
                                                  .textFieldInputDecoration
                                                  .copyWith(
                                                hintText: "Remark ",
                                                counterText: '',
                                                fillColor: Color.fromARGB(
                                                    255, 215, 243, 207),
                                              ),
                                              style:
                                                  AppStyles.textInputTextStyle,
                                              readOnly: status == 'Pending' &&
                                                      designation != "QC"
                                                  ? true
                                                  : false,
                                              // validator: MultiValidator(
                                              //   [
                                              //     RequiredValidator(
                                              //       errorText:
                                              //           "Please Enter Correct data",
                                              //     ),
                                              //   ],
                                              // ),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 0)),
                                            _isLoading
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator())
                                                : AppButton(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.white,
                                                      fontSize: 16,
                                                    ),
                                                    onTap: () {
                                                      AppHelper.hideKeyboard(
                                                          context);
                                                      if (status != 'Pending') {
                                                        setState(() {
                                                          sendStatus =
                                                              'Inprogress';
                                                        });
                                                        sendDataToBackend();
                                                      }
                                                      setState(() {
                                                        setPage =
                                                            "Tabber & Stringer";
                                                      });
                                                    },
                                                    label: "Next",
                                                    organization: '',
                                                  ),
                                            const SizedBox(
                                              height: 10,
                                            ),

                                            Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      setPage =
                                                          'Cell Cutting Machine';
                                                    });
                                                  },
                                                  child: const Text(
                                                    "BACK",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            appFontFamily,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            AppColors.redColor),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              child: const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Powered By Gautam Solar Pvt. Ltd.",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: appFontFamily,
                                                      color:
                                                          AppColors.greyColor,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                )
                              : setPage == "Tabber & Stringer"
                                  // Tabber & Stringer start
                                  ? Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.expand,
                                      children: [
                                        SingleChildScrollView(
                                          child: Form(
                                            key: _preLamFormKey,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
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
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 10),
                                                        child: Text(
                                                            "Incoming Production Quality Control",
                                                            style: TextStyle(
                                                                fontSize: 27,
                                                                color: AppColors
                                                                    .black,
                                                                fontFamily:
                                                                    appFontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700)))),
                                                const Center(
                                                    child: Text(
                                                        "(Pre Lam Checklist)",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                AppColors.black,
                                                            fontFamily:
                                                                appFontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Document No : ',
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'GSPL/prelam/IPC/003',
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'Rev.No. / Rev. Date : ',
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      'Ver.1.0 / 20-08-2023',
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                  ],
                                                ),
                                                // ******** Tabber & Stringer *****************
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const Center(
                                                    child: Text(
                                                        "Tabber & Stringer",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Color
                                                                .fromARGB(255,
                                                                    13, 160, 0),
                                                            fontFamily:
                                                                appFontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),

                                                // **********  start Tabber ***********
                                                const SizedBox(
                                                  height: 20,
                                                ),

                                                Text(
                                                  "Frequency",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberFreq1Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText: "Once per Shift",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Verification of Processn Parameter",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberVerifController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Verification of Processn Parameter",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                Text(
                                                  "Acceptance Criteria",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberAccep1Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "As per machine specification",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                // **********  start Tabber ***********

                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 2,
                                                  height: 20,
                                                ),

                                                Text(
                                                  "Frequency",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberFreq2Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Once 1 String/TS shift ",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),

                                                Text(
                                                  "Visual Check after stringer",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 232, 26, 26),
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Sr.No.1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisual1Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Visual Check after stringer",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Picture 1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisualcam1Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please capture a visual check after stringer picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabbervisualcam1Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                SizedBox(height: 5),
                                                Text(
                                                  "Sr.No.2",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisual2Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Visual Check after stringer",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Picture 2",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisualcam2Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please capture a visual check after stringer picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabbervisualcam2Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                SizedBox(height: 5),
                                                Text(
                                                  "Sr.No.3",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisual3Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Visual Check after stringer",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Picture 3",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisualcam3Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please capture a visual check after stringer picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabbervisualcam3Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                SizedBox(
                                                  height: 5,
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Sr.No.4",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisual4Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the Visual Check after stringer",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  "Picture 4",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabbervisualcam4Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please capture a visual check after stringer picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabbervisualcam4Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Acceptance Criteria",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberAccep2Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "As per pre Lam Visual Criteria ",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 2,
                                                  height: 20,
                                                ),

                                                Text(
                                                  "Frequency",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberFreq3Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Once 1 String/TS/shift",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "EI image of String",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 232, 26, 26),
                                                  ),
                                                  // style: AppStyles
                                                  //     .textfieldCaptionTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberEL1Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the EI image of String 1",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Picture EL Image Sr.No.1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberELImageCam1Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a EL Image Sr.No. 1 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabberELImageCam1Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberEL2Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the EI image of String 2",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Picture EL Image Sr.No. 2",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberELImageCam2Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a EL Image Sr.No. 1 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabberELImageCam2Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberEL3Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the EI image of String 3",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Picture EL Image Sr.No. 3",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberELImageCam3Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a EL Image Sr.No. 1 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabberELImageCam3Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberEL4Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the EI image of String 4",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Picture EL Image Sr.No. 4",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberELImageCam4Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a EL Image Sr.No. 4 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              tabberELImageCam4Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Acceptance Criteria",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberAccep3Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "As per pre Lam EI Criteria ",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 2,
                                                  height: 20,
                                                ),

                                                Text(
                                                  "Frequency",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberFreq4Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "1 Cell from all Stringer per shift",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Verification of Soldering Peel Strength",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle
                                                      .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 232, 26, 26),
                                                  ),
                                                  // style: AppStyles
                                                  //     .textfieldCaptionTextStyle,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Sr.No. 1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: veri1Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the verification of soldering peel strength 1",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Picture 1",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      veriCam1Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a V.S.P.S. Sr.No. 1 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              veriCam1Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Sr.No. 2",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: veri2Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the verification of soldering peel strength 2",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Picture 2",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      veriCam2Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a V.S.P.S. Sr.No. 2 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              veriCam2Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Sr.No. 3",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: veri3Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the verification of soldering peel strength 3",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Picture 3",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      veriCam3Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a V.S.P.S. Sr.No. 3 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              veriCam3Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Sr.No. 4",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                TextFormField(
                                                  controller: veri4Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Enter the verification of soldering peel strength 4",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct Avability of specification & WI.",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Picture 4",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      veriCam4Controller,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                        "Please Capture a V.S.P.S. Sr.No. 4 Picture",
                                                    counterText: '',
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    suffixIcon: IconButton(
                                                      onPressed: () async {
                                                        if (status !=
                                                            'Pending') {
                                                          await _openCamera(
                                                              veriCam4Controller);
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Text(
                                                  "Acceptance Criteria",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextFormField(
                                                  controller:
                                                      tabberAccep4Controller,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText:
                                                        "Peel Strength ≥ 1N",
                                                    counterText: '',
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: true,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Divider(
                                                  color: Colors.black,
                                                  thickness: 2,
                                                  height: 20,
                                                ),

                                                // *** Remark
                                                const SizedBox(
                                                  height: 15,
                                                ),

                                                Text(
                                                  "Remark",
                                                  style: AppStyles
                                                      .textfieldCaptionTextStyle,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),

                                                TextFormField(
                                                  controller:
                                                      tabberRemarkController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: AppStyles
                                                      .textFieldInputDecoration
                                                      .copyWith(
                                                    hintText: "Remark ",
                                                    counterText: '',
                                                    fillColor: Color.fromARGB(
                                                        255, 215, 243, 207),
                                                  ),
                                                  style: AppStyles
                                                      .textInputTextStyle,
                                                  readOnly: status ==
                                                              'Pending' &&
                                                          designation != "QC"
                                                      ? true
                                                      : false,
                                                  // validator:
                                                  //     MultiValidator(
                                                  //   [
                                                  //     RequiredValidator(
                                                  //       errorText:
                                                  //           "Please Enter Correct data",
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ),

                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 10, 0, 0)),
                                                _isLoading
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : AppButton(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color:
                                                              AppColors.white,
                                                          fontSize: 16,
                                                        ),
                                                        onTap: () {
                                                          AppHelper
                                                              .hideKeyboard(
                                                                  context);

                                                          sample2Controller =
                                                              [];
                                                          for (int i = 0;
                                                              i <
                                                                  numberOfStringers1 *
                                                                      5;
                                                              i++) {
                                                            // sample2Controller
                                                            //     .add({
                                                            //   "TabberVisualStringerControllers${i + 1}":
                                                            //       TabberVisualStringerControllers[
                                                            //               i]
                                                            //           .text,
                                                            // });
                                                          }

                                                          sample3Controller =
                                                              [];
                                                          for (int i = 0;
                                                              i <
                                                                  numberOfStringers2 *
                                                                      5;
                                                              i++) {
                                                            // sample3Controller
                                                            //     .add({
                                                            //   "TabberEIimageofStringerControllers${i + 1}":
                                                            //       TabberEIimageofStringerControllers[
                                                            //               i]
                                                            //           .text,
                                                            // });
                                                          }

                                                          sample4Controller =
                                                              [];
                                                          for (int i = 0;
                                                              i <
                                                                  numberOfStringers4 *
                                                                      2;
                                                              i++) {
                                                            // sample4Controller
                                                            //     .add({
                                                            //   "TabberVerificationofsilderingControllers${i + 1}":
                                                            //       TabberVerificationofsilderingControllers[
                                                            //               i]
                                                            //           .text,
                                                            // });
                                                          }
                                                          if (status !=
                                                              'Pending') {
                                                            setState(() {
                                                              sendStatus =
                                                                  'Inprogress';
                                                            });
                                                            sendDataToBackend();
                                                          }

                                                          setState(() {
                                                            setPage =
                                                                "Auto String Layup";
                                                          });
                                                        },
                                                        label: "Next",
                                                        organization: '',
                                                      ),
                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                // Back button
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          setPage =
                                                              'Cell Cutting Machine';
                                                          // 'Cell Loading';
                                                        });
                                                      },
                                                      child: const Text(
                                                        "BACK",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                appFontFamily,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .redColor),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 25,
                                                ),

                                                Container(
                                                  alignment: Alignment.center,
                                                  child: const Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Powered By Gautam Solar Pvt. Ltd.",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              appFontFamily,
                                                          color: AppColors
                                                              .greyColor,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                    )
                                  : setPage == "Auto String Layup"
                                      // Auto String Layup start
                                      ? Stack(
                                          alignment: Alignment.center,
                                          fit: StackFit.expand,
                                          children: [
                                            SingleChildScrollView(
                                              child: Form(
                                                key: _preLamFormKey,
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
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
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                                "Incoming Production Quality Control",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        27,
                                                                    color: AppColors
                                                                        .black,
                                                                    fontFamily:
                                                                        appFontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700)))),
                                                    const Center(
                                                        child: Text(
                                                            "(Pre Lam Checklist)",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: AppColors
                                                                    .black,
                                                                fontFamily:
                                                                    appFontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                    const SizedBox(
                                                      height: 35,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Document No : ',
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'GSPL/prelam/IPC/003',
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Rev.No. / Rev. Date : ',
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          'Ver.1.0 / 20-08-2023',
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                      ],
                                                    ),

                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Center(
                                                        child: Text(
                                                            "Auto String Layup",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        13,
                                                                        160,
                                                                        0),
                                                                fontFamily:
                                                                    appFontFamily,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700))),
                                                    // **********  start Tabber ***********
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Text(
                                                      "Frequency",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          autoStrFreq1Controller,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Once per Shift",
                                                        counterText: '',
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly: true,
                                                    ),

                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      "String to String Gap",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          autoStrGapController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Enter the String to String Gap",
                                                        counterText: '',
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                215, 243, 207),
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly:
                                                          status == 'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                      // validator:
                                                      //     MultiValidator(
                                                      //   [
                                                      //     RequiredValidator(
                                                      //       errorText:
                                                      //           "Please Enter Correct String to String Gap",
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ),

                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Text(
                                                      "Acceptance Criteria",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          autoStrAccepController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Refer Production Order & Module Drawing",
                                                        counterText: '',
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly: true,
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Divider(
                                                      color: Colors.black,
                                                      thickness: 2,
                                                      height: 20,
                                                    ),

                                                    Text(
                                                      "Frequency",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          autoStrFreq2Controller,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Once per Shift",
                                                        counterText: '',
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly: true,
                                                    ),

                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text(
                                                      "Cell edge to glass edge",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    TextFormField(
                                                      controller:
                                                          autoStrCellController,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Enter the Cell edge to glass edge",
                                                        counterText: '',
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                215, 243, 207),
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly:
                                                          status == 'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                      // validator:
                                                      //     MultiValidator(
                                                      //   [
                                                      //     RequiredValidator(
                                                      //       errorText:
                                                      //           "Please Enter Correct Cell edge to glass edge(Top)",
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ),

                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Text(
                                                      "Acceptance Criteria",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                          autoStrAccep2Controller,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText:
                                                            "Refer Production Order & Module Drwaing",
                                                        counterText: '',
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly: true,
                                                    ),

                                                    // *** Remark
                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Text(
                                                      "Remark",
                                                      style: AppStyles
                                                          .textfieldCaptionTextStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    TextFormField(
                                                      controller:
                                                          autoStrRemark2Controller,
                                                      keyboardType:
                                                          TextInputType.text,
                                                      textInputAction:
                                                          TextInputAction.next,
                                                      decoration: AppStyles
                                                          .textFieldInputDecoration
                                                          .copyWith(
                                                        hintText: "Remark ",
                                                        counterText: '',
                                                        fillColor:
                                                            Color.fromARGB(255,
                                                                215, 243, 207),
                                                      ),
                                                      style: AppStyles
                                                          .textInputTextStyle,
                                                      readOnly:
                                                          status == 'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                      // validator:
                                                      //     MultiValidator(
                                                      //   [
                                                      //     RequiredValidator(
                                                      //       errorText:
                                                      //           "Please Enter Correct data",
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ),

                                                    const SizedBox(
                                                      height: 15,
                                                    ),

                                                    Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 10, 0, 0)),
                                                    _isLoading
                                                        ? Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : AppButton(
                                                            textStyle:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .white,
                                                              fontSize: 16,
                                                            ),
                                                            onTap: () {
                                                              AppHelper
                                                                  .hideKeyboard(
                                                                      context);
                                                              if (status !=
                                                                  'Pending') {
                                                                setState(() {
                                                                  sendStatus =
                                                                      'Inprogress';
                                                                });
                                                                sendDataToBackend();
                                                              }
                                                              setState(() {
                                                                setPage =
                                                                    "Auto Bussing & Tapping";
                                                              });
                                                            },
                                                            label: "Next",
                                                            organization: '',
                                                          ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    // Back button
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              setPage =
                                                                  'Tabber & Stringer';
                                                            });
                                                          },
                                                          child: const Text(
                                                            "BACK",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    appFontFamily,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .redColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: const Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            "Powered By Gautam Solar Pvt. Ltd.",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  appFontFamily,
                                                              color: AppColors
                                                                  .greyColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
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
                                        )
                                      : setPage == "Auto Bussing & Tapping"
                                          // Auto Bussing & Tapping
                                          ? Stack(
                                              alignment: Alignment.center,
                                              fit: StackFit.expand,
                                              children: [
                                                SingleChildScrollView(
                                                  child: Form(
                                                    key: _preLamFormKey,
                                                    autovalidateMode:
                                                        AutovalidateMode
                                                            .onUserInteraction,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                AppAssets
                                                                    .imgLogo,
                                                                height: 100,
                                                                width: 230,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const Center(
                                                            child: Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top:
                                                                            10),
                                                                child: Text(
                                                                    "Incoming Production Quality Control",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            27,
                                                                        color: AppColors
                                                                            .black,
                                                                        fontFamily:
                                                                            appFontFamily,
                                                                        fontWeight:
                                                                            FontWeight.w700)))),
                                                        const Center(
                                                            child: Text(
                                                                "(Pre Lam Checklist)",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: AppColors
                                                                        .black,
                                                                    fontFamily:
                                                                        appFontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700))),
                                                        const SizedBox(
                                                          height: 35,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Document No : ',
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              'GSPL/prelam/IPC/003',
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Rev.No. / Rev. Date : ',
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            const SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              'Ver.1.0 / 20-08-2023',
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                          ],
                                                        ),
                                                        const Center(
                                                            child: Text(
                                                                "Auto Bussing & Tapping",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            13,
                                                                            160,
                                                                            0),
                                                                    fontFamily:
                                                                        appFontFamily,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700))),

                                                        // **********  start Auto Bussing & Tapping ***********

                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Once per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Soldering Peel strength between Ribbon to bushbar interconnector",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSoldController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Soldering Peel strength between Ribbon to bushbar interconnector",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Soldering Peel strength between Ribbon to bushbar interconnector",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        Text(
                                                          "Sr. No.1",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSoldCam1Controller,
                                                          decoration:
                                                              InputDecoration(
                                                            hintText:
                                                                "Please Capture a  Picture",
                                                            counterText: '',
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            suffixIcon:
                                                                IconButton(
                                                              onPressed:
                                                                  () async {
                                                                if (status !=
                                                                    'Pending') {
                                                                  await _openCamera(
                                                                      autobussSoldCam1Controller);
                                                                }
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .camera_alt),
                                                            ),
                                                            border:
                                                                const OutlineInputBorder(),
                                                          ),
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                ">=4N | Refer",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 25,
                                                        ),
                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Thrice per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Terminal busbar to edge of cell",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussTermController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Terminal busbar to edge of cell",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Refer Production Order & Module Drwaing",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Every 4h per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Soldering quality of Ribbon to busbar",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSol1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the soldering quality of Ribbon to busbar",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSol2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the soldering quality of Ribbon to busbar",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSol3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the soldering quality of Ribbon to busbar",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussSol4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the soldering quality of Ribbon to busbar",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "No Dry/Poor Soldering",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Every 4h per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Top & Bottom Creepage Distance/Terminal busbar to Glass Edge.",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobusstop1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter The Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobusstop2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter The Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobusstop3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter The Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobusstop4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter The Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Creepage distance should be  14 ± 1 mm",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq5Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Every 4h per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Quality of auto taping",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussQul1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Quality of auto taping",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussQul2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Quality of auto taping",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussQul3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Quality of auto taping",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussQul4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Quality of auto taping",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep5Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Creepage distance should be  14 ± 1 mm",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),
                                                        Text(
                                                          "Frequency",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussFreq6Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Every 4h per Shift",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),

                                                        const SizedBox(
                                                          height: 20,
                                                        ),

                                                        Text(
                                                          "Position verification of RFID & Logo Patch on Module",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussPos1Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Position verification of RFID & Logo Patch on Module",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussPos2Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Position verification of RFID & Logo Patch on Module",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussPos3Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Position verification of RFID & Logo Patch on Module",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussPos4Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Enter the Position verification of RFID & Logo Patch on Module",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct Terminal busbar to edge of cell",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Acceptance Criteria",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              autobussAccep6Controller,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText:
                                                                "Should not be tilt, Busbar should not visiable",
                                                            counterText: '',
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: true,
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Divider(
                                                          color: Colors.black,
                                                          thickness: 2,
                                                          height: 20,
                                                        ),

                                                        // *** Remark
                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Text(
                                                          "Remark",
                                                          style: AppStyles
                                                              .textfieldCaptionTextStyle,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),

                                                        TextFormField(
                                                          controller:
                                                              autobussRemarkController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          decoration: AppStyles
                                                              .textFieldInputDecoration
                                                              .copyWith(
                                                            hintText: "Remark ",
                                                            counterText: '',
                                                            fillColor:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    243,
                                                                    207),
                                                          ),
                                                          style: AppStyles
                                                              .textInputTextStyle,
                                                          readOnly: status ==
                                                                      'Pending' &&
                                                                  designation !=
                                                                      "QC"
                                                              ? true
                                                              : false,
                                                          // validator:
                                                          //     MultiValidator(
                                                          //   [
                                                          //     RequiredValidator(
                                                          //       errorText:
                                                          //           "Please Enter Correct data",
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ),

                                                        const SizedBox(
                                                          height: 15,
                                                        ),

                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(0, 10,
                                                                    0, 0)),
                                                        _isLoading
                                                            ? Center(
                                                                child:
                                                                    CircularProgressIndicator())
                                                            : AppButton(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                  fontSize: 16,
                                                                ),
                                                                onTap: () {
                                                                  AppHelper
                                                                      .hideKeyboard(
                                                                          context);
                                                                  if (status !=
                                                                      'Pending') {
                                                                    setState(
                                                                        () {
                                                                      sendStatus =
                                                                          'Inprogress';
                                                                    });
                                                                    sendDataToBackend();
                                                                  }
                                                                  setState(() {
                                                                    setPage =
                                                                        "EVA/Backsheet Cutting";
                                                                  });
                                                                },
                                                                label: "Next",
                                                                organization:
                                                                    '',
                                                              ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        // Back button
                                                        Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  setPage =
                                                                      'Auto String Layup';
                                                                });
                                                              },
                                                              child: const Text(
                                                                "BACK",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        appFontFamily,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppColors
                                                                        .redColor),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 25,
                                                        ),
                                                        Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                "Powered By Gautam Solar Pvt. Ltd.",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      appFontFamily,
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
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
                                            )
                                          : setPage == "EVA/Backsheet Cutting"
                                              // EVA/Backsheet Cutting
                                              ? Stack(
                                                  alignment: Alignment.center,
                                                  fit: StackFit.expand,
                                                  children: [
                                                    SingleChildScrollView(
                                                      child: Form(
                                                        key: _preLamFormKey,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .onUserInteraction,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    AppAssets
                                                                        .imgLogo,
                                                                    height: 100,
                                                                    width: 230,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const Center(
                                                                child: Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                10),
                                                                    child: Text(
                                                                        "Incoming Production Quality Control",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                27,
                                                                            color: AppColors
                                                                                .black,
                                                                            fontFamily:
                                                                                appFontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w700)))),
                                                            const Center(
                                                                child: Text(
                                                                    "(Pre Lam IPQC Checklist)",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: AppColors
                                                                            .black,
                                                                        fontFamily:
                                                                            appFontFamily,
                                                                        fontWeight:
                                                                            FontWeight.w700))),
                                                            const SizedBox(
                                                              height: 35,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Document No : ',
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  'GSPL/IPQC/IPC/003',
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  'Rev.No. / Rev. Date : ',
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  'Ver.2.0 / 20-03-2024',
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                              ],
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            const Center(
                                                                child: Text(
                                                                    "EVA/EPE/Backsheet Cutting ",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20,
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            13,
                                                                            160,
                                                                            0),
                                                                        fontFamily:
                                                                            appFontFamily,
                                                                        fontWeight:
                                                                            FontWeight.w700))),

                                                            // ******  start EVA/Backsheet Cutting ***

                                                            const SizedBox(
                                                              height: 15,
                                                            ),
                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 2,
                                                              height: 20,
                                                            ),

                                                            Text(
                                                              "Frequency",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaFreq1Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Once per Shift",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),

                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Rear EVA dimension & slit cutting width(mm)",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaRearController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Enter the  Rear EVA dimension & slit cutting width(mm)",
                                                                counterText: '',
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        215,
                                                                        243,
                                                                        207),
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: status ==
                                                                          'Pending' &&
                                                                      designation !=
                                                                          "QC"
                                                                  ? true
                                                                  : false,
                                                              // validator:
                                                              //     MultiValidator(
                                                              //   [
                                                              //     RequiredValidator(
                                                              //       errorText:
                                                              //           "Please Enter Correct Rear EVA dimension & sift cutting width(mm)",
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Text(
                                                              "Acceptance Criteria",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaAccep1Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "As per Specification GSPL/EVA(IQC)/001 & production order",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 2,
                                                              height: 20,
                                                            ),

                                                            Text(
                                                              "Frequency",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaFreq2Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Once per Shift",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),

                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "Back-sheet dimension& slit cutting diameter",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaBackController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Enter the Back-sheet dimension& slit cutting diameter",
                                                                counterText: '',
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        215,
                                                                        243,
                                                                        207),
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: status ==
                                                                          'Pending' &&
                                                                      designation !=
                                                                          "QC"
                                                                  ? true
                                                                  : false,
                                                              // validator:
                                                              //     MultiValidator(
                                                              //   [
                                                              //     RequiredValidator(
                                                              //       errorText:
                                                              //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Text(
                                                              "Acceptance Criteria",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaAccep2Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "As per Specification GSPL/BS(IQC)/001 & production order",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 2,
                                                              height: 20,
                                                            ),

                                                            Text(
                                                              "Frequency",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaFreq3Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Once per Shift",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),

                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Text(
                                                              "EVA/POE/Backsheet Status",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaPOEController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Enter the Back-sheet dimension& slit cutting diameter",
                                                                counterText: '',
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        215,
                                                                        243,
                                                                        207),
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: status ==
                                                                          'Pending' &&
                                                                      designation !=
                                                                          "QC"
                                                                  ? true
                                                                  : false,
                                                              // validator:
                                                              //     MultiValidator(
                                                              //   [
                                                              //     RequiredValidator(
                                                              //       errorText:
                                                              //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Text(
                                                              "Acceptance Criteria",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  EvaAccep3Controller,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Not allowed dust & foreign particle, shifting of EVA, Backsheet/Cut & non Uniform Embossing/Mfg Date",
                                                                counterText: '',
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: true,
                                                            ),
                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Divider(
                                                              color:
                                                                  Colors.black,
                                                              thickness: 2,
                                                              height: 20,
                                                            ),

                                                            const SizedBox(
                                                              height: 20,
                                                            ),

                                                            // *** Remark
                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Text(
                                                              "Remark",
                                                              style: AppStyles
                                                                  .textfieldCaptionTextStyle,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),

                                                            TextFormField(
                                                              controller:
                                                                  EvaRemarkController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              decoration: AppStyles
                                                                  .textFieldInputDecoration
                                                                  .copyWith(
                                                                hintText:
                                                                    "Remark ",
                                                                counterText: '',
                                                                fillColor: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        215,
                                                                        243,
                                                                        207),
                                                              ),
                                                              style: AppStyles
                                                                  .textInputTextStyle,
                                                              readOnly: status ==
                                                                          'Pending' &&
                                                                      designation !=
                                                                          "QC"
                                                                  ? true
                                                                  : false,
                                                              // validator:
                                                              //     MultiValidator(
                                                              //   [
                                                              //     RequiredValidator(
                                                              //       errorText:
                                                              //           "Please Enter Correct data",
                                                              //     ),
                                                              //   ],
                                                              // ),
                                                            ),

                                                            const SizedBox(
                                                              height: 15,
                                                            ),

                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0)),
                                                            _isLoading
                                                                ? Center(
                                                                    child:
                                                                        CircularProgressIndicator())
                                                                : AppButton(
                                                                    textStyle:
                                                                        const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: AppColors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                    onTap: () {
                                                                      AppHelper
                                                                          .hideKeyboard(
                                                                              context);
                                                                      if (status !=
                                                                          'Pending') {
                                                                        setState(
                                                                            () {
                                                                          sendStatus =
                                                                              'Inprogress';
                                                                        });
                                                                        sendDataToBackend();
                                                                      }
                                                                      setState(
                                                                          () {
                                                                        setPage =
                                                                            "Pre Lamination El & Visual inspection";
                                                                      });
                                                                    },
                                                                    label:
                                                                        "Next",
                                                                    organization:
                                                                        '',
                                                                  ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            // Back button
                                                            Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      setPage =
                                                                          'Auto Bussing & Tapping';
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    "BACK",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            appFontFamily,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        color: AppColors
                                                                            .redColor),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            const SizedBox(
                                                              height: 25,
                                                            ),
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  const Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "Powered By Gautam Solar Pvt. Ltd.",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          appFontFamily,
                                                                      color: AppColors
                                                                          .greyColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
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
                                                )
                                              : setPage ==
                                                      "Pre Lamination El & Visual inspection"
                                                  // Pre Lamination El & Visual inspection
                                                  ? Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      fit: StackFit.expand,
                                                      children: [
                                                        SingleChildScrollView(
                                                          child: Form(
                                                            key: _preLamFormKey,
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .onUserInteraction,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        AppAssets
                                                                            .imgLogo,
                                                                        height:
                                                                            100,
                                                                        width:
                                                                            230,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Center(
                                                                    child: Padding(
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                10),
                                                                        child: Text(
                                                                            "Incoming Production Quality Control",
                                                                            style: TextStyle(
                                                                                fontSize: 27,
                                                                                color: AppColors.black,
                                                                                fontFamily: appFontFamily,
                                                                                fontWeight: FontWeight.w700)))),
                                                                const Center(
                                                                    child: Text(
                                                                        "(Pre Lam IPQC Checklist)",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color: AppColors
                                                                                .black,
                                                                            fontFamily:
                                                                                appFontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w700))),
                                                                const SizedBox(
                                                                  height: 35,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'Document No : ',
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      'GSPL/IPQC/IPC/003',
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(
                                                                  height: 8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'Rev.No. / Rev. Date : ',
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      'Ver.2.0 / 20-03-2024',
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                  ],
                                                                ),

                                                                // **************  "Pre Lamination El & Visual inspection  *****************
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Center(
                                                                    child: Text(
                                                                        "Pre Lamination El & Visual Inspection ",
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                13,
                                                                                160,
                                                                                0),
                                                                            fontFamily:
                                                                                appFontFamily,
                                                                            fontWeight:
                                                                                FontWeight.w700))),

                                                                const SizedBox(
                                                                  height: 15,
                                                                ),

                                                                /**   Start */
                                                                Divider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 2,
                                                                  height: 20,
                                                                ),

                                                                Text(
                                                                  "Frequency",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreFreq1Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "5 Pieces Per Shift ",
                                                                    counterText:
                                                                        '',
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly:
                                                                      true,
                                                                ),

                                                                const SizedBox(
                                                                  height: 20,
                                                                ),

                                                                Text(
                                                                  "EI Inspection",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                    height: 2),
                                                                TextFormField(
                                                                  controller:
                                                                      PreEL1Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter EL Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                Text(
                                                                  "Sr. No.1",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreELCam1Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a EL Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreELCam1Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                TextFormField(
                                                                  controller:
                                                                      PreEL2Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter EL Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),

                                                                Text(
                                                                  "Sr. No.2",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreELCam2Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a EL Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreELCam2Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),

                                                                SizedBox(
                                                                    height: 5),
                                                                TextFormField(
                                                                  controller:
                                                                      PreEL3Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter EL Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),

                                                                SizedBox(
                                                                    height: 5),

                                                                Text(
                                                                  "Sr. No.3",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreELCam3Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a EL Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreELCam3Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                TextFormField(
                                                                  controller:
                                                                      PreEL4Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter EL Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.4",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreELCam4Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a EL Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreELCam4Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                TextFormField(
                                                                  controller:
                                                                      PreEL5Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter EL Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),

                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(
                                                                  "Sr. No.1",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreELCam5Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a EL Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreELCam5Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                Text(
                                                                  "Acceptance Criteria",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreAccep1Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "EL image should fullfil the EL Acceptance Criteria GSPL/EL/001",
                                                                    counterText:
                                                                        '',
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),

                                                                Divider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 2,
                                                                  height: 20,
                                                                ),

                                                                Text(
                                                                  "Frequency",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreFreq2Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "5 Pieces Per Shift ",
                                                                    counterText:
                                                                        '',
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly:
                                                                      true,
                                                                ),

                                                                const SizedBox(
                                                                  height: 20,
                                                                ),

                                                                Text(
                                                                  "Visual Inspection",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),

                                                                TextFormField(
                                                                  controller:
                                                                      PreVisul1Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter Visual Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.1",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreVisulCam1Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a Visual Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreVisulCam1Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),

                                                                TextFormField(
                                                                  controller:
                                                                      PreVisul2Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter Visual Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.2",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreVisulCam2Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a Visual Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreVisulCam2Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),

                                                                TextFormField(
                                                                  controller:
                                                                      PreVisul3Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter Visual Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.3",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreVisulCam3Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a Visual Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreVisulCam3Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),

                                                                SizedBox(
                                                                    height: 5),

                                                                TextFormField(
                                                                  controller:
                                                                      PreVisul4Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter Visual Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.4",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreVisulCam4Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a Visual Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreVisulCam4Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                SizedBox(
                                                                    height: 5),

                                                                TextFormField(
                                                                  controller:
                                                                      PreVisul5Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Enter Visual Inspection",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText:
                                                                  //           "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),
                                                                SizedBox(
                                                                    height: 5),
                                                                Text(
                                                                  "Sr. No.5",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreVisulCam5Controller,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        "Please Capture a Visual Inspection Picture",
                                                                    counterText:
                                                                        '',
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    suffixIcon:
                                                                        IconButton(
                                                                      onPressed:
                                                                          () async {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          await _openCamera(
                                                                              PreVisulCam5Controller);
                                                                        }
                                                                      },
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .camera_alt),
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                  ),
                                                                  readOnly:
                                                                      true,
                                                                ),

                                                                const SizedBox(
                                                                  height: 2,
                                                                ),
                                                                const SizedBox(
                                                                  height: 2,
                                                                ),

                                                                Text(
                                                                  "Acceptance Criteria",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                TextFormField(
                                                                  controller:
                                                                      PreAccep2Controller,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Visual image should fullfil the visual Acceptance Criteria as per GSPL/ELV/001",
                                                                    counterText:
                                                                        '',
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly:
                                                                      true,
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),

                                                                Divider(
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 2,
                                                                  height: 20,
                                                                ),

                                                                //  *** Remark
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),

                                                                Text(
                                                                  "Remark",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),

                                                                TextFormField(
                                                                  controller:
                                                                      PreRemarkController,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  textInputAction:
                                                                      TextInputAction
                                                                          .next,
                                                                  decoration: AppStyles
                                                                      .textFieldInputDecoration
                                                                      .copyWith(
                                                                    hintText:
                                                                        "Remark ",
                                                                    counterText:
                                                                        '',
                                                                    fillColor: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                  ),
                                                                  style: AppStyles
                                                                      .textInputTextStyle,
                                                                  readOnly: status ==
                                                                              'Pending' &&
                                                                          designation !=
                                                                              "QC"
                                                                      ? true
                                                                      : false,
                                                                  // validator:
                                                                  //     MultiValidator(
                                                                  //   [
                                                                  //     RequiredValidator(
                                                                  //       errorText: "Please Enter Correct data",
                                                                  //     ),
                                                                  //   ],
                                                                  // ),
                                                                ),

                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0)),
                                                                _isLoading
                                                                    ? Center(
                                                                        child:
                                                                            CircularProgressIndicator())
                                                                    : AppButton(
                                                                        textStyle:
                                                                            const TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          color:
                                                                              AppColors.white,
                                                                          fontSize:
                                                                              16,
                                                                        ),
                                                                        onTap:
                                                                            () {
                                                                          AppHelper.hideKeyboard(
                                                                              context);

                                                                          sample5Controller =
                                                                              [];
                                                                          for (int i = 0;
                                                                              i < numberOfStringers5 * 5;
                                                                              i++) {
                                                                            // sample5Controller.add({
                                                                            //   "PreLaminationEIinspectionrControllers${i + 1}": PreLaminationEIinspectionrControllers[i].text,
                                                                            // });
                                                                          }

                                                                          sample6Controller =
                                                                              [];
                                                                          // for (int i = 0;
                                                                          //     i < numberOfStringers6 * 5;
                                                                          //     i++) {
                                                                          //   sample6Controller.add({
                                                                          //     "PreLaminationVisualinspectionrControllers${i + 1}": PreLaminationVisualinspectionrControllers[i].text,
                                                                          //   });
                                                                          // }
                                                                          if (status !=
                                                                              'Pending') {
                                                                            setState(() {
                                                                              sendStatus = 'Inprogress';
                                                                            });
                                                                            sendDataToBackend();
                                                                          }
                                                                          setState(
                                                                              () {
                                                                            setPage =
                                                                                "String Rework Station";
                                                                          });
                                                                        },
                                                                        label:
                                                                            "Next",
                                                                        organization:
                                                                            '',
                                                                      ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),

                                                                // Back button
                                                                Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                    child:
                                                                        InkWell(
                                                                      onTap:
                                                                          () {
                                                                        setState(
                                                                            () {
                                                                          setPage =
                                                                              'EVA/Backsheet Cutting';
                                                                        });
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "BACK",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                appFontFamily,
                                                                            fontSize:
                                                                                16,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            color: AppColors.redColor),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 25,
                                                                ),

                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:
                                                                      const Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        "Powered By Gautam Solar Pvt. Ltd.",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              14,
                                                                          fontFamily:
                                                                              appFontFamily,
                                                                          color:
                                                                              AppColors.greyColor,
                                                                          fontWeight:
                                                                              FontWeight.w400,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : setPage ==
                                                          "String Rework Station"
                                                      // String Rework Station start
                                                      ? Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          fit: StackFit.expand,
                                                          children: [
                                                            SingleChildScrollView(
                                                              child: Form(
                                                                key:
                                                                    _preLamFormKey,
                                                                autovalidateMode:
                                                                    AutovalidateMode
                                                                        .onUserInteraction,
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            AppAssets.imgLogo,
                                                                            height:
                                                                                100,
                                                                            width:
                                                                                230,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const Center(
                                                                        child: Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: 10),
                                                                            child: Text("Incoming Production Quality Control", style: TextStyle(fontSize: 27, color: AppColors.black, fontFamily: appFontFamily, fontWeight: FontWeight.w700)))),
                                                                    const Center(
                                                                        child: Text(
                                                                            "(Pre Lam IPQC Checklist)",
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: AppColors.black,
                                                                                fontFamily: appFontFamily,
                                                                                fontWeight: FontWeight.w700))),
                                                                    const SizedBox(
                                                                      height:
                                                                          35,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'Document No : ',
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          'GSPL/IPQC/IPC/003',
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: 8,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          'Rev.No. / Rev. Date : ',
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          'Ver.2.0 / 20-03-2024',
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                      ],
                                                                    ),

                                                                    // ************** String Rework Station *****************
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Center(
                                                                        child: Text(
                                                                            "String Rework Station",
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Color.fromARGB(255, 13, 160, 0),
                                                                                fontFamily: appFontFamily,
                                                                                fontWeight: FontWeight.w700))),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    Text(
                                                                      "Frequency",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          StringAvaibilityFrequencyController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "Once a Shift",
                                                                        counterText:
                                                                            '',
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly:
                                                                          true,
                                                                    ),

                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Avaibility of Work instruction(WI)",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          StringAvaibilityController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "Enter the Avaibility of Work instruction(WI)",
                                                                        counterText:
                                                                            '',
                                                                        fillColor: Color.fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly: status == 'Pending' &&
                                                                              designation != "QC"
                                                                          ? true
                                                                          : false,
                                                                      // validator: MultiValidator(
                                                                      //   [
                                                                      //     RequiredValidator(
                                                                      //       errorText: "Please Enter Correct Avaibility of Work instruction(WI)",
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                    ),

                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    Text(
                                                                      "Acceptance Criteria",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          StringAvaibilityCriteriaController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "WI Should be available at station and operator should be aware of WI",
                                                                        counterText:
                                                                            '',
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly:
                                                                          true,
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Divider(
                                                                      color: Colors
                                                                          .black,
                                                                      thickness:
                                                                          2,
                                                                      height:
                                                                          20,
                                                                    ),

                                                                    Text(
                                                                      "Frequency",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          StringCleaningFrequencyController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "Once a Shift",
                                                                        counterText:
                                                                            '',
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly:
                                                                          true,
                                                                    ),

                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Text(
                                                                      "Cleaning of Rework station/soldering iron sponge",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    TextFormField(
                                                                      controller:
                                                                          StringCleaningController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "Enter the Cleaning of Rework station/soldering iron sponge",
                                                                        counterText:
                                                                            '',
                                                                        fillColor: Color.fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly: status == 'Pending' &&
                                                                              designation != "QC"
                                                                          ? true
                                                                          : false,
                                                                      // validator: MultiValidator(
                                                                      //   [
                                                                      //     RequiredValidator(
                                                                      //       errorText: "Please Enter Correct Cleaning of Rework station/soldering iron sponge",
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                    ),

                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    // *** Remark
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    Text(
                                                                      "Remark",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),

                                                                    TextFormField(
                                                                      controller:
                                                                          StringReworkRemarkController,
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .text,
                                                                      textInputAction:
                                                                          TextInputAction
                                                                              .next,
                                                                      decoration: AppStyles
                                                                          .textFieldInputDecoration
                                                                          .copyWith(
                                                                        hintText:
                                                                            "Remark ",
                                                                        counterText:
                                                                            '',
                                                                        fillColor: Color.fromARGB(
                                                                            255,
                                                                            215,
                                                                            243,
                                                                            207),
                                                                      ),
                                                                      style: AppStyles
                                                                          .textInputTextStyle,
                                                                      readOnly: status == 'Pending' &&
                                                                              designation != "QC"
                                                                          ? true
                                                                          : false,
                                                                      // validator: MultiValidator(
                                                                      //   [
                                                                      //     RequiredValidator(
                                                                      //       errorText: "Please Enter Correct data",
                                                                      //     ),
                                                                      //   ],
                                                                      // ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    Padding(
                                                                        padding: EdgeInsets.fromLTRB(
                                                                            0,
                                                                            10,
                                                                            0,
                                                                            0)),
                                                                    _isLoading
                                                                        ? Center(
                                                                            child:
                                                                                CircularProgressIndicator())
                                                                        : AppButton(
                                                                            textStyle:
                                                                                const TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              color: AppColors.white,
                                                                              fontSize: 16,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              AppHelper.hideKeyboard(context);
                                                                              if (status != 'Pending') {
                                                                                setState(() {
                                                                                  sendStatus = 'Inprogress';
                                                                                });
                                                                                sendDataToBackend();
                                                                              }
                                                                              setState(() {
                                                                                setPage = "Module Rework Station";
                                                                                sendStatus = "Inprogress";
                                                                              });
                                                                            },
                                                                            label:
                                                                                "Next",
                                                                            organization:
                                                                                '',
                                                                          ),
                                                                    const SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),

                                                                    // Back button
                                                                    Center(
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              setPage = 'Pre Lamination El & Visual inspection';
                                                                            });
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            "BACK",
                                                                            style: TextStyle(
                                                                                fontFamily: appFontFamily,
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: AppColors.redColor),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                      height:
                                                                          25,
                                                                    ),
                                                                    Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          const Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Powered By Gautam Solar Pvt. Ltd.",
                                                                            style:
                                                                                TextStyle(
                                                                              fontSize: 14,
                                                                              fontFamily: appFontFamily,
                                                                              color: AppColors.greyColor,
                                                                              fontWeight: FontWeight.w400,
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                10,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : setPage ==
                                                              "Module Rework Station"
                                                          //   Module Rework Station start
                                                          ? Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              fit: StackFit
                                                                  .expand,
                                                              children: [
                                                                SingleChildScrollView(
                                                                  child: Form(
                                                                    key:
                                                                        _preLamFormKey,
                                                                    autovalidateMode:
                                                                        AutovalidateMode
                                                                            .onUserInteraction,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <Widget>[
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              Column(
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
                                                                        const Center(
                                                                            child:
                                                                                Padding(padding: EdgeInsets.only(top: 10), child: Text("Incoming Production Quality Control", style: TextStyle(fontSize: 27, color: AppColors.black, fontFamily: appFontFamily, fontWeight: FontWeight.w700)))),
                                                                        const Center(
                                                                            child:
                                                                                Text("(Pre Lam IPQC Checklist)", style: TextStyle(fontSize: 20, color: AppColors.black, fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
                                                                        const SizedBox(
                                                                          height:
                                                                              35,
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
                                                                              'GSPL/IPQC/IPC/003',
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              8,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              'Rev.No. / Rev. Date : ',
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Text(
                                                                              'Ver.2.0 / 20-03-2024',
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                          ],
                                                                        ),

                                                                        // ************** Module Rework Station *****************
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        const Center(
                                                                            child:
                                                                                Text("Module Rework Station", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 13, 160, 0), fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Text(
                                                                          "Frequency",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleAvaibilityFrequencyController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Once a Shift",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Avaibility of Work instruction(WI)",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleAvaibilityController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Enter the Avaibility of Work instruction(WI)",
                                                                            counterText:
                                                                                '',
                                                                            fillColor: Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                243,
                                                                                207),
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly: status == 'Pending' && designation != "QC"
                                                                              ? true
                                                                              : false,
                                                                          // validator: MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Correct Avaibility of Work instruction(WI)",
                                                                          //     ),
                                                                          //   ],
                                                                          // ),
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Text(
                                                                          "Acceptance Criteria",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleAvaibilityCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "WI Should be available at station and operator should be aware of WI",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              2,
                                                                          height:
                                                                              20,
                                                                        ),

                                                                        Text(
                                                                          "Frequency",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleMethodCleaningFrequencyController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Once a Shift",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Method of Rework",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleMethodCleaningController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Enter the Method of Rework",
                                                                            counterText:
                                                                                '',
                                                                            fillColor: Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                243,
                                                                                207),
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly: status == 'Pending' && designation != "QC"
                                                                              ? true
                                                                              : false,
                                                                          // validator: MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Correct Method of Rework",
                                                                          //     ),
                                                                          //   ],
                                                                          // ),
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Text(
                                                                          "Acceptance Criteria",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleMethodCleaningCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "As per WI",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              2,
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Frequency",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleHandlingFrequencyController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Once a Shift",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Handling of Modules",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleHandlingController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Enter the Handling of Modules",
                                                                            counterText:
                                                                                '',
                                                                            fillColor: Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                243,
                                                                                207),
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly: status == 'Pending' && designation != "QC"
                                                                              ? true
                                                                              : false,
                                                                          // validator: MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Correct Handling of Modules",
                                                                          //     ),
                                                                          //   ],
                                                                          // ),
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Text(
                                                                          "Acceptance Criteria",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleHandlingCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Operator Should handle the rework module with both the Hands",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.black,
                                                                          thickness:
                                                                              2,
                                                                          height:
                                                                              20,
                                                                        ),

                                                                        Text(
                                                                          "Frequency",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleCleaningofReworkFrequencyController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Once a Shift",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Text(
                                                                          "Cleaning of Rework station/soldering iron sponge",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleCleaningofReworkController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Enter the Cleaning of Rework station/soldering iron sponge",
                                                                            counterText:
                                                                                '',
                                                                            fillColor: Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                243,
                                                                                207),
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly: status == 'Pending' && designation != "QC"
                                                                              ? true
                                                                              : false,
                                                                          // validator: MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Correct Cleaning of Rework station/soldering iron sponge",
                                                                          //     ),
                                                                          //   ],
                                                                          // ),
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        Text(
                                                                          "Acceptance Criteria",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleCleaningofReworkCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Rework station should be clean",
                                                                            counterText:
                                                                                '',
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly:
                                                                              true,
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

                                                                        // *** Remark

                                                                        Text(
                                                                          "Remark",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),

                                                                        TextFormField(
                                                                          controller:
                                                                              ModuleCleaningRemarkController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Remark ",
                                                                            counterText:
                                                                                '',
                                                                            fillColor: Color.fromARGB(
                                                                                255,
                                                                                215,
                                                                                243,
                                                                                207),
                                                                          ),
                                                                          style:
                                                                              AppStyles.textInputTextStyle,
                                                                          readOnly: status == 'Pending' && designation != "QC"
                                                                              ? true
                                                                              : false,
                                                                          // validator: MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Correct data",
                                                                          //     ),
                                                                          //   ],
                                                                          // ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Padding(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                0,
                                                                                10,
                                                                                0,
                                                                                0)),
                                                                        _isLoading
                                                                            ? Center(child: CircularProgressIndicator())
                                                                            : AppButton(
                                                                                textStyle: const TextStyle(
                                                                                  fontWeight: FontWeight.w700,
                                                                                  color: AppColors.white,
                                                                                  fontSize: 16,
                                                                                ),
                                                                                onTap: () {
                                                                                  AppHelper.hideKeyboard(context);
                                                                                  if (status != 'Pending') {
                                                                                    setState(() {
                                                                                      sendStatus = 'Inprogress';
                                                                                    });
                                                                                    sendDataToBackend();
                                                                                  }
                                                                                  setState(() {
                                                                                    setPage = "Laminator";
                                                                                  });
                                                                                },
                                                                                label: "Next",
                                                                                organization: '',
                                                                              ),
                                                                        const SizedBox(
                                                                          height:
                                                                              10,
                                                                        ),
                                                                        // Back button

                                                                        Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  setPage = 'String Rework Station';
                                                                                });
                                                                              },
                                                                              child: const Text(
                                                                                "BACK",
                                                                                style: TextStyle(fontFamily: appFontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.redColor),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              25,
                                                                        ),
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          child:
                                                                              const Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
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
                                                            )
                                                          : setPage ==
                                                                  "Laminator"
                                                              //   Laminator start
                                                              ? Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  fit: StackFit
                                                                      .expand,
                                                                  children: [
                                                                    SingleChildScrollView(
                                                                      child:
                                                                          Form(
                                                                        key:
                                                                            _preLamFormKey,
                                                                        autovalidateMode:
                                                                            AutovalidateMode.onUserInteraction,
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: <Widget>[
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
                                                                            const Center(child: Padding(padding: EdgeInsets.only(top: 10), child: Text("Incoming Production Quality Control", style: TextStyle(fontSize: 27, color: AppColors.black, fontFamily: appFontFamily, fontWeight: FontWeight.w700)))),
                                                                            const Center(child: Text("(Pre Lam IPQC Checklist)", style: TextStyle(fontSize: 20, color: AppColors.black, fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
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
                                                                                  'GSPL/IPQC/IPC/003',
                                                                                  style: AppStyles.textfieldCaptionTextStyle,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 8,
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  'Rev.No. / Rev. Date : ',
                                                                                  style: AppStyles.textfieldCaptionTextStyle,
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 8,
                                                                                ),
                                                                                Text(
                                                                                  'Ver.2.0 / 20-03-2024',
                                                                                  style: AppStyles.textfieldCaptionTextStyle,
                                                                                ),
                                                                              ],
                                                                            ),

                                                                            // ************** Laminator  *****************
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            const Center(child: Text("Laminator", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 13, 160, 0), fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Text(
                                                                              "Frequency",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorMonitoringFrequencyController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Once a Shift",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Text(
                                                                              "Monitoring of Laminator Process Parameter",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorMonitoringController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Monitoring of Laminator Process Parameter",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              // validator: MultiValidator(
                                                                              //   [
                                                                              //     RequiredValidator(
                                                                              //       errorText: "Please Enter Correct Monitoring of Laminator Process Parameter",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Text(
                                                                              "Acceptance Criteria",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorMonitoringCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Laminator specification GSPL/IPQC/LM/008 |  GSPL/IPQC/LM/009 |  GSPL/IPQC/LM/010",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.black,
                                                                              thickness: 2,
                                                                              height: 20,
                                                                            ),

                                                                            Text(
                                                                              "Frequency",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorAdhesiveFrequencyController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Once a Shift",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Text(
                                                                              "Adhesive on backsheet of the module",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorAdhesiveController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Adhesive on backsheet of the module",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              // validator: MultiValidator(
                                                                              //   [
                                                                              //     RequiredValidator(
                                                                              //       errorText: "Please Enter Correct Adhesive on backsheet of the module",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Text(
                                                                              "Acceptance Criteria",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorAdhesiveCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Teflon should be clean, No EVA residue is allowed ",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Divider(
                                                                              color: Colors.black,
                                                                              thickness: 2,
                                                                              height: 20,
                                                                            ),
                                                                            Text(
                                                                              "Frequency",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorPeelFrequencyController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "All Position | All Laminator Once a Week",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Text(
                                                                              "Peel Adhesive Test",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorPeelController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Peel Adhesive Test",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              // validator: MultiValidator(
                                                                              //   [
                                                                              //     RequiredValidator(
                                                                              //       errorText: "Please Enter Correct Peel Adhesive Test",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Text(
                                                                              "Acceptance Criteria",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorPeelCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Eva to Glass = 70N/cm EVA to Backsheet >= 80N/cm",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.black,
                                                                              thickness: 2,
                                                                              height: 20,
                                                                            ),

                                                                            Text(
                                                                              "Frequency",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorGelFrequencyController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "All Position | All Laminator once a week ",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 20,
                                                                            ),
                                                                            Text(
                                                                              "Gel Content Test",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorGelController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Gel Content Test",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              // validator: MultiValidator(
                                                                              //   [
                                                                              //     RequiredValidator(
                                                                              //       errorText: "Please Enter Correct Gel Content Test",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Text(
                                                                              "Acceptance Criteria",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: LaminatorGelCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "75 to 95% ",
                                                                                counterText: '',
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: true,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            // *** Remark
                                                                            Text(
                                                                              "Remark",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),

                                                                            TextFormField(
                                                                              controller: LaminatorRemarkController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Remark ",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              // validator: MultiValidator(
                                                                              //   [
                                                                              //     RequiredValidator(
                                                                              //       errorText: "Please Enter Correct data",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              "Reference PDF Document ",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: referencePdfController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                  hintText: "Please Select Reference Pdf",
                                                                                  fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                                  suffixIcon: IconButton(
                                                                                    onPressed: () async {
                                                                                      if (widget.id != null && widget.id != '' && referencePdfController.text != '') {
                                                                                        UrlLauncher.launch(referencePdfController.text);
                                                                                      } else if (status != 'Pending') {
                                                                                        _pickReferencePDF();
                                                                                      }
                                                                                    },
                                                                                    icon: widget.id != null && widget.id != '' && referencePdfController.text != '' ? const Icon(Icons.download) : const Icon(Icons.upload_file),
                                                                                  ),
                                                                                  counterText: ''),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              maxLines: 1,
                                                                              readOnly: true,
                                                                              validator: (value) {
                                                                                if (value!.isEmpty) {
                                                                                  return "Please Select Reference Pdf";
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),

                                                                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                                                            _isLoading
                                                                                ? Center(child: CircularProgressIndicator())
                                                                                : (widget.id == "" || widget.id == null) || (status == 'Inprogress' && widget.id != null)
                                                                                    ? AppButton(
                                                                                        textStyle: const TextStyle(
                                                                                          fontWeight: FontWeight.w700,
                                                                                          color: AppColors.white,
                                                                                          fontSize: 16,
                                                                                        ),
                                                                                        onTap: () {
                                                                                          AppHelper.hideKeyboard(context);
                                                                                          //sendDataToBackend(); //300

                                                                                          _preLamFormKey.currentState!.save;
                                                                                          if (_preLamFormKey.currentState!.validate()) {
                                                                                            setState(() {
                                                                                              // setPage = "Cell Cutting Machine";
                                                                                              sendStatus = "Pending";
                                                                                            });
                                                                                            sendDataToBackend();
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
                                                                                status == 'Pending')
                                                                              Container(
                                                                                color: Color.fromARGB(255, 191, 226, 187), // Change the background color to your desired color
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                  children: [
                                                                                    Divider(),
                                                                                    SizedBox(height: 15),
                                                                                    AppButton(
                                                                                      textStyle: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.white, fontSize: 16),
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

                                                                            // Back button
                                                                            Center(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: InkWell(
                                                                                  onTap: () {
                                                                                    setState(() {
                                                                                      setPage = 'Module Rework Station';
                                                                                    });
                                                                                  },
                                                                                  child: const Text(
                                                                                    "BACK",
                                                                                    style: TextStyle(fontFamily: appFontFamily, fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.redColor),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 25,
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
                                                                )
                                                              : Container(),
                ),
          floatingActionButton: (status == "Pending") ? null : _getFAB(),
          // bottomNavigationBar: Container(
          //   height: 60,
          //   decoration: const BoxDecoration(
          //     color: Color.fromARGB(255, 245, 203, 19),
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(20),
          //       topRight: Radius.circular(20),
          //     ),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       InkWell(
          //           onTap: () {
          //             Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                 builder: (BuildContext context) =>
          //                     department == 'IPQC' &&
          //                             designation != 'Super Admin'
          //                         ? IpqcPage()
          //                         : WelcomePage()));
          //           },
          //           child: Image.asset(
          //               home
          //                   ? AppAssets.icHomeSelected
          //                   : AppAssets.icHomeUnSelected,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           onTap: () {
          //             // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //             //     builder: (BuildContext context) => AddEditProfile()));
          //           },
          //           child: Image.asset(
          //               user
          //                   ? AppAssets.imgSelectedPerson
          //                   : AppAssets.imgPerson,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           child: Image.asset(
          //               face
          //                   ? AppAssets.icSearchSelected
          //                   : AppAssets.icSearchUnSelected,
          //               height: 25)),
          //       const SizedBox(
          //         width: 8,
          //       ),
          //       InkWell(
          //           onTap: () {
          //             Navigator.of(context).pushReplacement(MaterialPageRoute(
          //                 builder: (BuildContext context) => PublicDrawer()));
          //           },
          //           child: Image.asset(
          //               menu ? AppAssets.imgSelectedMenu : AppAssets.imgMenu,
          //               height: 25)),
          //     ],
          //   ),
          // ),
        );
      }),
    );
  }
}
