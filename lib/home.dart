import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:unident_app/clinics_glisare_imagini_screen.dart';
import 'package:unident_app/programari_screen.dart';
// import 'package:unident_app/feedback_screen.dart';
// import 'package:unident_app/glisare_imagini_screen_IGV_only.dart';
// import 'package:unident_app/password_reset.dart';
import 'package:unident_app/redirect_promotii_lunare.dart';
import 'package:unident_app/redirect_turism_screen.dart';
import 'package:unident_app/solicita_programare.dart';
// import 'package:unident_app/terms_and_conditions_screen.dart';
import 'package:unident_app/clinics_list_screen.dart';
// import 'package:unident_app/doctor_details_screen.dart';
import 'package:unident_app/home_screen.dart';
// import 'package:unident_app/login.dart';
import 'package:unident_app/my_account.dart';
// import 'package:unident_app/programari_screen.dart';
// import 'package:unident_app/register.dart';
// import 'package:unident_app/main.dart';
import 'package:unident_app/our_medics.dart';
import 'package:unident_app/tratamente.dart';
import 'package:unident_app/redirect_tarife.dart';
import 'package:unident_app/utils/api_call_functions.dart';

final _drawerController = ZoomDrawerController();
// final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
ApiCallFunctions apiCallFunctions = ApiCallFunctions();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

// TODO : NAVBAR REACTS TO THE PRESSES ON THE DRAWER
class _HomeState extends State<Home> {
  int currentIndexDrawer = 0;
  bool isClicked = false;
  int selectedIndex = -1;
  var currentIndexNavBar = 0;

  void setPage(index) {
    setState(() {
      currentIndexDrawer = index;
      if (index == 9) {
        currentIndexNavBar = 3;
      } else if (index == 10) {
        currentIndexNavBar = 1;
      } else if (index > 3) {
        currentIndexNavBar = -1;
      } else if (index == 0) {
        currentIndexNavBar = 0;
      } else if (index == 1) {
        currentIndexNavBar = -1;
      } else if (index == 2) {
        currentIndexNavBar = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      bottomNavigationBar: SalomonBottomBar(
        selectedItemColor: const Color.fromARGB(255, 13, 19, 130),
        currentIndex: currentIndexNavBar,
        onTap: (i) {
          if (i == 1) {
            setPage(10);
          } else if (i == 3) {
            setPage(9);
          } else {
            setPage(i);
          }
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const ImageIcon(AssetImage('./assets/images/navbar/icons8-home-55.png')),
            title: const Text("Acasa"),
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const ImageIcon(AssetImage('./assets/images/navbar/calendar.png')),
            title: const Text("Programari"),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const ImageIcon(AssetImage('./assets/images/navbar/dinte.png')),
            title: const Text("Tratamente"),
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const ImageIcon(AssetImage('./assets/images/navbar/pagina perosnala.png')),
            title: const Text("Profil"),
          ),
        ],
      ),
      body: ZoomDrawer(
        menuScreen: DrawerScreen(
          setIndex: setPage,
        ),
        controller: _drawerController,
        mainScreen: currentScreen(),
        borderRadius: 30,
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: Colors.deepPurple,
        menuScreenTapClose: true,
        duration: const Duration(milliseconds: 700),
      ),
    );
  }

  Widget currentScreen() {
    switch (currentIndexDrawer) {
      case 0:
        return const HomeScreen();
      case 1:
        return const SolicitaProgramareScreen();
      case 2:
        return const TratamenteScreen();
      case 3:
        return const RedirectTarif();
      case 4:
        return const OurMedicsScreen();
      case 5:
        return const ClinicsGlisareImaginiScreen();
      case 6:
        return const RedirectPromotiiLunare();
      case 7:
        return const RedirectTurism();
      case 8:
        return const ClinicsScreen();
      case 9:
        return const MyAccountScreen();
      case 10:
        return const ProgramariScreen();
      default:
        return const HomeScreen();
    }
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerScreen({Key? key, required this.setIndex}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerList(Icons.home, "Home", 0),
              drawerList(Icons.send, "Solicita o programare", 1),
              drawerList(Icons.calendar_month, "Planul de tratament", 2),
              drawerList(Icons.attach_money_outlined, "Tarife", 3),
              drawerList(Icons.people_alt, "Medici", 4),
              drawerList(Icons.location_on_outlined, "Clinicile Uident", 5),
              drawerList(Icons.star_border, "Promotii lunare", 6),
              drawerList(Icons.airplanemode_active_rounded, "Turism dentar", 7),
              drawerList(Icons.contact_page_outlined, "Contact", 8),
              drawerList(Icons.account_box_outlined, "Contul meu", 9)
            ],
          ),
          const SizedBox(height: 60),
          Positioned(
            bottom: 10,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset('./assets/images/unident-alb.png', height: 35),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
        _drawerController.close!();
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, bottom: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: const Icon(Icons.menu),
    );
  }
}
