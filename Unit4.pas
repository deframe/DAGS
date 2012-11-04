unit Unit4;  // Game Playing

interface

uses
  Unit1, Unit2, Sysutils;

// Variable Declarations

var
  currentlocation : integer;  // Global to unit4 - holds players current location in game as an integer pointing to the relevant position in the location array

// Specify procedures & functions implemented in unit

procedure processinput(input : string);
procedure showlocation;
procedure game_prompt;
procedure startgame;
procedure checkgame;

implementation

// Processinput procedure : The core procedure behind the game aspect of the system.
// Calls several other procedures to check validity and process a users input.
// (passed into the procedure by a string) The users command is determined, and
// appropriate code used for that command to achieve the desired effect.

procedure processinput(input : string);
var
  count, input_item_index : integer;
begin

// Directional commands
// Operates if movement in desired direction is valid and desired location is not LOCKED.
// Operates by changing currentlocation integer to that of the new location.

// General format for following Directional conditions:
// If Input = Directional Command then
// If Desired location exists AND desired location is not LOCKED then
// Set current location to desired location (ie. all conditions met)
// Othewise display error message.

  if northcommand.iscommand(input) then if ( location[currentlocation].north_pointer > 0 )
    and ( location[location[currentlocation].north_pointer].locked = FALSE )
      then currentlocation := location[currentlocation].north_pointer
  else begin writeln; writeln('You cannot move in that direction!'); end

  else
    if southcommand.iscommand(input) then if ( location[currentlocation].south_pointer > 0 )
      and ( location[location[currentlocation].south_pointer].locked = FALSE )
        then currentlocation := location[currentlocation].south_pointer
    else begin writeln; writeln('You cannot move in that direction!'); end

  else
    if eastcommand.iscommand(input) then if ( location[currentlocation].east_pointer > 0 )
      and ( location[location[currentlocation].east_pointer].locked = FALSE )
        then currentlocation := location[currentlocation].east_pointer
    else begin writeln; writeln('You cannot move in that direction!'); end

  else
    if westcommand.iscommand(input) then if ( location[currentlocation].west_pointer > 0 )
      and ( location[location[currentlocation].west_pointer].locked = FALSE )
        then currentlocation := location[currentlocation].west_pointer
    else begin writeln; writeln('You cannot move in that direction!'); end

// Examine command (item paramter required)
// Operates if item exits & the user has the item (ie. items location is 0)
// Operates by displaying the longdescription field of the specified item.

  else
    if examinecommand.iscommand(input) then
    begin
      input_item_index := item_index(parameter(input));  // Set input_item_index to location in item array of item parameter given in user input
      // Check if item exists & its location = 0 (users inventory)
      if ( input_item_index > 0 ) and ( item[input_item_index].location = 0 ) then
      begin
        writeln;
        writeln(item[input_item_index].longdescription);  // Display detailed description of item
      end
      // Otherwise display error message
      else begin writeln; writeln('You do not have that item!'); end;
    end

// Get command (item parameter required)
// Operates if item exists and items location field = users currentlocation.
// (eg. Item is at users current game location)
// Operates by displaying a message and setting the items location to 0 (users
// inventory)

  else
    if getcommand.iscommand(input) then  // Check that user input includes a GET command
    begin
      input_item_index := item_index(parameter(input));  // Set input_item_index to location in item array of item parameter given in user input
      // Check if item exists & its location is the same as the users
      if ( input_item_index > 0 ) and ( item[input_item_index].location = currentlocation )
      then
      begin
        writeln;
        writeln('You pick up the item!');  // Display confirmation that command is successful
        item[input_item_index].location := 0;  // Set items location to 0 (users inventory)
      end
      else begin writeln; writeln('That item is not here!'); end;  // Otherwise display error msg.
    end

// Drop command (item parameter required)
// Operates if item exists and user has item. (items location is 0)
// Operates by displaying message and setting items location to users currentlocation.

  else
    if dropcommand.iscommand(input) then  // Check that user input includes a DROP command
    begin
      input_item_index := item_index(parameter(input));  // Set input_item_index to location in item array of item parameter given in user input
      // Check that item exists & its location is 0 (users inventory)
      if ( input_item_index > 0 ) and ( item[input_item_index].location = 0 ) then
      begin
        writeln;
        writeln('You drop the item!');  // Display confirmation that command is successful
        item[input_item_index].location := currentlocation;  // Set items location to users
      end
      else begin writeln; writeln('You do not have that item!'); end;  // Otherwise display error msg.
    end

// Use command (item parameter required)
// Operates if item exists, user has item and (items location is 0) item has a
// linked action.
// Operates by selecting the appropriate action type (eg. Open Location) from
// an action record field and after checking other values (eg. items uselocation
// the same as currentlocation) will execute appropriate code.

// For Open Location action types, the actions actiontext field is displayed,
// the target location becomes unlocked and the target locations description
// is set to its ALTERNATIVE description.

  else
    if usecommand.iscommand(input) then  // Check that user input contains USE command
    begin
      input_item_index := item_index(parameter(input));  // Set input_item_index to location in item array of item parameter given in user input
      // Check that item exists & items location is 0 (users inventory)
      if ( input_item_index > 0 ) and ( item[input_item_index].location = 0 ) then
      begin
        // Check that item can be used at users current location
        if ( item[input_item_index].uselocation = currentlocation )
          // AND has a valid uselocation property (greater than 0)
          and ( item[input_item_index].uselocation > 0 )
            // AND has an action assigned to it
            and ( item[input_item_index].useaction > 0 ) then
        begin
          // If items action has an actiontype of 1.. (Open location)
          if ( action[item[input_item_index].useaction].actiontype = 1 ) then
          begin
            writeln;
            writeln(action[item[input_item_index].useaction].actiontext);  // Display action message
            // Unlock the desired locations
            location[action[item[input_item_index].useaction].openlocation].locked := FALSE;
            // If location has an alternative description..
            if ( location[currentlocation].altdescription <> '' ) then
            // Set locations actual description to the alternative description
            location[currentlocation].description :=
              location[currentlocation].altdescription;
          end;

          // Possible expansion into other Action types.

        end
        else  // If second conditions are not met..
        begin
          writeln;
          writeln('You cannot use this item here!');  // Display error message
        end;
      end
      // If first conditions are not met, display error message
      else begin writeln; writeln('You do not have that item!'); end;
    end

// Inventory command
// Operates at any time.
// Operates by looping through each item in memory and displaying it if its location
// is equal 0. (users inventory)

  else
    if inventorycommand.iscommand(input) then  // Check that user input contains INVENTORY command
    begin
      writeln;
      writeln('You are carrying : ');
      // Loop max_items times & check if current item has a name (ie. exists) AND items location = 0 (users inventory)
      for count := 1 to max_items do if ( item[count].name <> '' )
        and ( item[count].location = 0 )
      then writeln('    - ' + item[count].shortdescription);  // Displays items short description
    end

// Quit command
// Operates at any time.
// Operates by displaying a quit message.

  else
    if quitcommand.iscommand(input) then  // Check that user input contains QUIT command
    begin
      writeln;
      writeln('Exiting game...');  // Display 'exit game' message
      exit;                        // Exit procedure
    end

// Unknown command
// Operates when a command different to the commands above is entered.
// Operates by displaying an error message.

  else
    begin writeln; writeln('I do not understand that command!'); end;

end;

// Showlocation procedure : Displays the description field of the users current
// location. Will also display any objects should their location be the same as
// the users.

procedure showlocation;
var
  count : integer;
  itemavailable : boolean;
begin
  writeln;
  // Display heading of users current location
  writeln('[' + location[currentlocation].heading + '] - [Score : 0]');
  // Display description of users current location
  writeln(location[currentlocation].description);
  writeln;
  writeln('You can see : ');
  itemavailable := FALSE;  // No items current available
  for count := 1 to max_items do  // Loop max_items times
  begin
    if ( item[count].location = currentlocation ) then  // If items location = users location..
    begin
      itemavailable := TRUE;  // Item(s) now available
      writeln('    - ' + item[count].shortdescription);  // Display items short description
    end;
  end;  // End loop
  if ( itemavailable = FALSE ) then writeln('    - Nothing');  // If no items available, display message
end;

// Game prompt procedure : Main loop which controls the game aspect of the system.
// Calls showlocation procedure then waits for user input before sending it to the
// processinput procedure. (After being changed to uppercase)
// Loop exits when the EXIT command is entered by the user.

procedure game_prompt;
var
  input : string;
begin
  repeat                                // Start repeat..until loop
    showlocation;                       // Call showlocation procedure
    writeln;
    write('> ');
    readln(input);                      // Read user input into INPUT variable
    input := uppercase(input);          // Uppercase contents of INPUT
    processinput(input);                // Send INPUT to processoutput procedure
  until quitcommand.iscommand(input);   // End loop is user input contains QUIT command
end;

// Startgame procedure : Loads all locations, items and actions into memory.
// Checks if a gaming environment exists (ie. 1 or more locations) then displays
// a message, sets users currentlocation to 1 and calls gameprompt procedure.

procedure startgame;
begin
  load_locations;                       // Call load_locations procedure
  load_items;                           // Call load_items procedure
  load_actions;                         // Call load_actions procedure
  writeln;
  if ( location[1].heading = '' ) then  // If first locations heading is empty.. (ie. item doesn't exist)
  begin
    writeln('You have not defined an environment yet / properly!');  // Display error message
    exit;    // Exit procedure
  end
  else                                  // Otherwise..
  begin
    writeln('Welcome to the game...');  // Display welcome message
    currentlocation := 1;               // Set users current location to 1
    game_prompt;                        // Call game_prompt procedure
  end;
end;

// Checkgame procedure : Not related to game playing, this procedure loops through
// all locations, items and actions to find any 'leaks' in the gaming environment.
// Examples would be an item with its location set to a non-existant one, or a
// location directing to a non-existant one. The procedure displays error messages for
// any such case.

procedure checkgame;
var
  count : integer;
  error : boolean;
begin
  writeln;
  for count := 1 to max_locations do  // Loop max_locations times
  begin
    if ( length(location[count].heading) > 0 ) then  // If location exists..
    begin
      // If NORTH doesn't point to 0 & linked North location DOESN'T exist..
      if not ( length(location[location[count].north_pointer].heading) > 0 )
      and ( location[count].north_pointer <> 0 ) then
      begin
        // Display warning message including relevant data
        writeln('Link to undefined location (', IntToStr(location[count].north_pointer)
        ,') heading NORTH from location ', IntToStr(count), ' : ', location[count].heading);
        error := TRUE;  // Set error to TRUE
      end;
      // If SOUTH doesn't point to 0 & linked South location DOESN'T exist..
      if not ( length(location[location[count].south_pointer].heading) > 0 )
      and ( location[count].south_pointer <> 0 ) then
      begin
        // Display warning message including relevant data
        writeln('Link to undefined location (', IntToStr(location[count].south_pointer)
        ,') heading SOUTH from location ', IntToStr(count), ' : ', location[count].heading);
        error := TRUE;  // Set error to TRUE
      end;
      // If EAST doesn't point to 0 & linked East location DOESN'T exist..
      if not ( length(location[location[count].east_pointer].heading) > 0 )
      and ( location[count].east_pointer <> 0 ) then
      begin
        // Display warning message including relevant data
        writeln('Link to undefined location (', IntToStr(location[count].east_pointer)
        ,') heading EAST from location ', IntToStr(count), ' : ', location[count].heading);
        error := TRUE;  // Set error to TRUE
      end;
      // If WEST doesn't point to 0 & linked West location DOESN'T exist..
      if not ( length(location[location[count].west_pointer].heading) > 0 )
      and ( location[count].west_pointer <> 0 ) then
      begin
        // Display warning message including relevant data
        writeln('Link to undefined location (', IntToStr(location[count].west_pointer)
        ,') heading WEST from location ', IntToStr(count), ' : ', location[count].heading);
        error := TRUE;  // Set error to TRUE
      end;
    end;
  end;  // End loop
  for count := 1 to max_items do  // Loop max_items times
  begin
    if ( length(item[count].shortdescription) > 0 ) then  // If item exists..
    begin
      // If items location is NOT 0 & items location does NOT exist..
      if not ( length(location[item[count].location].heading) > 0 )
      and ( item[count].location <> 0 ) then
      begin
        // Display warning message including relevant data
        writeln('Link to undefined location (', IntToStr(item[count].location)
        ,') from item ', IntToStr(count), ' : ', item[count].shortdescription);
        error := TRUE;  // Set error to TRUE
      end;
    end;
  end;  // End loop
  if ( error = FALSE ) then writeln('No errors found!');  // Display message if error = TRUE
end;

end.

