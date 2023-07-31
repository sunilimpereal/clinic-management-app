import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:clinic_app/modules/Auth/model/login/user_object.dart';
import 'package:clinic_app/utils/constants/api_konstants.dart';
import 'package:clinic_app/utils/constants/keys_konstants.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:twitter_login/twitter_login.dart';

class SocialMediaSignInRepository {
  Future<GoogleSignInAccount?> googleSignIn() async {
    /*
    // Initiate the auth procedure
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // // fetch the auth details from the request made earlier
    // if (googleUser != null) {
    //   final GoogleSignInAuthentication googleAuth =
    //       await googleUser.authentication;
    //   // Create a new credential for signing in with google
    //   final credential = GoogleAuthProvider.credential(
    //     accessToken: googleAuth.accessToken,
    //     idToken: googleAuth.idToken,
    //   );
    //
    //   print(googleAuth.accessToken);
    //   print(googleAuth.idToken);
    // }

    const googleClientId =
        '229454198738-rj7j5ndqd3cph4orcdo47ds8hf7m8tg0.apps.googleusercontent.com';

    const callbackUrlScheme =
        'https://ec2-3-7-6-12.ap-south-1.compute.amazonaws.com:3000/api/v1/auth/google/redirect';

    final url = Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
      'response_type': 'code',
      'client_id': googleClientId,
      'redirect_uri': '$callbackUrlScheme',
      'scope': 'email',
    });

    final result = await FlutterWebAuth.authenticate(
      url: url.toString(),
      callbackUrlScheme:
          'com.googleusercontent.apps.229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630',
    );

    final code = Uri.parse(result).queryParameters;
    print(code);
     */

    //final googleSignIn = GoogleSignIn(scopes: [], );
    FlutterAppAuth appAuth = const FlutterAppAuth();
    try {
      //GoogleSignInAccount? result = await googleSignIn.signIn();
      // SocialLoginResponseModel? response =
      //     await ApiRequest<SocialLoginRequestModel, SocialLoginResponseModel>()
      //         .get(
      //   url: ApiConstants.googleRedirect,
      //   reponseFromJson: socialLoginResponseModelFromJson,
      // );
      //print('${result}google response');
      // if (response != null) {
      //   sharedPrefs.setAuthToken(response.authToken);
      //   sharedPrefs.setName(response.name);
      //   sharedPrefs.setId(response.id);
      //   sharedPrefs.setEmailId(response.email);
      // }
      //return result;
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          '229454198738-4sd8kivt7l45l8j7vtlp4a3alpikv630.apps.googleusercontent.com',
          'http://3.7.6.12:3000/api/v1/auth/google/redirect',
          serviceConfiguration: const AuthorizationServiceConfiguration(
              authorizationEndpoint:
                  'https://accounts.google.com/o/oauth2/auth',
              tokenEndpoint: 'https://accounts.google.com/o/oauth2/token'),
          scopes: ['openid', 'email'],
        ),
      );

      print('${result}hello');
    } catch (error) {
      log("$error");
    }
    return null;
  }

  Future<dynamic> twitterSignIn() async {
    // Initiate the auth procedure
    final twitterLogin = TwitterLogin(
        apiKey: KeysConstants.twitterApiKey,
        apiSecretKey: KeysConstants.twitterApiSecretKey,
        redirectURI: "http://3.7.6.12:3000/api/v1/auth/twitter/redirect");
    final loginResp = await twitterLogin.login();
    // if (loginResp.authToken != null) {
    //   final twitterAuthCred = TwitterAuthProvider.credential(
    //       accessToken: loginResp.authToken!,
    //       secret: loginResp.authTokenSecret!);
    //   try {
    //     final user =
    //         await FirebaseAuth.instance.signInWithCredential(twitterAuthCred);
    //     final idToken = await user.user!.getIdToken();
    //     log('IDToken $idToken');
    //     return user.credential;
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'account-exists-with-different-credential') {
    //       return 'Account exists with different credential';
    //     } else if (e.code == 'invalid-credential') {
    //       return 'Invalid credential';
    //     }
    //   } catch (e) {
    //     return e.toString();
    //   }
    // }
    switch (loginResp.status) {
      case TwitterLoginStatus.loggedIn:
        print('${loginResp.authToken}hello');
        break;
      case TwitterLoginStatus.cancelledByUser:
        // cancel
        print('====== Login cancel ======');
        break;
      case TwitterLoginStatus.error:
      case null:
        // error
        print('====== Login error ======');
        break;
    }
  }

  Future<dynamic> appleSignIn() async {
    // Initiate the auth procedure
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    if (credential.identityToken != null) {
      final oAuthProvider = OAuthProvider('apple.com');
      final firebaseCredential = oAuthProvider.credential(
        idToken: credential.identityToken!,
        accessToken: credential.authorizationCode,
      );
      try {
        final user = await FirebaseAuth.instance
            .signInWithCredential(firebaseCredential);
        final idToken = await user.user!.getIdToken();
        log('IDToken $idToken');
        log('$user');
        return user.credential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return 'Account exists with different credential';
        } else if (e.code == 'invalid-credential') {
          return 'Invalid credential';
        }
      } catch (e) {
        return e.toString();
      }
    }
  }

  Future<UserObject?> linkedinSignIn(BuildContext context) async {
    UserObject? user;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => LinkedInUserWidget(
              appBar: AppBar(title: const Text('Linkedin Login')),
              onGetUserProfile: (UserSucceededAction linkedInUser) {
                //print('${linkedInUser.user.firstName!.localized!.label!}hello');
                user = UserObject(
                  firstName: linkedInUser.user.firstName == null
                      ? ''
                      : linkedInUser.user.firstName!.localized == null
                          ? ''
                          : linkedInUser.user.firstName!.localized!.label ==
                                  null
                              ? ''
                              : linkedInUser.user.firstName!.localized!.label!,
                  email: linkedInUser.user.email == null
                      ? ''
                      : linkedInUser.user.email!.elements == null
                          ? ''
                          : linkedInUser.user.email!.elements![0].handleDeep ==
                                  null
                              ? ''
                              : linkedInUser.user.email!.elements![0]
                                          .handleDeep!.emailAddress ==
                                      null
                                  ? ''
                                  : linkedInUser.user.email!.elements![0]
                                      .handleDeep!.emailAddress!,
                  profileImageUrl: linkedInUser.user.profilePicture == null
                      ? ''
                      : linkedInUser.user.profilePicture!.displayImageContent ==
                              null
                          ? ''
                          : linkedInUser.user.profilePicture!
                                      .displayImageContent!.elements ==
                                  null
                              ? ''
                              : linkedInUser
                                          .user
                                          .profilePicture!
                                          .displayImageContent!
                                          .elements![0]
                                          .identifiers ==
                                      null
                                  ? ''
                                  : linkedInUser
                                              .user
                                              .profilePicture!
                                              .displayImageContent!
                                              .elements![0]
                                              .identifiers![0]
                                              .identifier ==
                                          null
                                      ? ''
                                      : linkedInUser
                                          .user
                                          .profilePicture!
                                          .displayImageContent!
                                          .elements![0]
                                          .identifiers![0]
                                          .identifier!,
                  lastName: linkedInUser.user.lastName == null
                      ? ''
                      : linkedInUser.user.lastName!.localized == null
                          ? ''
                          : linkedInUser.user.lastName!.localized!.label == null
                              ? ''
                              : linkedInUser.user.lastName!.localized!.label!,
                );
                // print('${user!.firstName}hello');
                Navigator.pop(context);
              },
              projection: const [
                ProjectionParameters.id,
                ProjectionParameters.localizedFirstName,
                ProjectionParameters.localizedLastName,
                ProjectionParameters.firstName,
                ProjectionParameters.lastName,
                ProjectionParameters.profilePicture,
              ],
              onError: (final UserFailedAction e) {
                print('Error: ${e.toString()}');
                print('Error: ${e.stackTrace.toString()}');
              },
              redirectUrl: ApiConstants.linkedinRedirect,
              clientId: KeysConstants.linkedinClientId,
              clientSecret: KeysConstants.linkedinClientSecret,
            )),
      ),
    );
    http.Response response = await http.get(
      Uri.parse(
        'http://3.7.6.12:3000/api/v1/auth/linkedin/redirect',
      ),
    );
    print(response.body);
    return user;
  }

  Future<dynamic> microsoftSignIn() async{
    
  }

  Future<dynamic> facebookSignIn() async {
    //Initiate the auth procedure
    // LoginResult result = await FacebookAuth.instance.login();

    // if (result.status == LoginStatus.success) {
    //   if (result.accessToken != null) {
    //     // if weare receiving token then we are signing in the user to firebase and returning that firebase token further
    //     final credential =
    //         FacebookAuthProvider.credential(result.accessToken!.token);
    //     try {
    //       final user =
    //           await FirebaseAuth.instance.signInWithCredential(credential);
    //       final idToken = await user.user!.getIdToken();
    //       log('IDToken $idToken');
    //       return user.credential;
    //     } on FirebaseAuthException catch (e) {
    //       if (e.code == 'account-exists-with-different-credential') {
    //         return 'Account exists with different credential';
    //       } else if (e.code == 'invalid-credential') {
    //         return 'Invalid credential';
    //       }
    //     } catch (e) {
    //       return e.toString();
    //     }
    //   } else {
    //     return result.message.toString();
    //   }
    // }
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();
        print(userData);
      }
    } catch (error) {
      print(error);
    }
  }

  // Future<dynamic> signInWithLinkedIn() async {
  //   // Create a new OAuth provider for LinkedIn
  //   final provider = OAuthProvider('linkedin.com');
  //   // Set the OAuth scopes you want to request from the user
  //   provider.addScope('r_liteprofile');
  //   provider.addScope('r_emailaddress');
  //   // Use the flutter_web_auth package to launch the LinkedIn authentication flow
  //   final result = await FlutterWebAuth.authenticate(
  //     url: provider.buildUrl(),
  //     callbackUrlScheme:
  //         'flutter-firebase-auth', // Replace with your app scheme
  //   );
  //   // Once the user has authenticated with LinkedIn, retrieve their Firebase credential
  //   final credential = provider.credentialFromResponseUri(result);
  //   // Use the Firebase Auth API to sign in the user
  //   final authResult =
  //       await FirebaseAuth.instance.signInWithCredential(credential);
  //   return authResult;
  // }
}
