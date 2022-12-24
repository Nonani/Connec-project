import 'package:connec/services/social_login.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:logger/logger.dart';

class KakaoLogin implements SocialLogin {
  User? user;
  Logger logger = Logger();
  @override
  Future<bool> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          logger.w(e);
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          try {
            user = await UserApi.instance.me();
            logger.w(user!.id);
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
      await UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }

}