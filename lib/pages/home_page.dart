import 'package:flutter/material.dart';
import 'package:protfolio/constants/colors.dart';
import 'package:protfolio/constants/sns_links.dart';
import 'package:protfolio/widgets/contact_section.dart';
import 'package:protfolio/widgets/main_desktop.dart';
import 'package:protfolio/widgets/main_mobile.dart';
import 'package:protfolio/widgets/project_section.dart';
import 'package:protfolio/widgets/skills_desktop.dart';
import 'package:protfolio/widgets/skills_mobile.dart';
import 'package:protfolio/utils/url_opener.dart' as url_opener;
import '../constants/size.dart';

import '../widgets/drawer_mobile.dart';
import '../widgets/footer.dart';
import '../widgets/header_desktop.dart';
import '../widgets/header_mobile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scrollController = ScrollController();
  final List<GlobalKey> navbarKeys = List.generate(4, (index) => GlobalKey());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: CustomColor.scaffoldBg,
          endDrawer: constraints.maxWidth >= kMinDesktopWidth
              ? null
              : DrawerMobile(
                  onNavItemTap: (int navIndex) {
                    scaffoldKey.currentState?.closeEndDrawer();
                    scrollToSection(navIndex);
                  },
                ),
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(key: navbarKeys.first),

                // MAIN
                if (constraints.maxWidth >= kMinDesktopWidth)
                  HeaderDesktop(
                    onNavMenuTap: (int navIndex) {
                      scrollToSection(navIndex);
                    },
                  )
                else
                  HeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                if (constraints.maxWidth >= kMinDesktopWidth)
                  MainDesktop(scrollToSection: () => scrollToSection(3))
                else
                  MainMobile(),

                // SKILLS
                Container(
                  key: navbarKeys[1],
                  width: screenWidth,
                  padding: const EdgeInsets.fromLTRB(25, 20, 25, 60),
                  color: CustomColor.bgLight1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      Text(
                        "What I can do",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      SizedBox(height: 50),

                      // platforms and skills
                      if (constraints.maxWidth >= kMedDesktopWidth)
                        SkillsDesktop()
                      else
                        SkillsMobile(),
                    ],
                  ),
                ),

                SizedBox(height: 30),

                // PROJECTS
                ProjectSection(key: navbarKeys[2]),

                SizedBox(height: 30),

                // CONTACT
                ContactSection(key: navbarKeys[3]),

                SizedBox(height: 30),

                // FOOTER
                Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      // open a blog page
      url_opener.openUrl(SnsLinks.leetCode);
      return;
    }

    final key = navbarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
