import 'dart:io';

void main() {
  TicTacToe().startGame();
}

class TicTacToe {
  List<String> square = List.filled(9, '');
  String currentPlayer = 'x';
  String winner = '';

  void startGame() {
    print('Welcome to Tic-Tac-Toe Game .. Good Luck!');
    while (true) {
      displayBoard();

      if (checkWin() || checkDraw()) {
        displayResult();
        if (!playAgain()) break;
        square = List.filled(9, '');
        currentPlayer = 'x';
        continue;
      }

      makeMove();
      switchPlayer();
    }
  }

  void displayBoard() {
    print(' ${square[0]}  | ${square[1]} | ${square[2]} ');
    print('-----------');
    print(' ${square[3]}  | ${square[4]} | ${square[5]} ');
    print('-----------');
    print(' ${square[6]}  | ${square[7]} | ${square[8]} ');
  }

  bool isValidMove(int pos) {
    return pos >= 1 && pos <= 9 && square[pos - 1] == '';
  }

  void makeMove() {
    int? pos;
    do {
      print('Player $currentPlayer  enter from 1 to 9 :');
      pos = int.tryParse(stdin.readLineSync() ?? '');
      if (pos == null || !isValidMove(pos)) {
        print('Invalid move. Please try again.');
      }
    } while (pos == null || !isValidMove(pos));

    square[pos - 1] = currentPlayer;
  }

  bool checkWin() {
    List<List<int>> winConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];

    for (var condition in winConditions) {
      if (square[condition[0]] != '' &&
          square[condition[0]] == square[condition[1]] &&
          square[condition[1]] == square[condition[2]]) {
        winner = currentPlayer;
        return true;
      }
    }
    return false;
  }

  bool checkDraw() {
    return square.every((cell) => cell != '');
  }

  void displayResult() {
    if (winner.isNotEmpty) {
      print('Player $winner Lost! Congrats');
    } else {
      print('Draw .. Try again <3');
    }
  }

  void switchPlayer() {
    currentPlayer = (currentPlayer == 'o') ? 'x' : 'o';
  }

  bool playAgain() {
    print('Do you want to play again? (Yes/No)');
    String response = stdin.readLineSync()?.toLowerCase() ?? '';
    return response == 'yes';
  }
}
