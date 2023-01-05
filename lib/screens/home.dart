import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_quizz/components/custom_icons.dart';
import 'package:project_quizz/data/data_image.dart';
import 'package:project_quizz/screens/card_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var cardAspectRatio = 12.0 / 16.0;
var widgetAspectRatio = cardAspectRatio * 1.2;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final fabKey = GlobalKey<FabCircularMenuState>();

  var currentPage = images.length - 1.0;

  bool isTapped = false;

  final user = FirebaseAuth.instance.currentUser!;
  String? name;
  int exp = 1;
  Future getId() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              final r = document.data() as Map<String, dynamic>;
              try {
                setState(() {
                  name = r['username'];
                  exp = r['exp'];
                });
              } catch (e) {
                print(e.toString());
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    getId();
    Size size = MediaQuery.of(context).size;

    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    // return Scaffold(
    //   body: Container(
    //     color: const Color(0xFF192A56),
    //     child: Column(
    //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         //name
    //         Center(
    //           child: Text(
    //             '$name',
    //             style: TextStyle(
    //               color: Colors.white.withOpacity(.7),
    //               fontWeight: FontWeight.w500,
    //               fontSize: 20,
    //             ),
    //           ),
    //         ),

    //         //email
    //         Text(user.email!),

    //         //exit
    //         ElevatedButton.icon(
    //           icon: const Icon(Icons.exit_to_app_outlined),
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   title: const Text('Thoát Ứng Dụng'),
    //                   content: const Text('Bạn có chắc muốn Thoát?'),
    //                   actions: <Widget>[
    //                     ElevatedButton(
    //                         child: const Text('Có'),
    //                         onPressed: () {
    //                           if (Platform.isAndroid) {
    //                             SystemNavigator.pop();
    //                           } else {
    //                             exit(0);
    //                           }
    //                         }),
    //                     ElevatedButton(
    //                         style: const ButtonStyle(
    //                           backgroundColor:
    //                               MaterialStatePropertyAll(Colors.red),
    //                         ),
    //                         child: const Text('Không'),
    //                         onPressed: () {
    //                           Navigator.of(context).pop();
    //                         }),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //           label: Text('THOÁT'),
    //         ),

    //         //logout
    //         ElevatedButton.icon(
    //           icon: const Icon(Icons.logout_outlined),
    //           onPressed: () {
    //             showDialog(
    //               context: context,
    //               builder: (BuildContext context) {
    //                 return AlertDialog(
    //                   title: const Text('Đăng Xuất Tài Khoản'),
    //                   content: const Text('Bạn có chắc muốn Đăng Xuất?'),
    //                   actions: <Widget>[
    //                     ElevatedButton(
    //                         child: const Text('Có'),
    //                         onPressed: () {
    //                           FirebaseAuth.instance.signOut();
    //                           navigatorKey.currentState?.push(
    //                             MaterialPageRoute(
    //                                 builder: (_) =>
    //                                     SignInScreen(onClickedSignUp: () {})),
    //                           );
    //                         }),
    //                     ElevatedButton(
    //                       style: const ButtonStyle(
    //                         backgroundColor:
    //                             MaterialStatePropertyAll(Colors.red),
    //                       ),
    //                       child: const Text('Không'),
    //                       onPressed: () {
    //                         Navigator.of(context).pop();
    //                       },
    //                     ),
    //                   ],
    //                 );
    //               },
    //             );
    //           },
    //           label: Text('ĐĂNG XUẤT'),
    //         ),
    //       ],
    //     ),
    //   ),

    //   //menu
    //   floatingActionButton: Builder(
    //     builder: (context) => FabCircularMenu(
    //       key: fabKey,
    //       alignment: Alignment.bottomRight,
    //       ringColor: Colors.white.withAlpha(25),
    //       ringDiameter: 500.0,
    //       ringWidth: 150.0,
    //       fabSize: 60.0,
    //       fabElevation: 8.0,
    //       fabIconBorder: const CircleBorder(
    //           side: BorderSide(color: Colors.white, width: 3)),
    //       fabColor: const Color(0xFF192A56),
    //       fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
    //       fabCloseIcon: const Icon(Icons.close, color: Colors.amber),
    //       fabMargin: const EdgeInsets.all(16.0),
    //       animationDuration: const Duration(milliseconds: 800),
    //       animationCurve: Curves.easeInOutCirc,
    //       onDisplayChange: ((isOpen) {}),
    //       children: <Widget>[
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.settings_applications_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.shopping_cart_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.account_circle_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //         RawMaterialButton(
    //           onPressed: () {},
    //           shape: const CircleBorder(),
    //           padding: const EdgeInsets.all(24.0),
    //           child: const Icon(
    //             Icons.house_outlined,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    //===================================
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF1B1E44),
            Color(0xFF2D3447),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        //menu
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            key: fabKey,
            alignment: Alignment.bottomRight,
            // ringColor: Colors.white.withAlpha(180),
            ringColor: Colors.blue.withAlpha(180),
            ringDiameter: 500.0,
            ringWidth: 150.0,
            fabSize: 60.0,
            fabElevation: 8.0,
            fabIconBorder: const CircleBorder(
                side: BorderSide(color: Colors.white, width: 3)),
            fabColor: const Color(0xFF192A56),
            fabOpenIcon: const Icon(Icons.menu, color: Colors.white),
            fabCloseIcon: const Icon(Icons.close, color: Colors.amber),
            fabMargin: const EdgeInsets.all(16.0),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            onDisplayChange: ((isOpen) {}),
            children: <Widget>[
              RawMaterialButton(
                // fillColor: Colors.blue.withOpacity(.3),
                splashColor: const Color(0xFF2D3447),
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.settings_applications_outlined,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  color: Color(0xFF2D3447),
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.account_circle_outlined,
                  color: Color(0xFF2D3447),
                  size: 40,
                ),
              ),
              RawMaterialButton(
                onPressed: () {},
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(24.0),
                child: const Icon(
                  Icons.house_outlined,
                  color: Color(0xFF2D3447),
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        //end menu

        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ///////
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          text: 'Xin chào ',
                          style: const TextStyle(
                              fontFamily: "Calibre-Semibold",
                              fontSize: 36.0,
                              color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: '$name',
                                style: const TextStyle(
                                    fontFamily: "Calibre-Semibold",
                                    fontSize: 46.0,
                                    color: Colors.red))
                          ]),
                    ),
                    // IconButton(
                    //     icon: const Icon(CustomIcons.option,
                    //         size: 12.0, color: Colors.white),
                    //     onPressed: () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFff6e6e),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Animated",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    const Text(
                      "25+ Stories",
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                ),
              ),
              Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: images.length,
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return Container();
                      },
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text("Favourite",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 46.0,
                          fontFamily: "Calibre-Semibold",
                          letterSpacing: 1.0,
                        )),
                    IconButton(
                        icon: const Icon(
                          CustomIcons.option,
                          size: 12.0,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 6.0),
                          child: Text("Latest",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    const Text("9+ Stories",
                        style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset("assets/images/image_02.jpg",
                            width: 296.0, height: 222.0),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
