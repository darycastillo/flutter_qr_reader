import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(BuildContext context, ScanModel scan) async {
  final url = scan.valor;

  if (scan.tipo == 'http') {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could no launc $url';
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
}
