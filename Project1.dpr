program Project1;   // Main Program

uses
  Forms,

  // Units used in program

  Unit1 in 'Unit1.pas',
  Unit2 in 'Unit2.pas',
  Unit3 in 'Unit3.pas',
  Unit4 in 'Unit4.pas',
  Unit5 in 'Unit5.pas',
  Unit6 in 'Unit6.pas',
  Unit7 in 'Unit7.pas';

{$R *.RES}

begin                              // Start program
  load_locations;                  // Load locations from file
  load_items;                      // Load items from file
  load_actions;                    // Load actions from file
  initialise_usercommands;         // Set up game commands
  main_menu;                       // Display main menu
end.                               // End program

