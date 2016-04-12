require 'spec_helper'
require 'stringio'
require 'ui'
require 'game_options'
require 'board'
require 'board_factory'
require 'marks'

describe Ui do
  let(:input) {StringIO.new}
  let(:output) {StringIO.new}
  let (:ui) {Ui.new(input, output)}

  CLEAR_SCREEN = "\e[H\e[2J"

  it "draws a 3x3 board to the console" do
    board = Board.new(3, [Marks::X, 1, Marks::X, Marks::O, 4, Marks::O, Marks::O, 7, Marks::X])
    ui = Ui.new(StringIO.new, output)
    ui.draw_board(board)
    expect(output.string).to eq("#{CLEAR_SCREEN}\n---------------\n  X |  2 |  X\n---------------\n  O |  5 |  O\n---------------\n  O |  8 |  X\n---------------\n")
  end

  it "shows the board size options menu" do
    ui = Ui.new(StringIO.new("1"), output)
    ui.board_size_menu(BoardFactory::BOARD_SIZES)
    expect(output.string).to eq("Please choose a board size:\n\n1 - 3x3\n2 - 4x4\n--> \n")
  end

  it "shows the game options menu" do
    ui = Ui.new(StringIO.new("1"), output)
    ui.menu(GameOptions::GAME_OPTIONS)
    expect(output.string).to eq("#{CLEAR_SCREEN}::: WELCOME TO TIC TAC TOE :::\n\nPlease indicate your desired game mode:\n\n1 - Human vs Human\n2 - Human vs Computer\n3 - Computer vs Human\n4 - Computer vs Computer\n5 - Human vs Random Player\n--> \n")
  end

  it "gets the game mode" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.menu(GameOptions::GAME_OPTIONS)).to eq(:HumanVsComputer)
  end

  it "gets the board size from the user" do
    ui = Ui.new(StringIO.new("2"), output)
    expect(ui.board_size_menu(BoardFactory::BOARD_SIZES)).to eq 4
  end

  it "displays error message and board size options on bad user input for board size" do
    BOARD_SIZE_ERROR = "Please select a valid board size!"
    VALID_OPTION = "1"
    allow(ui.input).to receive(:gets).and_return("bad", VALID_OPTION)
    ui.board_size_menu(BoardFactory::BOARD_SIZES)
    expect(output.string).to include(BOARD_SIZE_ERROR)
  end

  it "displays error message and menu options on bad user input for game options" do
    GAME_OPTIONS_ERROR = "Please select a valid game mode!"
    VALID_GAME_OPTION = "3"
    allow(ui.input).to receive(:gets).and_return("bad", VALID_GAME_OPTION)
    ui.get_game_mode(GameOptions::GAME_OPTIONS)
    expect(output.string).to include(GAME_OPTIONS_ERROR)
  end

  it "asks user for a position" do
    output = StringIO.new
    ui = Ui.new(StringIO.new("2"), output)
    ui.request_position(Board.new)
    expect(output.string).to eq("\nPlease enter a position:\n")
  end

  it "returns user's position" do
    ui = Ui.new(StringIO.new("2"), StringIO.new)
    expect(ui.request_position(Board.new)).to eq(1)
  end

  it "asks user for a position again if first input was invalid" do
    board = Board.new
    new_board = board.add_mark(1, Marks::X)
    ui = Ui.new(input, output)
    allow(ui.input).to receive(:gets).and_return("2", "3")
    ui.request_position(new_board)
    expect(output.string).to include("\nPlease enter a position:", "\nPlease enter a position:")
  end

  it "announces that the winner is X" do
    x_winner_board = Board.new(3, [Marks::X, Marks::X, Marks::X,
                                3, 4, Marks::O,
                                Marks::O, 7, 8])
    ui.announce_winner(x_winner_board)
    expect(output.string).to eq("\nGame over! Winner is X.\n")
  end

  it "announces a draw" do
    drawn_board = Board.new(3, [Marks::X, Marks::O, Marks::X,
                                Marks::X, Marks::O, Marks::O,
                                Marks::O, Marks::X, Marks::X])
    ui.announce_winner(drawn_board)
    expect(output.string).to eq("\nGame over! It's a draw.\n")
  end

  it "asks if user wants to play again" do
    allow(ui.input).to receive(:gets).and_return("n")
    ui.replay?
    expect(output.string).to eq("\nDo you want to play again?\n\n- Enter y for yes\n- Enter n for no\n")
  end

  it "knows that the user does not want to play again" do
    ui = Ui.new(StringIO.new("n"), output)
    expect(ui.replay?).to be false
  end

  it "knows that the user wants to play again" do
    ui = Ui.new(StringIO.new("y"), output)
    expect(ui.replay?).to be true
  end

  it "asks again for replay choice if unexpected input" do
    allow(ui.input).to receive(:gets).and_return("hello", "n")
    expect(output).to receive(:puts).with("\nDo you want to play again?\n\n- Enter y for yes\n- Enter n for no").twice
    ui.replay?
  end

  it "says goodbye to the user" do
    ui.say_goodbye
    expect(output.string).to eq(CLEAR_SCREEN + "Byyyee!\n\n")
  end

  it "notifies user of interruption" do
    ui.interruption_message
    expect(output.string).to eq(CLEAR_SCREEN + "You interrupted the application. Bye!\n\n")
  end
end
