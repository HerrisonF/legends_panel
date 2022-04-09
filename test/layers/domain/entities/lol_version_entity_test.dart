import 'package:flutter_test/flutter_test.dart';
import 'package:legends_panel/app/layers/domain/entities/lol_version_entity.dart';

main(){

  test('Should versions not be null', (){
    LolVersionEntity lolVersionEntity = LolVersionEntity(versions: ['1','2', '3']);
    expect(lolVersionEntity, isNotNull);
  });

  test('Should versions not be empty', (){
    LolVersionEntity lolVersionEntity = LolVersionEntity(versions: ['1','2', '3']);
    expect(lolVersionEntity.versions, isNotEmpty);
  });

  test('Should versions be empty and return Version not found', (){
    LolVersionEntity lolVersionEntity = LolVersionEntity(versions: []);
    var versionResult = lolVersionEntity.getLatestVersion();
    expect(versionResult, 'Version not found');
  });

  test('Should return the latest version', (){
    LolVersionEntity lolVersionEntity = LolVersionEntity(versions: ['1','2', '3']);
    var latestVersion = lolVersionEntity.getLatestVersion();
    expect(latestVersion, '1');
  });
}