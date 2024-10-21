import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// CustomVideoPlayer 위젯 파일 임포트
import 'package:vid_player/component/custom_video_player.dart';

class HomeScreen extends StatefulWidget {
  // StatelessWidget -> StatefulWidget
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;     // 동영상 저장할 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // 동영상이 선택됐을 때와 선택 안 됐을 때 보여줄 위젯
      body: video == null ? renderEmpty() : renderVideo(),
    );
  }

  // 동영상 선택 전 보여줄 위젯
  Widget renderEmpty() {
    return Container(
      width: MediaQuery.of(context).size.width,   // 너비 최대로 늘려주기
      decoration: getBoxDecoration(),   // 함수로부터 값 가져오기
      child: Column(
        // 위젯들 가운데 정렬
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(      // 로고 이미지
            onTap: onNewVideoPressed,   // 1. 로고 탭하면 실행하는 함수
          ),
          SizedBox(height: 30.0),
          _AppName(),   // 앱 이름
        ],
      ),
    );
  }

  void onNewVideoPressed() async {    // 2. 이미지 선택하는 기능을 구현한 함수
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (video != null) {
      setState(() {
        this.video = video;
      });
    }
  }

  BoxDecoration getBoxDecoration() {
    return BoxDecoration(
      // 그라데이션으로 색상 적용
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF2A3A7C),
          Color(0xFF000118),
        ],
      ),
    );
  }

  // 동영상 선택 후 보여줄 위젯
  Widget renderVideo() {
      return Center(
        child: CustomVideoPlayer(
          video: video!,    // 선택된 동영상 입력해주기
        ),
      );
  }
}

class _Logo extends StatelessWidget {
  final GestureTapCallback onTap;   // 탭 했을 때 실행할 함수

  const _Logo({required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,     // 3. 상위 위젯으로부터 탭 콜백받기
      child: Image.asset(
        'asset/img/logo.png',   // 로고 이미지
      ),
    );
  }
}

class _AppName extends StatelessWidget {  // 앱 제목을 보여줄 위젯
  const _AppName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,  // 글자 가운데 정렬
      children: [
        Text(
          'VIDEO',
          style: textStyle,
        ),
        Text(
          'PLAYER',
          style: textStyle.copyWith(
            // TextStyle 에서 두꼐만 700 으로 변경
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}