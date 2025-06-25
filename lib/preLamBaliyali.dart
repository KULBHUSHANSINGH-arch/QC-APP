import 'dart:convert';
import 'dart:io';
// import 'package:QCM/Ipqc.dart';
// import 'package:QCM/components/app_button_widget.dart';
// import 'package:QCM/components/app_loader.dart';
// import 'package:QCM/ipqcTestList.dart';
// import 'package:newqcm/Ipqc.dart';
// import 'package:newqcm/components/app_button_widget.dart';
// import 'package:newqcm/components/app_loader.dart';
// import 'package:newqcm/ipqcTestList.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:form_field_validator/form_field_validator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';
import 'package:qcmapp/Ipqc.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:qcmapp/components/app_loader.dart';
import 'package:qcmapp/ipqcTestList.dart';
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

class PreCardB extends StatefulWidget {
  final String? id;
  const PreCardB({super.key, this.id});
  @override
  test_PreCardState createState() => test_PreCardState();
}

class ImageMetadata {
  final String imageKey;
  final String imagePath;
  final String timestamp;
  final String type; // Added type (e.g., temperature, humidity)
  final String stage; // Added stage

  ImageMetadata({
    required this.imageKey,
    required this.imagePath,
    required this.timestamp,
    required this.type,
    required this.stage,
  });

  Map<String, dynamic> toMap() {
    return {
      'imageKey': imageKey,
      'imagePath': imagePath,
      'timestamp': timestamp,
      'type': type,
      'stage': stage,
    };
  }
}

class test_PreCardState extends State<PreCardB> {
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

  // Second Glass Loader
  TextEditingController glass1FrequController = TextEditingController();
  TextEditingController glassDimen1Controller = TextEditingController();
  TextEditingController glassAccep1Controller = TextEditingController();
  TextEditingController glassRemark1Controller = TextEditingController();

  TextEditingController EvaFreq2bController = TextEditingController();
  TextEditingController EvaBackbController = TextEditingController();
  TextEditingController EvaAccep2bController = TextEditingController();

  TextEditingController EvaFreq3bController = TextEditingController();
  TextEditingController EvaPOEbController = TextEditingController();
  TextEditingController EvaAccep3bController = TextEditingController();

  //3.
  TextEditingController evaFreqController = TextEditingController();
  TextEditingController evaTypeController = TextEditingController();
  TextEditingController evaAccepController = TextEditingController();
  TextEditingController evaCamera1Controller = TextEditingController();

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
  // TextEditingController EvaBackController = TextEditingController();
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

  TextEditingController StringCleaningFrequencyController =
      TextEditingController();
  TextEditingController StringCleaningController = TextEditingController();
  TextEditingController StringCleaningCriteriaController =
      TextEditingController();
  TextEditingController StringSoldFrequencyController = TextEditingController();
  TextEditingController StringSoldController = TextEditingController();
  TextEditingController StringSoldCriteriaController = TextEditingController();
  TextEditingController soldCameraController = TextEditingController();
  TextEditingController StringReworkRemarkController = TextEditingController();

  // 12. Module Rework Station

  TextEditingController ModuleMethodCleaningFrequencyController =
      TextEditingController();
  TextEditingController ModuleMethodCleaningController =
      TextEditingController();
  TextEditingController ModuleMethodCleaningCriteriaController =
      TextEditingController();
  TextEditingController modCameraController = TextEditingController();

  TextEditingController ModuleCleaningofReworkFrequencyController =
      TextEditingController();
  TextEditingController ModuleCleaningofReworkController =
      TextEditingController();
  TextEditingController ModuleCleaningofReworkCriteriaController =
      TextEditingController();
  TextEditingController ModuleSoldFrequencyController = TextEditingController();
  TextEditingController ModuleSoldController = TextEditingController();
  TextEditingController ModuleSoldCriteriaController = TextEditingController();
  TextEditingController ModuleCleaningRemarkController =
      TextEditingController();

  // 13. Laminator
  TextEditingController LaminatorMonitoringFrequencyController =
      TextEditingController();
  TextEditingController LaminatorMonitoringController = TextEditingController();
  TextEditingController LaminatorMonitoringCriteriaController =
      TextEditingController();

  TextEditingController LaminatordiaFrequencyController =
      TextEditingController();
  TextEditingController LaminatordiaController = TextEditingController();
  TextEditingController LaminatordiaCriteriaController =
      TextEditingController();

  TextEditingController LaminatorPeelFrequencyController =
      TextEditingController();
  TextEditingController LaminatorPeelController = TextEditingController();
  TextEditingController LaminatorPeelCriteriaController =
      TextEditingController();
  TextEditingController LaminatorComFrequencyController =
      TextEditingController();
  TextEditingController LaminatorConController = TextEditingController();
  TextEditingController LaminatorConCriteriaController =
      TextEditingController();

  TextEditingController LaminatorGelFrequencyController =
      TextEditingController();
  TextEditingController LaminatorGelController = TextEditingController();
  TextEditingController LaminatorGelCriteriaController =
      TextEditingController();

  TextEditingController LaminatorRemarkController = TextEditingController();
  TextEditingController referencePdfController = TextEditingController();
  // TextEditingController camera1Controller = TextEditingController();
  // TextEditingController camera2Controller = TextEditingController();

  // TextEditingController camera3Controller = TextEditingController();
  // TextEditingController camera4Controller = TextEditingController();
  // TextEditingController camera5Controller = TextEditingController();
  // TextEditingController camera6Controller = TextEditingController();

  // TextEditingController camera7Controller = TextEditingController();
  // TextEditingController camera8Controller = TextEditingController();
  // TextEditingController camera9Controller = TextEditingController();
  // TextEditingController camera10Controller = TextEditingController();

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
      selectedOption = 'Glass Loader',
      approvalStatus = "Approved",
      designation = '',
      token = '',
      WorkLocation = '',
      department = '';
  final _dio = Dio();
  List<ImageMetadata> _capturedImages = [];

  Response.Response? _response;
  List data = [];
  Map<String, String> imageMetaData = {};
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

  Future<void> _openCamera(
    TextEditingController controller,
    String imageKey,
    String type,
    String stage,
  ) async {
    if (controller.text.startsWith('http')) {
      // If it's already a URL, don't try to re-upload
      return;
    }
    try {
      final ImagePicker _picker = ImagePicker();

      // Open the camera and capture an image
      XFile? image = await _picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        final String currentDateTime =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

        // Compress the image
        final compressedImage = await _compressImage(File(image.path));

        setState(() {
          controller.text =
              compressedImage.path; // Display compressed image path

          // Check if the key already exists in the list
          int existingIndex = _capturedImages.indexWhere(
            (img) => img.imageKey == imageKey,
          );

          if (existingIndex != -1) {
            // Replace the existing entry with the new one
            _capturedImages[existingIndex] = ImageMetadata(
              imageKey: imageKey,
              imagePath: compressedImage.path,
              timestamp: currentDateTime,
              type: type,
              stage: stage,
            );
            print("🔄 Image Updated: $imageKey, $currentDateTime");
          } else {
            // Add a new entry if it doesn't exist
            _capturedImages.add(
              ImageMetadata(
                imageKey: imageKey,
                imagePath: compressedImage.path,
                timestamp: currentDateTime,
                type: type,
                stage: stage,
              ),
            );
            print("✅ Image Captured and Stored: $imageKey, $currentDateTime");
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Camera operation canceled')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error capturing image: $e')),
      );
    }
  }

  Future<XFile> _compressImage(File file) async {
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, // Original file path
      '${file.parent.path}/compressed_${file.uri.pathSegments.last}', // Compressed file path
      quality: 50, // Compression quality (0-100)
    );

    if (compressedImage == null) {
      throw Exception("Image compression failed");
    }

    return compressedImage;
  }

  Future<void> uploadImages(String prelamId) async {
    try {
      bool hasLocalImages =
          _capturedImages.any((image) => !image.imagePath.startsWith('http'));

      if (!hasLocalImages) {
        print("⚠️ No new images to upload. Skipping upload call.");
        Toast.show(
          "No new images to upload.",
          duration: Toast.lengthShort,
          gravity: Toast.center,
        );
        return;
      }
      var formData = FormData();

      // Add the PreLamDetailId (UUID)
      formData.fields.add(MapEntry('PreLamDetailId', prelamId));

      // Add images with their metadata
      for (var image in _capturedImages) {
        if (image.imagePath.startsWith('http')) {
          // Skip images already uploaded
          print("⏭️ Skipping already uploaded image: ${image.imagePath}");
          continue;
        }
        final bytes = await File(image.imagePath).readAsBytes();
        final fileName =
            '${image.imageKey}_${DateTime.now().microsecondsSinceEpoch}.jpg';

        // Add image binary
        formData.files.add(
          MapEntry(
            image.imageKey,
            MultipartFile.fromBytes(
              bytes,
              filename: fileName,
              contentType: MediaType('image', 'jpeg'),
            ),
          ),
        );

        // Add image metadata
        formData.fields
            .add(MapEntry('${image.imageKey}_timestamp', image.timestamp));
        formData.fields.add(MapEntry('${image.imageKey}_type', image.type));
        formData.fields.add(MapEntry('${image.imageKey}_stage', image.stage));
      }

      // Debug payload
      print("🚀 Payload Details:");
      print("Fields:");
      for (var field in formData.fields) {
        print("  ${field.key}: ${field.value}");
      }

      print("Files:");
      for (var file in formData.files) {
        print("  ${file.key}: ${file.value.filename}");
      }

      final url = '${site}IPQC/PreLamUploadImage';
      var response = await _dio.post(
        url,
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          followRedirects: false,
          validateStatus: (status) => true,
        ),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        Toast.show("Images uploaded successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.blueColor);

        setState(() {
          _capturedImages.clear(); // Clear the array after successful upload
        });
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (err) {
      print("❌ Error uploading images: $err");
      Toast.show("Error uploading images.",
          duration: Toast.lengthLong, gravity: Toast.center);
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
      // 1. Glass Loader
      glassFrequController.text = "Once a Shift";
      glassAccepController.text = "As per Production order";

      glass1FrequController.text = "Once a Shift";
      glassAccep1Controller.text = "As per Production order";
      // Shop Floor
      shopAccepController.text = "Temp. 25±2°C";
      shop1AccepController.text = "RH ≤60%";
      shopFreController.text = "Once a Shift";
      shopFreq1Controller.text = "Once a Shift";

      // 2. Glass side EVA Cutting
      evaFreqController.text = "Once a Shift";
      evaAccepController.text = "As per Production order";
      evaFreq1Controller.text = "Once a Shift";
      evaAccep1Controller.text = "As per Production order";

      evaFreq2Controller.text = "Once a Shift";
      evaAccep2Controller.text =
          "Not allowed dust & foreign particle/Cut & non Uniform Embossing /Mfg Date";

      // 4. Cell Cutting Machine
      cellCuttingFreqController.text = "Once a Shift";
      cellCuttingFreq1Controller.text = "Once a Shift";

      cellCuttingFreq2Controller.text = "Once a Shift";
      cellCuttingFreq3Controller.text = "Once a Shift";

      cellCuttingFreq4Controller.text = "Once a Shift";
      cellCuttingFreq5Controller.text = "1 String/Stringer/ shift";

      cellCuttingFreq6Controller.text = "1 String/Stringer/ shift";
      cellCuttingAccepController.text = "Refer Production order";
      cellCuttingAccep1Controller.text = "Refer Production order";
      cellCuttingAccep2Controller.text =
          "Free From dust,finger spot,color variation";
      cellCuttingAccep3Controller.text =
          "No unwanted or waste material should be at Cell Loading Area";
      cellCuttingAccep4Controller.text = "As per machine specification ";
      cellCuttingCellAccepController.text =
          "Refer Production order & Module Drawing";
      // 6. Tabber & Stringer
      tabberFreq1Controller.text = "Once per Shift";
      tabberFreq2Controller.text = "1 String/TS shift";
      tabberFreq3Controller.text = "1 String/TS/shift";
      tabberFreq4Controller.text = "1 cell from all Stringe per Shift";

      tabberAccep1Controller.text = "As per machine specification";
      tabberAccep2Controller.text = "As per pre Lam Visual Criteria";
      tabberAccep3Controller.text = "As per pre Lam EL Criteria";
      tabberAccep4Controller.text = "Peel Strength ≥1N";
      // 7. Auto String Layup
      autoStrFreq1Controller.text = "Once per Shift";
      autoStrFreq2Controller.text = "None";

      autoStrAccepController.text = "Refer Production order & Module Drawing";
      autoStrAccep2Controller.text = "Refer Production order & Module Drawing";
      // 8. Auto Bussing & Tapping
      autobussFreq1Controller.text = "Once per Shift";
      autobussFreq2Controller.text = "Once per Shift";

      autobussFreq3Controller.text = "Every 4h per shift";
      autobussFreq4Controller.text = "Every 4h per shift";

      autobussFreq5Controller.text = "Every 4h per shift";
      autobussFreq6Controller.text = "Every 4h per shift";

      autobussAccep1Controller.text = "≥4N";
      autobussAccep2Controller.text = "Refer Production order & Module Drawing";

      autobussAccep3Controller.text = "No Dry/Poor Soldering";
      autobussAccep4Controller.text = "Creepage distance should be 14±1mm";

      autobussAccep5Controller.text =
          "Taping should be proper,no Cell Shifting allowed";
      autobussAccep6Controller.text =
          "Should not be tilt,Busbar should not visible";

      // 9. EVA/Backsheet Cutting
      EvaFreq1Controller.text = "Once per Shift";
      // EvaFreq2Controller.text = "Once per Shift";

      EvaFreq3Controller.text = "Once per Shift";
      EvaAccep1Controller.text =
          "As per specification GSPL/EVA(IQC)/001 & Production order";

      // EvaAccep2Controller.text =
      //     "As per specification GSPL/BS(IQC)/001 & Production order";
      EvaAccep3Controller.text =
          "Not allowed dust & foreign particle,Shifting of EVA,Backsheet/Cut & non Uniform Embossing /Mfg Date";

      EvaFreq3bController.text = "Once per Shift";
      EvaAccep2bController.text =
          "As per specification GSPL/BS(IQC)/001 & Production order";

      EvaAccep2bController.text =
          "As per specification GSPL/BS(IQC)/001 & Production order";
      EvaAccep3bController.text =
          "Not allowed dust & foreign particle,Shifting of EVA,Backsheet/Cut & non Uniform Embossing /Mfg Date";
      // 10. Pre Lamination El & Visual inspection
      PreFreq1Controller.text = "5 Pieces Per Shift ";
      PreFreq2Controller.text = "5 Pieces Per Shift ";

      PreAccep1Controller.text =
          "EL image should fullfil the EL Acceptance Criteria GSPL/EL/001";
      PreAccep2Controller.text =
          "Visiual image should  fullfill the visual acceptance criteria as per GSPL/ELV/001";
      // String Rework Station
      StringCleaningFrequencyController.text = "Once per Shift";
      StringSoldFrequencyController.text = "Once per Shift";

      StringCleaningCriteriaController.text =
          "Rework Station should be Clean/Sponge should be Wet";
      StringSoldCriteriaController.text = "400±30°C";

      // 12. Module Rework Station
      ModuleMethodCleaningFrequencyController.text = "Once per Shift";
      ModuleCleaningofReworkFrequencyController.text = "Once per Shift";
      ModuleSoldFrequencyController.text = "Once per Shift";
      ModuleMethodCleaningCriteriaController.text =
          "As per WI (GSPL/QA/WI/009)";

      ModuleCleaningofReworkCriteriaController.text =
          "Rework Station should be Clean/Sponge should be Wet";
      ModuleSoldCriteriaController.text = "400±30°C";

      // 13. Laminator
      LaminatorMonitoringFrequencyController.text = "Once per Shift";
      LaminatorMonitoringCriteriaController.text =
          "As per Laminator Specification GSPL/QA/SG/07GSPL/QA/S/08";

      LaminatordiaFrequencyController.text = "Once per 24h";
      LaminatordiaCriteriaController.text =
          "Diaphragm/Release sheet should be clean,No EVA residue is allowed";

      LaminatorPeelFrequencyController.text =
          "All Position | All laminators to be coverd in a month";
      LaminatorPeelCriteriaController.text = "E/G ≥70N/cm E/B≥40N/cm";

      LaminatorGelFrequencyController.text =
          " All Position | All laminators to be coverd in a month ";
      LaminatorGelCriteriaController.text = "75 to 95% ";
      LaminatorComFrequencyController.text = "Once per Shift";
      LaminatorConCriteriaController.text = "25000 Cycle";
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
      WorkLocation = prefs.getString('workLocation')!;
    });
    _get();
  }

  Future<void> _get() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site')!;
    });

    final allSolarData = await http.post(
      Uri.parse('${site!}IPQC/GetSpecificPreLam'),
      body: jsonEncode(
          <String, String>{"JobCardDetailId": widget.id ?? '', "token": token}),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    setState(() {
      _isLoading = false;
    });

    var responseData = json.decode(allSolarData.body);

    print("ressssss");
    print(responseData);

    if (mounted) {
      setState(() {
        if (responseData != '') {
          print("resssssskkk");
          print(responseData['Status']);
          // Basic Information
          status = responseData['response']['Status'] ?? '';
          dateOfQualityCheck = responseData['response']['Date'] ?? '';
          DayController.text = responseData['response']['Date'] != ''
              ? DateFormat("EEE MMM dd, yyyy")
                  .format(DateTime.parse(responseData['response']['Date']))
              : '';
          selectedShift = responseData['response']['Shift'] ?? '';
          lineController.text = responseData['response']['Line'] ?? '';
          PoController.text = responseData['response']['PONo'] ?? '';

          // WorkLocation = responseData['data']['WorkLocation'] ?? '';
          // Shop Floor
          shopTempController.text = responseData['response']
                  ['ShopFloorCheckPoint']["Temprature"] ??
              '';
          shopHumidityController.text =
              responseData['response']['ShopFloorCheckPoint']["Humdity"] ?? '';
          shopRemarkController.text =
              responseData['response']['ShopFloorRemark'] ?? '';
          // Glass Loader
          glassDimenController.text = responseData['response']
                      ['GlassLoaderCheckPoint']
                  ["Glass dimension(LengthxWidthxThickness)"] ??
              '';
          glassRemarkController.text =
              responseData['response']['GlassLoaderRemark'] ?? '';

          // Auto Bussing & Tapping
          final autoBussingData =
              responseData['response']['AutoBussing&TappingCheckPoint'] ?? {};
          autobussSoldController.text = autoBussingData[
                  'Soldering Peel strength between Ribbon to bushbar interconnector'] ??
              '';
          autobussTermController.text =
              autoBussingData['Terminal busbar to edge of cell'] ?? '';
          autobussSol1Controller.text =
              autoBussingData['Soldering quality of Ribbon to busbar1'] ?? '';

          autobussSol2Controller.text =
              autoBussingData['Soldering quality of Ribbon to busbar2'] ?? '';
          autobussSol3Controller.text =
              autoBussingData['Soldering quality of Ribbon to busbar3'] ?? '';
          autobussSol4Controller.text =
              autoBussingData['Soldering quality of Ribbon to busbar4'] ?? '';
          autobusstop1Controller.text = autoBussingData[
                  'Top & Butttom Crepage distance/Terminal busbar to Glass Edge1'] ??
              '';
          autobusstop2Controller.text = autoBussingData[
                  'Top & Butttom Crepage distance/Terminal busbar to Glass Edge2'] ??
              '';
          autobusstop3Controller.text = autoBussingData[
                  'Top & Butttom Crepage distance/Terminal busbar to Glass Edge3'] ??
              '';
          autobusstop4Controller.text = autoBussingData[
                  'Top & Butttom Crepage distance/Terminal busbar to Glass Edge4'] ??
              '';
          autobussQul1Controller.text =
              autoBussingData['quality of auto taping1'] ?? '';
          autobussQul2Controller.text =
              autoBussingData['quality of auto taping2'] ?? '';
          autobussQul3Controller.text =
              autoBussingData['quality of auto taping3'] ?? '';
          autobussQul4Controller.text =
              autoBussingData['quality of auto taping4'] ?? '';
          autobussPos1Controller.text = autoBussingData[
                  'Position verification of RFID& Logo Patch on Module1'] ??
              '';
          autobussPos2Controller.text = autoBussingData[
                  'Position verification of RFID& Logo Patch on Module2'] ??
              '';
          autobussPos3Controller.text = autoBussingData[
                  'Position verification of RFID& Logo Patch on Module3'] ??
              '';
          autobussPos4Controller.text = autoBussingData[
                  'Position verification of RFID& Logo Patch on Module4'] ??
              '';
          autobussRemarkController.text =
              responseData['response']['AutoBussing&TappingRemark'] ?? '';

          // EVA/POE Cutting
          final evaPOEData =
              responseData['response']['EVA/POECuttingCheckPoint'] ?? {};
          evaTypeController.text = evaPOEData['EVA_Type'] ?? '';
          evaDimenController.text =
              evaPOEData['EVA dimension{LengthxWidthxThickness}'] ?? '';
          evaStatusController.text = evaPOEData['EVA_POE_Status'] ?? '';
          evaRemarkController.text =
              responseData['response']['EVA/POECuttingRemark'] ?? '';

          // Second glass Loader
          final glassbackData =
              responseData['response']['GlassLoader_BackSheetCheckPoint'] ?? {};
          glassDimen1Controller.text =
              glassbackData['Glass dimension(LengthxWidthxThickness)'] ?? '';
          EvaBackbController.text =
              glassbackData['Back-sheet dimension & slit cutting diameter'] ??
                  '';
          selectedOption = glassbackData['selectedOption'] ?? '';
          EvaPOEbController.text =
              glassbackData['EVA/POE/backsheet Status'] ?? '';
          glassRemark1Controller.text =
              responseData['response']['GlassLoader_BackSheetRemark'] ?? '';

          // Cell Cutting Machine & Loading
          final cellCuttingData = responseData['response']
                  ['CellCuttingMachine&CellLoadingCheckPoint'] ??
              {};
          cellCuttingMenuController.text =
              cellCuttingData['Cell Manufacture & Eff'] ?? '';
          cellCuttingSizeController.text =
              cellCuttingData['Cell Size(L*W)'] ?? '';
          cellCuttingCondiController.text =
              cellCuttingData['Cell Condition'] ?? '';
          cellCuttingCleanController.text =
              cellCuttingData['Cleanliness of Cell Loading Area'] ?? '';
          cellCuttingVerifiController.text =
              cellCuttingData['Verification of Process Parameter'] ?? '';

          // String Length
          cellCuttingString1Controller.text =
              cellCuttingData['String Length1'] ?? '';
          cellCuttingString2Controller.text =
              cellCuttingData['String Length2'] ?? '';
          cellCuttingString3Controller.text =
              cellCuttingData['String Length3'] ?? '';
          cellCuttingString4Controller.text =
              cellCuttingData['String Length4'] ?? '';

          // Cell Gap
          cellCuttingCell1Controller.text =
              cellCuttingData['cell To Cell Gap1'] ?? '';
          cellCuttingCell2Controller.text =
              cellCuttingData['cell To Cell Gap2'] ?? '';
          cellCuttingCell3Controller.text =
              cellCuttingData['cell To Cell Gap3'] ?? '';
          cellCuttingCell4Controller.text =
              cellCuttingData['cell To Cell Gap4'] ?? '';
          cellCuttingCell4Controller.text =
              cellCuttingData['cell To Cell Gap4'] ?? '';
          cellCuttingCellRemarkController.text = responseData['response']
                  ['CellCuttingMachine&CellLoadingRemark'] ??
              '';

          // Tabber And Stringer
          tabberVerifController.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Veification of Process Parameter'] ??
              '';
          tabbervisual1Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Visual Check after stringer1'] ??
              '';
          tabbervisual2Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Visual Check after stringer2'] ??
              '';
          tabbervisual3Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Visual Check after stringer3'] ??
              '';
          tabbervisual4Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Visual Check after stringer4'] ??
              '';
          tabberEL1Controller.text = responseData['response']
                  ['Tabber&StringerCheckPoint']['EI image of strings1'] ??
              '';
          tabberEL2Controller.text = responseData['response']
                  ['Tabber&StringerCheckPoint']['EI image of strings2'] ??
              '';
          tabberEL3Controller.text = responseData['response']
                  ['Tabber&StringerCheckPoint']['EI image of strings3'] ??
              '';
          tabberEL4Controller.text = responseData['response']
                  ['Tabber&StringerCheckPoint']['EI image of strings4'] ??
              '';
          veri1Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Verification of sildering peel strength1'] ??
              '';
          veri2Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Verification of sildering peel strength2'] ??
              '';
          veri3Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Verification of sildering peel strength3'] ??
              '';
          veri4Controller.text = responseData['response']
                      ['Tabber&StringerCheckPoint']
                  ['Verification of sildering peel strength1'] ??
              '';
          tabberRemarkController.text =
              responseData['response']['Tabber&StringerRemark'] ?? '';
          // Auto String Layup
          autoStrGapController.text = responseData['response']
                  ['AutoStringLayupCheckPoint']['String to string gap'] ??
              '';
          autoStrCellController.text = responseData['response']
                  ['AutoStringLayupCheckPoint']['Cell edge to glass edge'] ??
              '';
          autoStrRemark2Controller.text =
              responseData['response']['AutoStringLayupRemark'] ?? '';
          // EVA/EPE/Backsheet Cutting
          EvaRearController.text = responseData['response']
                      ['EVA/EPE/BacksheetcuttingCheckPoint']
                  ['Rear EVA dimension & slit cutting diameter(mm)'] ??
              '';
          // EvaBackController.text = responseData['response']
          //             ['EVA/EPE/BacksheetcuttingCheckPoint']
          //         ['Back-sheet dimension & slit cutting diameter'] ??
          //     '';
          EvaPOEController.text = responseData['response']
                      ['EVA/EPE/BacksheetcuttingCheckPoint']
                  ['EVA/POE/backsheet Status'] ??
              '';
          EvaRemarkController.text =
              responseData['response']['EVA/EPE/BacksheetcuttingRemark'] ?? '';

          // Pre-lamination EL & Visual Inspection
          final prelamData = responseData['response']
                  ['PrelaminationEL&VisualInspectionCheckPoint'] ??
              {};
          PreEL1Controller.text = prelamData['EL Inspection1'] ?? '';
          PreEL2Controller.text = prelamData['EL Inspection2'] ?? '';
          PreEL3Controller.text = prelamData['EL Inspection3'] ?? '';
          PreEL4Controller.text = prelamData['EL Inspection4'] ?? '';
          PreEL5Controller.text = prelamData['EL Inspection5'] ?? '';
          PreVisul1Controller.text = prelamData['Visual inspection1'] ?? '';
          PreVisul2Controller.text = prelamData['Visual inspection2'] ?? '';
          PreVisul3Controller.text = prelamData['Visual inspection3'] ?? '';
          PreVisul4Controller.text = prelamData['Visual inspection4'] ?? '';
          PreVisul5Controller.text = prelamData['Visual inspection5'] ?? '';
          PreRemarkController.text = responseData['response']
                  ['PrelaminationEL&VisualInspectionRemark'] ??
              '';
          //String Rework Station

          StringCleaningController.text = responseData['response']
                      ['StringReworkstationCheckPoint']
                  ['Cleaning of Rework station/soldering iron sponge'] ??
              '';
          StringSoldController.text = responseData['response']
                  ['StringReworkstationCheckPoint']['Soldering Iron Temp'] ??
              '';
          StringReworkRemarkController.text =
              responseData['response']['StringReworkstationRemark'] ?? '';
          // Module ReWork Station
          ModuleMethodCleaningController.text = responseData['response']
                  ['ModuleReworkStationCheckPoint']['Method of Rework'] ??
              '';
          ModuleCleaningofReworkController.text = responseData['response']
                      ['ModuleReworkStationCheckPoint']
                  ['Cleaning of Rework station/soldering iron sponge'] ??
              '';

          ModuleSoldController.text = responseData['response']
                  ['ModuleReworkStationCheckPoint']['Soldering Iron Temp'] ??
              '';
          ModuleCleaningRemarkController.text =
              responseData['response']['ModuleReworkStationRemark'] ?? '';
          // Laminator
          LaminatorMonitoringController.text = responseData['response']
                      ['LaminatorCheckPoint']
                  ['Monitoring of Laminator Process parameter'] ??
              '';
          LaminatordiaController.text = responseData['response']
                      ['LaminatorCheckPoint']
                  ['Cleaning of Diaphragm/release sheet'] ??
              '';
          LaminatorConController.text = responseData['response']
                      ['LaminatorCheckPoint']
                  ['Consumable life of Diaphragm/release sheet'] ??
              '';
          LaminatorPeelController.text = responseData['response']
                      ['LaminatorCheckPoint']
                  ['Peel of Test b/w: EVA/GlassEVA/Backsheet'] ??
              '';
          LaminatorGelController.text = responseData['response']
                  ['LaminatorCheckPoint']['Gel Content Test'] ??
              '';
          LaminatorRemarkController.text =
              responseData['response']['LaminatorRemark'] ?? '';

          // Image Data Handling
          final imageDetails =
              responseData['response']['ImageDetails'] as List<dynamic>? ?? [];
          _capturedImages.clear();

          // Convert API image data to your ImageMetadata format
          for (var imageDetail in imageDetails) {
            _capturedImages.add(
              ImageMetadata(
                imageKey: imageDetail['ImageType'] ?? '',
                imagePath: imageDetail['ImageURL'] ?? '',
                timestamp: imageDetail['Timestamp'] ?? '',
                type: imageDetail['ImageType'] ?? '',
                stage:
                    'API Response', // Or any default stage value you want to use
              ),
            );
          }

          // Update image controllers based on type
          for (var image in _capturedImages) {
            switch (image.imageKey) {
              case 'temperature_image':
                shopCameraController.text = image.imagePath ?? '';
                break;
              case 'humidity_image':
                shopCamera1Controller.text = image.imagePath ?? '';
                break;
              case 'evaType_image':
                evaCamera1Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image1':
                cellCuttingStrCam1Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image2':
                cellCuttingStrCam2Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image3':
                cellCuttingStrCam3Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image4':
                cellCuttingStrCam4Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image5':
                cellCuttingCellCam1Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image6':
                cellCuttingCellCam2Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image7':
                cellCuttingCellCam3Controller.text = image.imagePath ?? '';
                break;
              case 'CellCutting_Image8':
                cellCuttingCellCam4Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image1':
                tabbervisualcam1Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image2':
                tabbervisualcam2Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image3':
                tabbervisualcam3Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image4':
                tabbervisualcam4Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image5':
                tabberELImageCam1Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image6':
                tabberELImageCam2Controller.text = image.imagePath ?? '';
                break;

              case 'Tabber_Image7':
                tabberELImageCam3Controller.text = image.imagePath ?? '';
                break;

              case 'Tabber_Image8':
                tabberELImageCam4Controller.text = image.imagePath ?? '';
                break;

              case 'Tabber_Image9':
                veriCam1Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image10':
                veriCam2Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image11':
                veriCam3Controller.text = image.imagePath ?? '';
                break;
              case 'Tabber_Image12':
                veriCam4Controller.text = image.imagePath ?? '';
                break;
              case 'autoBussing_image':
                autobussSoldCam1Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image1':
                PreELCam1Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image2':
                PreELCam2Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image3':
                PreELCam3Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image4':
                PreELCam4Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image5':
                PreELCam5Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image6':
                PreVisulCam1Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image7':
                PreVisulCam2Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image8':
                PreVisulCam3Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image9':
                PreVisulCam4Controller.text = image.imagePath ?? '';
                break;
              case 'preEl_Image10':
                PreVisulCam5Controller.text = image.imagePath ?? '';
                break;
              case 'soldering_image':
                soldCameraController.text = image.imagePath ?? '';
                break;
              case 'soldering_image1':
                modCameraController.text = image.imagePath ?? '';
                break;

              // Add cases for other image types as needed
            }
          }

          // Reference PDF
          referencePdfController.text =
              responseData['response']['PreLamPdf'] ?? '';
        }
      });
    }
  }

  Future setApprovalStatuss(prelamId) async {
    print("callllll");
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    final url = ("${site!}IPQC/UpdatePreLamStatus");

    var params = {
      "Type": "PreLam Baliyali",
      "token": token,
      "CurrentUser": personid,
      "ApprovalStatus": "Pending",
      "JobCardDetailId": prelamId ?? ""
    };
    print(params);
    var response = await http.post(
      Uri.parse(url),
      body: json.encode(params),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      print("callllllssss");
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
        Toast.show("Pre Lam Baliyali Test Complete",
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

  Future setApprovalStatus() async {
    setState(() {
      _isLoading = true;
    });
    FocusScope.of(context).unfocus();
    final url = ("${site!}IPQC/UpdatePreLamStatus");
    var params = {
      "Type": "PreLam Baliyali",
      "token": token,
      "CurrentUser": personid,
      "ApprovalStatus": approvalStatus,
      "JobCardDetailId": widget.id ?? ""
    };
    print({
      "Type": "Prelam Baliyali",
      "token": token,
      "CurrentUser": personid,
      "ApprovalStatus": approvalStatus,
      "JobCardDetailId": widget.id ?? ""
    });

    var response = await http.post(
      Uri.parse(url),
      body: json.encode(params),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);
    print("response.statusCode");

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
        Toast.show("Pre Lam Test Baliyali $approvalStatus .",
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

  // Future<void> _pickReferencePDF() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['pdf'],
  //   );

  //   if (result != null) {
  //     File pdffile = File(result.files.single.path!);
  //     setState(() {
  //       referencePdfFileBytes = pdffile.readAsBytesSync();
  //       referencePdfController.text = result.files.single.name;
  //     });
  //   } else {
  //     // User canceled the file picker
  //   }
  // }

  // uploadPDF(List<int> referenceBytes) async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final prefs = await SharedPreferences.getInstance();
  //   site = prefs.getString('site')!;

  //   var currentdate = DateTime.now().microsecondsSinceEpoch;
  //   var formData = FormData.fromMap({
  //     "JobCardDetailId": prelamId,
  //     "PreLamPdf": MultipartFile.fromBytes(
  //       referenceBytes,
  //       filename: ('${referencePdfController.text}$currentdate.pdf'),
  //       contentType: MediaType("application", 'pdf'),
  //     ),
  //   });
  //   _response = await _dio.post(('${site!}IPQC/UploadPreLamPdf'), // Prod

  //       options: Options(
  //         contentType: 'multipart/form-data',
  //         followRedirects: false,
  //         validateStatus: (status) => true,
  //       ),
  //       data: formData);

  //   try {
  //     if (_response?.statusCode == 200) {
  //       setState(() {
  //         _isLoading = false;
  //       });

  //       Toast.show("PreLam Test Completed.",
  //           duration: Toast.lengthLong,
  //           gravity: Toast.center,
  //           backgroundColor: AppColors.blueColor);
  //       Navigator.of(context).pushReplacement(MaterialPageRoute(
  //           builder: (BuildContext context) => IpqcTestList()));
  //     } else {
  //       Toast.show("Error In Server",
  //           duration: Toast.lengthLong, gravity: Toast.center);
  //     }
  //   } catch (err) {
  //     print("Error");
  //   }
  // }

  // **************  Send the Data where will be Used to Backend *****************

  Future sendDataToBackend() async {
    if (sendStatus == "Pending") {
      print("Inside");
      print(sendStatus);
      print(widget.id);
      setApprovalStatuss(prelamId != '' && prelamId != null
          ? prelamId
          : widget.id != '' && widget.id != null
              ? widget.id
              : '');
    }
    var data = [
      {
        "PreLamDetailId": prelamId != '' && prelamId != null
            ? prelamId
            : widget.id != '' && widget.id != null
                ? widget.id
                : '',
        "Type": "PreLam Baliyali",
        "CurrentUser": personid,
        "Status": sendStatus,
        "DocNo": "GSPL/IPQC/IPC/003",
        "RevNo": "1.0 dated 12.08.2023",
        "Date": dateOfQualityCheck,
        "WorkLocation": WorkLocation,
        "Shift": selectedShift,
        "Line": lineController.text,
        "PONo": PoController.text
      },
      [
        {
          "Stage": "Glass Loader",
          "CheckPoint": {
            "Glass dimension(LengthxWidthxThickness)":
                glassDimenController.text,
          },
          "AcceptanceCriteria": {
            "Glass dimension(LengthxWidthxThickness)":
                glassAccepController.text,
          },
          "Frequency": {
            "Glass dimension(LengthxWidthxThickness)":
                glassFrequController.text,
          },
          "Remark": glassRemarkController.text,
        },
        {
          "Stage": "Shop Floor",
          "CheckPoint": {
            "Temprature": shopTempController.text,
            "Humdity": shopHumidityController.text,
          },
          "AcceptanceCriteria": {
            "Temprature": shopAccepController.text,
            "Humdity": shop1AccepController.text,
          },
          "Frequency": {
            "Temprature": shopFreController.text,
            "Humdity": shopFreq1Controller.text,
          },
          "Remark": shopRemarkController.text
        },
        {
          "Stage": "EVA/POE Cutting",
          "CheckPoint": {
            "EVA_Type": evaTypeController.text,
            "EVA dimension{LengthxWidthxThickness}": evaDimenController.text,
            "EVA_POE_Status": evaStatusController.text,
          },
          "AcceptanceCriteria": {
            "EVA_Type": evaAccepController.text,
            "EVA dimension{LengthxWidthxThickness}": evaAccep1Controller.text,
            "EVA_POE_Status": evaAccep2Controller.text,
          },
          "Frequency": {
            "EVA_Type": evaFreqController.text,
            "EVA dimension{LengthxWidthxThickness}": evaFreq1Controller.text,
            "EVA_POE_Status": evaFreq2Controller.text,
          },
          "Remark": evaRemarkController.text
        },
        {
          "Stage": "Cell Cutting Machine & Cell Loading",
          "CheckPoint": {
            "Cell Manufacture & Eff": cellCuttingMenuController.text,
            "Cell Size(L*W)": cellCuttingSizeController.text,
            "Cell Condition": cellCuttingCondiController.text,
            "Cleanliness of Cell Loading Area": cellCuttingCleanController.text,
            "Verification of Process Parameter":
                cellCuttingVerifiController.text,
            "String Length1": cellCuttingString1Controller.text,
            "String Length2": cellCuttingString2Controller.text,
            "String Length3": cellCuttingString3Controller.text,
            "String Length4": cellCuttingString4Controller.text,
            "cell To Cell Gap1": cellCuttingCell1Controller.text,
            "cell To Cell Gap2": cellCuttingCell2Controller.text,
            "cell To Cell Gap3": cellCuttingCell3Controller.text,
            "cell To Cell Gap4": cellCuttingCell4Controller.text,
          },
          "AcceptanceCriteria": {
            // "cell Size": CellSizeCriteriaController.text,
            "Cell Manufacture & Eff": cellCuttingAccepController.text,
            "Cell Size(L*W)": cellCuttingAccep1Controller.text,

            "Cell Condition": cellCuttingAccep2Controller.text,
            "Cleanliness of Cell Loading Area":
                cellCuttingAccep3Controller.text,
            "Verification of Process Parameter":
                cellCuttingAccep4Controller.text,
            "String Length & cell To Cell Gap":
                cellCuttingCellAccepController.text,
          },
          "Frequency": {
            // "cell Size": CellSizeFrequencyController.text,
            "Cell Manufacture & Eff": cellCuttingFreqController.text,
            "Cell Size(L*W)": cellCuttingFreq1Controller.text,

            "Cell Condition": cellCuttingFreq2Controller.text,
            "Cleanliness of Cell Loading Area": cellCuttingFreq3Controller.text,
            "Verification of Process Parameter":
                cellCuttingFreq4Controller.text,
            "String Length & cell To Cell Gap": cellCuttingFreq5Controller.text,
          },
          "Remark": cellCuttingCellRemarkController.text,
        },
        {
          "Stage": "Tabber & Stringer",
          "CheckPoint": {
            "Veification of Process Parameter": tabberVerifController.text,
            "Visual Check after stringer1": tabbervisual1Controller.text,
            "Visual Check after stringer2": tabbervisual2Controller.text,
            "Visual Check after stringer3": tabbervisual3Controller.text,
            "Visual Check after stringer4": tabbervisual4Controller.text,
            "EI image of strings1": tabberEL1Controller.text,
            "EI image of strings2": tabberEL2Controller.text,
            "EI image of strings3": tabberEL3Controller.text,
            "EI image of strings4": tabberEL4Controller.text,
            "Verification of sildering peel strength1": veri1Controller.text,
            "Verification of sildering peel strength2": veri2Controller.text,
            "Verification of sildering peel strength3": veri3Controller.text,
            "Verification of sildering peel strength4": veri4Controller.text,
          },
          "AcceptanceCriteria": {
            "Veification of Process Parameter": tabberAccep1Controller.text,
            "Visual Check after stringer": tabberAccep2Controller.text,
            "EI image of strings": tabberAccep3Controller.text,
            "Verification of sildering peel strength":
                tabberAccep4Controller.text,
          },
          "Frequency": {
            "Veification of Process Parameter": tabberFreq1Controller.text,
            "Visual Check after stringer": tabberFreq2Controller.text,
            "EI image of strings": tabberFreq3Controller.text,
            "Verification of sildering peel strength":
                tabberFreq4Controller.text,
          },
          "Remark": tabberRemarkController.text
        },
        {
          "Stage": "Auto String Layup",
          "CheckPoint": {
            "String to string gap": autoStrGapController.text,
            "Cell edge to glass edge": autoStrCellController.text,
          },
          "AcceptanceCriteria": {
            "String to string gap": autoStrAccepController.text,
            "Cell edge to glass edge": autoStrAccep2Controller.text,
          },
          "Frequency": {
            "String to string gap": autoStrFreq1Controller.text,
            "Cell edge to glass edge": autoStrFreq1Controller.text,
          },
          "Remark": autoStrRemark2Controller.text
        },
        {
          "Stage": "Auto Bussing & Tapping",
          "CheckPoint": {
            "Soldering Peel strength between Ribbon to bushbar interconnector":
                autobussSoldController.text,
            "Terminal busbar to edge of cell": autobussTermController.text,
            "Soldering quality of Ribbon to busbar1":
                autobussSol1Controller.text,
            "Soldering quality of Ribbon to busbar2":
                autobussSol2Controller.text,
            "Soldering quality of Ribbon to busbar3":
                autobussSol3Controller.text,
            "Soldering quality of Ribbon to busbar4":
                autobussSol4Controller.text,
            "Top & Butttom Crepage distance/Terminal busbar to Glass Edge1":
                autobusstop1Controller.text,
            "Top & Butttom Crepage distance/Terminal busbar to Glass Edge2":
                autobusstop3Controller.text,
            "Top & Butttom Crepage distance/Terminal busbar to Glass Edge3":
                autobusstop3Controller.text,
            "Top & Butttom Crepage distance/Terminal busbar to Glass Edge4":
                autobusstop4Controller.text,
            "quality of auto taping1": autobussQul1Controller.text,
            "quality of auto taping2": autobussQul2Controller.text,
            "quality of auto taping3": autobussQul3Controller.text,
            "quality of auto taping4": autobussQul4Controller.text,
            "Position verification of RFID& Logo Patch on Module1":
                autobussPos1Controller.text,
            "Position verification of RFID& Logo Patch on Module2":
                autobussPos2Controller.text,
            "Position verification of RFID& Logo Patch on Module3":
                autobussPos3Controller.text,
            "Position verification of RFID& Logo Patch on Module4":
                autobussPos4Controller.text,
          },
          "AcceptanceCriteria": {
            "Soldering Peel strength between Ribbon to bushbar interconnector":
                autobussAccep1Controller.text,
            "Terminal busbar to edge of cell": autobussAccep2Controller.text,
            "Soldering quality of Ribbon to busbar ":
                autobussAccep3Controller.text,
            "Top & Bottom Creepage Distance/Terminal busbar to Edge of Glass":
                autobussAccep4Controller.text,
            "quality of auto taping": autobussAccep5Controller.text,
            "Position verification of RFID& Logo Patch on Module":
                autobussAccep6Controller.text,
          },
          "Frequency": {
            "Soldering Peel strength between Ribbon to bushbar interconnector":
                autobussFreq1Controller.text,
            "Terminal busbar to edge of cell": autobussFreq2Controller.text,
            "Soldering quality of Ribbon to busbar ":
                autobussFreq3Controller.text,
            "Top & Bottom Creepage Distance/Terminal busbar to Edge of Glass":
                autobussFreq4Controller.text,
            "quality of auto taping": autobussFreq5Controller.text,
            "Position verification of RFID& Logo Patch on Module":
                autobussFreq6Controller.text,
          },
          "Remark": autobussRemarkController.text
        },
        {
          "Stage": "EVA/EPE/Backsheet cutting",
          "CheckPoint": {
            "Rear EVA dimension & slit cutting diameter(mm)":
                EvaRearController.text,
            // "Back-sheet dimension & slit cutting diameter":
            //     EvaBackController.text,
            "EVA/POE/backsheet Status": EvaPOEController.text,
          },
          "AcceptanceCriteria": {
            "Rear EVA dimension & slit cutting diameter(mm)":
                EvaAccep1Controller.text,
            // "Back-sheet dimension & slit cutting diameter":
            //     EvaAccep2Controller.text,
            "EVA/POE/backsheet Status": EvaAccep3Controller.text,
          },
          "Frequency": {
            "Rear EVA dimension & slit cutting diameter(mm)":
                EvaFreq1Controller.text,
            // "Back-sheet dimension & slit cutting diameter":
            //     EvaFreq2Controller.text,
            "EVA/POE/backsheet Status": EvaFreq3Controller.text,
          },
          "Remark": EvaRemarkController.text
        },
        {
          "Stage": "Glass Loader_BackSheet",
          "CheckPoint": {
            "selectedOption": selectedOption,
            "Glass dimension(LengthxWidthxThickness)":
                glassDimen1Controller.text,
            "Back-sheet dimension & slit cutting diameter":
                EvaBackbController.text,
            "EVA/POE/backsheet Status": EvaPOEbController.text,
          },
          "AcceptanceCriteria": {
            "Glass dimension(LengthxWidthxThickness)":
                glassAccep1Controller.text,
            "Back-sheet dimension & slit cutting diameter":
                EvaAccep2bController.text,
            "EVA/POE/backsheet Status": EvaAccep3bController.text,
          },
          "Frequency": {
            "Glass dimension(LengthxWidthxThickness)":
                glass1FrequController.text,
            "Back-sheet dimension & slit cutting diameter":
                EvaFreq2bController.text,
            "EVA/POE/backsheet Status": EvaFreq3bController.text,
          },
          "Remark": glassRemark1Controller.text,
        },
        {
          "Stage": "Pre lamination EL & Visual Inspection",
          "CheckPoint": {
            "EL Inspection1": PreEL1Controller.text,
            "EL Inspection2": PreEL2Controller.text,
            "EL Inspection3": PreEL3Controller.text,
            "EL Inspection4": PreEL4Controller.text,
            "EL Inspection5": PreEL5Controller.text,
            "Visual inspection1": PreVisul1Controller.text,
            "Visual inspection2": PreVisul2Controller.text,
            "Visual inspection3": PreVisul3Controller.text,
            "Visual inspection4": PreVisul4Controller.text,
            "Visual inspection5": PreVisul5Controller.text,
          },
          "AcceptanceCriteria": {
            "EL Inspection": PreAccep1Controller.text,
            "Visual inspection": PreAccep2Controller.text,
          },
          "Frequency": {
            "EL Inspection": PreFreq1Controller.text,
            "Visual inspection": PreFreq2Controller.text,
          },
          "Remark": PreRemarkController.text,
        },
        {
          "Stage": "String Rework station",
          "CheckPoint": {
            "Cleaning of Rework station/soldering iron sponge":
                StringCleaningController.text,
            "Soldering Iron Temp": StringSoldController.text,
          },
          "AcceptanceCriteria": {
            "Cleaning of Rework station/soldering iron sponge":
                StringCleaningCriteriaController.text,
            "Soldering Iron Temp": StringSoldCriteriaController.text,
          },
          "Frequency": {
            "Cleaning of Rework station/soldering iron sponge":
                StringCleaningFrequencyController.text,
            "Soldering Iron Temp": StringSoldFrequencyController.text,
          },
          "Remark": StringReworkRemarkController.text
        },
        {
          "Stage": "Module Rework Station",
          "CheckPoint": {
            "Method of Rework": ModuleMethodCleaningController.text,
            "Cleaning of Rework station/soldering iron sponge":
                ModuleCleaningofReworkController.text,
            "Soldering Iron Temp": ModuleSoldController.text,
          },
          "AcceptanceCriteria": {
            "Method of Rework": ModuleMethodCleaningCriteriaController.text,
            "Cleaning of Rework station/soldering iron sponge":
                ModuleCleaningofReworkCriteriaController.text,
            "Soldering Iron Temp": ModuleSoldCriteriaController.text,
          },
          "Frequency": {
            "Method of Rework": ModuleMethodCleaningFrequencyController.text,
            "Cleaning of Rework station/soldering iron sponge":
                ModuleCleaningofReworkFrequencyController.text,
            "Soldering Iron Temp": ModuleSoldFrequencyController.text,
          },
          "Remark": ModuleCleaningRemarkController.text
        },
        {
          "Stage": "Laminator",
          "CheckPoint": {
            "Monitoring of Laminator Process parameter":
                LaminatorMonitoringController.text,
            "Cleaning of Diaphragm/release sheet": LaminatordiaController.text,
            "Consumable life of Diaphragm/release sheet":
                LaminatorConController.text,
            "Peel of Test b/w: EVA/GlassEVA/Backsheet":
                LaminatorPeelController.text,
            "Gel Content Test": LaminatorGelController.text,
          },
          "AcceptanceCriteria": {
            "Monitoring of Laminator Process parameter":
                LaminatorMonitoringCriteriaController.text,
            "Cleaning of Diaphragm/release sheet":
                LaminatordiaCriteriaController.text,
            "Consumable life of Diaphragm/release sheet":
                LaminatorConCriteriaController.text,
            "Peel of Test b/w: EVA/GlassEVA/Backsheet":
                LaminatorPeelCriteriaController.text,
            "Gel Content Test": LaminatorGelCriteriaController.text,
          },
          "Frequency": {
            "Monitoring of Laminator Process parameter":
                LaminatorMonitoringFrequencyController.text,
            "Cleaning of Diaphragm/release sheet":
                LaminatordiaFrequencyController.text,
            "Consumable life of Diaphragm/release sheet":
                LaminatorComFrequencyController.text,
            "Peel of Test b/w: EVA/GlassEVA/Backsheet":
                LaminatorPeelFrequencyController.text,
            "Gel Content Test": LaminatorGelFrequencyController.text,
          },
          "Remark": LaminatorRemarkController.text
        },
      ]
    ];
    setState(() {
      _isLoading = true;
    });
    print('teeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    print(data);
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site')!;
    FocusScope.of(context).unfocus();

    final url = (site! + "IPQC/AddPreLam");
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
      print(objData['Status']);

      if (objData['success'] == false) {
        Toast.show(objData['message'],
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.redColor);
      } else {
        if (_capturedImages.isNotEmpty) {
          await uploadImages(prelamId); // Pass the UUID and upload images
        }
        if (sendStatus == 'Pending') {
          // uploadPDF((referencePdfFileBytes ?? []));
          Toast.show("PreLam Test Completed.",
              duration: Toast.lengthLong,
              gravity: Toast.center,
              backgroundColor: AppColors.blueColor);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => IpqcTestList()));
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
                                        child: Text(
                                            "(Pre Lam Baliyali Checklist )",
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
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText: "Please Enter Date",
                                          ),
                                        ],
                                      ),
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
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText: "Please Enter Line.",
                                          ),
                                        ],
                                      ),
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
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText: "Please Po Number",
                                          ),
                                        ],
                                      ),
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
                                          fillColor: Color.fromARGB(
                                              255, 215, 243, 207),
                                        ),
                                        style: AppStyles.textInputTextStyle,
                                        readOnly: status == 'Pending' &&
                                                designation != "QC"
                                            ? true
                                            : false,
                                        validator: MultiValidator(
                                          [
                                            RequiredValidator(
                                              errorText:
                                                  "Please Enter Temperature",
                                            ),
                                          ],
                                        )),

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
                                            if (status != 'Pending' &&
                                                shopCameraController
                                                    .text.isEmpty) {
                                              await _openCamera(
                                                  shopCameraController,
                                                  'temperature_image',
                                                  'Temprature',
                                                  'Shop Floor');
                                            }
                                          },
                                          icon: const Icon(Icons.camera_alt),
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      readOnly: true,
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText: "Please Click Picture ",
                                          ),
                                        ],
                                      ),
                                      enabled: !(widget.id != null &&
                                          widget.id != '' &&
                                          shopCameraController.text
                                              .isNotEmpty), // Disable the entire field if conditions are met
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
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText:
                                                "Please Enter Correct Humidity ",
                                          ),
                                        ],
                                      ),
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
                                                  shopCamera1Controller,
                                                  'humidity_image',
                                                  'Humidity',
                                                  'Shop Floor');
                                            }
                                          },
                                          icon: const Icon(Icons.camera_alt),
                                        ),
                                        border: const OutlineInputBorder(),
                                      ),
                                      readOnly: true,
                                      validator: MultiValidator(
                                        [
                                          RequiredValidator(
                                            errorText: "Please Click Picture ",
                                          ),
                                        ],
                                      ),
                                      enabled: !(widget.id != null &&
                                          widget.id != '' &&
                                          shopCamera1Controller
                                              .text.isNotEmpty),
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
                                      //       errorText: "Please Enter Remark",
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
                                          hintText:
                                              "Enter the Glass Dimension ",
                                          counterText: '',
                                          fillColor: Color.fromARGB(
                                              255, 215, 243, 207),
                                        ),
                                        style: AppStyles.textInputTextStyle,
                                        readOnly: status == 'Pending' &&
                                                designation != "QC"
                                            ? true
                                            : false,
                                        validator: MultiValidator(
                                          [
                                            RequiredValidator(
                                              errorText:
                                                  "Please Enter Glass Dimension",
                                            ),
                                          ],
                                        )),

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
                                      //       errorText: "Please Enter Remark",
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
                                              // if (status != 'Pending') {
                                              //   setState(() {
                                              //     sendStatus = 'Inprogress';
                                              //   });
                                              //   // sendDataToBackend();

                                              //   // uploadImages();
                                              // }
                                              _preLamFormKey.currentState!.save;
                                              if (_preLamFormKey.currentState!
                                                  .validate()) {
                                                if (status != 'Pending') {
                                                  setState(() {
                                                    sendStatus = 'Inprogress';
                                                    // setPage = "glassSide";
                                                  });
                                                  sendDataToBackend();

                                                  // uploadImages();
                                                }

                                                // sendDataToBackend();
                                                setState(() {
                                                  setPage = "glassSide";
                                                });
                                              }
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
                                          validator: MultiValidator(
                                            [
                                              RequiredValidator(
                                                errorText:
                                                    "Please Enter Correct  EVA Type..",
                                              ),
                                            ],
                                          ),
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
                                          controller: evaCamera1Controller,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Please Capture a EVA Picture",
                                            counterText: '',
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            suffixIcon: IconButton(
                                              onPressed: () async {
                                                if (status != 'Pending') {
                                                  await _openCamera(
                                                      evaCamera1Controller,
                                                      'evaType_image',
                                                      "EVA Type",
                                                      'EVA/POE Cutting');
                                                }
                                              },
                                              icon:
                                                  const Icon(Icons.camera_alt),
                                            ),
                                            border: const OutlineInputBorder(),
                                          ),
                                          readOnly: true,
                                          validator: MultiValidator(
                                            [
                                              RequiredValidator(
                                                errorText:
                                                    "Please Click Picture ",
                                              ),
                                            ],
                                          ),
                                          enabled: !(widget.id != null &&
                                              widget.id != '' &&
                                              evaCamera1Controller
                                                  .text.isNotEmpty),
                                        ),
                                        SizedBox(
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
                                          validator: MultiValidator(
                                            [
                                              RequiredValidator(
                                                errorText:
                                                    "Please Enter Correct EVA Dimension",
                                              ),
                                            ],
                                          ),
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
                                          validator: MultiValidator(
                                            [
                                              RequiredValidator(
                                                errorText:
                                                    "Please Enter Correct EVA/POE Status",
                                              ),
                                            ],
                                          ),
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
                                                  // if (status != 'Pending') {
                                                  //   setState(() {
                                                  //     sendStatus = 'Inprogress';
                                                  //   });
                                                  //   // sendDataToBackend();
                                                  // }

                                                  _preLamFormKey
                                                      .currentState!.save;
                                                  if (_preLamFormKey
                                                      .currentState!
                                                      .validate()) {
                                                    if (status != 'Pending') {
                                                      setState(() {
                                                        sendStatus =
                                                            'Inprogress';
                                                        // setPage =
                                                        //     "Cell Cutting Machine";
                                                      });
                                                      sendDataToBackend();
                                                    }

                                                    setState(() {
                                                      setPage =
                                                          "Cell Cutting Machine";
                                                    });
                                                  }

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
                                                    "(Pre Lam Baliyali Checklist )",
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
                                                  'Ver.1.0 / 01.12.2024',
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Cell Menufacturer & Eff.",
                                                      ),
                                                    ],
                                                  ),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Cell Size(L*W)",
                                                      ),
                                                    ],
                                                  ),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Cell Condition",
                                                      ),
                                                    ],
                                                  ),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Cleanliness of Cell Loading Area",
                                                  ),
                                                ],
                                              ),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Verification of Process Parameter",
                                                  ),
                                                ],
                                              ),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct String Length",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingStrCam1Controller,
                                                          'CellCutting_Image1',
                                                          'String Length1',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingStrCam1Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct String Length",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingStrCam2Controller,
                                                          'CellCutting_Image2',
                                                          'String Length2',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingStrCam2Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct String Length",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingStrCam3Controller,
                                                          'CellCutting_Image3',
                                                          'String Length3',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingStrCam3Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct String Length",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingStrCam4Controller,
                                                          'CellCutting_Image4',
                                                          'String Length4',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingStrCam4Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Cell to Cell Gap",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingCellCam1Controller,
                                                          'CellCutting_Image5',
                                                          'Cell To Cell Gap1',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingCellCam1Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Cell to Cell Gap",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingCellCam2Controller,
                                                          'CellCutting_Image6',
                                                          'Cell To Cell Gap2',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingCellCam2Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Cell to Cell Gap",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingCellCam3Controller,
                                                          'CellCutting_Image7',
                                                          'Cell To Cell Gap3',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingCellCam3Controller
                                                      .text.isNotEmpty),
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
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Enter Correct Cell to Cell Gap",
                                                  ),
                                                ],
                                              ),
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
                                                          cellCuttingCellCam4Controller,
                                                          'CellCutting_Image8',
                                                          'Cell To Cell Gap4',
                                                          'Cell Cutting Machine');
                                                    }
                                                  },
                                                  icon: const Icon(
                                                      Icons.camera_alt),
                                                ),
                                                border:
                                                    const OutlineInputBorder(),
                                              ),
                                              readOnly: true,
                                              validator: MultiValidator(
                                                [
                                                  RequiredValidator(
                                                    errorText:
                                                        "Please Click Picture ",
                                                  ),
                                                ],
                                              ),
                                              enabled: !(widget.id != null &&
                                                  widget.id != '' &&
                                                  cellCuttingCellCam4Controller
                                                      .text.isNotEmpty),
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.white,
                                                      fontSize: 16,
                                                    ),
                                                    onTap: () {
                                                      AppHelper.hideKeyboard(
                                                          context);
                                                      // if (status != 'Pending') {
                                                      //   setState(() {
                                                      //     sendStatus =
                                                      //         'Inprogress';
                                                      //   });
                                                      //   // sendDataToBackend();
                                                      // }
                                                      _preLamFormKey
                                                          .currentState!.save;
                                                      if (_preLamFormKey
                                                          .currentState!
                                                          .validate()) {
                                                        if (status !=
                                                            'Pending') {
                                                          setState(() {
                                                            sendStatus =
                                                                'Inprogress';
                                                            // setPage =
                                                            //     "Tabber & Stringer";
                                                          });
                                                          sendDataToBackend();
                                                        }

                                                        setState(() {
                                                          setPage =
                                                              "Tabber & Stringer";
                                                        });
                                                      }
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
                                                      setPage = 'glassSide';
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
                                                        "(Pre Lam Baliyali Checklist )",
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Verification of Processn Parameter",
                                                      ),
                                                    ],
                                                  ),
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
                                                  "Visual Check after stringing",
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Visual Check after stringer",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabbervisualcam1Controller,
                                                              'Tabber_Image1',
                                                              'Visual Check After Stringing1',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabbervisualcam1Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Visual Check after stringer",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabbervisualcam2Controller,
                                                              'Tabber_Image2',
                                                              'Visual Check After Stringing2',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabbervisualcam2Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Visual Check after stringer",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabbervisualcam3Controller,
                                                              'Tabber_Image3',
                                                              'Visual Check After Stringing3',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabbervisualcam3Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Visual Check after stringer",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabbervisualcam4Controller,
                                                              'Tabber_Image4',
                                                              'Visual Check After Stringing4',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabbervisualcam4Controller
                                                          .text.isNotEmpty),
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
                                                  "EI image of Strings",
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct EI image of String",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabberELImageCam1Controller,
                                                              'Tabber_Image5',
                                                              'El image Of Stringer1',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabberELImageCam1Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct EI image of String",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabberELImageCam2Controller,
                                                              'Tabber_Image6',
                                                              'El image Of Stringer2',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabberELImageCam2Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct EI image of String",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabberELImageCam3Controller,
                                                              'Tabber_Image7',
                                                              'El image Of Stringer3',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabberELImageCam3Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct EI image of String",
                                                      ),
                                                    ],
                                                  ),
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
                                                              tabberELImageCam4Controller,
                                                              'Tabber_Image8',
                                                              'El image Of Stringer4',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled: !(widget.id !=
                                                          null &&
                                                      widget.id != '' &&
                                                      tabberELImageCam4Controller
                                                          .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct Verification of Soldering Peel Strength",
                                                      ),
                                                    ],
                                                  ),
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
                                                              veriCam1Controller,
                                                              'Tabber_Image9',
                                                              'Veri of Sold peel Strength1',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled:
                                                      !(widget.id != null &&
                                                          widget.id != '' &&
                                                          veriCam1Controller
                                                              .text.isNotEmpty),
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
                                                        "Enter the Verification of Soldering Peel Strength",
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct verification of soldering peel strength",
                                                      ),
                                                    ],
                                                  ),
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
                                                              veriCam2Controller,
                                                              'Tabber_Image10',
                                                              'Veri of Sold peel Strength2',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled:
                                                      !(widget.id != null &&
                                                          widget.id != '' &&
                                                          veriCam2Controller
                                                              .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct verification of soldering peel strength.",
                                                      ),
                                                    ],
                                                  ),
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
                                                              veriCam3Controller,
                                                              'Tabber_Image11',
                                                              'Veri of Sold peel Strength3',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled:
                                                      !(widget.id != null &&
                                                          widget.id != '' &&
                                                          veriCam3Controller
                                                              .text.isNotEmpty),
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
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Enter Correct verification of soldering peel strength",
                                                      ),
                                                    ],
                                                  ),
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
                                                              veriCam4Controller,
                                                              'Tabber_Image12',
                                                              'Veri of Sold peel Strength4',
                                                              'Tabber & Stringer');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                          Icons.camera_alt),
                                                    ),
                                                    border:
                                                        const OutlineInputBorder(),
                                                  ),
                                                  readOnly: true,
                                                  validator: MultiValidator(
                                                    [
                                                      RequiredValidator(
                                                        errorText:
                                                            "Please Click Picture ",
                                                      ),
                                                    ],
                                                  ),
                                                  enabled:
                                                      !(widget.id != null &&
                                                          widget.id != '' &&
                                                          veriCam4Controller
                                                              .text.isNotEmpty),
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
                                                          // if (status !=
                                                          //     'Pending') {
                                                          //   setState(() {
                                                          //     sendStatus =
                                                          //         'Inprogress';
                                                          //   });
                                                          //   // sendDataToBackend();
                                                          // }
                                                          _preLamFormKey
                                                              .currentState!
                                                              .save;
                                                          if (_preLamFormKey
                                                              .currentState!
                                                              .validate()) {
                                                            if (status !=
                                                                'Pending') {
                                                              setState(() {
                                                                sendStatus =
                                                                    'Inprogress';
                                                                // setPage =
                                                                //     "Auto String Layup";
                                                              });
                                                              sendDataToBackend();
                                                            }

                                                            setState(() {
                                                              setPage =
                                                                  "Auto String Layup";
                                                            });
                                                          }
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
                                                            "(Pre Lam Baliyali Checklist )",
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
                                                      validator: MultiValidator(
                                                        [
                                                          RequiredValidator(
                                                            errorText:
                                                                "Please Enter Correct String to String Gap",
                                                          ),
                                                        ],
                                                      ),
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
                                                      validator: MultiValidator(
                                                        [
                                                          RequiredValidator(
                                                            errorText:
                                                                "Please Enter Correct Cell edge to glass edge",
                                                          ),
                                                        ],
                                                      ),
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
                                                              // if (status !=
                                                              //     'Pending') {
                                                              //   setState(() {
                                                              //     sendStatus =
                                                              //         'Inprogress';
                                                              //   });
                                                              //   // sendDataToBackend();
                                                              // }
                                                              _preLamFormKey
                                                                  .currentState!
                                                                  .save;
                                                              if (_preLamFormKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                if (status !=
                                                                    'Pending') {
                                                                  setState(() {
                                                                    sendStatus =
                                                                        'Inprogress';
                                                                    // setPage =
                                                                    //     "Auto Bussing & Tapping";
                                                                  });
                                                                  sendDataToBackend();
                                                                }

                                                                setState(() {
                                                                  setPage =
                                                                      "Auto Bussing & Tapping";
                                                                });
                                                              }
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
                                                                "(Pre Lam Baliyali Checklist )",
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Soldering Peel strength between Ribbon to bushbar interconnector",
                                                              ),
                                                            ],
                                                          ),
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
                                                                      autobussSoldCam1Controller,
                                                                      'autoBussing_image',
                                                                      'Soldering Prrl strength',
                                                                      'Auto Bussing And tapping');
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Click Picture ",
                                                              ),
                                                            ],
                                                          ),
                                                          enabled: !(widget
                                                                      .id !=
                                                                  null &&
                                                              widget.id != '' &&
                                                              autobussSoldCam1Controller
                                                                  .text
                                                                  .isNotEmpty),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Terminal busbar to edge of cell",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct soldering quality of Ribbon to busbar",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct soldering quality of Ribbon to busbar",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct soldering quality of Ribbon to busbar",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct soldering quality of Ribbon to busbar",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Top & Bottom Creepage Distance/Terminal busbar to Glass Edge",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Quality of auto taping",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Quality of auto taping",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Quality of auto taping",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Quality of auto taping",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Position verification of RFID & Logo Patch on Module",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Position verification of RFID & Logo Patch on Module",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Position verification of RFID & Logo Patch on Module",
                                                              ),
                                                            ],
                                                          ),
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
                                                          validator:
                                                              MultiValidator(
                                                            [
                                                              RequiredValidator(
                                                                errorText:
                                                                    "Please Enter Correct Position verification of RFID & Logo Patch on Module",
                                                              ),
                                                            ],
                                                          ),
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
                                                          //           "Please Enter Remark",
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
                                                                  // if (status !=
                                                                  //     'Pending') {
                                                                  //   setState(
                                                                  //       () {
                                                                  //     sendStatus =
                                                                  //         'Inprogress';
                                                                  //   });
                                                                  //   // sendDataToBackend();
                                                                  // }
                                                                  _preLamFormKey
                                                                      .currentState!
                                                                      .save;
                                                                  if (_preLamFormKey
                                                                      .currentState!
                                                                      .validate()) {
                                                                    if (status !=
                                                                        'Pending') {
                                                                      setState(
                                                                          () {
                                                                        sendStatus =
                                                                            'Inprogress';
                                                                        // setPage =
                                                                        //     "EVA/Backsheet Cutting";
                                                                      });
                                                                      sendDataToBackend();
                                                                    }

                                                                    setState(
                                                                        () {
                                                                      setPage =
                                                                          "EVA/Backsheet Cutting";
                                                                    });
                                                                  }
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
                                                                    "EVA/EPE Cutting",
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
                                                              validator:
                                                                  MultiValidator(
                                                                [
                                                                  RequiredValidator(
                                                                    errorText:
                                                                        "Please Enter Correct Rear EVA dimension & slit cutting width(mm)",
                                                                  ),
                                                                ],
                                                              ),
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

                                                            // Text(
                                                            //   "Frequency",
                                                            //   style: AppStyles
                                                            //       .textfieldCaptionTextStyle,
                                                            // ),
                                                            // SizedBox(
                                                            //   height: 5,
                                                            // ),
                                                            // TextFormField(
                                                            //   controller:
                                                            //       EvaFreq2Controller,
                                                            //   keyboardType:
                                                            //       TextInputType
                                                            //           .text,
                                                            //   textInputAction:
                                                            //       TextInputAction
                                                            //           .next,
                                                            //   decoration: AppStyles
                                                            //       .textFieldInputDecoration
                                                            //       .copyWith(
                                                            //     hintText:
                                                            //         "Once per Shift",
                                                            //     counterText: '',
                                                            //   ),
                                                            //   style: AppStyles
                                                            //       .textInputTextStyle,
                                                            //   readOnly: true,
                                                            // ),

                                                            // const SizedBox(
                                                            //   height: 20,
                                                            // ),
                                                            // Text(
                                                            //   "Back-sheet dimension& slit cutting diameter",
                                                            //   style: AppStyles
                                                            //       .textfieldCaptionTextStyle,
                                                            // ),
                                                            // SizedBox(
                                                            //   height: 5,
                                                            // ),
                                                            // TextFormField(
                                                            //   controller:
                                                            //       EvaBackController,
                                                            //   keyboardType:
                                                            //       TextInputType
                                                            //           .text,
                                                            //   textInputAction:
                                                            //       TextInputAction
                                                            //           .next,
                                                            //   decoration: AppStyles
                                                            //       .textFieldInputDecoration
                                                            //       .copyWith(
                                                            //     hintText:
                                                            //         "Enter the Back-sheet dimension& slit cutting diameter",
                                                            //     counterText: '',
                                                            //     fillColor: Color
                                                            //         .fromARGB(
                                                            //             255,
                                                            //             215,
                                                            //             243,
                                                            //             207),
                                                            //   ),
                                                            //   style: AppStyles
                                                            //       .textInputTextStyle,
                                                            //   readOnly: status ==
                                                            //               'Pending' &&
                                                            //           designation !=
                                                            //               "QC"
                                                            //       ? true
                                                            //       : false,
                                                            //   validator:
                                                            //       MultiValidator(
                                                            //     [
                                                            //       RequiredValidator(
                                                            //         errorText:
                                                            //             "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                            //       ),
                                                            //     ],
                                                            //   ),
                                                            // ),

                                                            // const SizedBox(
                                                            //   height: 15,
                                                            // ),

                                                            // Text(
                                                            //   "Acceptance Criteria",
                                                            //   style: AppStyles
                                                            //       .textfieldCaptionTextStyle,
                                                            // ),
                                                            // SizedBox(
                                                            //   height: 5,
                                                            // ),
                                                            // TextFormField(
                                                            //   controller:
                                                            //       EvaAccep2Controller,
                                                            //   keyboardType:
                                                            //       TextInputType
                                                            //           .text,
                                                            //   textInputAction:
                                                            //       TextInputAction
                                                            //           .next,
                                                            //   decoration: AppStyles
                                                            //       .textFieldInputDecoration
                                                            //       .copyWith(
                                                            //     hintText:
                                                            //         "As per Specification GSPL/BS(IQC)/001 & production order",
                                                            //     counterText: '',
                                                            //   ),
                                                            //   style: AppStyles
                                                            //       .textInputTextStyle,
                                                            //   readOnly: true,
                                                            // ),
                                                            // const SizedBox(
                                                            //   height: 15,
                                                            // ),

                                                            // Divider(
                                                            //   color:
                                                            //       Colors.black,
                                                            //   thickness: 2,
                                                            //   height: 20,
                                                            // ),

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
                                                                    "Enter the EVA/POE/Backsheet Status",
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
                                                              validator:
                                                                  MultiValidator(
                                                                [
                                                                  RequiredValidator(
                                                                    errorText:
                                                                        "Please Enter Correct EVA/POE/Backsheet Status",
                                                                  ),
                                                                ],
                                                              ),
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
                                                              //           "Please Enter Remark",
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
                                                                      // if (status !=
                                                                      //     'Pending') {
                                                                      //   setState(
                                                                      //       () {
                                                                      //     sendStatus =
                                                                      //         'Inprogress';
                                                                      //   });
                                                                      //   // sendDataToBackend();
                                                                      // }
                                                                      _preLamFormKey
                                                                          .currentState!
                                                                          .save;
                                                                      if (_preLamFormKey
                                                                          .currentState!
                                                                          .validate()) {
                                                                        if (status !=
                                                                            'Pending') {
                                                                          setState(
                                                                              () {
                                                                            sendStatus =
                                                                                'Inprogress';
                                                                            // setPage =
                                                                            //     "Pre Lamination El & Visual inspection";
                                                                          });
                                                                          sendDataToBackend();
                                                                        }

                                                                        setState(
                                                                            () {
                                                                          setPage =
                                                                              "Glass Loader/BackSheet";
                                                                        });
                                                                      }
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

                                              // Second Glass Loader Start
                                              : setPage ==
                                                      "Glass Loader/BackSheet"
                                                  // EVA/Backsheet Cutting
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

                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                Text(
                                                                  "Select Type",
                                                                  style: AppStyles
                                                                      .textfieldCaptionTextStyle,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    RadioListTile<
                                                                        String>(
                                                                      title: Text(
                                                                          "Glass Loader"),
                                                                      value:
                                                                          "Glass Loader",
                                                                      groupValue:
                                                                          selectedOption,
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          selectedOption =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                    RadioListTile<
                                                                        String>(
                                                                      title: Text(
                                                                          "Backsheet"),
                                                                      value:
                                                                          "Backsheet",
                                                                      groupValue:
                                                                          selectedOption,
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          selectedOption =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),

                                                                Center(
                                                                    child: Text(
                                                                        selectedOption == "Backsheet"
                                                                            ? "Backsheet Cutting"
                                                                            : "Glass Loader",
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
                                                                  color: Colors
                                                                      .black,
                                                                  thickness: 2,
                                                                  height: 20,
                                                                ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Frequency",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        glass1FrequController,
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
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Glass Dimension {L*W*T}",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                      controller:
                                                                          glassDimen1Controller,
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
                                                                            "Enter the Glass Dimension ",
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
                                                                              designation !=
                                                                                  "QC"
                                                                          ? true
                                                                          : false,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Glass Dimension",
                                                                          ),
                                                                        ],
                                                                      )),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Acceptance Criteria",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        glassAccep1Controller,
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
                                                                          "As Per Production Order",
                                                                      counterText:
                                                                          '',
                                                                    ),
                                                                    style: AppStyles
                                                                        .textInputTextStyle,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  // *** Remark
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption !=
                                                                    "Backsheet")
                                                                  Divider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        2,
                                                                    height: 20,
                                                                  ),

                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Frequency",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaFreq2bController,
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
                                                                      counterText:
                                                                          '',
                                                                    ),
                                                                    style: AppStyles
                                                                        .textInputTextStyle,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Back-sheet dimension& slit cutting diameter",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaBackbController,
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
                                                                    readOnly: status ==
                                                                                'Pending' &&
                                                                            designation !=
                                                                                "QC"
                                                                        ? true
                                                                        : false,
                                                                    validator:
                                                                        MultiValidator(
                                                                      [
                                                                        RequiredValidator(
                                                                          errorText:
                                                                              "Please Enter Correct Back-sheet dimension& slit cutting diameter",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Acceptance Criteria",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaAccep2bController,
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
                                                                      counterText:
                                                                          '',
                                                                    ),
                                                                    style: AppStyles
                                                                        .textInputTextStyle,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Divider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        2,
                                                                    height: 20,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Frequency",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaFreq3bController,
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
                                                                      counterText:
                                                                          '',
                                                                    ),
                                                                    style: AppStyles
                                                                        .textInputTextStyle,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "EVA/POE/Backsheet Status",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaPOEbController,
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
                                                                          "Enter the Backsheet Status",
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
                                                                    readOnly: status ==
                                                                                'Pending' &&
                                                                            designation !=
                                                                                "QC"
                                                                        ? true
                                                                        : false,
                                                                    validator:
                                                                        MultiValidator(
                                                                      [
                                                                        RequiredValidator(
                                                                          errorText:
                                                                              "Please Enter Correct Backsheet Status",
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Text(
                                                                    "Acceptance Criteria",
                                                                    style: AppStyles
                                                                        .textfieldCaptionTextStyle,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  TextFormField(
                                                                    controller:
                                                                        EvaAccep3bController,
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
                                                                      counterText:
                                                                          '',
                                                                    ),
                                                                    style: AppStyles
                                                                        .textInputTextStyle,
                                                                    readOnly:
                                                                        true,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  const SizedBox(
                                                                    height: 15,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
                                                                  Divider(
                                                                    color: Colors
                                                                        .black,
                                                                    thickness:
                                                                        2,
                                                                    height: 20,
                                                                  ),
                                                                if (selectedOption ==
                                                                    "Backsheet")
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
                                                                      glassRemark1Controller,
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
                                                                          // if (status !=
                                                                          //     'Pending') {
                                                                          //   setState(
                                                                          //       () {
                                                                          //     sendStatus =
                                                                          //         'Inprogress';
                                                                          //   });
                                                                          //   // sendDataToBackend();
                                                                          // }
                                                                          _preLamFormKey
                                                                              .currentState!
                                                                              .save;
                                                                          if (_preLamFormKey
                                                                              .currentState!
                                                                              .validate()) {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              setState(() {
                                                                                sendStatus = 'Inprogress';
                                                                                // setPage =
                                                                                //     "Pre Lamination El & Visual inspection";
                                                                              });
                                                                              sendDataToBackend();
                                                                            }

                                                                            setState(() {
                                                                              setPage = "Pre Lamination El & Visual inspection";
                                                                            });
                                                                          }
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

                                                  // Second Glass Loader End
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

                                                                    // **************  "Pre Lamination El & Visual inspection  *****************
                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),
                                                                    const Center(
                                                                        child: Text(
                                                                            "Pre Lamination El & Visual Inspection ",
                                                                            style: TextStyle(
                                                                                fontSize: 20,
                                                                                color: Color.fromARGB(255, 13, 160, 0),
                                                                                fontFamily: appFontFamily,
                                                                                fontWeight: FontWeight.w700))),

                                                                    const SizedBox(
                                                                      height:
                                                                          15,
                                                                    ),

                                                                    /**   Start */
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
                                                                      height:
                                                                          20,
                                                                    ),

                                                                    Text(
                                                                      "EI Inspection",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            2),
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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct EL Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      "Sr. No.1",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreELCam1Controller, 'preEl_Image1', 'EL inspection', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreELCam1Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct EL Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      "Sr. No.2",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreELCam2Controller, 'preEl_Image2', 'EL inspection2', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreELCam2Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),

                                                                    SizedBox(
                                                                        height:
                                                                            5),
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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct EL Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                        height:
                                                                            5),

                                                                    Text(
                                                                      "Sr. No.3",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreELCam3Controller, 'preEl_Image3', 'EL inspection3', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreELCam3Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct EL Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.4",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreELCam4Controller, 'preEl_Image4', 'EL inspection4', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreELCam4Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct EL Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),

                                                                    SizedBox(
                                                                      height: 5,
                                                                    ),
                                                                    Text(
                                                                      "Sr. No.5",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreELCam5Controller, 'preEl_Image5', 'EL inspection4', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreELCam5Controller
                                                                              .text
                                                                              .isNotEmpty),
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
                                                                      height:
                                                                          20,
                                                                    ),

                                                                    Text(
                                                                      "Visual Inspection",
                                                                      style: AppStyles
                                                                          .textfieldCaptionTextStyle,
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),

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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct  Visual Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.1",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreVisulCam1Controller, 'preEl_Image6', 'Visual Inspection1', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreVisulCam1Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),

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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct Visual Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.2",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreVisulCam2Controller, 'preEl_Image7', 'Visual Inspection2', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreVisulCam2Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),

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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct  Visual Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.3",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreVisulCam3Controller, 'preEl_Image8', 'Visual Inspection3', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreVisulCam3Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),

                                                                    SizedBox(
                                                                        height:
                                                                            5),

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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct  Visual Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.4",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreVisulCam4Controller, 'preEl_Image9', 'Visual Inspection4', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreVisulCam4Controller
                                                                              .text
                                                                              .isNotEmpty),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),

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
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Enter Correct  Visual Inspection",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5),
                                                                    Text(
                                                                      "Sr. No.5",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                        suffixIcon:
                                                                            IconButton(
                                                                          onPressed:
                                                                              () async {
                                                                            if (status !=
                                                                                'Pending') {
                                                                              await _openCamera(PreVisulCam5Controller, 'preEl_Image10', 'Visual Inspection5', 'Pre Lamination El & Visual Inspection');
                                                                            }
                                                                          },
                                                                          icon:
                                                                              const Icon(Icons.camera_alt),
                                                                        ),
                                                                        border:
                                                                            const OutlineInputBorder(),
                                                                      ),
                                                                      readOnly:
                                                                          true,
                                                                      validator:
                                                                          MultiValidator(
                                                                        [
                                                                          RequiredValidator(
                                                                            errorText:
                                                                                "Please Click Picture ",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      enabled: !(widget.id != null &&
                                                                          widget.id !=
                                                                              '' &&
                                                                          PreVisulCam5Controller
                                                                              .text
                                                                              .isNotEmpty),
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

                                                                    //  *** Remark
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
                                                                      // validator:
                                                                      //     MultiValidator(
                                                                      //   [
                                                                      //     RequiredValidator(
                                                                      //       errorText:
                                                                      //           "Please Enter Remark",
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

                                                                              sample5Controller = [];
                                                                              for (int i = 0; i < numberOfStringers5 * 5; i++) {
                                                                                // sample5Controller.add({
                                                                                //   "PreLaminationEIinspectionrControllers${i + 1}": PreLaminationEIinspectionrControllers[i].text,
                                                                                // });
                                                                              }

                                                                              sample6Controller = [];
                                                                              // for (int i = 0;
                                                                              //     i < numberOfStringers6 * 5;
                                                                              //     i++) {
                                                                              //   sample6Controller.add({
                                                                              //     "PreLaminationVisualinspectionrControllers${i + 1}": PreLaminationVisualinspectionrControllers[i].text,
                                                                              //   });
                                                                              // }
                                                                              // if (status !=
                                                                              //     'Pending') {
                                                                              //   setState(() {
                                                                              //     sendStatus = 'Inprogress';
                                                                              //   });
                                                                              //   // sendDataToBackend();
                                                                              // }
                                                                              _preLamFormKey.currentState!.save;
                                                                              if (_preLamFormKey.currentState!.validate()) {
                                                                                if (status != 'Pending') {
                                                                                  setState(() {
                                                                                    sendStatus = 'Inprogress';
                                                                                    // setPage = "String Rework Station";
                                                                                  });
                                                                                  sendDataToBackend();
                                                                                }

                                                                                setState(() {
                                                                                  setPage = "String Rework Station";
                                                                                });
                                                                              }
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
                                                                              setPage = 'Glass Loader/BackSheet';
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
                                                              "String Rework Station"
                                                          // String Rework Station start
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

                                                                        // ************** String Rework Station *****************
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        const Center(
                                                                            child:
                                                                                Text("String Rework Station", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 13, 160, 0), fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
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
                                                                              StringCleaningFrequencyController,
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
                                                                              StringCleaningController,
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
                                                                          validator:
                                                                              MultiValidator(
                                                                            [
                                                                              RequiredValidator(
                                                                                errorText: "Please Enter Correct Cleaning of Rework station/soldering iron sponge",
                                                                              ),
                                                                            ],
                                                                          ),
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
                                                                              StringCleaningCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Rework Station should be Clean/Sponge should be Wet",
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
                                                                              StringSoldFrequencyController,
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
                                                                          "Soldering Iron Temp.",
                                                                          style:
                                                                              AppStyles.textfieldCaptionTextStyle,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              StringSoldController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "Enter the Soldering Iron Temp.",
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
                                                                          validator:
                                                                              MultiValidator(
                                                                            [
                                                                              RequiredValidator(
                                                                                errorText: "Please Enter Correct Soldering Iron Temp",
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),
                                                                        Text(
                                                                          "Picture",
                                                                          style: TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        TextFormField(
                                                                          controller:
                                                                              soldCameraController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            hintText:
                                                                                "Please Capture a Temperature Picture",
                                                                            counterText:
                                                                                '',
                                                                            contentPadding:
                                                                                const EdgeInsets.all(10),
                                                                            suffixIcon:
                                                                                IconButton(
                                                                              onPressed: () async {
                                                                                if (status != 'Pending') {
                                                                                  await _openCamera(soldCameraController, 'soldering_image', 'Soldering Iron Temp', 'Module String Stations');
                                                                                }
                                                                              },
                                                                              icon: const Icon(Icons.camera_alt),
                                                                            ),
                                                                            border:
                                                                                const OutlineInputBorder(),
                                                                          ),
                                                                          readOnly:
                                                                              true,
                                                                          validator:
                                                                              MultiValidator(
                                                                            [
                                                                              RequiredValidator(
                                                                                errorText: "Please Click Picture ",
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          enabled: !(widget.id != null &&
                                                                              widget.id != '' &&
                                                                              soldCameraController.text.isNotEmpty),
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
                                                                              StringSoldCriteriaController,
                                                                          keyboardType:
                                                                              TextInputType.text,
                                                                          textInputAction:
                                                                              TextInputAction.next,
                                                                          decoration: AppStyles
                                                                              .textFieldInputDecoration
                                                                              .copyWith(
                                                                            hintText:
                                                                                "400±30°C",
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
                                                                        const SizedBox(
                                                                          height:
                                                                              15,
                                                                        ),

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
                                                                              StringReworkRemarkController,
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
                                                                          // validator:
                                                                          //     MultiValidator(
                                                                          //   [
                                                                          //     RequiredValidator(
                                                                          //       errorText: "Please Enter Remark",
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
                                                                                  // if (status != 'Pending') {
                                                                                  //   setState(() {
                                                                                  //     sendStatus = 'Inprogress';
                                                                                  //   });
                                                                                  //   // sendDataToBackend();
                                                                                  // }
                                                                                  _preLamFormKey.currentState!.save;
                                                                                  if (_preLamFormKey.currentState!.validate()) {
                                                                                    if (status != 'Pending') {
                                                                                      setState(() {
                                                                                        // setPage = "Module Rework Station";
                                                                                        sendStatus = "Inprogress";
                                                                                      });
                                                                                      sendDataToBackend();
                                                                                    }
                                                                                    setState(() {
                                                                                      setPage = "Module Rework Station";
                                                                                    });
                                                                                  }
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
                                                                                  setPage = 'Pre Lamination El & Visual inspection';
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

                                                                            // ************** Module Rework Station *****************
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            const Center(child: Text("Module Rework Station", style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 13, 160, 0), fontFamily: appFontFamily, fontWeight: FontWeight.w700))),
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
                                                                              controller: ModuleMethodCleaningFrequencyController,
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
                                                                              "Method of Rework",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: ModuleMethodCleaningController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Method of Rework",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              validator: MultiValidator(
                                                                                [
                                                                                  RequiredValidator(
                                                                                    errorText: "Please Enter Correct Method of Rework",
                                                                                  ),
                                                                                ],
                                                                              ),
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
                                                                              controller: ModuleMethodCleaningCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "As per WI (GSPL/QA/WI/009)",
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
                                                                              controller: ModuleCleaningofReworkFrequencyController,
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
                                                                              "Cleaning of Rework station/Soldering iron sponge",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: ModuleCleaningofReworkController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Cleaning of Rework station/Soldering iron sponge",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              validator: MultiValidator(
                                                                                [
                                                                                  RequiredValidator(
                                                                                    errorText: "Please Enter Correct Cleaning of Rework station/Soldering iron sponge",
                                                                                  ),
                                                                                ],
                                                                              ),
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
                                                                              controller: ModuleMethodCleaningCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Rework Station should be Clean/Sponge should be Wet",
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
                                                                              controller: ModuleSoldFrequencyController,
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
                                                                              "Soldering Iron Temp.",
                                                                              style: AppStyles.textfieldCaptionTextStyle,
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5,
                                                                            ),
                                                                            TextFormField(
                                                                              controller: ModuleSoldController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "Enter the Soldering Iron Temp.",
                                                                                counterText: '',
                                                                                fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                              ),
                                                                              style: AppStyles.textInputTextStyle,
                                                                              readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                              validator: MultiValidator(
                                                                                [
                                                                                  RequiredValidator(
                                                                                    errorText: "Please Enter Correct Soldering Iron Temp.",
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),

                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Text(
                                                                              "Picture",
                                                                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            TextFormField(
                                                                              controller: modCameraController,
                                                                              decoration: InputDecoration(
                                                                                hintText: "Please Capture a Temperature Picture",
                                                                                counterText: '',
                                                                                contentPadding: const EdgeInsets.all(10),
                                                                                suffixIcon: IconButton(
                                                                                  onPressed: () async {
                                                                                    if (status != 'Pending') {
                                                                                      await _openCamera(modCameraController, 'soldering_image1', 'Soldering Iron Temp', 'Module Rework Stations');
                                                                                    }
                                                                                  },
                                                                                  icon: const Icon(Icons.camera_alt),
                                                                                ),
                                                                                border: const OutlineInputBorder(),
                                                                              ),
                                                                              readOnly: true,
                                                                              validator: MultiValidator(
                                                                                [
                                                                                  RequiredValidator(
                                                                                    errorText: "Please Click Picture ",
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              enabled: !(widget.id != null && widget.id != '' && modCameraController.text.isNotEmpty),
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
                                                                              controller: ModuleSoldCriteriaController,
                                                                              keyboardType: TextInputType.text,
                                                                              textInputAction: TextInputAction.next,
                                                                              decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                hintText: "400±30°C",
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
                                                                              controller: ModuleCleaningRemarkController,
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
                                                                              //       errorText: "Please Enter Remark",
                                                                              //     ),
                                                                              //   ],
                                                                              // ),
                                                                            ),
                                                                            const SizedBox(
                                                                              height: 15,
                                                                            ),
                                                                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                                                                                      // if (status != 'Pending') {
                                                                                      //   setState(() {
                                                                                      //     sendStatus = 'Inprogress';
                                                                                      //   });
                                                                                      //   // sendDataToBackend();
                                                                                      // }
                                                                                      _preLamFormKey.currentState!.save;
                                                                                      if (_preLamFormKey.currentState!.validate()) {
                                                                                        if (status != 'Pending') {
                                                                                          setState(() {
                                                                                            sendStatus = 'Inprogress';
                                                                                            // setPage = "Laminator";
                                                                                          });
                                                                                          sendDataToBackend();
                                                                                        }

                                                                                        setState(() {
                                                                                          setPage = "Laminator";
                                                                                        });
                                                                                      }
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
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                                  validator: MultiValidator(
                                                                                    [
                                                                                      RequiredValidator(
                                                                                        errorText: "Please Enter Correct Monitoring of Laminator Process Parameter",
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                                  controller: LaminatordiaFrequencyController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "24h",
                                                                                    counterText: '',
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: true,
                                                                                ),

                                                                                const SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Text(
                                                                                  "Cleaning of Diaphragm/release sheet",
                                                                                  style: AppStyles.textfieldCaptionTextStyle,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                TextFormField(
                                                                                  controller: LaminatordiaController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "Enter the Cleaning of Diaphragm/release sheet",
                                                                                    counterText: '',
                                                                                    fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                                  validator: MultiValidator(
                                                                                    [
                                                                                      RequiredValidator(
                                                                                        errorText: "Please Enter Correct Cleaning of Diaphragm/release sheet",
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                                  controller: LaminatordiaCriteriaController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "Diaphragm/Release sheet should be clean,No EVA residue is allowed",
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
                                                                                  controller: LaminatorComFrequencyController,
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
                                                                                  "Consumable life of Diaphragm/release sheet",
                                                                                  style: AppStyles.textfieldCaptionTextStyle,
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 5,
                                                                                ),
                                                                                TextFormField(
                                                                                  controller: LaminatorConController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "Enter the Consumable life of Diaphragm/release sheet",
                                                                                    counterText: '',
                                                                                    fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                                  validator: MultiValidator(
                                                                                    [
                                                                                      RequiredValidator(
                                                                                        errorText: "Please Enter Correct Consumable life of Diaphragm/release sheet",
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                                  controller: LaminatorConCriteriaController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "25000 Cycle",
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
                                                                                    hintText: "All Position | All laminators to be coverd in a month",
                                                                                    counterText: '',
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: true,
                                                                                ),

                                                                                const SizedBox(
                                                                                  height: 20,
                                                                                ),
                                                                                Text(
                                                                                  "Peel of Test b/w: EVA/GlassEVA/Backsheet",
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
                                                                                    hintText: "Enter the Peel of Test b/w: EVA/GlassEVABackheet",
                                                                                    counterText: '',
                                                                                    fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: status == 'Pending' && designation != "QC" ? true : false,
                                                                                  validator: MultiValidator(
                                                                                    [
                                                                                      RequiredValidator(
                                                                                        errorText: "Please Enter Correct Peel of Test b/w: EVA/GlassEVABackheet",
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                                    hintText: "E/G ≥70N/cm E/B≥40N/cm",
                                                                                    counterText: '',
                                                                                  ),
                                                                                  style: AppStyles.textInputTextStyle,
                                                                                  readOnly: true,
                                                                                ),
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
                                                                                  controller: LaminatorGelFrequencyController,
                                                                                  keyboardType: TextInputType.text,
                                                                                  textInputAction: TextInputAction.next,
                                                                                  decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                    hintText: "All Position | All laminators to be coverd in a month",
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
                                                                                  validator: MultiValidator(
                                                                                    [
                                                                                      RequiredValidator(
                                                                                        errorText: "Please Enter Correct Gel Content Test",
                                                                                      ),
                                                                                    ],
                                                                                  ),
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
                                                                                    hintText: "75to 95%",
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
                                                                                  //       errorText: "Please Enter Correct Remark",
                                                                                  //     ),
                                                                                  //   ],
                                                                                  // ),
                                                                                ),
                                                                                const SizedBox(
                                                                                  height: 15,
                                                                                ),
                                                                                // Text(
                                                                                //   "Reference PDF Document",
                                                                                //   style: AppStyles.textfieldCaptionTextStyle,
                                                                                // ),
                                                                                // const SizedBox(
                                                                                //   height: 5,
                                                                                // ),
                                                                                // TextFormField(
                                                                                //   controller: referencePdfController,
                                                                                //   keyboardType: TextInputType.text,
                                                                                //   textInputAction: TextInputAction.next,
                                                                                //   decoration: AppStyles.textFieldInputDecoration.copyWith(
                                                                                //       hintText: "Please Select Reference Pdf",
                                                                                //       fillColor: Color.fromARGB(255, 215, 243, 207),
                                                                                //       suffixIcon: IconButton(
                                                                                //         onPressed: () async {
                                                                                //           if (widget.id != null && widget.id != '' && referencePdfController.text != '') {
                                                                                //             UrlLauncher.launch(referencePdfController.text);
                                                                                //           } else if (status != 'Pending') {
                                                                                //             _pickReferencePDF();
                                                                                //           }
                                                                                //         },
                                                                                //         icon: widget.id != null && widget.id != '' && referencePdfController.text != '' ? const Icon(Icons.download) : const Icon(Icons.upload_file),
                                                                                //       ),
                                                                                //       counterText: ''),
                                                                                //   style: AppStyles.textInputTextStyle,
                                                                                //   maxLines: 1,
                                                                                //   readOnly: true,
                                                                                //   validator: (value) {
                                                                                //     if (value!.isEmpty) {
                                                                                //       return "Please Select Reference Pdf";
                                                                                //     } else {
                                                                                //       return null;
                                                                                //     }
                                                                                //   },
                                                                                // ),
                                                                                // const SizedBox(
                                                                                //   height: 15,
                                                                                // ),

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
                                                                                              // sendDataToBackend(); //300

                                                                                              _preLamFormKey.currentState!.save;
                                                                                              if (_preLamFormKey.currentState!.validate()) {
                                                                                                if (status != 'Pending') {
                                                                                                  setState(() {
                                                                                                    // setPage = "Cell Cutting Machine";

                                                                                                    sendStatus = "Pending";
                                                                                                  });
                                                                                                  sendDataToBackend();
                                                                                                }
                                                                                              }
                                                                                            },
                                                                                            label: "Save",
                                                                                            organization: '',
                                                                                          )
                                                                                        : Container(),

                                                                                const SizedBox(
                                                                                  height: 10,
                                                                                ),
                                                                                if (widget.id != "" && widget.id != null && status == 'Pending')
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
