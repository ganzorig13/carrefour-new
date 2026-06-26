import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carrefour/library/library.dart';

class IORegisterWidget extends StatefulWidget {
  final IORegisterModel model;
  const IORegisterWidget({super.key, required this.model});

  @override
  State<IORegisterWidget> createState() => _IORegisterWidgetState();
}

class _IORegisterWidgetState extends State<IORegisterWidget> {
  @override
  void initState() {
    super.initState();
    widget.model.first.status.addListener(checkValidation);
    widget.model.last.status.addListener(checkValidation);
    widget.model.number.status.addListener(checkValidation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Регистрийн дугаар',
          style: IOStyles.caption1Bold,
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child: IOTextfieldWidget(
                model: widget.model.first,
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 6,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/chevron.down.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      IOColors.textTertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                onTap: onTapFirst,
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 70,
              child: IOTextfieldWidget(
                model: widget.model.last,
                suffix: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 6,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/chevron.down.svg',
                    width: 24,
                    height: 24,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      IOColors.textTertiary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                onTap: onTapLast,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: IOTextfieldWidget(
                model: widget.model.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void checkValidation() {
    final isValid = widget.model.first.isValid &&
        widget.model.last.isValid &&
        widget.model.number.isValid;
    widget.model.status.value = IOTextfieldStatusModel(
      status: isValid ? IOTextfieldStatus.success : IOTextfieldStatus.error,
      descriptionText: 'Утга буруу байна',
    );
  }

  void onTapFirst() async {
    final char = await IORegisterSheet(
      chars: widget.model.chars,
    ).show();
    widget.model.first.focusNode.unfocus();
    if (char == null) return;
    widget.model.first.controller.text = char;
    widget.model.first.status.value = IOTextfieldStatusModel(
      status: IOTextfieldStatus.success,
    );
  }

  void onTapLast() async {
    final char = await IORegisterSheet(
      chars: widget.model.chars,
    ).show();
    widget.model.last.focusNode.unfocus();
    if (char == null) return;
    widget.model.last.controller.text = char;
    widget.model.last.status.value = IOTextfieldStatusModel(
      status: IOTextfieldStatus.success,
    );
  }
}
