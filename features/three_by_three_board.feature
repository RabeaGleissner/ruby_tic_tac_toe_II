Feature: Three by three board
  In order to make sure that the three by three board is implemented,
  As a player,
  I want to play the game on this board size.

Scenario: First player wins
    Given an empty three by three board
    When the first player chooses the top left position
    And the second player chooses the bottom left position
    And the first player chooses the top middle position
    And the second player chooses the bottom middle position
    And the first player chooses the top right position
    Then the first player wins.
