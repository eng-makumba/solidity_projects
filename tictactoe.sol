// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TicTacToe {
    address public player1;
    address public player2;
    address public currentPlayer;
    
    uint8[3][3] public board;
    
    enum GameState { Active, Draw, Player1Won, Player2Won }
    GameState public gameState;
    
    event MoveMade(address player, uint8 row, uint8 col);
    event GameEnded(GameState gameState, address winner);

    modifier onlyPlayers() {
        require(msg.sender == player1 || msg.sender == player2, "Not a player");
        _;
    }

    modifier validMove(uint8 row, uint8 col) {
        require(row < 3 && col < 3, "Invalid row or column");
        require(board[row][col] == 0, "Cell already taken");
        _;
    }

    modifier onlyDuringGame() {
        require(gameState == GameState.Active, "Game is not active");
        _;
    }

    constructor() {
        player1 = msg.sender;
        currentPlayer = player1;
    }

    function joinGame() external {
        require(player2 == address(0), "Game is already full");
        player2 = msg.sender;
        gameState = GameState.Active;
    }

    function makeMove(uint8 row, uint8 col) external onlyPlayers onlyDuringGame validMove(row, col) {
        require(msg.sender == currentPlayer, "It's not your turn");
        
        // Mark the board with the player's symbol
        board[row][col] = (msg.sender == player1) ? 1 : 2;

        emit MoveMade(msg.sender, row, col);

        if (checkWin()) {
            gameState = (currentPlayer == player1) ? GameState.Player1Won : GameState.Player2Won;
            emit GameEnded(gameState, currentPlayer);
        } else if (checkDraw()) {
            gameState = GameState.Draw;
            emit GameEnded(GameState.Draw, address(0));
        } else {
            // Switch to the other player
            currentPlayer = (currentPlayer == player1) ? player2 : player1;
        }
    }

    function checkWin() internal view returns (bool) {
        // Check rows, columns, and diagonals for three of the same symbol
        for (uint8 i = 0; i < 3; i++) {
            if (board[i][0] == board[i][1] && board[i][1] == board[i][2] && board[i][0] != 0) {
                return true; // Row
            }
            if (board[0][i] == board[1][i] && board[1][i] == board[2][i] && board[0][i] != 0) {
                return true; // Column
            }
        }

        if (board[0][0] == board[1][1] && board[1][1] == board[2][2] && board[0][0] != 0) {
            return true; // Diagonal
        }

        if (board[0][2] == board[1][1] && board[1][1] == board[2][0] && board[0][2] != 0) {
            return true; // Diagonal
        }

        return false;
    }

    function checkDraw() internal view returns (bool) {
        for (uint8 i = 0; i < 3; i++) {
            for (uint8 j = 0; j < 3; j++) {
                if (board[i][j] == 0) {
                    return false; // There is an empty cell, game is not a draw
                }
            }
        }
        return true; // All cells are filled, game is a draw
    }

    function resetGame() external onlyPlayers {
        require(gameState != GameState.Active, "Game is still active");
        
        // Reset the game state and board
        gameState = GameState.Active;
        currentPlayer = player1;
        
        for (uint8 i = 0; i < 3; i++) {
            for (uint8 j = 0; j < 3; j++) {
                board[i][j] = 0;
            }
        }
    }
}
