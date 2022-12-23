import 'dart:convert';
import 'dart:core';

import 'package:football_live_score/helper/date_helper.dart';
import 'package:football_live_score/modules/dashbord/home/model/Fixture_model.dart';
import 'package:football_live_score/modules/dashbord/home/model/detailes_stats_model.dart';
import 'package:football_live_score/modules/dashbord/home/model/gd_2_model.dart';
import 'package:football_live_score/modules/dashbord/home/model/match_details_model.dart';
import 'package:football_live_score/modules/dashbord/home/service/home_service.dart';
import 'package:football_live_score/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomeController extends GetxController {
  RxList<CombineTeamsModel>? combileTemes = <CombineTeamsModel>[].obs;
  RxList<TempModel>? tempModel = <TempModel>[].obs;
  RxList<Gd2Model> teamOne = <Gd2Model>[].obs;
  RxList<Gd2Model> teamTwo = <Gd2Model>[].obs;
  RxList<Gd2Model> gdeName = <Gd2Model>[].obs;
  Rx<MatchDetailsModel>? matchDetailsModel = MatchDetailsModel().obs;
  RxBool isLoading = false.obs;
  RxBool isFactsLoading = false.obs;
  RxInt todayIndex = 0.obs;
  ScrollController dateScrollController = ScrollController();

  RxList<PlayerStats?> homeTeamRow = <PlayerStats?>[].obs;
  RxList<PlayerStats?> awayTeamRow = <PlayerStats?>[].obs;
  RxBool opacity = false.obs;
  AutoScrollController? controller;
  Rx<DateTime> nowTime = DateTime.now().obs;
  RxBool isTimeFinished = false.obs;
  CountdownTimerController? countdownTimerController;

  @override
  void onInit() {
    // TODO: implement onInit
    fixtureApiCall();
    // controller = AutoScrollController(
    //   viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(Get.context!).padding.bottom),
    // );
    //
    // controller?.addListener(() {
    //   if ((controller?.position.pixels ?? 0.0) >= 20.0) {
    //     opacity.value = true;
    //   } else {
    //     opacity.value = false;
    //   }
    // });
    super.onInit();
  }

  // Future fixtureApiCall() async {
  //   try {
  //     tempModel?.clear();
  //     isLoading.value = true;
  //     combileTemes?.value = await HomeService.fixtureApi();
  //     combileTemes?.value.forEach((element) {
  //       String dateTime = (element.time?.substring(0, 12) ?? '');
  //       String date = displayDayAndDateTimes(dateTime, "yyyyMMddhhmm");
  //       int? index = tempModel?.indexWhere((ele) {
  //         return displayDayAndDateTimes(ele.time?.substring(0, 8).toString() ?? '00000000', "yyyyMMdd") ==
  //             date.substring(0, 8).toString();
  //       });
  //       if (index != -1) {
  //         var result = tempModel?[index!].data?.add(element);
  //       } else {
  //         ///add here
  //         // int diff = newParsedDate.difference(DateTime.now()).inDays;
  //         // timeAgo('');
  //
  //         TempModel dataModel = TempModel(data: [element], time: date);
  //
  //         tempModel?.add(dataModel);
  //         /// for set scroll position
  //         int? tempIndex = tempModel!.indexWhere((element) {
  //           String year = DateTime.now().toString().substring(0, 4);
  //           String month = DateTime.now().toString().substring(5, 7);
  //           String day = DateTime.now().toString().substring(8, 10);
  //           return element.time.toString().substring(0, 8) == '$year$month$day';
  //         });
  //         if (tempIndex != -1) {
  //           todayIndex.value = tempIndex;
  //         } else {
  //           int? tempIndex2 = tempModel!.indexWhere((element) {
  //             String year = DateTime.now().toString().substring(0, 4);
  //             String month = DateTime.now().toString().substring(5, 7);
  //             String day = DateTime.now().toString().substring(8, 10);
  //             DateTime dt = DateTime.parse("$year-$month-$day");
  //
  //             String apiYear = element.time.toString().substring(0, 4);
  //             String apiMonth = element.time.toString().substring(4, 6);
  //             String apiDay = element.time.toString().substring(6, 8);
  //             DateTime apiDt = DateTime.parse("$apiYear-$apiMonth-$apiDay");
  //
  //             return apiDt.isAfter(dt);
  //           });
  //           if (tempIndex2 != -1) {
  //             todayIndex.value = tempIndex2;
  //           }
  //         }
  //         scrollToIndex();
  //         // /// for set scroll position
  //         // todayIndex.value = tempModel!.indexWhere((element) {
  //         //   String year = DateTime.now().toString().substring(0, 4);
  //         //   String month = DateTime.now().toString().substring(5, 7);
  //         //   String day = DateTime.now().toString().substring(8, 10);
  //         //   return element.time.toString().substring(0, 8) == '$year$month$day';
  //         // });
  //         // scrollToIndex();
  //       }
  //     });
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future fixtureApiCall() async {
    try {
      tempModel?.clear();
      isLoading.value = true;
      combileTemes?.value = await HomeService.fixtureApi();
      combileTemes?.value.forEach((element) {
        String dateTime = (element.time?.substring(0, 12) ?? '');
        String date = displayDayAndDateTimes(dateTime, "yyyyMMddhhmm");
        int? index = tempModel?.indexWhere((ele) {
          return displayDayAndDateTimes(ele.time?.substring(0, 8).toString() ?? '00000000', "yyyyMMdd") ==
              date.substring(0, 8).toString();
        });

        if (index != -1) {
          var result = tempModel?[index!].data?.add(element);
        } else {
          ///add here

          TempModel dataModel = TempModel(data: [element], time: date);

          tempModel?.add(dataModel);

          /// for set scroll position
          int? tempIndex = tempModel!.indexWhere((element) {
            String year = DateTime.now().toString().substring(0, 4);
            String month = DateTime.now().toString().substring(5, 7);
            String day = DateTime.now().toString().substring(8, 10);
            return element.time.toString().substring(0, 8) == '$year$month$day';
          });
          if (tempIndex != -1) {
            todayIndex.value = tempIndex;
          } else {
            int? tempIndex2 = tempModel!.indexWhere((element) {
              String year = DateTime.now().toString().substring(0, 4);
              String month = DateTime.now().toString().substring(5, 7);
              String day = DateTime.now().toString().substring(8, 10);
              DateTime dt = DateTime.parse("$year-$month-$day");

              String apiYear = element.time.toString().substring(0, 4);
              String apiMonth = element.time.toString().substring(4, 6);
              String apiDay = element.time.toString().substring(6, 8);
              DateTime apiDt = DateTime.parse("$apiYear-$apiMonth-$apiDay");

              return apiDt.isAfter(dt);
            });
            if (tempIndex2 != -1) {
              todayIndex.value = tempIndex2;
            }
          }
          scrollToIndex();
        }
      });
    } catch (e,st) {
      print("scrollToIndexscrollToIndex:-${e} ${st}");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  Future scrollToIndex() async {
    print('index--->${todayIndex.value}');
    await controller?.scrollToIndex(
      todayIndex.value,
      preferPosition: AutoScrollPosition.begin,
    );
  }

  Future matchDetailsApiCall({String? matchID}) async {
    try {
      matchDetailsModel?.value = MatchDetailsModel();
      isFactsLoading.value = true;
      String json = await HomeService.matchDetailsApi(matchID: matchID);
      matchDetailsModel?.value = MatchDetailsModel.fromJson(jsonDecode(json));

      for (Gd2Model element in matchDetailsModel?.value.root?.gd2 ?? []) {
        int? index = matchDetailsModel?.value.root?.gd2?.indexWhere((ele) {
          return element.minutesPlayer == ele.playerModel?.id;
        });
        if (index != -1) {
          List<String> commentName = matchDetailsModel?.value.root?.gd2?[index!].playerModel?.gd21 ?? [];
          commentName.add(element.commentsPlayer.toString());
          matchDetailsModel?.value.root?.gd2?[index!].playerModel?.gd21 = commentName;
        } else {
          PlayerModel data = PlayerModel(id: element.minutesPlayer, gd21: [element.commentsPlayer.toString()]);
          int? indexdd = matchDetailsModel?.value.root?.gd2?.indexOf(element);
          matchDetailsModel?.value.root?.gd2?[indexdd!].playerModel?.id = data.id;
          matchDetailsModel?.value.root?.gd2?[indexdd!].playerModel?.gd21 = data.gd21;
        }
      }
      matchDetailsModel?.value.root?.detailedstats?.playerStats?.forEach((element) {
        if (element.playsOnHomeTeam == true) {
          homeTeamRow.add(element);
        } else {
          if (element.playsOnHomeTeam == false) {
            awayTeamRow.add(element);
          }
        }
      });

      awayTeamRow.sort(
        (a, b) {
          return (b?.playerRating ?? 0.0).compareTo(a?.playerRating ?? 0.0);
        },
      );
      homeTeamRow.sort(
        (a, b) {
          return (b?.playerRating ?? 0.0).compareTo(a?.playerRating ?? 0.0);
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      isFactsLoading.value = false;
    }
    // matchDetailsModel?.value.root?.gd2?.forEach((element) {
    //   print("matchDetailsModel===>${element.toJson()}");
    // });
  }

  String dateFormat(String date) {
    String? amPm;
    int hours = int.parse(date.substring(0, 2)) + 4;
    int minute = int.parse(date.substring(2, 4)) + 30;
    if (hours > 12) {
      amPm = "PM";
      hours = hours - 12;
    } else {
      amPm = "AM";
    }
    String formattedDate = "$hours:$minute $amPm";
    return formattedDate;
  }

  findIndex() {
    try {
      // if (rankingController.formModel.value.teamForm?.length != null) {
      // for (int i = 0; i < tempModel!.length; i++) {
      // print("teamForm===>----${tempModel?.first.time}");

      // }

    } catch (e, st) {
      print("error==>$e $st");
    }
  }

  imageTeamOneType(String? type) {
    switch (type) {
      case "Argentina":
        return AssetsPath.arg;
      case "Australia":
        return AssetsPath.aus;
      case "Belgium":
        return AssetsPath.bel;
      case "Brazil":
        return AssetsPath.bra;
      case "Canada":
        return AssetsPath.can;
      case "Cameroon":
        return AssetsPath.cmr;
      case "Costa Rica":
        return AssetsPath.cri;
      case "Croatia":
        return AssetsPath.cro;
      case "Denmark":
        return AssetsPath.den;
      case "Ecuador":
        return AssetsPath.ecu;
      case "England":
        return AssetsPath.eng;
      case "France":
        return AssetsPath.fra;
      case "Germany":
        return AssetsPath.ger;
      case "Ghana":
        return AssetsPath.gha;
      case "Iran":
        return AssetsPath.irn;
      case "Japan":
        return AssetsPath.jpn;
      case "South Korea":
        return AssetsPath.kor;
      case "Morocco":
        return AssetsPath.mar;
      case "Mexico":
        return AssetsPath.mex;
      case "Netherlands":
        return AssetsPath.ned;
      case "Poland":
        return AssetsPath.pol;
      case "Portugal":
        return AssetsPath.por;
      case "Qatar":
        return AssetsPath.qat;
      case "Saudi Arabia":
        return AssetsPath.sau;
      case "Senegal":
        return AssetsPath.sen;
      case "Serbia":
        return AssetsPath.ser;
      case "Spain":
        return AssetsPath.spa;
      case "Switzerland":
        return AssetsPath.sui;
      case "Tunisia":
        return AssetsPath.tun;
      case "Uruguay":
        return AssetsPath.urg;
      case "USA":
        return AssetsPath.usa;
      case "Wales":
        return AssetsPath.wal;
      default:
        return AssetsPath.whiteBackground;
    }
  }
}

class TempModel {
  List<CombineTeamsModel>? data;
  String? time;

  TempModel({this.data, this.time});
}
