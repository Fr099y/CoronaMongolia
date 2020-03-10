import 'dart:async';

import 'package:coronamongolia/Styles.dart';
import 'package:coronamongolia/api/MyBloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

class MyMapWidget extends StatefulWidget {
  @override
  _MyMapWidgetState createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> with AutomaticKeepAliveClientMixin<MyMapWidget> {
  Completer<GoogleMapController> _mapController = Completer();
  double _zoom = 14;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<dynamic>(
          stream: globalStatisticData,
          builder: (context, snapshot) {
            Set<Circle> circles = Set.from([]);
            bool _hasData = snapshot.hasData && snapshot.data != null;
            if (_hasData) {
              (snapshot.data['features'] as List).forEach((feature) {
                dynamic _data = feature['attributes'];
                double _lat = double.parse("${_data['Lat']}");
                double _lon = double.parse("${_data['Long_']}");
                String _id = "${_data['OBJECTID']}";
                circles.add(
                  Circle(
                    circleId: CircleId(_id),
                    center: LatLng(_lat, _lon),
                    fillColor: Colors.red.withOpacity(0.3),
                    radius: _getRadius(),
                    strokeWidth: 0,
                  ),
                );
              });
            }

            return GoogleMap(
              initialCameraPosition: CameraPosition(zoom: _zoom, target: LatLng(0, 0)),
              circles: circles,
              onCameraMove: (cameraPosition) {
                _zoom = cameraPosition.zoom;
              },
              onCameraIdle: () {
                setState(() {});
              },
              onMapCreated: (GoogleMapController controller) {
                _mapController.complete(controller);
              },
            );
          }),
    );
  }

  double _getRadius() {
    //TODO _zoom-с шалтгаалж Radius тооцох
    return 100000.0;
  }

  @override
  bool get wantKeepAlive => true;
}
