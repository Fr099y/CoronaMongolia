import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coronamongolia/Styles.dart';
import 'package:coronamongolia/api/MyBloc.dart';
import 'package:coronamongolia/utils/AlertUitls.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' as math;

import 'package:location/location.dart';

class MyMapWidget extends StatefulWidget {
  @override
  _MyMapWidgetState createState() => _MyMapWidgetState();
}

class _MyMapWidgetState extends State<MyMapWidget> with AutomaticKeepAliveClientMixin<MyMapWidget> {
  Completer<GoogleMapController> _mapController = Completer();
  double _zoom = 15;
  var location = new Location();
//  Set<Circle> _circles = Set.from([]);
  Set<Circle> _riskCircles = Set.from([]);

  @override
  void initState() {
    super.initState();
    getLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<dynamic>(
          stream: globalStatisticData,
          builder: (context, snapshot) {
            Set<Circle> _globalCircles = Set.from([]);
            bool _hasData = snapshot.hasData && snapshot.data != null;
            if (_hasData) {
              (snapshot.data['features'] as List).forEach((feature) {
                dynamic _data = feature['attributes'];
                double _lat = double.parse("${_data['Lat']}");
                double _lon = double.parse("${_data['Long_']}");
                String _id = "${_data['OBJECTID']}";
                _globalCircles.add(
                  Circle(
                    circleId: CircleId(_id),
                    center: LatLng(_lat, _lon),
                    fillColor: Colors.red.withOpacity(0.3),
                    radius: _getGlobalRadius(),
                    strokeWidth: 0,
                  ),
                );
              });
            }

            return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("locations").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot) {
                  if (querySnapshot.hasData && querySnapshot.data != null) {
                    _riskCircles.clear();
                    querySnapshot.data.documents.forEach((document) {
                      LatLng _latLng;
                      if (document.data.containsKey('location')) {
                        GeoPoint _geoPoint = document.data['location'] as GeoPoint;
                        _latLng = LatLng(_geoPoint.latitude, _geoPoint.longitude);
                      }
                      if (_latLng != null) {
                        _riskCircles.add(
                          Circle(
                            circleId: CircleId(document.documentID),
                            center: _latLng,
                            fillColor: document.data['isClean'] == true ? Colors.green.withOpacity(0.3) : Colors.orangeAccent.withOpacity(0.3),
                            radius: double.parse("${document.data['radius'] ?? 70}"),
                            strokeWidth: 1,
                            strokeColor: document.data['isClean'] == true ? Colors.green : Colors.red,
                            onTap: () => showCircleDetailBottomSheet(context, document),
                            consumeTapEvents: true,
                          ),
                        );
                      }
                    });
                  }
                  _globalCircles.addAll(_riskCircles);
                  return GoogleMap(
                    initialCameraPosition: CameraPosition(zoom: _zoom, target: LatLng(47.918417, 106.917610)),
                    circles: _globalCircles,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
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
                });
          }),
    );
  }

  double _getGlobalRadius() {
    //TODO _zoom-с шалтгаалж Radius тооцох
    return 100000.0;
  }

  double _getRiskRadius() {
    return 100.0;
  }

  @override
  bool get wantKeepAlive => true;

  getLocationPermission() async {
    try {
      location.requestPermission().then((_) {
        setState(() {});
        location.onLocationChanged().listen((currentLocation) {
          //TODO circle дотор орсон үгүйг шалгаад хэрвээ орсон бол анхааруулга өгөх
        });
      });
    } catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Permission denied');
      }
    }
  }
}
