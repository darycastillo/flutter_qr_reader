import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter_qr_reader/models/scan_model.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({Key? key}) : super(key: key);

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final Completer<GoogleMapController> _controller = Completer();
  MapType maptype = MapType.hybrid;

  @override
  Widget build(BuildContext context) {
    final scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 100);

    final Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
          markerId: const MarkerId('geo-location'), position: scan.getLatLng()),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Mapa"),
          actions: [
            IconButton(
                onPressed: () async {
                  final GoogleMapController controller =
                      await _controller.future;
                  controller.animateCamera(
                      CameraUpdate.newCameraPosition(puntoInicial));
                },
                icon: const Icon(Icons.location_on))
          ],
        ),
        body: GoogleMap(
          myLocationButtonEnabled: false,
          mapType: maptype,
          markers: markers,
          initialCameraPosition: puntoInicial,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.layers),
            onPressed: () {
              if (maptype == MapType.normal) {
                maptype = MapType.hybrid;
              } else {
                maptype = MapType.normal;
              }
              setState(() {});
            }));
  }
}
