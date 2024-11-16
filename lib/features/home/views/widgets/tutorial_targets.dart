import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:piece_of_happiness/constants/colors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> tutorialTargets({
  required BuildContext context,
  required GlobalKey profileKey,
  required GlobalKey settingsKey,
  required GlobalKey pieceKey,
  required GlobalKey addKey,
  required GlobalKey pickKey,
  required GlobalKey lightbulbKey,
}) {
  return [
    TargetFocus(
      identify: "Profile",
      keyTarget: profileKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Gap(MediaQuery.of(context).size.width * 0.15),
              const Text(
                "사용자 프로필",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "프로필 사진과 이름을 확인할 수 있어요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
    TargetFocus(
      identify: "Settings",
      keyTarget: settingsKey,
      contents: [
        TargetContent(
          align: ContentAlign.bottom,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Gap(MediaQuery.of(context).size.width * 0.05),
              const Text(
                "사용자 프로필",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  textAlign: TextAlign.end,
                  "프로필 수정, 다크모드 전환, 로그아웃 등이 가능한 설정화면으로 이동할 수 있어요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
    TargetFocus(
      identify: "Piece",
      keyTarget: pieceKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "행복조각",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "현재까지 저장된 조각의 개수를 확인할 수 있어요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    TargetFocus(
      identify: "Add",
      keyTarget: addKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "조각 추가",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "새로운 행복조각을 만들 수 있어요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    TargetFocus(
      identify: "Pick",
      keyTarget: pickKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "조각 뽑기",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "저장된 행복조각 중 하나를 랜덤하게 보여줘요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    TargetFocus(
      identify: "Lightbulb",
      keyTarget: lightbulbKey,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "튜토리얼 안내",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "언제든지 튜토리얼을 확인할 수 있어요.",
                  style: TextStyle(
                    color: Color(
                      ThemeColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ];
}
