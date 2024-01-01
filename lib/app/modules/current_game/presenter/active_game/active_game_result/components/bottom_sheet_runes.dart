import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:legends_panel/app/modules/current_game/presenter/active_game/active_game_result/components/active_game_participant_controller.dart';

class BottomSheetRunes extends StatelessWidget {
  late final ActiveGameParticipantController activeGameParticipantController;
  final double iconSize = 40;

  BottomSheetRunes({
    required this.activeGameParticipantController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            "${activeGameParticipantController.activeGameParticipantModel.summonerName} - ${AppLocalizations.of(context)!.perk}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: activeGameParticipantController
                .generalController.lolConstantsModel.perks!
                .map(
                  (perkClasse) => Visibility(
                    visible: activeGameParticipantController.generalController
                        .checkPerkIsAssigned(
                      options: [
                        activeGameParticipantController
                            .activeGameParticipantModel.perk!.perkStyle,
                        activeGameParticipantController
                            .activeGameParticipantModel.perk!.perkSubStyle,
                      ],
                      perkCorrente: perkClasse.id,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blueGrey,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.network(
                                  activeGameParticipantController
                                      .generalController
                                      .getPerkStyleBadgeUrl(
                                    perkId: perkClasse.id,
                                  ),
                                  errorBuilder: (context, error, stackTrace) {
                                    return SizedBox.shrink();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(perkClasse.name),
                              )
                            ],
                          ),
                          Column(
                            children: perkClasse.slotModels
                                .map(
                                  (slot) => Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: slot.runeModels
                                          .map(
                                            (runa) => Stack(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 2,
                                                  ),
                                                  height: iconSize,
                                                  width: iconSize,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                  child: Image.network(
                                                    activeGameParticipantController
                                                        .generalController
                                                        .getPerkDetailBadgeUrl(
                                                      iconPath: runa.icon,
                                                    ),
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return SizedBox.shrink();
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                    horizontal: 2,
                                                  ),
                                                  height: iconSize,
                                                  width: iconSize,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.withOpacity(
                                                        activeGameParticipantController
                                                                .generalController
                                                                .checkPerkIsAssigned(
                                                      options:
                                                          activeGameParticipantController
                                                              .activeGameParticipantModel
                                                              .perk!
                                                              .perkIds,
                                                      perkCorrente: runa.id,
                                                    )
                                                            ? 0
                                                            : 0.85),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
