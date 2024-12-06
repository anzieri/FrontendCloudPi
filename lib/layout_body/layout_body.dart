import "package:flutter/material.dart";
import "package:remotefilesystem/centered_view.dart";
import "package:remotefilesystem/homie.dart";

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return const CenteredView(child: Homie());
      },
    );
  }
}