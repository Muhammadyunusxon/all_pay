class CardModel {
  CardModel({
    this.number,
    this.owner,
    this.ownerId,
    this.docId,
    this.expireDate,
    this.moneyAmount=5000,
    this.cardName,
    this.indexGradient=-1,
    this.indexImage=1,
    this.isMain,
  });

  String? number;
  String? owner;
  String? ownerId;
  String? docId;
  String? expireDate;
  num? moneyAmount;
  String? cardName;
  int? indexGradient;
  int? indexImage;
  bool? isMain;

  CardModel copyWith({
    String? number,
    String? owner,
    String? ownerId,
    String? docId,
    String? expireDate,
    num? moneyAmount,
    String? cardName,
    int? indexGradient,
    int? indexImage,
    bool? isMain,
  }) =>
      CardModel(
        number: number ?? this.number,
        owner: owner ?? this.owner,
        ownerId: ownerId ?? this.ownerId,
        docId: docId ?? this.docId,
        expireDate: expireDate ?? this.expireDate,
        moneyAmount: moneyAmount ?? this.moneyAmount,
        cardName: cardName ?? this.cardName,
        indexGradient: indexGradient ?? this.indexGradient,
        indexImage: indexImage ?? this.indexImage,
        isMain: isMain ?? this.isMain,
      );

  factory CardModel.fromJson({required Map json, required String docId}) =>
      CardModel(
        number: json["number"],
        owner: json["owner"],
        ownerId: json["ownerId"],
        docId: docId,
        expireDate: json["expireDate"],
        moneyAmount: json["moneyAmount"],
        cardName: json["cardName"],
        indexGradient: json["indexGradient"],
        indexImage: json["indexImage"],
        isMain: json["isMain"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "owner": owner,
        "ownerId": ownerId,
        "expireDate": expireDate,
        "moneyAmount": moneyAmount,
        "cardName": cardName,
        "indexGradient": indexGradient,
        "indexImage": indexImage,
        "isMain": isMain,
      };
}
