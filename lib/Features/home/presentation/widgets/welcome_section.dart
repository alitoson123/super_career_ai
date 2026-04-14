import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:super_career_ai/generated/l10n.dart';

class WelcomeSection extends StatelessWidget {
  final String userName;
  final int newMatchesCount;

  const WelcomeSection({
    super.key,
    required this.userName,
    required this.newMatchesCount,
  });

  @override
  Widget build(BuildContext context) {
    // welcome back text
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).welcomeBack(userName),
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 4.h),
        Text(
          S.of(context).newJobMatches(newMatchesCount),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
