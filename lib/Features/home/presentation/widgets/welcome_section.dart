import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:super_career_ai/generated/l10n.dart';

class WelcomeSection extends StatelessWidget {
  final int newMatchesCount;

  const WelcomeSection({
    super.key,
    required this.newMatchesCount,
  });

  @override
  Widget build(BuildContext context) {
    // welcome back text
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).welcomeBack,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        SizedBox(height: 4.h),
        Text(
          newMatchesCount == 0
              ? S.of(context).noNewMatches
              : S.of(context).newOpportunities(newMatchesCount),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
