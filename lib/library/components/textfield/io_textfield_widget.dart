import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carrefour/library/library.dart';

class IOTextfieldWidget extends StatefulWidget {
  final IOTextfieldModel model;
  final Widget? suffix;
  final VoidCallback? onTap;
  const IOTextfieldWidget({
    super.key,
    required this.model,
    this.suffix,
    this.onTap,
  });

  @override
  State<IOTextfieldWidget> createState() => _IOTextfieldWidgetState();
}

class _IOTextfieldWidgetState extends State<IOTextfieldWidget> {
  final borderRadius = BorderRadius.circular(8);

  Widget get secureButton => SizedBox.square(
        dimension: 48,
        child: IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius.copyWith(
                topLeft: const Radius.circular(0),
                bottomLeft: const Radius.circular(0),
              ),
            ),
          ),
          icon: SvgPicture.asset(
            widget.model.isSecure
                ? 'assets/icons/eye.off.svg'
                : 'assets/icons/eye.on.svg',
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(
              IOColors.textTertiary,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () {
            setState(() {
              widget.model.isSecure = !widget.model.isSecure;
            });
          },
        ),
      );
  Widget? get suffix =>
      widget.model.keyboardType == TextInputType.visiblePassword
          ? secureButton
          : widget.suffix;

  @override
  void initState() {
    super.initState();
    widget.model.focusNode.addListener(() {
      if (mounted) setState(() {});
    });
    widget.model.status.addListener(() {
      if (mounted) setState(() {});
    });
    if (widget.model.validators != null) {
      Validator(validations: widget.model.validators ?? []).setValidation(
        controller: widget.model.controller,
        status: widget.model.status,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.model.hasTitle) ...[
          Text(
            widget.model.label,
            style: IOStyles.caption1Bold.copyWith(color: IOColors.brand500),
          ),
          const SizedBox(height: 8)
        ],
        TextFormField(
          onTap: widget.onTap,
          style: IOStyles.body2Regular.copyWith(
            color: IOColors.textPrimary.withOpacity(
              widget.model.isEnabled ? 1 : 0.5,
            ),
          ),
          inputFormatters: widget.model.inputFormatters,
          textInputAction: TextInputAction.done,
          cursorColor: IOColors.textPrimary,
          enabled: widget.model.isEnabled,
          focusNode: widget.model.focusNode,
          controller: widget.model.controller,
          keyboardType: widget.model.keyboardType,
          obscureText: widget.model.isSecure,
          autocorrect: false,
          enableSuggestions: false,
          maxLength: widget.model.maxLength,
          maxLines: widget.model.maxLine,
          readOnly: widget.model.readOnly,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: widget.model.hasBorder
                    ? const BorderSide(
                        width: 1,
                        color: IOColors.strokePrimary,
                      )
                    : BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: widget.model.hasBorder
                    ? const BorderSide(
                        width: 1,
                        color: IOColors.brand100,
                      )
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: widget.model.hasBorder
                    ? const BorderSide(
                        width: 1,
                        color: IOColors.brand500,
                      )
                    : BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: widget.model.hasBorder
                    ? const BorderSide(
                        width: 1,
                        color: IOColors.errorPrimary,
                      )
                    : BorderSide.none,
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: widget.model.hasBorder
                    ? const BorderSide(
                        width: 1,
                        color: IOColors.errorPrimary,
                      )
                    : BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              filled: true,
              fillColor: IOColors.backgroundPrimary,
              // fillColor: switch (widget.model.status.value.status) {
              //   IOTextfieldStatus.normal => IOColors.backgroundPrimary,
              //   IOTextfieldStatus.success => IOColors.backgroundPrimary,
              //   IOTextfieldStatus.error => IOColors.errorSecondary,
              // },
              hintText: widget.model.placeholder,
              hintStyle: IOStyles.body1Regular.copyWith(
                color: IOColors.brand200,
              ),
              errorText: widget.model.status.value.descriptionText,
              counterText: '',

              // errorStyle: const TextStyle(fontSize: 0),
              helperStyle: const TextStyle(fontSize: 0),
              counterStyle: const TextStyle(fontSize: 0),
              suffixIcon: suffix,
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 48,
                minWidth: 24,
                maxHeight: 48,
                minHeight: 48,
              )
              // suffix: suffix,
              // prefixIcon: widget.model.prefix,
              ),
        ),
      ],
    );
  }
}
