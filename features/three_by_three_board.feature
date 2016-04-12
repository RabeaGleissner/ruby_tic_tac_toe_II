Feature: Three by three board
  A player can play the game on a three by three board.

Scenario: First player wins
    Given an empty three by three board
    When the first player chooses the top left position
    And the second player chooses the bottom left position
    And the first player chooses the top middle position
    And the second player chooses the bottom middle position
    And the first player chooses the top right position
    Then the first player wins.
