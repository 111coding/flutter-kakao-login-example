# flutter_kakao_login_example

https://pub.dev/packages/kakao_flutter_sdk
https://developers.kakao.com/docs/latest/ko/kakaologin/flutter

## Min targer
- #### Target Android API level 19 or higher (Android 4.4 (Kitkat) or higher)
- #### iOS 11.0 or higher

### 0. Kakao Developer 플랫폼 추가 & Android Debug Hash 등록

https://developers.kakao.com/console

https://developers.kakao.com/docs/latest/ko/getting-started/sdk-android#add-key-hash

- mac

```
keytool -exportcert -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64
```

- window

```
keytool -exportcert -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore -storepass android -keypass android | openssl sha1 -binary | openssl base64
```

## 이 프로젝트는 아래 세팅이 다 되어 있어서 "{YOUR_NATIVE_APP_KEY}"를 검색해서 kakao developers 에서 발급받은 키를 전체검색해서 바꿔서 테스트용으로 사용 가능!

---

### 1. flutter sdk 추가

```yml
kakao_flutter_sdk: ^1.1.1
```

### 2. Android setting

- #### AndroidManifest.xml 에  Redirect URI 설정

```xml
<activity android:name="com.kakao.sdk.flutter.AuthCodeCustomTabsActivity">
    <intent-filter android:label="flutter_web_auth">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />

        <!-- Redirect URI, "kakao${YOUR_NATIVE_APP_KEY}://oauth" 형식 -->
        <data android:scheme="kakao${YOUR_NATIVE_APP_KEY}" android:host="oauth"/>
    </intent-filter>
</activity>
```

### 3. iOS setting

https://developers.kakao.com/docs/latest/ko/getting-started/sdk-ios#set-up

- #### Info.plist 설정

##### 앱 실행 허용 목록 추가

```xml
 <key>LSApplicationQueriesSchemes</key>
  <array>
      <!-- 카카오톡으로 로그인 -->
      <string>kakaokompassauth</string>
      <!-- 카카오링크 -->
      <string>kakaolink</string>
  </array>
```

##### 커스텀 URL 스키마

```
카카오 로그인: kakao${NATIVE_APP_KEY}://oauth
카카오링크: kakao${NATIVE_APP_KEY}://kakaolink
카카오스토리: kakao${NATIVE_APP_KEY}://kakaostory
```

```xml
	<key>CFBundleURLTypes</key>
	<array>

		...

		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>kakao${NATIVE_APP_KEY}://oauth</string>
			</array>
		</dict>
        ...

	</array>
```

### 3. Flutter

- #### SDK init

```dart
KakaoSdk.init(nativeAppKey: '${NATIVE_APP_KEY}');
```

- #### SDK init

```dart
KakaoSdk.init(nativeAppKey: '${NATIVE_APP_KEY}');
```

- #### Login

```dart
try {
    OAuthToken token = await isKakaoTalkInstalled()
        ? await UserApi.instance.loginWithKakaoTalk() // 카카오톡 앱으로 로그인
        : await UserApi.instance.loginWithKakaoAccount(); // 웹뷰로 로그인
    print(token.accessToken);
} catch (e) {
    print("로그인 실패 $e");
}
```