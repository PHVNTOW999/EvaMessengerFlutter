import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  String? _verificationId;
  int? _resendToken;

  AuthService({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Stream<User?> get user => _firebaseAuth.authStateChanges();

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  String? get verificationId => _verificationId;
  int? get resendToken => _resendToken;

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId, int? resendToken) codeSent,
    required Function(FirebaseAuthException e) verificationFailed,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Автоматическая верификация на Android
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: verificationFailed,
      codeSent: (String vId, int? rToken) {
        _verificationId = vId;
        _resendToken = rToken;
        codeSent(vId, rToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
      timeout: timeout,
    );
  }

  Future<User?> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
