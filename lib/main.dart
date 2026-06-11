import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_career_ai/Core/navigator/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:super_career_ai/Core/services/Bloc_observes_service/my_Bloc_observe.dart';
import 'package:super_career_ai/Core/services/locator_service/service_locator.dart';
import 'package:super_career_ai/Features/jobs/Data/repo_impl/job_repo_impl.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/get_base_cv_cubit.dart';
import 'package:super_career_ai/Features/jobs/presentation/view_model/base_cv_cubit.dart/uplaod_base_cv_cubit.dart';
import 'generated/l10n.dart';
import 'package:super_career_ai/Core/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  Bloc.observer = MyBlocObserver(); // bloc observer
  await dotenv.load(fileName: ".env");
  runApp(const SuperCareerApp());
} 

class SuperCareerApp extends StatelessWidget {
  const SuperCareerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              BaseCvCubit(jobRepo: getIt<JobRepoImpl>())..fetchBaseCV(),
        ),
        BlocProvider(
          create: (context) => UploadBaseCvCubit(jobRepo: getIt<JobRepoImpl>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            locale: Locale('en'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: AppRoutes.route,
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
