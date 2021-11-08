import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/constants/assets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  "https://raw.communitydragon.org/latest/plugins/rcp-fe-lol-store/global/default/background.png",
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
                      image: AssetImage(imageBackgroundAboutPage),
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
                margin: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 100),
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
                        "1.0.0",
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
                      margin: EdgeInsets.only(top: 50),
                      child: Text(
                        "DEVELOPMENT".tr + "Herrison Féres",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 14,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 40),
                          child: IconButton(
                            onPressed: () {
                              openLinkedin(context);
                            },
                            icon: Icon(
                              FeatherIcons.linkedin,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 40, left: 40),
                          child: IconButton(
                            onPressed: () {
                              openGit(context);
                            },
                            icon: Icon(
                              FeatherIcons.github,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                      ],
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

  openLinkedin(BuildContext context) async {
    var linkedinUrl =
        "https://www.linkedin.com/in/herrison-f%C3%A9res-423023103/";
    await canLaunch(linkedinUrl)
        ? launch(linkedinUrl)
        : showToast(context, "LINKEDIN_INSTALL".tr);
  }

  openGit(BuildContext context) async {
    var gitUrl = "https://github.com/HerrisonF";
    await canLaunch(gitUrl)
        ? launch(gitUrl)
        : showToast(context, "GIT_INSTALL".tr);
  }

  showToast(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
