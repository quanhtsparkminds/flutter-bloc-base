enum AppRoutes {
  flash,
  introduction,
  authenticate,
  loginWithPhone,
  loginWithEmail,
  forgotPassword,
  signup,
  bottomTabbar,
  home,
  recentActivity,
  chat,
  booking,
  profile,
  setupLocalAuthentication,
  localAuthentication,
  category,
  electrician,
  popularHandyman,
  favorite,
  filter,
}

extension PathName on AppRoutes {
  String get path {
    switch (this) {
      case AppRoutes.flash:
        return '/${AppRoutes.flash.name.toLowerCase()}';
      case AppRoutes.introduction:
        return '/${AppRoutes.introduction.name.toLowerCase()}';
      case AppRoutes.authenticate:
        return '/${AppRoutes.authenticate.name.toLowerCase()}';
      case AppRoutes.loginWithPhone:
        return AppRoutes.loginWithPhone.name.toLowerCase();
      case AppRoutes.loginWithEmail:
        return AppRoutes.loginWithEmail.name.toLowerCase();
      case AppRoutes.forgotPassword:
        return AppRoutes.forgotPassword.name.toLowerCase();
      case AppRoutes.signup:
        return AppRoutes.signup.name.toLowerCase();
      case AppRoutes.setupLocalAuthentication:
        return AppRoutes.setupLocalAuthentication.name.toLowerCase();
      case AppRoutes.localAuthentication:
        return AppRoutes.localAuthentication.name.toLowerCase();
      case AppRoutes.bottomTabbar:
        return '/${AppRoutes.bottomTabbar.name.toLowerCase()}';
      case AppRoutes.home:
        return '/${AppRoutes.home.name.toLowerCase()}';
      case AppRoutes.recentActivity:
        return '/${AppRoutes.recentActivity.name.toLowerCase()}';
      case AppRoutes.popularHandyman:
        return AppRoutes.popularHandyman.name.toLowerCase();
      case AppRoutes.favorite:
        return AppRoutes.favorite.name.toLowerCase();
      case AppRoutes.filter:
        return AppRoutes.filter.name.toLowerCase();
      case AppRoutes.booking:
        return '/${AppRoutes.booking.name.toLowerCase()}';
      case AppRoutes.chat:
        return '/${AppRoutes.chat.name.toLowerCase()}';
      case AppRoutes.profile:
        return '/${AppRoutes.profile.name.toLowerCase()}';
      case AppRoutes.category:
        return '/${AppRoutes.category.name.toLowerCase()}';
      case AppRoutes.electrician:
        return '/${AppRoutes.electrician.name.toLowerCase()}';
      default:
        return '/not-found';
    }
  }
}
