import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/providers/scan_list_provider.dart';
import 'package:flutter_qr_reader/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanTiles extends StatelessWidget {
  final String tipo;
  const ScanTiles({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanListProvider scanListProvider =
        Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (_, index) => Dismissible(
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (s) =>
                  scanListProvider.borrarScanById(scans[index].id!),
              key: UniqueKey(),
              child: ListTile(
                leading: Icon(
                  tipo == 'http' ? Icons.home_outlined : Icons.map_outlined,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(scans[index].valor),
                subtitle: Text('ID: ${scans[index].id}'),
                trailing:
                    const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
                onTap: () => launchURL(context, scans[index]),
              ),
            ));
  }
}
