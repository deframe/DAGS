unit Unit3;  // Main Menu & Instructions

interface

uses
  Unit1, Unit2, Unit4, Unit5, Unit6, Unit7;

// Specify procedures & functions implemented in unit

procedure display_instructions;
procedure quit;
procedure main_menu;

implementation

// Display instructions procedure : Displays available game commands.

procedure display_instructions;
begin
  writeln;
  writeln('Instructions : ');
  writeln;
  writeln('Available Game commands : ');
  writeln;
  writeln(' - NORTH or N : Move North (If available)');
  writeln(' - SOUTH or S : Move South (If available)');
  writeln(' - EAST or E : Move East (If available)');
  writeln(' - WEST or W : Move West (If available)');
  writeln(' - EXAMINE or EX <item> : Examine an item in your inventory');
  writeln(' - GET or TAKE <item> : Pick up an item');
  writeln(' - DROP <item> : Drop an item from your inventory');
  writeln(' - INVENTORY or INV : Display your inventory');
  writeln(' - USE <item> : Use an item from your inventory');
  writeln(' - QUIT or Q or EXIT or END : Exit the game');
end;

// Quit procedure : Displays a quit message.

procedure quit;
begin
  writeln;
  writeln('Thanks for trying DAGS. I hope you enjoyed yourself!');
end;

// Main menu procedure : Displays the main menu from which submenus and major
// features (eg. starting the game) can be reached. Note, the main menu loop
// executes THROUGHOUT the entire running of the program. When the loop is quit,
// the program ends.

procedure main_menu;
var
  option : integer;
begin
  repeat                                  // Start repeat..until loop
    writeln;
    writeln('- Daves''s Adventure Game System (DAGS) v1.0 -');
    writeln;
    writeln('  1. Locations Menu');
    writeln('  2. Items Menu');
    writeln('  3. Actions Menu');
    writeln('  4. Check Game');
    writeln;
    writeln('  5. Play Game');
    writeln('  6. Instructions');
    writeln('  7. Quit');
    writeln;
    write('Please select an option : ');
    readln(option);                       // Read option
    case option of                        // Start case statement
      1 : locations_menu;                 // option = 1.. call locations_menu
      2 : items_menu;                     // option = 2.. call items_menu
      3 : actions_menu;                   // option = 3.. call actions_menu
      4 : checkgame;                      // option = 4.. call checkgame
      5 : startgame;                      // option = 5.. call startgame
      6 : display_instructions;           // option = 6.. call display_instructions
      7 : quit;                           // option = 7.. call quit
    else                                  // If option is not specified above..
      begin
        writeln;
        writeln('Invalid Selection!');    // Display error message
      end;
    end;                                  // End case statement
  until option = 7;                       // Quit loop when option 7 selected
end;

end.
