import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:gelite/utils/colors.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/qrcontroller.dart';
import '../utils/helper.dart';

class qr extends StatefulWidget {
  const qr({super.key});

  @override
  State<qr> createState() => _qrState();
}

class _qrState extends State<qr> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final QRController qrcontroller = Get.put(QRController());

  Barcode? result;
  QRViewController? controller;
  String username = '';

  Future<void> user() async {
    SharedPreferences token = await SharedPreferences.getInstance();
    setState(() {
      username = token.getString('full_name').toString();
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.iconcolor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.backgroundColor,
                      radius: 45,
                      child: IconButton(
                        icon: Icon(
                          PhosphorIcons.flashlight,
                          color: AppColors.iconcolor,
                        ),
                        onPressed: () async {
                          await controller!.toggleFlash();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Flash ',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        print(result!.code);
        if (result!.code!.isNotEmpty) {
          setState(() {
            eventcode = result!.code.toString();
          });
          print(eventcode);

          controller!.pauseCamera();
          Get.toNamed('/LandingPage');
          qrcontroller.attendance(eventcode);
        }
        // pendinglist_();
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
