import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connec/services/social_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      await kakao.UserApi.instance.unlink();
      return true;
    } catch (error) {
      return false;
    }
  }


}