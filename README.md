# Solidity Tic-Tac-Toe

This is a simple implementation of the classic game of Tic-Tac-Toe using Solidity.

## Game Rules

1. The game is played on a grid that's 3 squares by 3 squares.
2. Player 1 is X, Player 2 is O. Players take turns putting their symbols on the board.
3. The first player to get 3 of their symbols in a row (up, down, across, or diagonally) is the winner.
4. When all 9 squares are full, the game is over.

## Contract Functions

- `move(uint8 row, uint8 column)`: Makes a move for the current player at the specified row and column.
- `checkWin(uint8 row, uint8 column)`: Checks if the current player has won the game.
- `resetBoard()`: Resets the game board for a new game.

## Getting Started

To deploy and interact with the contract, you will need an Ethereum development environment, like Truffle, and an Ethereum client, like Ganache.

## License

This project is licensed under the MIT License.
