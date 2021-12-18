import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:legends_panel/app/controller/master_controller/master_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {

  final MasterController _masterController = Get.find<MasterController>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imageBackgroundAboutPage2,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(
                    Rect.fromLTRB(0, 60, rect.width, rect.height - 40));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 70),
                  bottomRight: Radius.elliptical(
                      MediaQuery.of(context).size.width / 2, 70),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          imageBackgroundAboutPage
                        ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white.withOpacity(0.45),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 80),
                      child: Text(
                        "Watch Summoner",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 50),
                      child: Text(
                        _masterController.packageInfo.version,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "© 2021 WatchSummoner was created under Riot Games' \"Legal Jibber Jabber\" policy using assets owned by Riot Games.  Riot Games does not endorse or sponsor this project.",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        AppLocalizations.of(context)!.development,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      margin: EdgeInsets.only(top: 40, bottom: 100),
                      child: IconButton(
                        onPressed: () {
                          openGit(context);
                        },
                        icon: Icon(
                          FeatherIcons.github,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  openGit(BuildContext context) async {
    var gitUrl = "https://github.com/HerrisonF";
    await canLaunch(gitUrl)
        ? launch(gitUrl)
        : showToast(context, AppLocalizations.of(context)!.gitInstall);
  }

  showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
