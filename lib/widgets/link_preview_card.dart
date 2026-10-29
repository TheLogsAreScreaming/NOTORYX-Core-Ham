import 'package:flutter/material.dart';

import '../services/link_preview.dart';
import '../theme/mesh_theme.dart';

/// A quiet card under a message: site, title and a line of description.
/// Shows nothing until (and unless) the page gives a title.
class LinkPreviewCard extends StatelessWidget {
  const LinkPreviewCard({super.key, required this.url, this.fetcher});

  final Uri url;
  final LinkPreviewFetcher? fetcher;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LinkPreview?>(
      future: (fetcher ?? linkPreviews).preview(url),
      builder: (context, snap) {
        final p = snap.data;
        if (p == null) return const SizedBox.shrink();
        return Container(
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.fromLTRB(8, 4, 4, 4),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: MeshPalette.line3, width: 2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                p.site,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: MeshTheme.mono(fontSize: 11.5, color: MeshPalette.ink3),
              ),
              Text(
                p.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: MeshPalette.ink,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (p.description != null)
                Text(
                  p.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: MeshPalette.ink3, fontSize: 13),
                ),
            ],
          ),
        );
      },
    );
  }
}
