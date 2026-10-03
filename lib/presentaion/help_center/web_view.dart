import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebViewPage extends StatefulWidget {
  const MyWebViewPage({super.key});

  @override
  State<MyWebViewPage> createState() => _MyWebViewPageState();
}

class _MyWebViewPageState extends State<MyWebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(Uri.parse('https://a2zenon.com'))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text('A2ZENON موقع',style: TextStyle(color: AppColors.text_gray_Dark,fontFamily: 'cairo'),),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
