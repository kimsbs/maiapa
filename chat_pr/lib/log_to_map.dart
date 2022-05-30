import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:chat_pr/log_page.dart';

class logMap extends StatefulWidget {

  final Para parameter;
  logMap({Key? key, required this.parameter}) : super(key: key);
  @override
  State<logMap> createState() => _logMapState();

}

class _logMapState extends State<logMap> {
  @override

  Widget build(BuildContext context){
    print("===================MARK======================");
    print(widget.parameter.lat_para);
    print(widget.parameter.lng_para);
    print(widget.parameter.idx);

    final Hos_LatLng = LatLng(widget.parameter.lat_para, widget.parameter.lng_para);

    final initialPosition = CameraPosition(target: Hos_LatLng, zoom: 17.5,);

    final Marker marker = Marker(
      markerId: MarkerId('${widget.parameter.idx.toString()}'),
      position: Hos_LatLng,
      infoWindow: InfoWindow(
        title: widget.parameter.name_para,
        snippet: widget.parameter.addr_para,
      ),
    );

    return Scaffold(
       appBar: AppBar(
          title: const Center(
            child: Text(
              '지도',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
       ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: Set.from([marker]),
      ),
    );

  }
}

