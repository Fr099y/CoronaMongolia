import 'package:coronamongolia/Strings.dart';
import 'package:coronamongolia/api/MyBloc.dart';
import 'package:coronamongolia/custom/EmptyWidget.dart';
import 'package:coronamongolia/custom/LoadingWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Utils.dart';

class MyListWidget extends StatefulWidget {
  @override
  _MyListWidgetState createState() => _MyListWidgetState();
}

class _MyListWidgetState extends State<MyListWidget> with AutomaticKeepAliveClientMixin<MyListWidget> {
  Debouncer _debouncer = Debouncer(milliseconds: 300);
  String _searchText = "";
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: StreamBuilder<dynamic>(
        stream: globalStatisticData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          bool _hasData = snapshot.hasData;
          bool _isEmpty = snapshot.data == null;
          return _hasData ? _isEmpty ? EmptyWidget() : _dataWidget(snapshot.data) : LoadingWidget();
        },
      ),
    );
  }

  Widget _searchSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        decoration: InputDecoration(hintText: "Хайх"),
        onChanged: (text) {
          _debouncer.run(() => setState(() => _searchText = text));
        },
      ),
    );
  }

  Widget _dataWidget(dynamic data) {
    List<dynamic> _features = (data['features'] as List).where((a) {
          String countryRegion = a['attributes']['Country_Region'] as String;
          String provinceState = a['attributes']['Province_State'] as String;
          return countryRegion?.toLowerCase()?.contains(_searchText) == true || provinceState?.toLowerCase()?.contains(_searchText) == true;
        }).toList() ??
        [];
    return Container(
      child: Column(
        children: <Widget>[
          _searchSection(),
          Expanded(
            child: ListView.separated(
              itemCount: _features.length,
              itemBuilder: (BuildContext context, int index) {
                return _rowItem(_features[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: 1,
                  color: Colors.black.withOpacity(0.3),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowItem(dynamic rowData) {
    dynamic _data = rowData['attributes'];
    String _stateName = "${_data['Country_Region']} ${_data['Province_State'] != null ? "-> ${_data['Province_State']}" : ""}";
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _stateName,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
          ),
          Container(height: 12),
          Row(
            children: <Widget>[
              _caseItem(_data['Confirmed'], STR_CONFIRMED, Colors.deepOrangeAccent),
              _caseItem(_data['Deaths'], STR_DEATHS, Colors.red),
              _caseItem(_data['Recovered'], STR_RECOVERED, Colors.green),
            ],
          )
        ],
      ),
    );
  }

  Widget _caseItem(int count, String text, Color color) {
    return Expanded(
      child: Container(
        color: color,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              "$count",
              style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
