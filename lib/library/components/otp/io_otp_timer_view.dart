import 'package:flutter/material.dart';
import 'package:carrefour/library/library.dart';

class IOOtpTimerWidget extends StatefulWidget {
  final IOOtpTimerModel model;
  final VoidCallback? onTap;
  const IOOtpTimerWidget({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  State<IOOtpTimerWidget> createState() => _IOOtpTimerState();
}

class _IOOtpTimerState extends State<IOOtpTimerWidget> {
  late final VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      if (mounted) setState(() {});
    };
    widget.model.addListener(_listener);
  }

  @override
  void dispose() {
    widget.model.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: widget.model.isTimerEnded
          ? IOButtonWidget(
              model: widget.model.buttonModel,
              onPressed: widget.onTap,
            )
          : Text(
              '${widget.model.minute}:${widget.model.second}',
              style: IOStyles.caption1Bold.copyWith(
                color: IOColors.brand500,
              ),
            ),
    );
  }
}
