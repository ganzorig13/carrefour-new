import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carrefour/library/library.dart';

class IOButtonWidget extends StatelessWidget {
  final IOButtonMainModel model;
  final VoidCallback? onPressed;
  const IOButtonWidget({
    super.key,
    required this.model,
    this.onPressed,
  });

  VoidCallback? onTap() {
    return (model.isLoading || !model.isEnabled) ? null : onPressed;
  }

  Widget get child => model.onlyIcon
      ? Center(
          child: SizedBox.square(
            dimension: model.size.iconSize,
            child: model.isLoading
                ? CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(
                      model.foregroundColor,
                    ),
                  )
                : SvgPicture.asset(
                    'assets/icons/${model.icon}',
                    width: model.size.iconSize,
                    height: model.size.iconSize,
                    colorFilter: ColorFilter.mode(
                      model.foregroundColor,
                      BlendMode.srcIn,
                    ),
                  ),
          ),
        )
      : Padding(
          padding: model.size.padding,
          child: Row(
            mainAxisSize:
                model.isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: model.isLoading
                ? [
                    SizedBox.square(
                      dimension: model.size.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(
                          model.foregroundColor,
                        ),
                      ),
                    )
                  ]
                : [
                    if (model.hasPrefix)
                      Padding(
                        padding: EdgeInsets.only(
                          right: model.size.separator,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/${model.prefixIcon}',
                          width: model.size.iconSize,
                          height: model.size.iconSize,
                          colorFilter: ColorFilter.mode(
                            model.foregroundColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    Flexible(
                      child: Text(
                        model.label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: model.size.style.copyWith(
                          color: model.foregroundColor,
                        ),
                      ),
                    ),
                    if (model.hasSuffix)
                      Padding(
                        padding: EdgeInsets.only(
                          left: model.size.separator,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/${model.suffixIcon}',
                          width: model.size.iconSize,
                          height: model.size.iconSize,
                          colorFilter: ColorFilter.mode(
                            model.foregroundColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                  ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: model.size.height,
      width: model.onlyIcon ? model.size.height : null,
      decoration: BoxDecoration(
        color: model.backgroundColor,
        borderRadius: BorderRadius.circular(model.borderRadius),
        border: Border.all(
          width: 1,
          color: model.borderColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(model.borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap(),
            splashColor: Colors.transparent,
            highlightColor: model.fBackgroundColor,
            child: child,
          ),
        ),
      ),
    );
  }
}
