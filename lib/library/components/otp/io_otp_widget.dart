import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOOtpWidget extends StatefulWidget {
  final IOOtpModel model;
  const IOOtpWidget({super.key, required this.model});

  @override
  State<IOOtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<IOOtpWidget> {
  List<Widget> digits = [];

  @override
  void initState() {
    super.initState();
    buildDigit();
    widget.model.controller.addListener(_onModelChanged);
    widget.model.focus.addListener(_onModelChanged);
  }

  @override
  void dispose() {
    widget.model.controller.removeListener(_onModelChanged);
    widget.model.focus.removeListener(_onModelChanged);
    super.dispose();
  }

  void _onModelChanged() => buildDigit();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.model.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: digits,
          ),
          Opacity(
            opacity: 0,
            child: TextFormField(
              autofocus: widget.model.isAutoFocus,
              controller: widget.model.controller,
              focusNode: widget.model.focus,
              maxLength: widget.model.length,
              keyboardType: widget.model.keyboardType,
            ),
          ),
        ],
      ),
    );
  }

  void buildDigit() {
    if (!mounted) return;
    final temp = <Widget>[];
    final value = widget.model.value;
    for (int i = 0; i < widget.model.length; i++) {
      bool isActive = false;
      if (widget.model.focus.hasFocus) {
        isActive = i == value.length;
        if (i == widget.model.length - 1 && widget.model.isValid) {
          isActive = true;
        }
      }
      final digit = IOOtpDigitWidget(
        size: widget.model.size,
        isSecure: widget.model.isSecure,
        isCurrent: isActive,
        value: i < value.length ? value[i] : null,
      );
      temp.add(digit);
    }

    setState(() {
      digits = temp;
    });
  }
}

class IOOtpDigitWidget extends StatelessWidget {
  final String? value;
  final double size;
  final bool isSecure;
  final bool isCurrent;
  const IOOtpDigitWidget({
    super.key,
    required this.size,
    required this.isSecure,
    required this.isCurrent,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          width: 1,
          color: isCurrent ? IOColors.brand500 : IOColors.strokePrimary,
        ),
      ),
      child: value == null
          ? const Text(
              '-',
              style: IOStyles.body2Regular,
            )
          : isSecure
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: IOColors.brand500,
                    shape: BoxShape.circle,
                  ),
                )
              : Text(
                  value!,
                  textAlign: TextAlign.center,
                  style: IOStyles.body1Bold,
                ),
    );
  }
}
