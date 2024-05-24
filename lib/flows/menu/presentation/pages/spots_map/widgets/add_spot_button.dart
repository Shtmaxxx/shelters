import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shelters/gen/assets.gen.dart';
class AddSpotButton extends StatelessWidget {
  const AddSpotButton({
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 70,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0.0, 0.75),
                  blurRadius: 10,
                  spreadRadius: 4,
                  color: Theme.of(context).primaryColor.withOpacity(0.44),
                )
              ]),
          child: SvgPicture.asset(
            Assets.icons.add.path,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
