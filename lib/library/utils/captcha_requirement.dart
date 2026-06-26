class CaptchaRequirement {
  CaptchaRequirement._();

  static final CaptchaRequirement _instance = CaptchaRequirement._();
  static CaptchaRequirement get instance => _instance;

  final List<DateTime> _sendOtpTimestamps = [];
  static const int _sendOtpWindowMinutes = 10;
  static const int _sendOtpLimitWithoutCaptcha = 2;

  int _failedVerifyAttempts = 0;
  static const int _failedVerifyLimit = 2; 

  void recordSendOtpRequest() {
    final cutoff = DateTime.now().subtract(const Duration(minutes: _sendOtpWindowMinutes));
    _sendOtpTimestamps.removeWhere((t) => t.isBefore(cutoff));
    _sendOtpTimestamps.add(DateTime.now());
  }

  bool get shouldRequireCaptchaForSendOtp {
    final cutoff = DateTime.now().subtract(const Duration(minutes: _sendOtpWindowMinutes));
    final count = _sendOtpTimestamps.where((t) => t.isAfter(cutoff)).length;
    return count >= _sendOtpLimitWithoutCaptcha;
  }

  bool get shouldRequireCaptchaForVerify {
    return _failedVerifyAttempts >= _failedVerifyLimit;
  }

  void recordFailedVerify() {
    _failedVerifyAttempts++;
  }

  void recordSuccessVerify() {
    _failedVerifyAttempts = 0;
  }
}
