import 'package:flutter/material.dart';

import 'package:newsrs/constants.dart';

// TODO: Add SharedPrefs and add more values
class DynamicSettings extends StatefulWidget {
  final Widget child;

  const DynamicSettings({
    Key? key,
    required this.child,
  }) : super(key: key);

  static _DynamicSettingsState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsData>()!.state;

  @override
  _DynamicSettingsState createState() => _DynamicSettingsState();
}

class _DynamicSettingsState extends State<DynamicSettings> {
  bool _isAppBarBottom = kIsAppBarBottom;
  List<String> _sources = kDefaultSources;

  bool get isAppBarBottom => _isAppBarBottom;
  List<String> get sources => _sources;

  set isAppBarBottom(bool newValue) => setState(
        () => _isAppBarBottom = newValue,
      );

  set sources(List<String> newValue) => setState(
        () => _sources = newValue,
      );

  @override
  Widget build(BuildContext context) {
    return SettingsData(
      child: widget.child,
      state: this,
      isAppBarBottom: _isAppBarBottom,
      sources: _sources,
    );
  }
}

class SettingsData extends InheritedWidget {
  final bool isAppBarBottom;
  final _DynamicSettingsState state;
  final List<String> sources;

  const SettingsData({
    Key? key,
    required Widget child,
    required this.isAppBarBottom,
    required this.sources,
    required this.state,
  }) : super(key: key, child: child);

  static SettingsData? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsData>();

  @override
  bool updateShouldNotify(SettingsData oldWidget) =>
      isAppBarBottom != oldWidget.isAppBarBottom ||
      sources != oldWidget.sources;
}