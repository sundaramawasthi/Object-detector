import 'package:comboapp/CALANDER/calenderhome.dart';
import 'package:comboapp/DETECTOR/dector_main.dart';
import 'package:comboapp/Maskdetection/main_mask.dart';
import 'package:comboapp/NOTEPAD/notes.dart';
import 'package:comboapp/TODO/todopagelist.dart';
import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFFFFDE7);

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: FittedBox(
                fit: BoxFit.fill, child: Image.asset('assets/menuback.jpg')),
          ),
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuDashboardPage()));
                  },
                  child: Text("DASHBOARD",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => calenderhome()));
                  },
                  child: Text("Calender",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TodoListPage()));
                  },
                  child: Text("To-Do_List",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mysplashscreen()));
                  },
                  child: Text("Object\nDetector",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NotesPage()));
                  },
                  child: Text("NotePad",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    List list = [
      'CALENDER',
      'TO-DO lIST',
      'OBJECT-DETECTOR',
      'NOTEPAD',
      'MASK-DETECTOR'
    ];
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: FittedBox(
                  fit: BoxFit.fill, child: Image.asset('assets/frontmenu.jpg')),
            ),
            Material(
              animationDuration: duration,
              borderRadius: BorderRadius.all(Radius.circular(40)),
              elevation: 8,
              color: backgroundColor,
              child: Container(
                width: double.infinity,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            InkWell(
                              child: Icon(Icons.menu, color: Colors.white),
                              onTap: () {
                                setState(() {
                                  if (isCollapsed)
                                    _controller.forward();
                                  else
                                    _controller.reverse();

                                  isCollapsed = !isCollapsed;
                                });
                              },
                            ),
                            Text("DASHBOARD",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white)),
                            Icon(Icons.settings, color: Colors.white),
                          ],
                        ),
                        SizedBox(height: 50),
                        Container(
                          height: 200,
                          child: PageView(
                            controller: PageController(viewportFraction: 0.8),
                            scrollDirection: Axis.horizontal,
                            pageSnapping: true,
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.grey,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                mysplashscreen()));
                                  },
                                  child: const Image(
                                    image: AssetImage(
                                      'assets/Object.jpg',
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.black,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TodoListPage()));
                                  },
                                  child: const Image(
                                    image: AssetImage('assets/todo.jpg'),
                                  ),
                                ),
                                width: 100,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.grey,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => mask()));
                                  },
                                  child: const Image(
                                    image: AssetImage('assets/mask.jpg'),
                                  ),
                                ),
                                width: 100,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.yellow,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                calenderhome()));
                                  },
                                  child: Image(
                                    image: AssetImage('assets/calender.jpg'),
                                  ),
                                ),
                                width: 100,
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                color: Colors.yellow,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NotesPage()));
                                  },
                                  child: const Image(
                                    image: AssetImage('assets/notepad.jpg'),
                                  ),
                                ),
                                width: 100,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        const Text(
                          "OBJECT DETECTOR",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: UniqueKey(),
                                background: Container(
                                  padding: EdgeInsets.only(left: 30),
                                  alignment: Alignment.centerLeft,
                                  color: Color(0xFFFF768E),
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                secondaryBackground: Container(
                                  padding: EdgeInsets.only(right: 30),
                                  alignment: Alignment.centerRight,
                                  color: Color(0xFFFF768E),
                                  child: const Text(
                                    "DELETE",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                child: Text(
                                  list[index],
                                  style: TextStyle(fontSize: 20),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const Divider(
                                height: 30,
                              );
                            },
                            itemCount: list.length)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
