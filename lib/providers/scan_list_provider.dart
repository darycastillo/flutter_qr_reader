import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipoSelecionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(newScan);
    //asignar id de base de datos
    newScan.id = id;

    if (tipoSelecionado == newScan.tipo) {
      scans.add(newScan);
      notifyListeners();
    }
    return newScan;
  }

  cargarScans() async {
    final res = await DBProvider.db.getAllScans();
    scans = [...res];
    notifyListeners();
  }

  cargarScansPorTipo(String tipo) async {
    final res = await DBProvider.db.getScansByType(tipo);
    scans = [...res];
    tipoSelecionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.delteAllScans();
    scans = [];
    notifyListeners();
  }

  borrarScanById(int id) async {
    await DBProvider.db.delteById(id);
    // cargarScansPorTipo(tipoSelecionado);
    scans.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
