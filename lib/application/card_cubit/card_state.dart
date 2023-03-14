part of 'card_cubit.dart';

class CardState {
  CardModel? card;
  bool isLoading;

  CardState({this.card, this.isLoading = false});

  CardState copyWith({
    CardModel? card,
    bool? isLoading,
    String? number,
    String? owner,
    String? ownerId,
    String? expireDate,
    num? moneyAmount,
    String? cardName,
    int? indexGradient,
    int? indexImage,
    bool? isMain,
    String? docId,
  }) {
    return CardState(
      card: card ?? CardModel(
        number: number ?? this.card?.number,
        owner: owner ?? this.card?.owner,
        ownerId: ownerId ?? this.card?.ownerId,
        expireDate: expireDate ?? this.card?.expireDate,
        moneyAmount: moneyAmount ?? this.card?.moneyAmount,
        indexImage: indexImage ?? this.card?.indexImage,
        cardName: cardName ?? this.card?.cardName,
        indexGradient: indexGradient ?? this.card?.indexGradient,
        isMain: isMain ?? this.card?.isMain,
        docId: docId ?? this.card?.docId,
      ),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
