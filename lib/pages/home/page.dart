import 'package:flutter/material.dart';
import 'package:haina/common/constant/constants.dart';
import 'package:haina/pages/home/color_palettes_screen.dart';
import 'package:haina/pages/home/conversation_screen.dart';
import 'package:haina/pages/home/elevation_screen.dart';
import 'package:haina/pages/home/navigation.dart';
import 'package:haina/pages/home/typography_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  bool controllerInitialized = false;

  // 中等布局
  bool showMediumSizeLayout = false;

  // 大尺寸，也就是说，这个是控制桌面端的，const double largeWidthBreakpoint = 1300;
  bool showLargeSizeLayout = false;

  // 这是主页默认值
  int screenIndex = ScreenSelected.conversation.value;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // 尺寸发生变化
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > mediumWidthBreakpoint ? 1 : 0;
    }
  }

  void handleScreenChanged(int screenSelected) {
    setState(() {
      screenIndex = screenSelected;
    });
  }

  // 创建导航页面
  Widget createScreenFor(
      ScreenSelected screenSelected, bool showNavBarExample) {
    switch (screenSelected) {
      case ScreenSelected.color:
        return const ColorPalettesScreen();
      case ScreenSelected.typography:
        return const TypographyScreen();
      case ScreenSelected.elevation:
        return const ElevationScreen();
      case ScreenSelected.conversation:
        return const ConversationScreen();
    }
  }

  // 创建AppBar
  PreferredSizeWidget createAppBar() {
    return AppBar(
      title: const Text('海纳AI'),
      actions:
          !showMediumSizeLayout && !showLargeSizeLayout ? [] : [Container()],
    );
  }

  // 菜单栏的副菜单
  Widget _trailingActions() => const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return NavigationTransition(
          scaffoldKey: scaffoldKey,
          animationController: controller,
          railAnimation: railAnimation,
          appBar: createAppBar(),
          body: createScreenFor(
              ScreenSelected.values[screenIndex], controller.value == 1),
          navigationRail: NavigationRail(
            extended: showLargeSizeLayout,
            destinations: navRailDestinations,
            selectedIndex: screenIndex,
            onDestinationSelected: (index) {
              setState(() {
                screenIndex = index;
                handleScreenChanged(screenIndex);
              });
            },
            trailing: Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: showLargeSizeLayout ? Container() : _trailingActions(),
              ),
            ),
          ),
          // 导航栏
          navigationBar: NavigationBars(
            onSelectItem: (index) {
              setState(() {
                screenIndex = index;
                handleScreenChanged(screenIndex);
              });
            },
            selectedIndex: screenIndex,
            isExampleBar: false,
          ),
        );
      },
    );
  }
}

// 【整体】导航栏过渡
class NavigationTransition extends StatefulWidget {
  const NavigationTransition(
      {super.key,
      required this.scaffoldKey,
      required this.animationController,
      required this.railAnimation,
      required this.navigationRail,
      required this.navigationBar,
      required this.appBar,
      required this.body});

  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController animationController;
  final CurvedAnimation railAnimation;
  final Widget navigationRail;
  final Widget navigationBar;
  final PreferredSizeWidget appBar;
  final Widget body;

  @override
  State<NavigationTransition> createState() => _NavigationTransitionState();
}

class _NavigationTransitionState extends State<NavigationTransition> {
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  late final ReverseAnimation barAnimation;
  bool controllerInitialized = false;
  bool showDivider = false;

  @override
  void initState() {
    super.initState();

    controller = widget.animationController;
    railAnimation = widget.railAnimation;

    barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      key: widget.scaffoldKey,
      appBar: widget.appBar,
      body: Row(
        children: <Widget>[
          RailTransition(
            animation: railAnimation,
            backgroundColor: colorScheme.surface,
            child: widget.navigationRail,
          ),
          widget.body,
        ],
      ),
      bottomNavigationBar: BarTransition(
        animation: barAnimation,
        backgroundColor: colorScheme.surface,
        child: widget.navigationBar,
      ),
      endDrawer: const NavigationDrawerSection(),
    );
  }
}

final List<NavigationRailDestination> navRailDestinations = appBarDestinations
    .map(
      (destination) => NavigationRailDestination(
        icon: Tooltip(
          message: destination.label,
          child: destination.icon,
        ),
        selectedIcon: Tooltip(
          message: destination.label,
          child: destination.selectedIcon,
        ),
        label: Text(destination.label),
      ),
    )
    .toList();

class SizeAnimation extends CurvedAnimation {
  SizeAnimation(Animation<double> parent)
      : super(
          parent: parent,
          curve: const Interval(
            0.2,
            0.8,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            0,
            0.2,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

class OffsetAnimation extends CurvedAnimation {
  OffsetAnimation(Animation<double> parent)
      : super(
          parent: parent,
          curve: const Interval(
            0.4,
            1.0,
            curve: Curves.easeInOutCubicEmphasized,
          ),
          reverseCurve: Interval(
            0,
            0.2,
            curve: Curves.easeInOutCubicEmphasized.flipped,
          ),
        );
}

class RailTransition extends StatefulWidget {
  const RailTransition(
      {super.key,
      required this.animation,
      required this.backgroundColor,
      required this.child});

  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;

  @override
  State<RailTransition> createState() => _RailTransition();
}

class _RailTransition extends State<RailTransition> {
  late Animation<Offset> offsetAnimation;
  late Animation<double> widthAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // The animations are only rebuilt by this method when the text
    // direction changes because this widget only depends on Directionality.
    final bool ltr = Directionality.of(context) == TextDirection.ltr;

    widthAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(widget.animation));

    offsetAnimation = Tween<Offset>(
      begin: ltr ? const Offset(-1, 0) : const Offset(1, 0),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class BarTransition extends StatefulWidget {
  const BarTransition(
      {super.key,
      required this.animation,
      required this.backgroundColor,
      required this.child});

  final Animation<double> animation;
  final Color backgroundColor;
  final Widget child;

  @override
  State<BarTransition> createState() => _BarTransition();
}

class _BarTransition extends State<BarTransition> {
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> heightAnimation;

  @override
  void initState() {
    super.initState();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(OffsetAnimation(widget.animation));

    heightAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(SizeAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          alignment: Alignment.topLeft,
          heightFactor: heightAnimation.value,
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
