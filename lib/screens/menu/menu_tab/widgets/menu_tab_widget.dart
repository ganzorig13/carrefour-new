import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuTabWidget extends StatelessWidget {
  final MenuTabModel model;
  final Function(MenuTabItemType, bool?) onTap;
  const MenuTabWidget({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (model.title.isNotEmpty)
          SizedBox(
            height: 40,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                model.title,
                style: IOStyles.body1Bold.copyWith(
                  color: IOColors.brand700,
                ),
              ),
            ),
          ),
        IOCardWidget(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = model.items[index];

              return SizedBox(
                height: 56,
                child: IOButtonOpacityWidget(
                  onTap: () => onTap(item.type, null),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: item.isSvg
                              ? SvgPicture.asset(
                                  'assets/icons/${item.type.icon}',
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    IOColors.brand600,
                                    BlendMode.srcIn,
                                  ),
                                )
                              : Image.asset(
                                  'assets/icons/${item.type.icon}',
                                  width: 24,
                                  height: 24,
                                ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.type.title,
                            overflow: TextOverflow.ellipsis,
                            style: IOStyles.body2Bold.copyWith(
                              color: IOColors.brand600,
                            ),
                          ),
                        ),
                        item.value == null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: SvgPicture.asset(
                                  'assets/icons/chevron.right.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: const ColorFilter.mode(
                                    IOColors.brand600,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            : IOSwitch(
                                value: item.value!,
                                onChanged: (v) => onTap(item.type, v),
                              ),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                thickness: 1,
                color: IOColors.strokePrimary,
              );
            },
            itemCount: model.items.length,
          ),
        ),
      ],
    );
  }
}
