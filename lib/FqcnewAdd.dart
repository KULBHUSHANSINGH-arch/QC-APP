import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
// import 'package:QCM/FqcNewTestList.dart';
// import 'package:QCM/Fqcnew.dart';
// import 'package:QCM/QualityList.dart';
// import 'package:QCM/QualityPage.dart';
// import 'package:QCM/components/app_loader.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/response.dart' as Response;
import 'package:qcmapp/FqcNewTestList.dart';
import 'package:qcmapp/Fqcnew.dart';
import 'package:qcmapp/QualityList.dart';
import 'package:qcmapp/QualityPage.dart';
import 'package:qcmapp/barcode_scanner_widget.dart';
import 'package:qcmapp/components/app_button_widget.dart';
import 'package:qcmapp/components/app_loader.dart';
// import 'package:QCM/components/app_button_widget.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:logging_appenders/logging_appenders.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'components/appbar.dart';
import 'constant/app_assets.dart';
import 'constant/app_color.dart';
import 'constant/app_fonts.dart';
import 'constant/app_strings.dart';
import 'constant/app_styles.dart';

class AddFQCNew extends StatefulWidget {
  final String? id;
  AddFQCNew({this.id});
  _AddFQCNewState createState() => _AddFQCNewState();
}

class _AddFQCNewState extends State<AddFQCNew> {
  File? _image, personPreview, _elimage;
  List<int>? personlogoBytes, pdfFileBytes, _imageBytes, _elimageBytes;
  List data = [];
  List statedata1 = [];
  List citydata1 = [];
  List lineList = [];
  bool sameAsPresentAddress = false;
  final picker = ImagePicker();

  final _dio = Dio();
  // Response? _response;
  Response.Response? _response;
  List<String>? issuetypeController = [];
  int serialNumber = 0;
  // String? issuetypeController;
  String? subissuetypeController;
  String? _errorMessage,
      bloodGroupController,
      token,
      barcodeScanRes,
      issueStatus = 'Not OK',
      issueStatusType,
      laminatorTypeController,
      shiftController,
      // issuetypeController,
      // particletypeController,
      // subparticletypeController,

      modulepicture,
      WorkLocationName,
      WorkLocation,
      elpicture,
      personLogoname,
      personid,
      designation,
      department,
      lineController,
      setpersonid,
      firstname,
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
  String setStatus = "Active";
  Map<String, dynamic> apiResponse = {};

  List<Map<String, dynamic>> multiBarcodeResponse = [];
  bool isLoading = false;
  List<Map<String, dynamic>> particleList = [];
  List<Map<String, dynamic>> subparticleList = [];
  final List<Map<String, String>> staticSubParticleList = [
    {'particleChildName': 'Conductiver', 'particleChildId': '1'},
    {'particleChildName': 'Non-Conductive', 'particleChildId': '2'},
  ];
  List<Map<String, dynamic>> issueList = [];
  List<Map<String, dynamic>> subIssueList = [];

  // List issueList = [],
  // particleList = [],
  // subparticleList = [],
  List elList = [],
      stringList = [],
      modelNumberList = [],
      reportingManagerList = [],
      shiftList = [
        {"key": "NG", "value": "NG"},
        {"key": "OK", "value": "OK"},
      ];
  // List<Map<String, String>> chamberList = [
  //   {"key": "Ok", "value": "Ok"},
  //   {"key": "Not Ok", "value": "Not Ok"},
  // ];
  // List<Map<String, String>> laminatorList = [
  //   {"key": "GME", "value": "GME"},
  //   {"key": "Jinchen", "value": "Jinchen"},
  // ];

  List<Map<String, dynamic>> sublaminator1 = [];
  List itemsData = [];
  SharedPreferences? prefs;
  TextEditingController shiftinchargeprelimeController =
      new TextEditingController();
  TextEditingController shiftinchargepostlimeController =
      new TextEditingController();

  TextEditingController productBarcodeController = new TextEditingController();
  TextEditingController wattageController = new TextEditingController();
  TextEditingController othermodelnumberController =
      new TextEditingController();
  TextEditingController responsiblepersonController =
      new TextEditingController();
  TextEditingController reasonofissueController = new TextEditingController();
  TextEditingController stageController = new TextEditingController();
  TextEditingController issuecomefromController = new TextEditingController();
  TextEditingController actiontakenController = new TextEditingController();
  TextEditingController otherissuetypeController = new TextEditingController();
  TextEditingController remarksController = new TextEditingController();
  List<TextEditingController> barcodeControllers = [];
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
    // getLocationData();
    getStringData();

    getIssueData(null);

    // addField();
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
      WorkLocationName = prefs.getString('WorkLocationName');
      WorkLocation = prefs.getString("workLocation");
    });
    getLineData();
    if (widget.id != "" && widget.id != null) {
      _get();
    }
  }

  Future<void> getLineData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse('https://hrm.umanerp.com/api/factory/getUnitLine');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({"factoryId": "2", "type": "line"}),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final lineBody = jsonDecode(response.body);
        print("lineBody...?");
        print(lineBody['data']);
        setState(() {
          lineList = lineBody['data'];
        });

        return;
      }

      setState(() {});
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  void addField() {
    setState(() {
      barcodeControllers.add(TextEditingController());
    });
  }

  void removeField(int index) {
    setState(() {
      barcodeControllers[index].dispose();
      barcodeControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var controller in barcodeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Future<void> scanBarcode(int index) async {
  //   String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //     '#FF6666',
  //     'Cancel',
  //     true,
  //     ScanMode.DEFAULT,
  //   );

  //   if (barcodeScanRes != "-1") {
  //     setState(() {
  //       barcodeControllers[index].text = barcodeScanRes;
  //     });
  //     setState(() {
  //       serialNumber++;
  //       barcodeControllers.add(TextEditingController());
  //     });
  //   }
  // }

  // Future<void> scanAndAddBarcode() async {
  //   bool keepScanning = true;

  //   while (keepScanning) {
  //     try {
  //       String barcode = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', // Line color
  //         'Stop', // Button text for user to stop scanning
  //         true, // Show flash
  //         ScanMode.BARCODE,
  //       );

  //       if (barcode == '-1') {
  //         // User tapped cancel
  //         keepScanning = false;
  //         print('User stopped scanning.');
  //       } else {
  //         setState(() {
  //           serialNumber++;
  //           barcodeControllers.add(TextEditingController(text: barcode));
  //         });
  //       }
  //     } catch (e) {
  //       print('Barcode scan failed: $e');
  //       keepScanning = false;
  //     }
  //   }
  // }

// Method to scan and add multiple barcodes in sequence
// Future<void> scanAndAddBarcode() async {
//   // Show instructions to the user before starting continuous scanning
//   await showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title: const Text('Continuous Scanning Mode'),
//       content: const Text('The scanner will automatically continue after each successful scan.\n\nPress the CLOSE button in the scanner to exit.'),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.pop(context),
//           child: const Text('Start Scanning'),
//         ),
//       ],
//     ),
//   );

//   // Track scanned barcodes during this session
//   List<String> sessionBarcodes = [];

//   try {
//     // Use a callback to handle barcodes as they are scanned
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => BarcodeScannerWidget(
//           continuousScan: true,
//           delayBetweenScans: 1000, // 1.5 seconds between scans
//           // onBarcodeDetected: (barcode) {
//           //   // Add the barcode to our list
//           //   sessionBarcodes.add(barcode);

//           //   // Add a new controller for this barcode
//           //   setState(() {
//           //     serialNumber++;
//           //     barcodeControllers.add(TextEditingController(text: barcode));
//           //   });

//           //   // Show a count of how many barcodes have been scanned
//           //   ScaffoldMessenger.of(context).showSnackBar(
//           //     SnackBar(
//           //       content: Text('Barcode added: $barcode (${sessionBarcodes.length} total)'),
//           //       duration: const Duration(milliseconds: 800),
//           //       backgroundColor: Colors.green,
//           //     ),
//           //   );
//           // },
//           onBarcodeDetected: (barcode) {
//   if (sessionBarcodes.contains(barcode)) {
//     // Show warning if barcode is already scanned
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Duplicate barcode ignored: $barcode'),
//         duration: const Duration(milliseconds: 500),
//         backgroundColor: Colors.orange,
//       ),
//     );
//     return; // Skip adding duplicate
//   }

//   // Add the barcode to our list
//   sessionBarcodes.add(barcode);

//   // Add a new controller for this barcode
//   setState(() {
//     serialNumber++;
//     barcodeControllers.add(TextEditingController(text: barcode));
//   });

//   // Show a count of how many barcodes have been scanned
//   // ScaffoldMessenger.of(context).showSnackBar(
//   //   SnackBar(
//   //     content: Text('Barcode added: $barcode (${sessionBarcodes.length} total)'),
//   //     duration: const Duration(milliseconds: 500),
//   //     backgroundColor: Colors.green,
//   //   ),
//   // );
// },

//         ),
//       ),
//     );

//     // When done (user pressed CLOSE), show summary
//     if (sessionBarcodes.isNotEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${sessionBarcodes.length} barcodes scanned'),
//           backgroundColor: Colors.green,
//         ),
//       );
//     }

//   } catch (e) {
//     // Handle errors during scanning
//     print('Barcode scan failed: $e');
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Error scanning barcode: $e'),
//         backgroundColor: Colors.red,
//       ),
//     );
//   }
// }
  Future<void> scanAndAddBarcode() async {
    // Track scanned barcodes during this session
    List<String> sessionBarcodes = [];

    try {
      // Directly open the scanner without showing dialog
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BarcodeScannerWidget(
            continuousScan: true,
            delayBetweenScans: 500, // 1 second between scans
            onBarcodeDetected: (barcode) {
              if (sessionBarcodes.contains(barcode)) {
                // Show error if barcode is already scanned
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Error: Duplicate barcode "$barcode" already scanned.'),
                    duration: const Duration(milliseconds: 1200),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // Add the barcode to our list
              sessionBarcodes.add(barcode);

              // Add a new controller for this barcode
              setState(() {
                serialNumber++;
                barcodeControllers.add(TextEditingController(text: barcode));
              });

              // Show success message
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Barcode added: $barcode (${sessionBarcodes.length} total)'),
              //     duration: const Duration(milliseconds: 800),
              //     backgroundColor: Colors.green,
              //   ),
              // );
            },
          ),
        ),
      );

      // When done (user pressed CLOSE), show summary
      if (sessionBarcodes.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${sessionBarcodes.length} barcodes scanned'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      // Handle errors during scanning
      print('Barcode scan failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scanning barcode: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

// Method to scan a single barcode for a specific index
  Future<void> scanBarcode(int index) async {
    try {
      // Show the scanner page and get the result
      final barcode = await Navigator.push<String>(
        context,
        MaterialPageRoute(
          builder: (context) => const BarcodeScannerWidget(
            continuousScan: false, // Explicitly set to single scan mode
          ),
        ),
      );

      // Handle the scanned barcode
      if (barcode != null && barcode.isNotEmpty && barcode != "-1") {
        setState(() {
          barcodeControllers[index].text = barcode;
        });
      }
    } catch (e) {
      print('Barcode scan failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error scanning barcode: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String formatValue(dynamic value) {
    if (value == null ||
        (value is String && value.trim().toLowerCase() == 'no record found')) {
      return 'N/A';
    }
    return value.toString();
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      // cameraDevice: CameraDevice.rear,
    );

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _compressImage(_image!);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _compressImage(File imageFile) async {
    var _imageBytesOriginal = imageFile.readAsBytesSync();
    _imageBytes = await FlutterImageCompress.compressWithList(
      _imageBytesOriginal!,
      quality: 60,
    );
  }

  Future<void> _get() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (widget.id != '' && widget.id != null) {
        _isLoading = true;
      }
      site = prefs.getString('site');
    });

    final qualityUrl = ((site!) + 'TestEquipmet/getNewFQC');

    try {
      final response = await http.post(
        Uri.parse(qualityUrl),
        body: jsonEncode({
          "fqcnewid": widget.id ?? '',
          "token": token!,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      var resBody = json.decode(response.body);

      if (mounted) {
        setState(() {
          data = resBody['data'];
          if (data != null && data.isNotEmpty) {
            final item = data[0];

            // Bind image path
            modulepicture = item['productTestUrl'] ?? "";

            // Bind text field controllers
            productBarcodeController.text = item['productBarcode'] ?? '';
            otherissuetypeController.text = item['otherissuetype'] ?? '';
            remarksController.text = item['Remark'] ?? '';

            // Parse supervisors data
            if (item['productTestReport'] != null) {
              try {
                final testReport = json.decode(item['productTestReport']);
                shiftinchargeprelimeController.text =
                    testReport['supervisors']?['preLam'] ?? '';
                shiftinchargepostlimeController.text =
                    testReport['supervisors']?['postLam'] ?? '';
              } catch (e) {
                print("Error parsing productTestReport: $e");
              }
            }

            // Bind regular string variables
            shiftController = item['pallateType'] ?? '';
            issueStatus = item['issueStatus'] ?? 'Not OK';
            WorkLocation = item['WorkLocation'] ?? '';
            issueStatusType = item['issueStatusType'] ?? '';

            // Decode issuetype as List<String>
            try {
              final List<String> decodedList =
                  List<String>.from(json.decode(item['issuetype'] ?? '[]'));
              issuetypeController = decodedList;
            } catch (e) {
              print("Error decoding issuetype: $e");
              issuetypeController = [];
            }

            // Call the QC API if we have a barcode
            if (item['productBarcode'] != null &&
                item['productBarcode'].toString().isNotEmpty) {
              fetchQcApiData(item['productBarcode']);
            }
          }
        });
      }
    } catch (e) {
      print("Error in _get(): $e");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<bool> redirectto() async {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return widget.id != "" && widget.id != null
          ? QualityList()
          : QualityPage();
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
                    return widget.id != "" && widget.id != null
                        ? FQCNewList()
                        : FqcNewPage();
                  }));
                },
              ),
              body: Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10, top: 15),
                child: _isLoading ? AppLoader() : _user(),
              ),
              // floatingActionButton: _getFAB(),
            )));
  }

  // Widget _getFAB() {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 70),
  //     child: FloatingActionButton(
  //       onPressed: () {
  //         createData(
  //           "Inprogress",
  //           shiftController ?? "",
  //           productBarcodeController.text,
  //           issueStatus ?? "",
  //           issuetypeController != null ? issuetypeController!.join(", ") : "",
  //         );
  //         // setState(() {
  //         //   setStatus = 'Inprogress';
  //         // });
  //       },
  //       child: ClipOval(
  //         child: Image.asset(
  //           AppAssets.save,
  //           height: 70,
  //           width: 60,
  //         ),
  //       ),
  //     ),
  //   );
  // }

//   TextFormField textProductBarcode() {
//     return TextFormField(
//       controller: productBarcodeController,
//       decoration: AppStyles.textFieldInputDecoration.copyWith(
//         hintText: "Please Scan Module Barcode.",
//         counterText: '',
//         contentPadding: EdgeInsets.all(10),
//         suffixIcon: IconButton(
//           // onPressed: () async {
//           //   barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           //     '#FF6666',
//           //     'Cancel',
//           //     true,
//           //     ScanMode.DEFAULT,
//           //   );

//           //   setState(() {
//           //     productBarcodeController.text =
//           //         (barcodeScanRes != "-1" ? barcodeScanRes : '')!;
//           //   });

//           //   if (barcodeScanRes != '' &&
//           //       barcodeScanRes != null &&
//           //       barcodeScanRes != "-1") {
//           //     fetchQcApiData(barcodeScanRes!);
//           //   }
//           // },
//           onPressed: () async {
//   // Show the scanner page and get the result
//   final barcode = await Navigator.push<String>(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const BarcodeScannerWidget(),
//     ),
//   );

//   // Handle the scanned barcode
//   if (barcode != null && barcode.isNotEmpty && barcode != "-1") {
//     setState(() {
//       productBarcodeController.text = barcode;
//     });

//     print("Scan.......?");
//     print(productBarcodeController.text);

//     fetchQcApiData(barcode);
//   }
// },

//           icon: const Icon(Icons.qr_code),
//         ),
//       ),
//       readOnly: true,
//       style: AppStyles.textInputTextStyle,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please Scan Module Barcode.';
//         }
//         return null;
//       },
//       onChanged: (value) {
//         int val = value.length;
//         print("Module Barcode Changed: $val");
//         if (value != "" && value != null && val >= 16) {
//           print("Module Barcode Changed: $value");
//           fetchQcApiData(value!);
//         }

//         // This will be called whenever the text changes

//         // You can add custom logic here if needed
//       },
//     );
//   }
// Widget textProductBarcode() {
//   return TextFormField(
//     controller: productBarcodeController,
//     decoration: AppStyles.textFieldInputDecoration.copyWith(
//       hintText: "Please Scan Module Barcode.",
//       counterText: '',
//       contentPadding: const EdgeInsets.all(10),
//       suffixIcon: IconButton(
//         onPressed: () async {
//           try {
//             // Show the scanner page and get the result
//             final barcode = await Navigator.push<String>(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const BarcodeScannerWidget(),
//               ),
//             );

//             // Handle the scanned barcode
//             if (barcode != null && barcode.isNotEmpty && barcode != "-1") {
//               setState(() {
//                 productBarcodeController.text = barcode;
//               });

//               print("Scan successful: ${productBarcodeController.text}");

//               // Call your API with the scanned barcode
//               fetchQcApiData(barcode);
//             }
//           } catch (e) {
//             print('Barcode scan failed: $e');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Error scanning barcode: $e'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         icon: const Icon(Icons.qr_code),
//       ),
//     ),
//     readOnly: true,
//     style: AppStyles.textInputTextStyle,
//     validator: (value) {
//       if (value == null || value.isEmpty) {
//         return 'Please Scan Module Barcode.';
//       }
//       return null;
//     },
//     onChanged: (value) {
//       int val = value.length;
//       print("Module Barcode Changed: $val");
//       if (value.isNotEmpty && val >= 16) {
//         print("Module Barcode Changed: $value");
//         fetchQcApiData(value);
//       }
//     },
//   );
// }

  Widget textProductBarcode() {
    return TextFormField(
      controller: productBarcodeController,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
        hintText: "Please Scan Module Barcode.",
        counterText: '',
        contentPadding: const EdgeInsets.all(10),
        suffixIcon: IconButton(
          onPressed: () async {
            try {
              // Show the scanner page and get the result
              // Using continuousScan: false for single scan mode
              final barcode = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarcodeScannerWidget(
                    continuousScan: false, // Single scan mode
                  ),
                ),
              );

              // Handle the scanned barcode
              if (barcode != null && barcode.isNotEmpty && barcode != "-1") {
                setState(() {
                  productBarcodeController.text = barcode;
                });

                print("Scan successful: ${productBarcodeController.text}");

                // Call your API with the scanned barcode
                if (fetchQcApiData != null) {
                  fetchQcApiData(barcode);
                }
              }
            } catch (e) {
              print('Barcode scan failed: $e');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error scanning barcode: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          icon: const Icon(Icons.qr_code),
        ),
      ),
      readOnly: true,
      style: AppStyles.textInputTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please Scan Module Barcode.';
        }
        return null;
      },
      onChanged: (value) {
        int val = value.length;
        print("Module Barcode Changed: $val");
        if (value.isNotEmpty && val >= 16) {
          print("Module Barcode Changed: $value");
          fetchQcApiData(value);
        }
      },
    );
  }

  // Stringer

  TextFormField textOtherIssueType() {
    return TextFormField(
      controller: otherissuetypeController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter Issue Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter issue type';
        }
        return null;
      },
    );
  }

  TextFormField remarks() {
    return TextFormField(
      controller: remarksController,
      minLines: 1,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.next,
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Enter remarks",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      style: AppStyles.textInputTextStyle,
      readOnly: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter remarks';
        }
        return null;
      },
    );
  }

  Future<void> fetchQcApiData(String barcode) async {
    print("Starting API call...");
    setState(() {
      isLoading = true;
    });

    final String apiUrl = "https://www.umanmrp.in/api/qcApi.php";

    // Pass everything in the headers
    // final Map<String, String> headers = {
    //   'apiKey': "mrpap1Dqcp1",
    //   'barcode': "GS03540M27624003414",
    //   'store_id': "1",
    // };

    try {
      final String storeId = WorkLocationName == "Baliyali Unit 1"
          ? '4'
          : WorkLocationName == "Haridwar Unit 1"
              ? '2'
              : WorkLocationName == "Haridwar Unit 2"
                  ? '1'
                  : '3'; // Default value

      final Map<String, String> payload = {
        'apikey': 'mrp-ap1D-qc@p1',
        'type': 'fqc',
        'barcode': barcode,
        'storeid': storeId,
      };

      payload.forEach((key, value) {
        print('$key: $value');
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: payload,
      );

      if (response.statusCode == 200) {
        final rawBody = response.body;
        print('Raw Body: $rawBody'); // Step 1

        final decoded = jsonDecode(rawBody);
        print('Decoded Keys: ${decoded.keys}'); // Step 2

        final prettyJson = const JsonEncoder.withIndent('  ').convert(decoded);
        debugPrint('Pretty Response:\n$prettyJson', wrapWidth: 1024); // Step 3

        setState(() {
          apiResponse = decoded;
        });
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        print("Response body: ${response}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getMultipleBarcodeRejectionData() async {
    List<String> barcodes =
        itemsData.map((e) => e['moduleBarcode'] as String).toList();

    setState(() {
      isLoading = true;
    });

    final String apiUrl = "https://umanmrp.in/api/qcApiBarcodes.php";

    try {
      final String storeId = WorkLocationName == "Baliyali Unit 1"
          ? '4'
          : WorkLocationName == "Haridwar Unit 1"
              ? '2'
              : WorkLocationName == "Haridwar Unit 2"
                  ? '1'
                  : '3'; // Default value

      final Map<String, dynamic> payload = {
        'apikey': 'mrp-ap1D-qc@p4',
        'barcodes': barcodes,
        'storeid': storeId,
      };

      print('Sending payload:');
      payload.forEach((key, value) {
        print('$key: $value');
      });

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        final rawBody = response.body;
        print('Raw Body: $rawBody');

        final decoded = jsonDecode(rawBody);

        showBarcodePopup(context, decoded.cast<Map<String, dynamic>>());

        setState(() {
          multiBarcodeResponse = List<Map<String, dynamic>>.from(decoded);
        });
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      print("Error occurred: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showBarcodePopup(
      BuildContext context, List<Map<String, dynamic>> barcodeData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Barcode Rejection Report"),
              SizedBox(height: 5),
              Text(
                "Total Pannel Scan: ${serialNumber}",
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.blue),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: barcodeData.length,
              itemBuilder: (context, index) {
                var barcode = barcodeData[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Barcode: ${barcode['id']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        _buildSection("Visual 90", barcode['visual90']),
                        SizedBox(height: 8),
                        _buildSection("Visual 360", barcode['visual360']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 120,
                  height: 45,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Close"),
                  ),
                ),
                SizedBox(
                  width: 120,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      createData(
                          "Completed",
                          lineController ?? "",
                          shiftController ?? "",
                          productBarcodeController.text,
                          issueStatus ?? "",
                          // issuetypeController,
                          otherissuetypeController.text ?? "",
                          issueStatusType ?? "",
                          remarksController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Submit"),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildSection(String title, Map<String, dynamic> section) {
    return section['reason'] != "no record found"
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 4),
              Text("Reason: ${section['reason'] ?? 'N/A'}"),
              Text(
                  "Location: ${section['location']?.isEmpty ?? true ? 'N/A' : section['location']}"),
              Text("Date: ${section['date'] ?? 'N/A'}"),
              Text("Time: ${section['time'] ?? 'N/A'}"),
              Text("Username: ${section['username'] ?? 'N/A'}"),
            ],
          )
        : Container();
  }

  getStringData() async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'Quality/typeStringer');
    print("Fetching data from: $url");

    http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    ).then((response) {
      if (mounted) {
        var issueBody = jsonDecode(response.body);
        setState(() {
          stringList = issueBody;
        });
      }
    });
  }

  // getIssueData(issuetypeController) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   site = prefs.getString('site');

  //   final url = (site! + 'Quality/GetIssues');

  //   http.post(
  //     Uri.parse(url),
  //     headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   ).then((response) {
  //     if (mounted) {
  //       var issueBody = jsonDecode(response.body);
  //       setState(() {
  //         issueList = issueBody['Issues'];
  //         issueList.add({
  //           "IssueId": "9f00c67d-0b99-11ef-8005-52549f6cc694",
  //           "Issue": "Other"
  //         });
  //       });
  //     }
  //   });
  // }
  Future<void> getIssueData([String? issueId]) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      site = prefs.getString('site');

      if (site == null) {
        print("Site URL is null");
        return;
      }

      final url = Uri.parse(site! + 'Quality/GetIssues');
      print("Fetching from URL: $url");

      final response = await http.post(
        url,
        body: jsonEncode({
          "IssueId": issueId ?? "",
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!mounted) return;

      if (response.statusCode != 200) {
        print("Error: Status Code ${response.statusCode}");
        print("Response: ${response.body}");
        return;
      }

      final issueBody = jsonDecode(response.body);

      setState(() {
        if (issueId == null || issueId.isEmpty) {
          issueList = (issueBody['Issues'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];
        } else {
          subIssueList = (issueBody['Issues'] as List?)
                  ?.map((item) => Map<String, dynamic>.from(item))
                  .toList() ??
              [];
        }
      });
    } catch (e, stackTrace) {
      print("Error fetching issue/sub-issue data: $e");
      print("Stack trace: $stackTrace");
    }
  }

  DropdownButtonFormField textLine() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Line",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: lineList
          .map((label) => DropdownMenuItem(
                child: Text(label['factoryLines']!,
                    style: AppStyles.textInputTextStyle),
                value: label['factoryLines'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          lineController = val!;
        });
      },
      value: lineController != '' ? lineController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a line';
        }
        return null; // Return null if the validation is successful
      },
    );
  }

  DropdownButtonFormField textShift() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
          hintText: "Please Select Pallate Type",
          counterText: '',
          contentPadding: EdgeInsets.all(10)),
      borderRadius: BorderRadius.circular(20),
      items: shiftList
          .map((label) => DropdownMenuItem(
                child: Text(label['key']!, style: AppStyles.textInputTextStyle),
                value: label['value'].toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          shiftController = val!;
        });
      },
      value: shiftController != '' ? shiftController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select pallate type';
        }
        return null; // Return null if the validation is successful
      },
    );
  }

  Widget textIssueType() {
    return MultiSelectDialogField(
      items: issueList
          .map((label) => MultiSelectItem<String>(
                label['IssueId'].toString(),
                label['Issue'].toString(),
              ))
          .toList(),
      title: const Text("Please Select Issue Type"),
      buttonText: const Text("Please Select Issue Type"),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      initialValue: issuetypeController ?? [], // Ensure it's a list
      onConfirm: (values) {
        setState(() {
          issuetypeController =
              values.cast<String>(); // Store the selected values
        });
      },
      chipDisplay: MultiSelectChipDisplay(
        chipColor: Colors.blueAccent,
        textStyle: const TextStyle(color: Colors.white),
        onTap: (value) {
          setState(() {
            issuetypeController?.remove(value);
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select issue type';
        }
        return null;
      },
    );
  }

  DropdownButtonFormField textSubIssueType() {
    return DropdownButtonFormField<String>(
      decoration: AppStyles.textFieldInputDecoration.copyWith(
        hintText: "Please Select Sub-Issue Type",
        counterText: '',
        contentPadding: const EdgeInsets.all(10),
      ),
      borderRadius: BorderRadius.circular(20),
      items: subIssueList
          .map((label) => DropdownMenuItem(
                child: Text(label['ChildIssue']?.toString() ?? '',
                    style: AppStyles.textInputTextStyle),
                value: label['ChildIssueId']?.toString(),
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          subissuetypeController = val;
        });
      },
      value: subissuetypeController != '' ? subissuetypeController : null,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a sub-issue type';
        }
        return null;
      },
    );
  }

  // laminator

  Widget subLaminatorType() {
    return Column(
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
                  itemsData = [];
                  int serialNumber = 0;
                  for (int i = 0; i < serialNumber; i++) {
                    barcodeControllers.add(TextEditingController());
                  }
                  setState(() {
                    issueStatus = val!;
                    issueStatusType = '';
                    issuetypeController = [];
                    otherissuetypeController.text = '';
                    remarksController.text = "";
                    _image = null;
                    _imageBytes = null;
                  });
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: Text("Not OK", style: AppStyles.textInputTextStyle),
                value: "Not OK",
                groupValue: issueStatus,
                onChanged: (val) {
                  itemsData = [];
                  int serialNumber = 0;
                  for (int i = 0; i < serialNumber; i++) {
                    barcodeControllers.add(TextEditingController());
                  }
                  setState(() {
                    issueStatus = val!;
                  });
                  // fetchQcApiData(productBarcodeController.text);
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
    );
  }

  Widget subLaminator1Type() {
    return Column(
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
                title: Text("Pass", style: AppStyles.textInputTextStyle),
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
                title: Text("Reject", style: AppStyles.textInputTextStyle),
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
            // Expanded(
            //   child: RadioListTile<String>(
            //     title: Text("Rework", style: AppStyles.textInputTextStyle),
            //     value: "Rework",
            //     groupValue: issueStatusType,
            //     onChanged: (val) {
            //       setState(() {
            //         issueStatusType = val!;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: Text("Rework", style: AppStyles.textInputTextStyle),
                value: "Rework",
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
        if (issueStatusType == null ||
            issueStatusType == "") // Show error if no option is selected
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Please select Issue Status.',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  Future createData(
      String status,
      String line,
      String shift,
      String productBarcode,
      String issueStatus,
      // List issuetype,
      String otherissuetype,
      String issueStatusType,
      String remarksController) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    final url = (site! + 'TestEquipmet/AddNewFQC'); // Prod

    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(<String, dynamic>{
        "fqcnewid":
            widget.id != "" && widget.id != null ? widget.id.toString() : "",
        "currentuser": personid ?? '',
        "line": line,
        "status": status,
        "pallateType": shift,
        "issueStatus": issueStatus,
        "productBarcode": issueStatus == "Not OK" ? productBarcode : itemsData,
        "productTestReport": issueStatus == "Not OK"
            ? apiResponse.toString()
            : multiBarcodeResponse,
        "issuetype": jsonEncode(issuetypeController),
        "otherissuetype": otherissuetype,
        "WorkLocation": WorkLocation ?? "",
        "issueStatusType": issueStatusType,
        "Remark": remarksController
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print({
      "fqcnewid":
          widget.id != "" && widget.id != null ? widget.id.toString() : "",
      "currentuser": personid ?? '',
      "line": line,
      "status": status,
      "pallateType": shift,
      "issueStatus": issueStatus,
      "productBarcode":
          issueStatus == "Not OK" ? productBarcode : itemsData.toString(),
      "productTestReport": issueStatus == "Not OK"
          ? apiResponse.toString()
          : multiBarcodeResponse.toString(),
      "issuetype": jsonEncode(issuetypeController),
      "Remark": remarksController
    });
    print(response.body);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      setState(() {
        setpersonid = data['UUID'];
      });
      if (_imageBytes != null && _imageBytes != '') {
        upload((_imageBytes ?? []), (productBarcode ?? ''));
      } else {
        Toast.show("Issue reporting successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.primaryColor);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => FQCNewList()),
            (Route<dynamic> route) => false);
      }
    } else if (response.statusCode == 400) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("This Issue is Already Reported.",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
    } else if (response.statusCode == 409) {
      setState(() {
        _isLoading = false;
      });
      Toast.show("This Barcode Number is Already Exist.",
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.redAccent);
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

  Future upload(
    List<int> imageBytes,
    String name,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    site = prefs.getString('site');

    var currentdate = DateTime.now().microsecondsSinceEpoch;

    // Create FormData with both images
    Map<String, dynamic> formDataMap = {
      'fqcnewid': setpersonid != '' && setpersonid != null ? setpersonid : '',
    };

// Add ModuleImage conditionally
    if (imageBytes != null && imageBytes.isNotEmpty) {
      formDataMap["image"] = MultipartFile.fromBytes(
        imageBytes,
        filename: '${name}${currentdate.toString()}.jpg',
        contentType: MediaType("image", 'jpg'),
      );
    }

// Add ElModuleImage conditionally
    // if (elImageBytes != null && elImageBytes.isNotEmpty) {
    //   formDataMap["ElModuleImage"] = MultipartFile.fromBytes(
    //     elImageBytes,
    //     filename: '${name}${currentdate.toString()}.jpg',
    //     contentType: MediaType("image", 'jpg'),
    //   );
    // }

// Create FormData from the map
    var formData = FormData.fromMap(formDataMap);

    try {
      print("Payload:");
      formData.fields.forEach((field) {
        print("${field.key}: ${field.value}");
      });
      formData.files.forEach((file) {
        print(
            "${file.key}: ${file.value.filename} (${file.value.contentType})");
      });

      _response =
          await _dio.post((site! + 'TestEquipmet/UploadNewFQCImage'), // Prod
              options: Options(
                contentType: 'multipart/form-data',
                followRedirects: false,
                validateStatus: (status) => true,
              ),
              data: formData);

      print("Response:");
      print("Status Code: ${_response?.statusCode}");
      print("Response Data: ${_response?.data}");

      if (_response?.data != null) {
        setState(() {
          _isLoading = false;
        });
        print("Upload....?");
        print(_response!.data);

        Toast.show("Issue reporting successfully.",
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: AppColors.primaryColor);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => FQCNewList()),
            (Route<dynamic> route) => false);
      }
    } catch (err) {
      print("Error");
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
          // const Center(
          //     child: Padding(
          //         padding: EdgeInsets.only(top: 10),
          //         child: Text("Incoming Quality Control Plan",
          //             style: TextStyle(
          //                 fontSize: 27,
          //                 color: AppColors.black,
          //                 fontFamily: appFontFamily,
          //                 fontWeight: FontWeight.w700)))),
          const Center(
              child: Text("FQC",
                  style: TextStyle(
                      fontSize: 25,
                      color: AppColors.black,
                      fontFamily: appFontFamily,
                      fontWeight: FontWeight.w700))),
          const SizedBox(
            height: 25,
          ),
          if (WorkLocationName == "Baliyali Unit 1")
            Text(
              "Select Line*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
          if (WorkLocationName == "Baliyali Unit 1") const SizedBox(height: 5),
          if (WorkLocationName == "Baliyali Unit 1") textLine(),

          const SizedBox(
            height: 15,
          ),
          Text(
            "Pallate Type*",
            style: AppStyles.textfieldCaptionTextStyle,
          ),
          const SizedBox(height: 5),
          textShift(),

          const SizedBox(
            height: 15,
          ),
          if (WorkLocationName == "Baliyali Unit 1")
            Text(
              "Module Status*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
          if (WorkLocationName == "Baliyali Unit 1") const SizedBox(height: 5),
          if (WorkLocationName == "Baliyali Unit 1") subLaminatorType(),

          const SizedBox(
            height: 15,
          ),
          if (issueStatus == "Not OK")
            Text(
              "Module Barcode*",
              style: AppStyles.textfieldCaptionTextStyle,
            ),
          if (issueStatus == "OK") const SizedBox(height: 5),
          if (issueStatus == "OK")
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemCount: serialNumber,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(5.0),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.stretch,
            //         children: [
            //           const SizedBox(height: 10),
            //           Text(
            //             "Module Barcode*",
            //             style: AppStyles.textfieldCaptionTextStyle,
            //           ),
            //           const SizedBox(height: 2),
            //           TextFormField(
            //             controller: barcodeControllers[index],
            //             readOnly: true,
            //             decoration: AppStyles.textFieldInputDecoration.copyWith(
            //               hintText: "Please Scan Module Barcode.",
            //               counterText: '',
            //               contentPadding: EdgeInsets.all(10),
            //               fillColor: const Color.fromARGB(255, 255, 255, 255)
            //                   .withOpacity(0.5),
            //               filled: true,
            //               suffixIcon: IconButton(
            //                 onPressed: () => scanBarcode(index),
            //                 icon: const Icon(Icons.qr_code),
            //               ),
            //             ),
            //             style: AppStyles.textInputTextStyle,
            //             validator: (value) {
            //               if (value == null || value.isEmpty) {
            //                 return 'Please Scan Module Barcode.';
            //               }
            //               return null;
            //             },
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // ),

            // Column(
            //   children: [
            //     ListView.builder(
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemCount: barcodeControllers.length,
            //       itemBuilder: (context, index) {
            //         return Padding(
            //           padding: const EdgeInsets.all(5.0),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text("Module Barcode*"),
            //               TextFormField(
            //                 controller: barcodeControllers[index],
            //                 readOnly: true,
            //                 decoration: InputDecoration(
            //                   hintText: "Scanned Module Barcode",
            //                   suffixIcon: Icon(Icons.check),
            //                   filled: true,
            //                   fillColor: Colors.grey.shade200,
            //                   contentPadding: EdgeInsets.all(10),
            //                 ),
            //                 validator: (value) {
            //                   if (value == null || value.isEmpty) {
            //                     return 'Please Scan Module Barcode.';
            //                   }
            //                   return null;
            //                 },
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //     SizedBox(
            //       height: 15,
            //     ),
            //     ElevatedButton.icon(
            //       onPressed: scanAndAddBarcode,
            //       icon: Icon(Icons.qr_code_scanner, size: 28),
            //       label: Text(
            //         'Scan & Add',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor:
            //             Colors.deepPurple, // or Theme.of(context).primaryColor
            //         foregroundColor: Colors.white,
            //         padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            //         elevation: 8,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //       ),
            //     )
            //   ],
            // ),

            Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: barcodeControllers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Module Barcode*"),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: barcodeControllers[index],
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: "Scanned Module Barcode",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (barcodeControllers.length > 1) {
                                            serialNumber--;
                                            barcodeControllers.removeAt(index);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.remove_circle,
                                          color: Colors.red),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    contentPadding: EdgeInsets.all(10),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Scan Module Barcode.';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: scanAndAddBarcode,
                  icon: Icon(Icons.qr_code_scanner, size: 28),
                  label: Text(
                    'Scan Pannel',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),

          // if (issueStatus == "OK") const SizedBox(height: 10),

          // if (issueStatus == "OK")
          //   Container(
          //     margin: EdgeInsets.only(right: 10, bottom: 10),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         // Total Module box
          //         Container(
          //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //           decoration: BoxDecoration(
          //             color: Colors.green,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Text(
          //             "Total Module:  $serialNumber",
          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 16,
          //               fontWeight: FontWeight.bold,
          //             ),
          //             textAlign: TextAlign.center,
          //           ),
          //         ),

          //         // Remove button
          //         ElevatedButton(
          //           onPressed: () {
          //             setState(() {
          //               if (serialNumber > 1) {
          //                 serialNumber--;
          //                 barcodeControllers.removeLast();
          //               }
          //             });
          //           },
          //           style: ElevatedButton.styleFrom(
          //             backgroundColor: Colors.red,
          //             padding:
          //                 EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //           ),
          //           child: Text(
          //             "Remove",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),

          if (issueStatus == "Not OK") textProductBarcode(),
          const SizedBox(height: 15),

          if (apiResponse.isNotEmpty && issueStatus == "Not OK")
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (apiResponse.containsKey("lamination")) ...[
                    Text("Lamination",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Date: ${apiResponse["lamination"]["date"] ?? "N/A"}"),
                    Text("Time: ${apiResponse["lamination"]["time"] ?? "N/A"}"),
                    Text(
                        "Supervisor: ${apiResponse["lamination"]["username"] ?? "N/A"}"),
                    Divider(color: Colors.grey),
                  ],
                  if (apiResponse.containsKey("visual90")) ...[
                    Text("Visual90 Rejection",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                        "Reason: ${apiResponse["visual90"]["reason"] ?? "N/A"}"),
                    Text(
                        "Location: ${apiResponse["visual90"]["location"] ?? "N/A"}"),
                    Text("Date: ${apiResponse["visual90"]["date"] ?? "N/A"}"),
                    Text("Time: ${apiResponse["visual90"]["time"] ?? "N/A"}"),
                    Text(
                        "Supervisor: ${apiResponse["visual90"]["username"] ?? "N/A"}"),
                    Divider(color: Colors.grey),
                  ],
                  if (WorkLocationName == "Baliyali Unit 1" &&
                      apiResponse.containsKey("visual360")) ...[
                    Text("Visual360 Rejection",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                        "Reason: ${apiResponse["visual360"]["reason"] ?? "N/A"}"),
                    Text(
                        "Location: ${apiResponse["visual360"]["location"] ?? "N/A"}"),
                    Text("Date: ${apiResponse["visual360"]["date"] ?? "N/A"}"),
                    Text("Time: ${apiResponse["visual360"]["time"] ?? "N/A"}"),
                    Text(
                        "Supervisor: ${apiResponse["visual360"]["username"] ?? "N/A"}"),
                    Divider(color: Colors.grey),
                  ],
                  if (apiResponse.containsKey("barcodeData")) ...[
                    Text("Barcode Data",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    if (WorkLocationName == "Baliyali Unit 1" &&
                        apiResponse["barcodeData"].containsKey("preEl")) ...[
                      Text(
                          "Pre-EL Date: ${formatValue(apiResponse["barcodeData"]["preEl"]["date"])}"),
                      Text(
                          "Pre-EL Time: ${formatValue(apiResponse["barcodeData"]["preEl"]["time"])}"),
                    ],
                    if (WorkLocationName == "Baliyali Unit 1" &&
                        apiResponse["barcodeData"].containsKey("framing")) ...[
                      Text(
                          "Framing Date: ${formatValue(apiResponse["barcodeData"]["framing"]["date"])}"),
                      Text(
                          "Framing Time: ${formatValue(apiResponse["barcodeData"]["framing"]["time"])}"),
                    ],
                    Divider(color: Colors.grey),
                  ],
                  if (WorkLocationName == "Baliyali Unit 1" &&
                      apiResponse.containsKey("supervisors")) ...[
                    Text("Supervisors",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(
                        "Pre-Lam Supervisors: ${formatValue(apiResponse["supervisors"]["preLam"])}"),
                    Text(
                        "Post-Lam Supervisors: ${formatValue(apiResponse["supervisors"]["postLam"])}"),
                    Divider(color: Colors.grey),
                  ],
                ],
              ),
            ),

          if (issueStatus == "Not OK")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Issue Type*",
                  style: AppStyles.textfieldCaptionTextStyle,
                ),
                const SizedBox(height: 5),
                textIssueType(),
                const SizedBox(height: 15),

                // Text(
                //   "Issue Status*",
                //   style: AppStyles.textfieldCaptionTextStyle,
                // ),
                const SizedBox(height: 5),
                subLaminator1Type(),
                const SizedBox(height: 15),
                Text(
                  "Remarks*",
                  style: AppStyles.textfieldCaptionTextStyle,
                ),
                const SizedBox(height: 5),

                remarks(),
                const SizedBox(height: 15),
                Text(
                  "Capture Module Pic*",
                  style: AppStyles.textfieldCaptionTextStyle,
                ),
                const SizedBox(height: 10),
                _image == null
                    ? Container(
                        width: 300,
                        height: 300,
                        child: GestureDetector(
                          onTap: () {
                            getImage();
                          },
                          child: widget.id != "" &&
                                  widget.id != null &&
                                  modulepicture != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: ((modulepicture ?? '')),
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppAssets.camera,
                                    fit: BoxFit.cover,
                                    width: 300,
                                    height: 300,
                                  ),
                                ),
                        ),
                      )
                    : Container(
                        width: 300,
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                if (_image == null && (widget.id == "" || modulepicture == ""))
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Please capture the Module picture.",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
              ],
            ),

          // if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
          //   Text(
          //     "Sub Foreign Particle*",
          //     style: AppStyles.textfieldCaptionTextStyle,
          //   ),
          // if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
          //   const SizedBox(
          //     height: 5,
          //   ),
          // if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
          //   textSubForeignParticle(),
          // if (issuetypeController == "f1e24387-9e85-11ef-80b2-1a2cd4d9c0d1")
          //   const SizedBox(
          //     height: 15,
          //   ),
          // if (subIssueList.isNotEmpty) ...[
          //   Text(
          //     "Sub Issue Type*",
          //     style: AppStyles.textfieldCaptionTextStyle,
          //   ),
          //   const SizedBox(
          //     height: 5,
          //   ),
          //   textSubIssueType(),
          //   const SizedBox(
          //     height: 15,
          //   ),
          // ],

          // Text(
          //   "Capture Module Pic*",
          //   style: AppStyles.textfieldCaptionTextStyle,
          // ),
          // const SizedBox(height: 10),
          // _image == null
          //     ? Container(
          //         width: 300, // Set the desired width
          //         height: 300, // Set the desired height
          //         child: GestureDetector(
          //           onTap: () {
          //             getImage();
          //           },
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(
          //                 10), // Adjust the radius to your preference
          //             child: Image.asset(
          //               AppAssets.camera,
          //               fit: BoxFit.cover,
          //               width:
          //                   300, // Set width and height to match Container's size
          //               height: 300,
          //             ),
          //           ),
          //         ),
          //       )
          //     : Container(
          //         width: 300, // Set the desired width
          //         height: 300, // Set the desired height
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(10),
          //           child: Image.file(
          //             _image!, // Assuming _image is a File object
          //             fit: BoxFit.cover,
          //             width:
          //                 300, // Set width and height to match Container's size
          //             height: 300,
          //           ),
          //         ),
          //       ),

          const SizedBox(height: 30),

          AppButton(
            organization: (organizationtype ?? ''),
            textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                fontSize: 16),
            onTap: () async {
              if (qualityformKey.currentState!.validate()) {
                bool isBaliyali = WorkLocationName == "Baliyali Unit 1";
                // if (shiftController != null &&
                //     shiftController != "" &&
                //     productBarcodeController.text != "" &&
                //     issueStatus != "" &&
                //     issueStatus != null) {
                // Additional checks only when issueStatus is "Not OK"
                if (issueStatus == "Not OK") {
                  itemsData = [];
                  if (issuetypeController != null &&
                      issuetypeController!.isNotEmpty &&
                      issueStatusType != null &&
                      issueStatusType!.isNotEmpty &&
                      remarksController != null &&
                      shiftController != null &&
                      shiftController != "" &&
                      (!isBaliyali ||
                          (lineController != null && lineController != "")) &&
                      productBarcodeController.text != "" &&
                      (_image != null ||
                          (widget.id != "" && modulepicture != ""))) {
                    createData(
                        "Completed",
                        lineController ?? "",
                        shiftController ?? "",
                        productBarcodeController.text,
                        issueStatus ?? "",
                        // issuetypeController,
                        otherissuetypeController.text ?? "",
                        issueStatusType ?? "",
                        remarksController.text);
                  } else {
                    Toast.show("Please fill all required field.",
                        duration: Toast.lengthLong,
                        gravity: Toast.center,
                        backgroundColor: Colors.redAccent);
                  }
                } else {
                  itemsData = [];
                  print("Hit...............?");

                  for (int i = 0; i < serialNumber; i++) {
                    itemsData
                        .add({"moduleBarcode": barcodeControllers[i].text});
                  }

                  if (serialNumber == 0) {
                    Toast.show("Please Scan Pannel.",
                        duration: Toast.lengthLong,
                        gravity: Toast.center,
                        backgroundColor: Colors.redAccent);
                  } else {
                    getMultipleBarcodeRejectionData();
                  }

                  // If issueStatus is NOT "Not OK", proceed without checking issue type and image
                  // createData(
                  //     "Completed",
                  //     shiftController ?? "",
                  //     productBarcodeController.text,
                  //     issueStatus ?? "",
                  //     // issuetypeController != null
                  //     //     ? issuetypeController!.join(", ")
                  //     //     : "",
                  //     otherissuetypeController.text ?? "",
                  //     issueStatusType ?? "",
                  //     remarksController.text);
                }
                // }
              }
            },
            label:
                issueStatus == "Not OK" ? AppStrings.SAVE : "Check Rejection",
          ),
          SizedBox(height: 10),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              widget.id != "" && widget.id != null
                                  ? FQCNewList()
                                  : FqcNewPage()),
                      (Route<dynamic> route) => false);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      fontFamily: appFontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.redColor),
                ),
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
