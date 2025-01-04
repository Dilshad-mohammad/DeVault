import 'package:flutter/material.dart';

import '../../../../utils/constants/helpers/colors.dart';
import '../Curved Edges/curved_edges_widget.dart';
import 'circular_container.dart';

class DPrimaryHeaderContainer extends StatelessWidget {
  const DPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DCurvedEdgesWidget(
      child: Container(
        color: DColors.primary,
        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(top: -150, right: -250, child: DCircularContainer(backgroundColor: DColors.textWhite.withAlpha(25))),
            Positioned(top: 100, right: -300, child: DCircularContainer(backgroundColor: DColors.textWhite.withAlpha(25))),
            child,
          ],
        ),
      ),
    );
  }
}
