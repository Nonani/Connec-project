import 'package:connec/services/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:logger/logger.dart';

class KakaoLogin implements SocialLogin {
  kakao.User? user;
  Logger logger = Logger();

  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await kakao.isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await kakao.UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          logger.w(e);
          return false;
        }
      } else {
        try {
          await kakao.UserApi.instance.loginWithKakaoAccount();
          try {
            user = await kakao.UserApi.instance.me();
            List<String> scopes = [];

            if (user!.kakaoAccount?.emailNeedsAgreement == true) {
              scopes.add('account_email');
            }
            if (user!.kakaoAccount?.birthdayNeedsAgreement == true) {
              scopes.add("birthday");
            }
            if (user!.kakaoAccount?.birthyearNeedsAgreement == true) {
              scopes.add("birthyear");
            }
            if (user!.kakaoAccount?.ciNeedsAgreement == true) {
              scopes.add("account_ci");
            }
            if (user!.kakaoAccount?.phoneNumberNeedsAgreement == true) {
              scopes.add("phone_number");
            }
            if (user!.kakaoAccount?.profileNeedsAgreement == true) {
              scopes.add("profile");
            }
            if (user!.kakaoAccount?.ageRangeNeedsAgreement == true) {
              scopes.add("age_range");
            }

            if (scopes.length > 0) {
              print('사용자에게 추가 동의 받아야 하는 항목이 있습니다');

              // OpenID Connect 사용 시
              // scope 목록에 "openid" 문자열을 추가하고 요청해야 함
              // 해당 문자열을 포함하지 않은 경우, ID 토큰이 재발급되지 않음
              // scopes.add("openid")

              // scope 목록을 전달하여 추가 항목 동의 받기 요청
              // 지정된 동의 항목에 대한 동의 화면을 거쳐 다시 카카오 로그인 수행
              kakao.OAuthToken token;
              try {
                token = await kakao.UserApi.instance.loginWithNewScopes(scopes);
                print('현재 사용자가 동의한 동의 항목: ${token.scopes}');
              } catch (error) {
                print('추가 동의 요청 실패 $error');
                return false;
              }
              logger.w(user!.id);
            }
          } catch (error) {
            print('사용자 정보 요청 실패 $error');
          }
          return true;
        } catch (e) {
          logger.w(e);
          return false;
        }
      }
    } catch (e) {
      logger.w(e);
      return false;
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await kakao.UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }
}
