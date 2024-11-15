enum PieceType {
  date,
  image,
  text;

  String get tagname => switch (this) {
        PieceType.date => "날짜",
        PieceType.image => "사진",
        PieceType.text => "내용",
      };
}
