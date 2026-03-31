import 'package:agent_pro/features/auth/presentation/controllers/auth_controller.dart';
import 'package:agent_pro/features/auth/presentation/controllers/sign_in_notifier.dart';
import 'package:agent_pro/features/auth/presentation/widgets/agent_stats.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomePage extends ConsumerStatefulWidget {
  const WelcomePage({super.key});

  @override
  ConsumerState<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends ConsumerState<WelcomePage> {
  int _currentIndex = 0;
  bool _isFabMenuOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref.invalidate(signInProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    Widget selectedNavIcon(Widget icon) {
      return Container(
        width: 56,
        height: 32,
        //padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(16),
            right: Radius.circular(16),
          ),
        ),
        child: icon,
      );
    }

    return Stack(
      children: [
        Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(child: Text("AgentPro")),
                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text("Sign In"),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to sign-in page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.app_registration),
                  title: const Text("Sign Up"),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to sign-up page
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text("Sign Out"),
                  onTap: () {
                    ref.read(authControllerProvider.notifier).performSignOut();
                    // Navigate to sign-out page
                  },
                ),
              ],
            ),
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: colorScheme.surfaceContainerHigh,
                expandedHeight: MediaQuery.of(context).size.height * 0.33,
                toolbarHeight: 72,
                title: Builder(
                  builder: (scaffoldContext) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SearchBar(
                      // scrollPadding: const EdgeInsets.all(8.0),
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                        minWidth: 400,
                        minHeight: 56,
                        maxHeight: 80,
                      ),
                      backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainerLow),
                      elevation: const WidgetStatePropertyAll(1),
                      leading: IconButton(
                        icon: Icon(Icons.menu, color: colorScheme.secondary),
                        onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
                      ),
                      hintText: "Cherchez un joueur",
                      trailing: [
                        IconButton(
                          icon: Icon(Icons.notifications_outlined, color: colorScheme.secondary),
                          onPressed: () {
                            // Handle search action
                          },
                        ),
                        // TODO: Replace with user profile picture if available
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: colorScheme.secondary),
                        ),
                      ],
                      onChanged: (value) {
                        // Handle search input
                      },
                    ),
                  ),
                ),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(8),
                  child: SizedBox(height: 8),
                ),
                flexibleSpace: const FlexibleSpaceBar(
                  background: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      spacing: 16,
                      // mainAxisSize: .min,
                      mainAxisAlignment: .end,
                      children: [
                        AgentStats(
                          statsTitle: "Valeur Totale de mes 6 joueurs",
                          statsValue: "€0M",
                          selected: true,
                        ),
                        // SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: AgentStats(statsTitle: "Mes Contrats", statsValue: "0"),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: AgentStats(statsTitle: "Negotiations", statsValue: "0"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(child: Container(height: 648, color: Colors.amber)),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        softWrap: true,
                        "Vous n'avez aucun joueur dans votre liste de surveillance, en ajoutez un",
                        textAlign: .center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            backgroundColor: colorScheme.surfaceContainerHigh,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.secondary,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              // Handle navigation tap
              setState(() {
                _currentIndex = index;
                _isFabMenuOpen = false;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_2_outlined, color: colorScheme.secondary),
                activeIcon: selectedNavIcon(
                  Icon(Icons.groups_2_outlined, color: colorScheme.surfaceBright),
                ),
                label: "Joueurs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment, color: colorScheme.secondary),
                activeIcon: selectedNavIcon(
                  Icon(Icons.assignment, color: colorScheme.surfaceBright),
                ),
                label: "Contrats",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  height: 24,
                  'assets/icons/ai.svg',
                  colorFilter: ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
                ),
                activeIcon: selectedNavIcon(
                  SvgPicture.asset(
                    height: 24,
                    'assets/icons/ai.svg',
                    colorFilter: ColorFilter.mode(colorScheme.surfaceBright, BlendMode.srcIn),
                  ),
                ),
                label: "IA",
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  height: 24,
                  'assets/icons/news.svg',
                  colorFilter: ColorFilter.mode(colorScheme.secondary, BlendMode.srcIn),
                ),
                activeIcon: selectedNavIcon(
                  SvgPicture.asset(
                    height: 24,
                    'assets/icons/news.svg',
                    colorFilter: ColorFilter.mode(colorScheme.surfaceBright, BlendMode.srcIn),
                  ),
                ),
                label: "Actualités",
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: IgnorePointer(
            ignoring: !_isFabMenuOpen,
            child: AnimatedOpacity(
              opacity: _isFabMenuOpen ? 1 : 0,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setState(() {
                    _isFabMenuOpen = false;
                  });
                },
                child: ColoredBox(color: colorScheme.scrim.withValues(alpha: 0.22)),
              ),
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: kBottomNavigationBarHeight + 16 + bottomInset,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _isFabMenuOpen
                    ? Column(
                        key: const ValueKey('fab_menu_open'),
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            foregroundColor: colorScheme.onPrimaryContainer,
                            backgroundColor: colorScheme.primaryContainer,
                            heroTag: 'fab_add_manual',
                            onPressed: () {
                              setState(() => _isFabMenuOpen = false);
                              // TODO: Handle "Ajout Manuel"
                            },
                            icon: const Icon(Icons.edit),
                            label: const Text('Ajout Manuel'),
                          ),
                          const SizedBox(height: 12),
                          FloatingActionButton.extended(
                            foregroundColor: colorScheme.onPrimaryContainer,
                            backgroundColor: colorScheme.primaryContainer,
                            heroTag: 'fab_market',
                            onPressed: () {
                              setState(() => _isFabMenuOpen = false);
                              // TODO: Handle "Via marché"
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Via marché'),
                          ),
                          const SizedBox(height: 12),
                        ],
                      )
                    : const SizedBox.shrink(key: ValueKey('fab_menu_closed')),
              ),
              FloatingActionButton(
                shape: const CircleBorder(),
                foregroundColor: colorScheme.onPrimary,
                backgroundColor: colorScheme.primary,
                elevation: 3,
                heroTag: 'fab_main',
                onPressed: () {
                  setState(() {
                    _isFabMenuOpen = !_isFabMenuOpen;
                  });
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) =>
                      RotationTransition(turns: animation, child: child),
                  child: Icon(
                    _isFabMenuOpen ? Icons.close : Icons.add,
                    key: ValueKey(_isFabMenuOpen),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
