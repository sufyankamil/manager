class Constants {
  Constants._privateConstructor();

  static final Constants _instance = Constants._privateConstructor();

  static Constants get instance => _instance;

  // Constants for App
  static const String appName = 'Task Management App';

  // Constants for Routes
  static const String splashRoute = '/';
  static const String signUpRoute = '/signUp';
  static const String signInRoute = '/signIn';
  static const String homeRoute = '/home';
  static const String emailAuthRoute = '/email_auth';

  // Constants for Main.dart
  static const String userTokenKey = 'uid';
  static const String errorLoading = 'Error loading Data';
  static const String loading = 'Loading Please Wait...';

  static const ok = 'OK';

  // Constants for SplashScreen
  static const String splashScreenImage = 'assets/images/logo.png';
  static const String splashScreenText =
      'Manage your tasks easily with Manager App';

  // Constants for SignUpScreen
  static const String signUpScreenTitle = 'Create Account Now';
  static const String signUpScreenGoogleButton = 'Sign up with Google';
  static const String signUpScreenFacebookButton = 'Sign up with Facebook';
  static const String signUpWithEmailButton = 'Sign up with Email';
  static const String signUpScreenSkipButton = 'Skip for now';
  static const String signUpScreenAlreadyHaveAccount = 'Already have account?';

  // Constants for LoginScreen
  static const String loginScreenTitle = 'Login to your Account';
  static const String loginButton = 'Login';
  static const String dontHaveAccount = 'Don\'t have an account?';
  static const String signUpButton = 'Sign up';
  static const String forgotPassword = 'Forgot Password?';
  static const String userNotFound = 'User Not Found';
  static const String userNotFoundMessage =
      'No user found for that email. Please create an account.';

  // Constants for HomeScreen
  static const String homeScreenTitle = 'Task Management App';

  // Constants for Email Auth
  static const String emailAuthScreenTitle = 'Sign in with Email';
  static const agreementTitle = 'Terms of Service and Privacy Policy';
  static const agreementContent =
      'By signing up you agree to our terms of service and privacy policy';
  static const agreeTerms = 'Please accept the terms and conditions.';
  static const agreementButton = 'Agree';
  static const disagreeButton = 'Disagree';
  static const accountExists = 'Account Exists';
  static const accountExistsMessage =
      'The account already exists for that email. Please login or reset your password.';
  static const weekPassword = 'Week Password';
  static const weekPasswordMessage =
      'The password provided is too weak. Please try again with a stronger password.';
}
