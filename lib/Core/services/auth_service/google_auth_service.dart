import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
 // GoogleAuthService({GoogleSignIn? googleSignIn})
 //     : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

 // final GoogleSignIn _googleSignIn;
  static const MethodChannel _channel =
      MethodChannel('super_career_ai/google_sign_in_config');

  bool get isSupported {
    if (kIsWeb) return true;
    // Avoid `dart:io` so this file can compile for web too.
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return false;
    }
  }

  Future<String?> getIdToken() async {
    var trimmedServerClientId =
        const String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID').trim();

    if (!kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        trimmedServerClientId.isEmpty) {
      try {
        final fromRes =
            await _channel.invokeMethod<String>('getDefaultWebClientId');
        trimmedServerClientId = (fromRes ?? '').trim();
      } catch (_) {
        // Ignore and keep empty. We'll provide a clear error if idToken is missing.
      }
    }

  /*  await _googleSignIn.initialize(
      serverClientId: trimmedServerClientId.isEmpty ? null : trimmedServerClientId,
      clientId: kIsWeb ? const String.fromEnvironment('GOOGLE_WEB_CLIENT_ID') : null,
    );*/

    // Force fresh auth to avoid cached sessions returning null tokens.
    try {
      //await _googleSignIn.signOut();
    } catch (_) {}

 /*   if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError('Google authenticate() is not supported here.');
    }*/

    /*inal account = await _googleSignIn.authenticate(
      scopeHint: const ['email', 'profile', 'openid'],
    );*/

    //final auth = account.authentication;
   // final idToken = auth.idToken;
    /*if (idToken == null || idToken.isEmpty) {
      // On Android/iOS, an ID token often requires a *server* client id (Web client id).
      // We don't hard-fail before showing the Google UI; instead we surface a clear fix.
      final platform = kIsWeb ? 'web' : defaultTargetPlatform.name;
      throw StateError(
        'Google returned no idToken on $platform. '
        'Add android/app/google-services.json (Firebase) OR pass '
        '--dart-define=GOOGLE_SERVER_CLIENT_ID=... then rebuild.',
      );
    }
    return idToken;*/
  }
}

