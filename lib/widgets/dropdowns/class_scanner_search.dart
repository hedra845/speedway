import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/presentaion/orders/orders.dart';
import 'package:svg_flutter/svg.dart';

class BarcodeScannerScreen_search extends StatefulWidget {
  const BarcodeScannerScreen_search({super.key});
  

  @override
  _BarcodeScannerScreen_searchState createState() => _BarcodeScannerScreen_searchState();
}

class _BarcodeScannerScreen_searchState extends State<BarcodeScannerScreen_search> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true; // Flag to track scanning state

  void _onBarcodeDetect(BarcodeCapture capture) {
    if (!isScanning) return; // Prevent multiple scans

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? scannedValue = barcodes.first.rawValue;

      if (scannedValue != null) {
        setState(() {
          isScanning = false; // Stop scanning
        });

        cameraController.stop(); // Stop the camera

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Orders(search_scan: scannedValue),
          ),
        ).then((_) {
          setState(() {
            isScanning = true; // Resume scanning when returning
          });
          cameraController.start(); // Restart the camera
        });
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        title: const Text('Barcode Scanner',style: TextStyle(color: AppColors.text_gray_Dark,fontFamily: 'cairo'),),
         leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/images/icons/arrow-left.svg')),
        actions: [
          IconButton(
            icon:  Icon(Icons.flash_on,color: AppColors.black.withOpacity(0.5),),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon:  Icon(Icons.cameraswitch,color: AppColors.black.withOpacity(0.5),),
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: cameraController,
        onDetect: _onBarcodeDetect,
      ),
    );
  }
}