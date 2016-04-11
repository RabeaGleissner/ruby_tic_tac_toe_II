Feature: Four by four board
  A player can play the game on a four by four board.

Scenario: First player wins
    Given an empty four by four board
    When the first player chooses the first position in the first row
    And the second player chooses the last position in the first row
    And the first player chooses the first position in the second row
    And the second player chooses the last position in the second row
    And the first player chooses the first position in the third row
    And the second player chooses the last position in the third row
    And the first player chooses the first position in the last row
    Then the first player wins.

Scenario: Second player wins
    Given an empty four by four board
    When the first player chooses the first position in the first row
    And the second player chooses the last position in the first row
    And the first player chooses the first position in the second row
    And the second player chooses the last position in the second row
    And the first player chooses the first position in the third row
    And the second player chooses the last position in the third row
    And the first player chooses the second position in the last row
    And the second player chooses the last position in the last row
    Then the second player wins.

Scenario: Game ends with a draw
    Given an empty four by four board
    When the first player chooses the first position in the first row
    And the second player chooses the second position in the first row
    And the first player chooses the third position in the first row
    And the second player chooses the fourth position in the first row
    And the first player chooses the first position in the second row
    And the second player chooses the second position in the second row
    And the first player chooses the third position in the second row
    And the second player chooses the fourth position in the second row
    And the first player chooses the first position in the third row
    And the second player chooses the second position in the third row
    And the first player chooses the third position in the third row
    And the second player chooses the fourth position in the third row
    And the first player chooses the second position in the last row
    And the second player chooses the first position in the last row
    And the first player chooses the last position in the last row
    And the second player chooses the third position in the last row
    Then the game is a draw.
