unit Unit5;  // Location Procedures & Functions

interface

uses
  Unit1, Sysutils;

// Specify procedures & functions implemented in unit

procedure list_locations;
procedure view_locations;
procedure add_location;
procedure edit_location;
procedure clear_locations;
procedure locations_menu;

implementation

// List locations procedure : Displays headings of all defined locations in the gaming
// environment.

procedure list_locations;
var
  count : integer;
begin
  writeln('Locations in game : ');
  writeln;
  for count := 1 to max_locations do  // Loop max_locations times
  begin
    if ( location[count].heading <> '' ) then  // If location exists..
      // Display locations heading
      writeln('  [' + IntToStr(count) + '] ' + location[count].heading);
  end;
end;

// View locations procedure : Lists all locations & allows user to view all details/fields
// for each record.

procedure view_locations;
var
  option, input_location_number : integer;
begin
  writeln;
  load_locations;  // Call load_locations procedure
  list_locations;  // Call list_locations procedure
  repeat           // Start repeat..until loop
    writeln;
    write('Do you wish to view more details? [1=Yes, 2=No, 3=List] : ');
    readln(option);  // Read user input into OPTION variable
    if ( option = 1 ) then  // If OPTION variable = 1..
    begin
      writeln;
      write('Enter the location number you wish to view in detail : ');
      readln(input_location_number);  // Read user input into INPUT_LOCATION_NUMBER variable
      // If given location number is invalid or does not exist...
      if ( input_location_number < 1 ) or ( input_location_number > max_locations )
      or ( location[input_location_number].heading = '' ) then
      begin
        writeln;
        writeln('That Location does not exist / is invalid!');  // Display error message
        continue;  // Jump to start of repeat..until loop
      end
      else  // Otherwise.. (location IS valid)
      begin
        // Display all fields of specified location record
        writeln;
        writeln('-- Details for Location ' + IntToStr(input_location_number) + ' ----------');
        writeln;
        writeln('[Heading] ' + location[input_location_number].heading);
        writeln;
        writeln('[Description]');
        writeln(location[input_location_number].description);
        writeln;
        writeln('[Alternative Description]');
        writeln(location[input_location_number].altdescription);
        writeln;

        // If location has a linked location to the North..
        if ( location[input_location_number].north_pointer > 0 ) then
          // If this North location does not exist..
          if ( location[location[input_location_number].north_pointer].heading = '' )
            then
              // Display relevant data (including UNDEFINED)
              writeln('[North] <Undefined> (Location ' +
              IntToStr(location[input_location_number].north_pointer) + ')')
            else  // Otherwise..
              // Display relevant data
              writeln('[North] ' + location[location[input_location_number].north_pointer].
              heading + ' (Location ' + IntToStr(location[input_location_number].
              north_pointer) + ')')
        else writeln('[North] No Location');  // Otherwise Display 'No Location'

        // If location has a linked location to the South..
        if ( location[input_location_number].south_pointer > 0 ) then
          // If this South location does not exist..
          if ( location[location[input_location_number].south_pointer].heading = '' )
          then
            // Display relevant data (including UNDEFINED)
            writeln('[South] <Undefined> (Location ' +
            IntToStr(location[input_location_number].south_pointer) + ')')
          else  // Otherwise..
            // Display relevant data
            writeln('[South] ' + location[location[input_location_number].south_pointer].
            heading + ' (Location ' + IntToStr(location[input_location_number].
            south_pointer) + ')')
        else writeln('[South] No Location');  // Otherwise Display 'No Location'

        // If location has a linked location to the East..
        if ( location[input_location_number].east_pointer > 0 ) then
          // If this East location does not exist..
          if ( location[location[input_location_number].east_pointer].heading = '' )
          then
            // Display relevant data (including UNDEFINED)
            writeln('[East ] <Undefined> (Location ' +
            IntToStr(location[input_location_number].east_pointer) + ')')
          else  // Otherwise..
            // Display relevant data
            writeln('[East ] ' + location[location[input_location_number].east_pointer].
            heading + ' (Location ' + IntToStr(location[input_location_number].
            east_pointer) + ')')
        else writeln('[East ] No Location');  // Otherwise Display 'No Location'

        // If location has a linked location to the West..
        if ( location[input_location_number].west_pointer > 0 ) then
          // If this West location does not exist..
          if ( location[location[input_location_number].west_pointer].heading = '' )
          then
            // Display relevant data (including UNDEFINED)
            writeln('[West ] <Undefined> (Location ' +
            IntToStr(location[input_location_number].west_pointer) + ')')
          else  // Otherwise..
            // Display relevant data
            writeln('[West ] ' + location[location[input_location_number].west_pointer].
            heading + ' (Location ' + IntToStr(location[input_location_number].
            west_pointer) + ')')
        else writeln('[West ] No Location');  // Otherwise Display 'No Location'

        writeln;
        write('[Locked?] ');
        if ( location[input_location_number].locked = TRUE ) then writeln('Yes')
        else writeln('No');
      end;
    end
    else if ( option = 2 ) then break  // Exit repeat..until loop if option 2 selected
    else if ( option = 3 ) then        // Option 3 selected..
    begin
      writeln;
      list_locations;  // Call list_locations procedure
    end
    else  // Otherwise.. (Choice not equal to 1,2 or 3)
    begin
      writeln;
      writeln('Invalid Selection!');  // Display error message
      continue;  // Jump to top of repeat..until loop
    end;
  until option = 2;  // End loop if option 2 selected
  locations_menu;    // Call locations_menu
end;

// Add location procedure : Adds a new location record & asks for user to input all
// required details.

procedure add_location;
var
  count, option : integer;
  temp_heading : string[30];
  temp_description, temp_altdescription : string[255];
  temp_north_pointer, temp_south_pointer, temp_east_pointer, temp_west_pointer : integer;
  temp_locked : integer;
begin
  for count := 1 to max_locations do  // Loop max_locations times
  begin
    if ( location[count].heading = '' ) then break;  // If location does not exist, exit loop
  end;

  // Display each field of record & read user input into each

  writeln;
  writeln('Please enter the following details for Location ' + IntToStr(count));
  writeln;
  write('[Heading] ');
  readln(temp_heading);
  writeln;
  writeln('[Description]');
  readln(temp_description);
  writeln;
  writeln('[Alternative Description (Leave blank if not needed)]');
  readln(temp_altdescription);
  writeln;
  writeln('For the following enter the locations this current location will connect to ' +
  'in their relevant directions. Use 0 (zero) if there is no is no location to direct to.');
  writeln;
  write('[North] ');
  readln(temp_north_pointer);
  write('[South] ');
  readln(temp_south_pointer);
  write('[East ] ');
  readln(temp_east_pointer);
  write('[West ] ');
  readln(temp_west_pointer);
  repeat  // Start repeat..until loop
    writeln;
    write('[Locked? (1=Yes, 2=No)] ');
    readln(temp_locked);
  until (temp_locked = 1) or (temp_locked = 2);  // End loop if temp_locked = 1 or 2
  writeln;
  repeat  // Start repeat..until loop
    write('Save this record? [1=Yes, 2=No] ');
    readln(option);  // Read user input into OPTION
    if ( option = 1 ) then  // if OPTION = 1.. (Save)
    begin
      // Initialise new record with inputed data
      location[count].heading := temp_heading;
      location[count].description := temp_description;
      location[count].altdescription := temp_altdescription;
      location[count].north_pointer := temp_north_pointer;
      location[count].south_pointer := temp_south_pointer;
      location[count].east_pointer := temp_east_pointer;
      location[count].west_pointer := temp_west_pointer;
      if ( temp_locked = 1 ) then location[count].locked := TRUE
      else location[count].locked := FALSE;
      save_locations;  // Call save_locations procedure
      writeln;
      writeln('Locations Updated!');  // Display successful message
    end
    else if ( option = 2 ) then  // if OPTION = 2.. (Don't save)
    begin
      writeln;
      writeln('Locations NOT Updated!');  // Display confirmation message
    end
    else  // Otherwise.. (OPTION not = 1 or 2)
    begin
      writeln;
      writeln('Invalid Selection!');  // Display error message
    end;
  until ( option = 1 ) or ( option = 2 );  // Repeat until OPTION = 1 or 2
  locations_menu;  // Call locations_menu
end;

// Edit location procedure : Allows the user to edit the details/fields in any location
// record currently held in memory.

procedure edit_location;
var
  option, saveoption, change : integer;
  optionvalid : boolean;
  temp_heading : string[30];
  temp_description, temp_altdescription : string[255];
  temp_north_pointer, temp_south_pointer, temp_east_pointer, temp_west_pointer : integer;
  temp_locked : integer;
begin
  repeat  // Start repeat_until loop
    writeln;
    write('Enter the location number you wish to edit [0=List] ');
    readln(option);  // Read user input into OPTION
    if ( option = 0 ) then  // If OPTION = 0..
    begin
      writeln;
      list_locations;  // Call list_locations procedure
    end
    // Otherwise.. if option is invalid..
    else if ( option < 0 ) or ( option > max_locations ) or ( location[option].heading = '' )
    then
    begin
      writeln;
      writeln('That Location does not exist / is invalid!');  // Display error message
    end
    else  // Otherwise.. (input is valid)
    begin
      optionvalid := TRUE;  // Set OPTIONVALID to TRUE
      writeln;

      // Display each field of selected record & its current data.
      // Option is given to change the data or not.

      writeln('[Heading] ' + location[option].heading);  // Display locations heading
      writeln;
      write('Change? [1=Yes, 2=No] ');  // Prompt for change
      readln(change);                   // Read user input into CHANGE
      repeat                            // Start repeat..until loop
        if ( change = 1 ) then          // If CHANGE = 1..
        begin
          writeln;
          write('[Heading] ');
          readln(temp_heading);         // Read user input into temporary heading
        end
        // Otherwise set temporary heading to current heading (no change)
        else if ( change = 2 ) then temp_heading := location[option].heading
        else  // Otherwise (CHANGE isn't 1 or 2)
        begin
          writeln;
          writeln('Invalid Selection!');  // Display error message
        end;
      until ( change = 1 ) or ( change = 2 );  // Exit loop if CHANGE = 1 or 2

      // The rest of this procedure follows the same format seen above, allowing user
      // to enter a new value for each field if he/she desires.

      writeln;
      writeln('[Description]');
      writeln(location[option].description);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          writeln('[Description]');
          readln(temp_description);
        end
        else if ( change = 2 ) then temp_description := location[option].description
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Alternative Description]');
      writeln(location[option].altdescription);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          writeln('[Alternative Description]');
          readln(temp_altdescription);
        end
        else if ( change = 2 ) then temp_altdescription := location[option].altdescription
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      if ( location[option].north_pointer = 0 ) then writeln('[North] 0 (No location)')
      else if ( location[location[option].north_pointer].heading = '' ) then
        writeln('[North] ' + IntToStr(location[option].north_pointer) + ' (Undefined)')
        else
          writeln('[North] ' + IntToStr(location[option].north_pointer) + ' (' +
          location[location[option].north_pointer].heading + ')');
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[North] ');
          readln(temp_north_pointer);
        end
        else if ( change = 2 ) then temp_north_pointer := location[option].north_pointer
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      if ( location[option].south_pointer = 0 ) then writeln('[South] 0 (No location)')
      else if ( location[location[option].south_pointer].heading = '' ) then
      writeln('[South] ' + IntToStr(location[option].south_pointer) + ' (Undefined)')
      else
        writeln('[South] ' + IntToStr(location[option].south_pointer) + ' (' +
        location[location[option].south_pointer].heading + ')');
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[South] ');
          readln(temp_south_pointer);
        end
        else if ( change = 2 ) then temp_south_pointer := location[option].south_pointer
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      if ( location[option].east_pointer = 0 ) then writeln('[East ] 0 (No location)')
      else if ( location[location[option].east_pointer].heading = '' ) then
        writeln('[East ] ' + IntToStr(location[option].east_pointer) + ' (Undefined)')
        else
          writeln('[East] ' + IntToStr(location[option].east_pointer) + ' (' +
          location[location[option].east_pointer].heading + ')');
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[East ] ');
          readln(temp_east_pointer);
        end
        else if ( change = 2 ) then temp_east_pointer := location[option].east_pointer
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      if ( location[option].west_pointer = 0 ) then writeln('[West] 0 (No location)')
      else if ( location[location[option].west_pointer].heading = '' ) then
        writeln('[West] ' + IntToStr(location[option].west_pointer) + ' (Undefined)')
        else
          writeln('[West] ' + IntToStr(location[option].west_pointer) + ' (' +
          location[location[option].west_pointer].heading + ')');
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[West ] ');
          readln(temp_west_pointer);
        end
        else if ( change = 2 ) then temp_west_pointer := location[option].west_pointer
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );

      writeln;
      write('[Locked?] ');
      if ( location[option].locked = TRUE ) then writeln('Yes')
      else writeln('No');
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Locked?] ');
          readln(temp_locked);
        end
        else if ( change = 2 ) then if ( location[option].locked = TRUE ) then
          temp_locked := 1 else temp_locked := 0
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );

    end;
  until optionvalid;  // End loop if OPTIONVALID = TRUE
  repeat              // Start repeat..until loop
    writeln;
    write('Save this record? [1=Yes, 2=No] ');
    readln(saveoption);  // Read user input into SAVEOPTION
    if ( saveoption = 1 ) then  // If SAVEOPTION = 1..
    begin
      // Initialise record with user inputed values.
      location[option].heading := temp_heading;
      location[option].description := temp_description;
      location[option].altdescription := temp_altdescription;
      location[option].north_pointer := temp_north_pointer;
      location[option].south_pointer := temp_south_pointer;
      location[option].east_pointer := temp_east_pointer;
      location[option].west_pointer := temp_west_pointer;
      if ( temp_locked = 1 ) then location[option].locked := TRUE
      else location[option].locked := FALSE;
      save_locations;  // Call save_locations procedure
      writeln;
      writeln('Locations Updated!');  // Display successful message
    end
    else if ( saveoption = 2 ) then  // SAVEOPTION = 2..
    begin
      writeln;
      writeln('Locations NOT Updated!');  // Display confirmation
    end
    else  // Otherwise.. (SAVEOPTION isn't = 1 or 2)
    begin
      writeln;
      writeln('Invalid Selection!');  // Display error message
    end;
  until ( saveoption = 1 ) or ( saveoption = 2 );  // End loop if SAVEOPTION = 1 or 2
  locations_menu;  // Call locations_menu
end;

// Clear locations procedure : Clears all location records in memory & on file.

procedure clear_locations;
var
  count : integer;
  confirmation : string[1];
begin
  writeln;
  write('Are you sure? [Y/N] : ');
  readln(confirmation);  // Read user input into CONFIRMATION
  if ( UpperCase(confirmation) = 'Y' ) then  // If Uppercased CONFIRMATION = Y..
  begin
    for count := 1 to max_locations do  // Loop max_locations times
    begin
      // Clear all fields of current location record
      location[count].heading := '';
      location[count].description := '';
      location[count].altdescription := '';
      location[count].north_pointer := 0;
      location[count].south_pointer := 0;
      location[count].east_pointer := 0;
      location[count].west_pointer := 0;
      location[count].locked := FALSE;
    end;  // End loop
    writeln;
    writeln('All Locations cleared!');  // Display success message
    save_locations;  // Call save_locations procedure
  end
  else if ( UpperCase(confirmation) = 'N' ) then  // If Uppercased CONFIRMATION = N..
  begin
    writeln;
    writeln('Locations NOT cleared!');  // Display confirmation
  end
  else  // Otherwise.. (CONFIRMATION isn't = Y or N)
  begin
    writeln;
    writeln('Invalid choice! Locations NOT cleared!');  // Display error message
  end;
end;

// Locations menu procedure : Displays the Locations sub-menu details & allows user
// to input selection.

procedure locations_menu;
var
  option : integer;
begin
  // Display Location sub-menu options
  writeln;
  writeln('- Locations Menu ----------------------------');
  writeln;
  writeln('  1. View Locations');
  writeln('  2. Add Location');
  writeln('  3. Edit Location');
  writeln('  4. Clear all Locations');
  writeln('  5. Main Menu');
  writeln;
  write('Please select an option : ');
  readln(option);  // Read user input into OPTION
  case option of   // Start sase..of statement
    1 : view_locations;   // Option = 1.. Call view_locations procedure
    2 : add_location;     // Option = 2.. Call add_locations procedure
    3 : edit_location;    // Option = 3.. Call edit_locations procedure
    4 : clear_locations;  // Option = 4.. Call clear_locations procedure
    5 : exit;             // Option = 5.. Exit procedure
  else                    // Otherwise..
    begin
      writeln;
      writeln('Invalid Selection!');  // Display error message
      locations_menu;                 // Call locations_menu procedure
    end;
  end;
end;

end.
