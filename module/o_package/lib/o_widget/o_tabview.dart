// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OTabBar extends StatefulWidget {
  final List<Widget> tab;
  final List<Widget> view;
  final bool
  isTabBarAtTop; // TabBar'ın pozisyonunu belirler (true: üst, false: alt)
  final Widget? topWidget; // Sayfanın en üstüne eklenecek widget
  final Widget? bottomWidget; // Sayfanın en altına eklenecek widget
  final Function(TabController)?
  onTabControllerCreated; // İsteğe bağlı callback
  final Function(TabController controller)?
  onTabChanged; // İsteğe bağlı callback
  final PreferredSizeWidget? appBar;

  final TabBarProperties? tabBarProperties;
  final TextStyle? labelStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;

  const OTabBar({
    super.key,
    required this.tab,
    required this.view,
    this.isTabBarAtTop = true, // Varsayılan olarak üstte
    this.topWidget,
    this.bottomWidget,
    this.onTabControllerCreated, // İsteğe bağlı
    this.onTabChanged,
    this.appBar, // İsteğe bağlı
    this.tabBarProperties,
    this.labelStyle,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
  });

  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<OTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tab.length, vsync: this);

    // Eğer callback tanımlandıysa, TabController'ı döndür
    if (widget.onTabControllerCreated != null) {
      widget.onTabControllerCreated!(_tabController);
    }

    // Sekme değişikliklerini dinlemek için listener ekliyoruz
    _tabController.addListener(() {
      if (_tabController.indexIsChanging && widget.onTabChanged != null) {
        // Eğer callback tanımlandıysa, sekme değişikliğini bildir
        widget.onTabChanged!(_tabController);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      body: Column(
        mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment:
            widget.crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          if (widget.topWidget != null) widget.topWidget!, // Üst widget
          if (widget.isTabBarAtTop) _buildTabBar(), // TabBar'ı üstte mi?
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.view,
            ),
          ),
          if (!widget.isTabBarAtTop) _buildTabBar(), // TabBar'ı altta mı?
          if (widget.bottomWidget != null) widget.bottomWidget!, // Alt widget
        ],
      ),
    );
  }

  // TabBar'ı oluşturan yardımcı metot
  Widget _buildTabBar() {
    return Material(
      color: widget.tabBarProperties?.backgroundColor,
      child: TabBar(
        controller: _tabController,
        tabs: widget.tab.map((title) => title).toList(),
        dividerColor: widget.tabBarProperties?.dividerColor,
        dividerHeight: widget.tabBarProperties?.dividerHeight,
        automaticIndicatorColorAdjustment:
            widget.tabBarProperties?.automaticIndicatorColorAdjustment ?? true,
        indicatorColor: widget.tabBarProperties?.indicatorColor,
        indicatorSize: widget.tabBarProperties?.indicatorSize,
        indicator: widget.tabBarProperties?.indicator,
        indicatorPadding:
            widget.tabBarProperties?.indicatorPadding ?? EdgeInsets.zero,
        overlayColor: WidgetStateProperty.all(
          widget.tabBarProperties?.overlayColor,
        ),
        isScrollable: widget.tabBarProperties?.isScrollable ?? false,
        labelColor: widget.tabBarProperties?.labelColor,
        unselectedLabelColor: widget.tabBarProperties?.unselectedLabelColor,
        indicatorWeight: widget.tabBarProperties?.indicatorWeight ?? 2,
        labelPadding:
            widget.tabBarProperties?.labelPadding ?? const EdgeInsets.all(16),
        labelStyle: widget.labelStyle,
      ),
    );
  }
}

class TabBarProperties {
  Color? dividerColor;
  double? dividerHeight;
  Color? backgroundColor;
  Color? labelColor;
  bool? automaticIndicatorColorAdjustment;
  Color? indicatorColor;
  TabBarIndicatorSize? indicatorSize;
  EdgeInsetsGeometry? indicatorPadding;
  Color? overlayColor;
  Color? unselectedLabelColor;
  double? indicatorWeight;
  EdgeInsetsGeometry? labelPadding;
  bool? isScrollable;
  Decoration? indicator;

  TabBarProperties({
    this.dividerColor,
    this.dividerHeight,
    this.backgroundColor,
    this.automaticIndicatorColorAdjustment,
    this.indicatorColor,
    this.indicatorSize,
    this.indicatorPadding,
    this.overlayColor,
    this.unselectedLabelColor,
    this.indicatorWeight,
    this.labelPadding,
    this.isScrollable,
    this.indicator,
    this.labelColor,
  });
}
