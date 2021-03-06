import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:svarog/constants.dart';
import 'package:svarog/widgets/settings.dart';
import 'package:svarog/widgets/tiles/card_list_tile.dart';

class SourceCard extends StatelessWidget {
  final Uri source;

  const SourceCard({
    Key? key,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardListTile(
      color: Theme.of(context).backgroundColor,
      title: Text(source.host),
      horizontalTitleGap: kSourceCardHGap,
      dense: true,
      leading: ClipRRect(
        child: CachedNetworkImage(
          imageUrl: source.toString() + '/favicon.ico',
          height: kSourceCardImageSize,
          width: kSourceCardImageSize,
          placeholder: (context, _) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(
            Icons.warning_rounded,
          ),
        ),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      trailing: IconButton(
        splashRadius: kSourceCardSplashRadius,
        color: Theme.of(context).colorScheme.error,
        onPressed: () => _onDelete(context),
        icon: const Icon(Icons.delete_rounded),
      ),
    );
  }

  void _onDelete(BuildContext context) {
    Set<Uri> newSource = Set.from(DynamicSettings.of(context).sources);
    newSource.remove(source);
    DynamicSettings.of(context).sources = newSource;
  }
}
