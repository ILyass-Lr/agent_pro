import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/services/app_settings_service.dart';
import 'onboarding_page.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _listenOnboardingCompletion(Mutation<void> mutation) {
    ref.listen(mutation, (previous, next) {
      if (next is MutationSuccess && context.mounted) {
        context.go('/sign-in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mutationState = ref.watch(completeOnBoarding);
    _listenOnboardingCompletion(completeOnBoarding);
    return Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) => setState(() => _currentPage = index),
          children: const [
            OnBoardingPage(
              title: 'Intelligence Prédictive',
              description:
                  "Anticipez le potentiel de chaque joueur grâce à nos algorithmes d'analyse IA avancée.",
              iconPath: 'assets/icons/ai.svg',
            ),
            OnBoardingPage(
              title: 'Réseau Mondial Élite',
              description:
                  "Accédez directement aux données exclusives des 50 plus grands clubs européens.",
              iconPath: 'assets/icons/diversity.svg',
            ),
            OnBoardingPage(
              title: 'Conformité FIFA',
              description:
                  "Une plateforme sécurisée répondant aux plus hauts standards institutionnels du football.",
              iconPath: 'assets/icons/verified.svg',
            ),
          ],
        ),
        Align(
          alignment: const Alignment(0, 0.92),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 16,
              children: [
                if (_currentPage > 0)
                  FilledButton.icon(
                    onPressed: () {
                      _controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 56),
                      maximumSize: const Size(72, 56),
                      backgroundColor: colorScheme.secondaryContainer,
                      foregroundColor: colorScheme.onSecondaryContainer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    icon: Icon(Icons.arrow_back, size: 24, color: colorScheme.onPrimaryContainer),
                    iconAlignment: IconAlignment.end,
                    label: const SizedBox.shrink(),
                  ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: mutationState is MutationPending
                        ? null
                        : () async {
                            completeOnBoarding.run(ref, (tsx) async {
                              await ref.read(appSettingServiceProvider).setOnBoardingComplete();
                            });
                          },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(260, 56),
                      backgroundColor: colorScheme.primaryContainer,
                      foregroundColor: colorScheme.onPrimaryContainer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    icon: mutationState is MutationPending
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(colorScheme.onPrimaryContainer),
                            ),
                          )
                        : Icon(Icons.login, size: 24, color: colorScheme.onPrimaryContainer),
                    iconAlignment: IconAlignment.start,

                    label: Text(mutationState is MutationPending ? "Loading..." : "Se Connecter"),
                  ),
                ),
                if (_currentPage < 2)
                  FilledButton.icon(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: const Size(48, 56),
                      maximumSize: const Size(72, 56),
                      backgroundColor: colorScheme.secondaryContainer,
                      foregroundColor: colorScheme.onSecondaryContainer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                    icon: Icon(
                      Icons.arrow_forward,
                      size: 24,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    iconAlignment: IconAlignment.end,
                    label: const SizedBox.shrink(),
                  ),
              ],
            ),
          ),
        ),
        Container(
          alignment: const Alignment(0, 0.75),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 3,
            effect: WormEffect(
              dotColor: colorScheme.secondary.withValues(alpha: 0.4), // inactive dots
              activeDotColor: colorScheme.secondary, // active dot
              dotHeight: 16,
              dotWidth: 16,
            ),
          ),
        ),
      ],
    );
  }
}
