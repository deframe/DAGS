unit Unit2;  // User commands in Game

interface

uses
  unit1, sysutils;

// Data type Declarations

type
  usercommand_object = object                // Declare usercommand as object
    // Declare keyword as an array of 5 strings within USERCOMMAND object
    keyword : array[1..5] of string[10];
    // usercommand object constructor (for initalising specified values)
    constructor init(in_keyword1, in_keyword2, in_keyword3, in_keyword4, in_keyword5 : string);
    function iscommand(instring : string) : boolean;  // Function to process usercommand values
  end;

// Variable Declarations

var

  // Declare all game commands as (previously declared) USERCOMMAND_OBJECT objects

  northcommand, southcommand, eastcommand, westcommand : usercommand_object;
  quitcommand, examinecommand, getcommand, dropcommand, inventorycommand : usercommand_object;
  usecommand : usercommand_object;

// Specify procedures & functions implemented in unit

procedure initialise_usercommands;
function command(instring : string) : string;
function parameter(instring : string) : string;
function item_index(in_item : string) : integer;

implementation

// Start of USERCOMMAND_OBJECT procedures & functions

// Usercommand constructor : Initalises the Usercommand keyword array with values
// passed with the construction of a Usercommand type

constructor usercommand_object.init(in_keyword1, in_keyword2, in_keyword3, in_keyword4,
 in_keyword5 : string);
begin
  keyword[1] := in_keyword1; keyword[2] := in_keyword2; keyword[3] := in_keyword3;
  keyword[4] := in_keyword4; keyword[5] := in_keyword5;
end;

// Usercommand iscommand function : Returns TRUE if the passed string is an actual
// command allowed in the game. Otherwise returns FALSE.

function usercommand_object.iscommand(instring : string) : boolean;
var
  count : integer;
begin
  // Return TRUE and EXIT PROCEDURE if command is allowed
  // Loop 5 times (1 iteration for each keyword) with IF condition met if current keyword = command word in input string
  for count := 1 to 5 do if ( keyword[count] = command(instring) ) then
  begin
    iscommand := TRUE;
    exit;
  end;
  // Return FALSE (will only be called if procedure is not exited, as above)
  iscommand := FALSE;
end;

// Initialise usercommands procedure : Sets the user commands allowed by the game.
// Shortened versions of command (eg. INV for Inventory) are also specified - up to
// five can be used for each command.

procedure initialise_usercommands;
begin
  northcommand.init('N','NORTH','','','');             // Set NORTH command
  southcommand.init('S','SOUTH','','','');             // Set SOUTH command
  eastcommand.init('E','EAST','','','');               // Set EAST command
  westcommand.init('W','WEST','','','');               // Set WEST command
  quitcommand.init('Q','QUIT','EXIT','END','');        // Set QUIT command
  examinecommand.init('EX','EXAMINE','','','');        // Set EXAMINE command
  getcommand.init('GET','TAKE','','','');              // Set GET command
  dropcommand.init('DROP','','','','');                // Set DROP command
  inventorycommand.init('INV','INVENTORY','','','');   // Set INVENTORY command
  usecommand.init('USE','','','','');                  // Set USE command
end;

// Command function : Returns the first word of a users input in the game -
// usually a command. (eg. 'INVENTORY', where INVENTORY is the command)

function command(instring : string) : string;
var
  count : integer;
  the_command : string;
begin
  for count := 1 to length(instring) do                 // Loop length(instring) times
  begin
    if ( instring[count] = ' ' ) then break             // Break loop if char. is a space
    else the_command := the_command + instring[count];  // Else add char. to the_command
  end;                                                  // End loop
  command := the_command;                               // Return the_command
end;

// Parameter function : Returns the second word of a users input in the game -
// usually a parameter for a command. (eg. 'USE KEY', where KEY is the paramter)

function parameter(instring : string) : string;
var
  count : integer;
  the_parameter : string;
  addcharacters : boolean;
begin
  for count := 1 to length(instring) do                 // Loop length(instring) times
  begin
    // Add character to the_parameter if addcharacters is TRUE
    if ( addcharacters = TRUE ) then the_parameter := the_parameter + instring[count];
    // Set addcharacters to TRUE if character is a space
    if ( instring[count] = ' ' ) then addcharacters := TRUE;
  end;
  parameter := the_parameter;                           // Return the_parameter
end;

// Item index function : Returns the location in the items array of a specified
// item by passing its NAME to the function. Returns 0 if the item does not exist.

function item_index(in_item : string) : integer;
var
  count : integer;
begin
  for count := 1 to max_items do                        // Loop max_items times
  begin
    // If items name matches passed string, return item array location & EXIT PROCEDURE
    // Both strings are uppercased to allow the user to input commands in any case
    if ( UpperCase(item[count].name) = UpperCase(in_item) ) then
    begin
      item_index := count;
      exit;
    end;
  end;
  // Return 0 (will only be called if procedure is not exited, as above)
  item_index := 0;
end;

end.
