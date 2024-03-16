import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:hae/screen/Landing.dart';
import 'package:hae/screen/memoList.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';

void main() async {
  // .env 파일을 읽어와서 환경 변수로 설정합니다.
  await dotenv.load(fileName: ".env");

  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: '${dotenv.env['KAKAO_NATIVE_APP_KEY']}',
    javaScriptAppKey: '${dotenv.env['KAKAO_JAVA_SCRIPT_APP_KEY']}',
  );

  return runApp(const Main());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Landing(),
    ),
    GoRoute(
      path: '/memoList',
      builder: (context, state) => const MemoList(),
    ),
  ],
);

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
