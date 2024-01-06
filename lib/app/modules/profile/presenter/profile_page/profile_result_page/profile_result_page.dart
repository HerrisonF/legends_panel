import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legends_panel/app/core/constants/assets.dart';
import 'package:legends_panel/app/core/general_controller/general_controller.dart';
import 'package:legends_panel/app/core/http_configuration/http_services.dart';
import 'package:legends_panel/app/core/logger/logger.dart';
import 'package:legends_panel/app/core/routes/routes_path.dart';
import 'package:legends_panel/app/modules/current_game/domain/models/summoner_identification/summoner_profile_model.dart';
import 'package:legends_panel/app/modules/profile/data/repositories/profile_repository.dart';
import 'package:legends_panel/app/modules/profile/presenter/profile_page/profile_result_page/profile_result_page_controller.dart';

class ProfileResultPage extends StatefulWidget {
  final SummonerProfileModel summonerProfileModel;

  const ProfileResultPage({
    required this.summonerProfileModel,
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileResultPage> createState() => _ProfileResultPageState();
}

class _ProfileResultPageState extends State<ProfileResultPage> {
//   final ScrollController _scrollController = ScrollController();

  late final ProfileResultController profileResultController;

  @override
  void initState() {
    //this._scrollController.addListener(this._scrollListenerFunction);
    profileResultController = ProfileResultController(
      summonerProfileModel: widget.summonerProfileModel,
      profileRepository: ProfileRepository(
        logger: GetIt.I<Logger>(),
        httpServices: GetIt.I<HttpServices>(),
      ),
      generalController: GetIt.I<GeneralController>(),
    );
    super.initState();
  }

//
//   @override
//   void dispose() {
//     this._scrollController.removeListener(this._scrollListenerFunction);
//     this._scrollController.dispose();
//     super.dispose();
//   }
//
//   _scrollListenerFunction() {
//     if (isUserScrollingDown() &&
//         (this._profileController.newIndex ==
//             this._profileController.oldIndex)) {
//       this
//           ._profileController
//           .loadMoreMatches(_masterController.userForProfile.region);
//     }
//   }
//
//   bool isUserScrollingDown() {
//     return (this._scrollController.offset * 1.3) >=
//             this._scrollController.position.maxScrollExtent &&
//         !this._scrollController.position.outOfRange;
//   }
//
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageBackgroundProfilePage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 280,
                child: summonerPanel(),
              ),
              Positioned(
                left: 20,
                top: 20,
                child: _outButton(),
              ),
            ],
          ),
          //MasteryChampions(),
          // ValueListenableBuilder(
          //   valueListenable: _profileController.matchList,
          //   builder: (context, value, _) {
          //     return _profileController.matchList.value.length > 0
          //         ? Expanded(
          //             child: Container(
          //               margin: EdgeInsets.only(bottom: 45),
          //               child: ListView.builder(
          //                 itemCount: _hasMoreMatchesToLoad(),
          //                 controller: this._scrollController,
          //                 itemBuilder: (_, myCurrentPosition) {
          //                   return _isLoadingGameCard(myCurrentPosition);
          //                 },
          //               ),
          //             ),
          //           )
          //         : CircularProgressIndicator();
          //   },
          // ),
        ],
      ),
    );
  }

//
//   Widget _isLoadingGameCard(int myCurrentPosition) {
//     if (myCurrentPosition < this._profileController.matchList.value.length) {
//       return ItemMatchListGameCard(
//           _profileController.matchList.value[myCurrentPosition]);
//     } else {
//       return Container(
//         padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
//         margin: EdgeInsets.only(bottom: 30),
//         child: CircularProgressIndicator(),
//       );
//     }
//   }
//
  _outButton() {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
        size: 26,
      ),
      onPressed: () {
        context.push(RoutesPath.PROFILE_PAGE);
      },
    );
  }

//   int _hasMoreMatchesToLoad() {
//     if (_profileController.lockNewLoadings.value) {
//       return _profileController.matchList.value.length;
//     }
//     if (_profileController.isLoadingNewMatches.value) {
//       return _profileController.matchList.value.length + 1;
//     }
//     return _profileController.matchList.value.length;
//   }
//
  Widget summonerPanel() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: _backgroundChampionMask(),
        ),
        Positioned(
          top: 55,
          child: _playerRankedEloEmblem(),
        ),
        Positioned(
          top: 20,
          child: _profileBadge(),
        ),
        Positioned(
          top: 50,
          left: 0,
          right: 0,
          child: _profileStatistics(),
        ),
      ],
    );
  }

  ShaderMask _backgroundChampionMask() {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black,
            Colors.transparent,
          ],
        ).createShader(
          Rect.fromLTRB(
            0,
            0,
            rect.width,
            rect.height,
          ),
        );
      },
      blendMode: BlendMode.dstIn,
      child: ClipRRect(
        child:
            profileResultController.summonerProfileModel!.masteries != null &&
                    profileResultController
                        .summonerProfileModel!.masteries!.isNotEmpty
                ? Container(
                    height: 280,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          profileResultController.generalController
                              .getChampionBigImage(
                            championName: profileResultController
                                .summonerProfileModel!
                                .masteries!
                                .first
                                .championModel!
                                .id,
                          ),
                        ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black26,
                          BlendMode.overlay,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
      ),
    );
  }

  Container _playerRankedEloEmblem() {
    return Container(
      height: 200,
      child: Image.network(
        profileResultController.getRankedSoloTierBadge(),
        errorBuilder: (context, error, stackTrace) {
          return SizedBox.shrink();
        },
      ),
    );
  }

  Container _profileStatistics() {
    return Container(
      margin: EdgeInsets.only(
        right: 5,
        left: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              _summonerLevel(),
              _summonerLeaguePoints(),
            ],
          ),
          Column(
            children: [
              _summonerVictory(),
              _summonerLosses(),
            ],
          )
        ],
      ),
    );
  }

  Container _summonerLosses() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 0.0),
            blurRadius: 40,
          )
        ],
      ),
      child: Text(
        AppLocalizations.of(context)!.lose +
            "\n" +
            profileResultController.getLosses().toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Container _summonerVictory() {
    return Container(
      margin: EdgeInsets.only(top: 35),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 0.0),
            blurRadius: 30,
          )
        ],
      ),
      child: Text(
        AppLocalizations.of(context)!.victory +
            "\n" +
            profileResultController.getWins().toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Container _summonerLeaguePoints() {
    return Container(
      margin: EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 0.0),
            blurRadius: 40,
          )
        ],
      ),
      child: Text(
        "${AppLocalizations.of(context)!.leaguePoints} \n" +
            profileResultController.getLeaguePoints().toString(),
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Container _summonerLevel() {
    return Container(
      margin: EdgeInsets.only(top: 40),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(1.0, 0.0),
            blurRadius: 40,
          )
        ],
      ),
      child: Text(
        AppLocalizations.of(context)!.level +
            " \n ${profileResultController.summonerProfileModel!.summonerLevel}",
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  _profileBadge() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: 200,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(1.0, 0.0),
                blurRadius: 60,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            profileResultController.summonerProfileModel!.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                profileResultController.getUserProfileImage(),
              ),
              onError: (exception, stackTrace) => SizedBox.shrink(),
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.elliptical(50, 60),
              bottomRight: Radius.elliptical(50, 60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
        ),
      ],
    );
  }
}
