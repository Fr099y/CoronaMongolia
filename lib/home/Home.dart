import 'package:coronamongolia/api/MyBloc.dart';
import 'package:coronamongolia/home/MyListWidget.dart';
import 'package:coronamongolia/home/MyMapWidget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _pageController = PageController(keepPage: true);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    mainBloc.getGlobalStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
            physics: NeverScrollableScrollPhysics(),
            children: <Widget>[
              MyMapWidget(),
              MyListWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _pageController.animateToPage(index, duration: Duration(milliseconds: 250), curve: Curves.easeIn),
        currentIndex: _currentPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text("Газрын зураг"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("Жагсаалтаар"),
          ),
        ],
      ),
    );
  }
}
