class EnabledCodec {
  String? mime;
  String? fmtpLine;

  EnabledCodec({this.mime, this.fmtpLine});

  factory EnabledCodec.fromJson(Map<String, dynamic> json) => EnabledCodec(
        mime: json['mime'] as String?,
        fmtpLine: json['fmtpLine'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'mime': mime,
        'fmtpLine': fmtpLine,
      };
}
