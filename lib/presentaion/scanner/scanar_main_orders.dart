import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:svg_flutter/svg.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  _BarcodeScannerScreenState createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanning = true;

  Future<void> _onBarcodeDetect(BarcodeCapture capture) async {
    if (!isScanning) return;

    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? scannedValue = barcodes.first.rawValue;

      if (scannedValue != null)  {
        setState(() {
          isScanning = false;
        });

        cameraController.stop();
        // ✅ رجع القيمة إلى الصفحة السابقة
        Navigator.pop(context, scannedValue);
      }
    }
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        title: const Text(
          'Barcode Scanner',
          style: TextStyle(color: AppColors.text_gray_Dark, fontFamily: 'cairo'),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/images/icons/arrow-left.svg'),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on, color: AppColors.black.withOpacity(0.5)),
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            icon: Icon(Icons.cameraswitch, color: AppColors.black.withOpacity(0.5)),
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
