import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _login() async {
    try {
      OAuthToken token = await isKakaoTalkInstalled()
          ? await UserApi.instance.loginWithKakaoTalk() // 카카오톡 앱으로 로그인
          : await UserApi.instance.loginWithKakaoAccount(); // 웹뷰로 로그인
      print(token.accessToken);
    } catch (e) {
      print("로그인 실패 $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kakao Login"),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: _login,
            child: const Text("카카오톡으로 시작하기"),
          ),
        ),
      ),
    );
  }
}
