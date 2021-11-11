import 'package:flutter/material.dart';
import 'package:newsrs/constants.dart';
import 'package:newsrs/widgets/settings.dart';

import 'package:newsrs/widgets/tiles/card_list_tile.dart';

class SourceCard extends StatelessWidget {
  final String source;

  const SourceCard({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Optimize this
    List<String> newSource = List.from(DynamicSettings.of(context).sources);
    newSource.remove(source);

    return CardListTile(
      color: Theme.of(context).backgroundColor,
      title: Text(source),
      trailing: IconButton(
        splashRadius: kSourceCardSplashRadius,
        color: Theme.of(context).colorScheme.error,
        onPressed: () => DynamicSettings.of(context).sources = newSource,
        icon: const Icon(Icons.delete_rounded),
      ),
    );
  }
}
