import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter交流群(5)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  String avatar = 'images/1.jpg';
  double height = 0.0;
  bool isShow = false;
  bool isStack = false;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(duration: const Duration(seconds: 1), vsync: this)
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.aspect_ratio),
            tooltip: '绝对定位模式',
            onPressed: () {
              setState(() {
                isStack = !isStack;
              });
            },
          ),
        ],
      ),
      body: Container(
          height: double.infinity,
          color: Colors.white,
          child: isStack ? Stack(
            children: [
              for (int i = 1; i <= 5; i++)
                Positioned(top: 60.0 * (i-1),child: _getLine('images/$i.jpg')),
              Positioned(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: height,
                  // color: Colors.blue,
                  child: Center(
                    child: SlideTransition(
                      position: Tween(begin: Offset(-0.03, 0), end: Offset(0.03, 0))
                          .animate(_controller),
                      child: RotationTransition(
                        child: Image.asset(avatar, width: 150, height: 150),
                        turns: Tween(begin: -0.005, end: 0.005)
                            .chain(CurveTween(curve: Curves.easeInOut))
                            .animate(_controller),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ) : Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                height: height,
                // color: Colors.blue,
                child: Center(
                  child: SlideTransition(
                    position: Tween(begin: Offset(-0.03, 0), end: Offset(0.03, 0))
                        .animate(_controller),
                    child: RotationTransition(
                      child: Image.asset(avatar, width: 150, height: 150),
                      turns: Tween(begin: -0.005, end: 0.005)
                          .chain(CurveTween(curve: Curves.easeInOut))
                          .animate(_controller),
                    ),
                  ),
                ),
              ),
              for (int i = 1; i <= 5; i++)
                _getLine('images/$i.jpg'),
            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isShow = false;
            height = 0.0;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getLine(String img) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      padding: EdgeInsets.only(
          left: 10,
          right: 10
      ),
      child: Row(
        children: [
          Image.asset(img, width: 50, height: 50),
          SizedBox(width: 15),
          InkWell(
            onTap: (){
              if (!isShow) {
                height = height == 200.0 ? 0.0 : 200.0;
                isShow = true;
              }
              avatar = img;
              setState(() {});
            },
            child: Container(
              width: 100,
              height: 30,
              color: Colors.green[400],
              child: Center(child: Text('2\'\'')),
            ),
          )
        ],
      ),
    );
  }
}
