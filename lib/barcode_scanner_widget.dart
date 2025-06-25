// import 'package:flutter/material.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// class BarcodeScannerWidget extends StatefulWidget {
//   final Function(String) onBarcodeDetected;
//   const BarcodeScannerWidget({Key? key, required this.onBarcodeDetected}) : super(key: key);
//   @override
//   State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
// }

// class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> with SingleTickerProviderStateMixin {
//   // Create a controller that can be disposed
//   late MobileScannerController controller;
//   bool isScanning = true;
  
//   // Animation controller for the scanning line
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize with optimized settings
//     controller = MobileScannerController(
//       // Set to fastest detection speed
//       detectionSpeed: DetectionSpeed.normal,
//       // Use the back camera
//       facing: CameraFacing.back,
//       // Enable auto-focus
//       torchEnabled: true,
//     );
    
//     // Initialize animation controller for scanning line
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     );
    
//     _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.linear,
//       ),
//     );
    
//     // Make the animation repeat up and down
//     _animationController.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     // Clean up controllers when widget is disposed
//     controller.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan Barcode'),
//         actions: [
//           // Add flashlight toggle
//           IconButton(
//             icon: ValueListenableBuilder(
//               valueListenable: controller.torchState,
//               builder: (context, state, child) {
//                 return Icon(
//                   state == TorchState.off ? Icons.flash_off : Icons.flash_on,
//                 );
//               },
//             ),
//             onPressed: () => controller.toggleTorch(),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 // Scanner
//                 MobileScanner(
//                   controller: controller,
//                   onDetect: (capture) {
//                     if (!isScanning) return; // Prevent multiple detections
                    
//                     final barcodes = capture.barcodes;
//                     if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
//                       // Set scanning flag to false to prevent multiple callbacks
//                       setState(() {
//                         isScanning = false;
//                       });
                      
//                       // Stop the animation
//                       _animationController.stop();
                      
//                       // Show a brief success indicator
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Barcode detected!'),
//                           duration: Duration(milliseconds: 500),
//                           backgroundColor: Colors.green,
//                         ),
//                       );
                      
//                       // Give visual feedback
//                       Future.delayed(const Duration(milliseconds: 300), () {
//                         Navigator.pop(context);
//                         widget.onBarcodeDetected(barcodes.first.rawValue!);
//                       });
//                     }
//                   },
//                 ),
                
//                 // Scanning line animation
//                 AnimatedBuilder(
//                   animation: _animationController,
//                   builder: (context, child) {
//                     return Positioned(
//                       top: MediaQuery.of(context).size.height * 0.25 + 
//                             (_animation.value * MediaQuery.of(context).size.height * 0.5),
//                       left: 0,
//                       right: 0,
//                       child: Container(
//                         height: 2,
//                         color: Colors.red.withOpacity(0.8),
//                       ),
//                     );
//                   },
//                 ),
                
//                 // Optional scan frame overlay
//                 Center(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.8,
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Add scanning overlay with instructions
//           Container(
//             color: Colors.black.withOpacity(0.8),
//             padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
//             child: Column(
//               children: const [
//                 Text(
//                   'Point camera at barcode',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 SizedBox(height: 4),
//                 Text(
//                   'Scanning will happen automatically',
//                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerWidget extends StatefulWidget {
  final void Function(String)? onBarcodeDetected;
  final bool continuousScan; // Control scanning mode
  final int delayBetweenScans; // Milliseconds to wait between scans

  const BarcodeScannerWidget({
    Key? key, 
    this.onBarcodeDetected,
    this.continuousScan = false, // Default to single scan mode
    this.delayBetweenScans = 1500, // Default 1.5 seconds between scans
  }) : super(key: key);

  @override
  State<BarcodeScannerWidget> createState() => _BarcodeScannerWidgetState();
}

class _BarcodeScannerWidgetState extends State<BarcodeScannerWidget> with SingleTickerProviderStateMixin {
  late MobileScannerController controller;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isScanning = true;
  String? lastScannedBarcode;
  bool canScan = true; // Flag to control scan cooldown
  
  @override
  void initState() {
    super.initState();

    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
      torchEnabled: false, // Start with torch off
    );

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    // Don't process if we're not scanning or in cooldown period
    if (!isScanning || !canScan) return;

    final barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      final String barcode = barcodes.first.rawValue!;
      
      // Skip if this is the same barcode as the last one
      if (barcode == lastScannedBarcode) {
        return;
      }
      
      // Update the last scanned barcode
      lastScannedBarcode = barcode;
      
      // Prevent multiple scans by setting cooldown
      setState(() {
        canScan = false;
      });
      
      // Show feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Barcode detected: $barcode'),
          duration: const Duration(milliseconds: 800),
          backgroundColor: Colors.green,
        ),
      );

      // Call the callback if provided
      widget.onBarcodeDetected?.call(barcode);

      if (widget.continuousScan) {
        // In continuous mode, don't close the scanner
        // Just allow scanning again after a delay
        Future.delayed(Duration(milliseconds: widget.delayBetweenScans), () {
          if (mounted) {
            setState(() {
              canScan = true; // Enable scanning again after delay
            });
          }
        });
      } else {
        // In single scan mode, stop scanning and return the result
        setState(() {
          isScanning = false;
        });
        
        _animationController.stop();
        
        // Return the barcode to the caller after a brief delay
        Future.delayed(const Duration(milliseconds: 300), () {
          Navigator.pop(context, barcode);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.continuousScan ? 'Continuous Scan' : 'Scan Barcode'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, null); // Return null to indicate cancellation
          },
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: controller.torchState,
              builder: (context, state, child) {
                return Icon(
                  state == TorchState.off ? Icons.flash_off : Icons.flash_on,
                );
              },
            ),
            onPressed: () => controller.toggleTorch(),
          ),
          // Add a close button with clear text
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('CLOSE'),
            onPressed: () {
              Navigator.pop(context, null); // Return null to indicate cancellation
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  controller: controller,
                  onDetect: _onBarcodeDetected,
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Positioned(
                      top: MediaQuery.of(context).size.height * 0.25 +
                          (_animation.value * MediaQuery.of(context).size.height * 0.5),
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 2,
                        color: Colors.red.withOpacity(0.8),
                      ),
                    );
                  },
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Column(
              children: [
                const Text(
                  'Point camera at barcode',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.continuousScan 
                      ? 'Continuous scanning mode - press CLOSE when done'
                      : 'Scanning will happen automatically',
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}