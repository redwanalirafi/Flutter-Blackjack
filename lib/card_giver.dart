import 'package:flutter/material.dart';
import 'dart:math';

Map<String, int> cardValues = {
  // Cards numbered 2 to 10
  "2_of_clubs.png": 2, "2_of_diamonds.png": 2, "2_of_hearts.png": 2,
  "2_of_spades.png": 2,
  "3_of_clubs.png": 3, "3_of_diamonds.png": 3, "3_of_hearts.png": 3,
  "3_of_spades.png": 3,
  "4_of_clubs.png": 4, "4_of_diamonds.png": 4, "4_of_hearts.png": 4,
  "4_of_spades.png": 4,
  "5_of_clubs.png": 5, "5_of_diamonds.png": 5, "5_of_hearts.png": 5,
  "5_of_spades.png": 5,
  "6_of_clubs.png": 6, "6_of_diamonds.png": 6, "6_of_hearts.png": 6,
  "6_of_spades.png": 6,
  "7_of_clubs.png": 7, "7_of_diamonds.png": 7, "7_of_hearts.png": 7,
  "7_of_spades.png": 7,
  "8_of_clubs.png": 8, "8_of_diamonds.png": 8, "8_of_hearts.png": 8,
  "8_of_spades.png": 8,
  "9_of_clubs.png": 9, "9_of_diamonds.png": 9, "9_of_hearts.png": 9,
  "9_of_spades.png": 9,
  "10_of_clubs.png": 10, "10_of_diamonds.png": 10, "10_of_hearts.png": 10,
  "10_of_spades.png": 10,

  // Jack, Queen, and King have a value of 10
  "jack_of_clubs.png": 10, "jack_of_diamonds.png": 10,
  "jack_of_hearts.png": 10, "jack_of_spades.png": 10,
  "jack_of_clubs2.png": 10, "jack_of_diamonds2.png": 10,
  "jack_of_hearts2.png": 10, "jack_of_spades2.png": 10,
  "queen_of_clubs.png": 10, "queen_of_diamonds.png": 10,
  "queen_of_hearts.png": 10, "queen_of_spades.png": 10,
  "queen_of_clubs2.png": 10, "queen_of_diamonds2.png": 10,
  "queen_of_hearts2.png": 10, "queen_of_spades2.png": 10,
  "king_of_clubs.png": 10, "king_of_diamonds.png": 10,
  "king_of_hearts.png": 10, "king_of_spades.png": 10,
  "king_of_clubs2.png": 10, "king_of_diamonds2.png": 10,
  "king_of_hearts2.png": 10, "king_of_spades2.png": 10,

  // Ace has a value of 11
  "ace_of_clubs.png": 11, "ace_of_diamonds.png": 11, "ace_of_hearts.png": 11,
  "ace_of_spades.png": 11,
  "ace_of_spades2.png": 11,

  // Optional: card_back.png could be excluded, or you could assign it a value of 0 or null if needed.
  "card_back.png": 0,
};

class CardGiver extends StatefulWidget {
  const CardGiver({super.key});

  @override
  State<CardGiver> createState() {
    return _CardGiver();
  }
}

class _CardGiver extends State<CardGiver> {
  var dealerCards = [
    Image.asset(
      'assets/images/card_back.png',
      width: 60,
    ),
    Image.asset(
      'assets/images/card_back.png',
      width: 60,
    ),
  ];
  var playerCards = [
    Image.asset(
      'assets/images/card_back.png',
      width: 60,
    ),
    Image.asset(
      'assets/images/card_back.png',
      width: 60,
    ),
  ];

  int dealerPoint = 0;
  int playerPoint = 0;
  int playerAce = 0;
  int dealerAce = 0;

  var result = "";

  void takeCard() {
    var random = Random();
    var randomKey =
        cardValues.keys.elementAt(random.nextInt(cardValues.length));

    if (randomKey.contains("ace")) {
      playerAce++;
    }
    // print("Take Card");
    setState(() {
      playerCards.removeWhere((card) =>
          (card.image as AssetImage).assetName ==
          'assets/images/card_back.png');

      playerCards.add(
        Image.asset(
          'assets/images/$randomKey',
          width: 60,
        ),
      );
      playerPoint += cardValues[randomKey] ?? 0;

      if (playerPoint > 21) {
        if (playerAce > 0) {
          playerAce--;
          playerPoint -= 10;
        } else {
          result = "YOU LOSE. Get better noob.";
        }
      }
    });
  }

  void resetCards() {
    setState(() {
      result = "";
      playerAce = 0;
      playerPoint = 0;
      playerCards = [
        Image.asset(
          'assets/images/card_back.png',
          width: 60,
        ),
        Image.asset(
          'assets/images/card_back.png',
          width: 60,
        ),
      ];

      dealerAce = 0;
      dealerPoint = 0;
      dealerCards = [
        Image.asset(
          'assets/images/card_back.png',
          width: 60,
        ),
        Image.asset(
          'assets/images/card_back.png',
          width: 60,
        ),
      ];
    });
  }

  void playerHold() {
    setState(() {
      while (dealerPoint < 17) {
        dealerCards.removeWhere((card) =>
            (card.image as AssetImage).assetName ==
            'assets/images/card_back.png');

        var random = Random();
        var randomKey =
            cardValues.keys.elementAt(random.nextInt(cardValues.length));

        if (randomKey.contains("ace")) {
          dealerAce++;
        }

        dealerCards.add(
          Image.asset(
            'assets/images/$randomKey',
            width: 60,
          ),
        );
        dealerPoint += cardValues[randomKey] ?? 0;

        if (dealerPoint > 21) {
          if (dealerAce > 0) {
            dealerAce--;
            dealerPoint -= 10;
          }
        }
      }

      if (dealerPoint > 21) {
        result = "You Win! Congrats.";
      } else if (dealerPoint == playerPoint) {
        result = "Draw...";
      } else if (dealerPoint > playerPoint) {
        result = "Dealer Wins! Get better loser.";
      } else {
        result = "You Win! Congrats ig.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          "Dealer Point: $dealerPoint",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: dealerCards,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: playerCards,
        ),
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: takeCard,
              style: TextButton.styleFrom(
                // padding: const EdgeInsets.only(
                //   top: 50,
                // ),
                backgroundColor: const Color.fromARGB(255, 31, 243, 23),
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Take Card"),
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              onPressed: playerHold,
              style: TextButton.styleFrom(
                // padding: const EdgeInsets.only(
                //   top: 50,
                // ),
                backgroundColor: const Color.fromARGB(255, 201, 23, 0),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Hold"),
            ),
          ],
        ),
        TextButton(
          onPressed: resetCards,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   top: 50,
            // ),
            backgroundColor: const Color.fromARGB(255, 0, 119, 255),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18),
          ),
          child: const Text("Reset"),
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
          "Player Point:$playerPoint",
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
          result,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
