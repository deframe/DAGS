unit Unit1;  // Location + Item declarations and types

interface

uses
  Sysutils;

// Data type Declarations

type
  action_record = record                     // Declare Action record type
    name : string[30];
    actiontype : integer;
    openlocation : integer;
    actiontext : string[255];
  end;
  location_record = record                   // Declare Location record type
    heading : string[30];
    description, altdescription : string[255];
    north_pointer, south_pointer, east_pointer, west_pointer : integer;
    actionitem : integer;
    locked : boolean;
  end;
  item_record = record                       // Declare Item record type
    name : string[20];
    shortdescription : string[30];
    longdescription : string[255];
    location : integer;
    useaction : integer;
    uselocation : integer;
  end;

// Constant Declarations

const
  max_locations = 50;                        // Set max number of locations
  max_items = 50;                            // Set max number of items
  max_actions = 50;                          // Set max number of actions

// Variable Declarations

var
  location : array[1..max_locations] of location_record;   // Define LOCATION as array of location_record
  item : array[1..max_items] of item_record;               // Define ITEM as array of item_record
  action : array[1..max_actions] of action_record;         // Define ACTION as array of action_record
  locationfile : file of location_record;                  // Define LOCATIONFILE as a file of location_record
  itemfile : file of item_record;                          // Define ITEMFILE as a file of item_record
  actionfile : file of action_record;                      // Define ACTIONFILE as a file of action_record

// Specify procedures & functions implemented in unit

procedure load_locations;
procedure save_locations;
procedure load_items;
procedure save_items;
procedure load_actions;
procedure save_actions;

implementation

// Load locations procedure : Loads records from location file into
// an array of similar type

procedure load_locations;
var
  count : integer;
begin
  if fileexists('locations.dat') then        // If locations.dat exists..
  begin
    assign(locationfile,'locations.dat');    // Assign LOCATIONFILE to locations.dat
    reset(locationfile);                     // Open LOCATIONFILE for reading
    for count := 1 to max_locations do       // Loop max_locations times
    begin
      if eof(locationfile) then break;       // Break loop if end-of-file
      read(locationfile,location[count]);    // Read record from file to array
    end;
    close(locationfile);                     // Close file
  end
  else                                       // Else (File doesn't exist)
  begin
    assign(locationfile,'locations.dat');    // Assign LOCATIONFILE to locations.dat
    rewrite(locationfile);                   // Open/Create file (for writing)
    close(locationfile);                     // Close file
  end;
end;

// Save locations procedure : Saves records in locations array to the
// locations file

procedure save_locations;
var
  count : integer;
begin
  assign(locationfile,'locations.dat');      // Assign LOCATIONFILE to locations.dat
  rewrite(locationfile);                     // Open LOCATIONFILE for writing
  for count := 1 to max_locations do         // Loop max_locations times
  begin
    // Write record (if it exists)
    if ( location[count].heading <> '' ) then write(locationfile,location[count]);
  end;
  close(locationfile);                       // Close file
end;

// Note : The following procedures are identical in structure to the previous
// two, hence there is no need to fully comment them.

// Load items procedure : Loads records from item file into
// an array of similar type

procedure load_items;
var
  count : integer;
begin
  if fileexists('items.dat') then            // If items.dat exists..
  begin
    assign(itemfile,'items.dat');            // Assign ITEMFILE to items.dat
    reset(itemfile);                         // Open ITEMFILE for reading
    for count := 1 to max_items do           // Loop max_items times
    begin
      if eof(itemfile) then break;           // Break loop if end-of-file
      read(itemfile,item[count]);            // Read record from file to array
    end;
    close(itemfile);                         // Close file
  end
  else                                       // Else (File doesn't exist)
  begin
    assign(itemfile,'items.dat');            // Assign ITEMFILE to items.dat
    rewrite(itemfile);                       // Open/Create file (for writing)
    close(itemfile);                         // Close file
  end;
end;

// Save items procedure : Saves records in items array to the
// items file

procedure save_items;
var
  count : integer;
begin
  assign(itemfile,'items.dat');              // Assign ITEMFILE to locations.dat
  rewrite(itemfile);                         // Open ITEMFILE for writing
  for count := 1 to max_items do             // Loop max_items times
  begin
    // Write record (if it exists)
    if ( item[count].shortdescription <> '' ) then write(itemfile,item[count]);
  end;
  close(itemfile);                           // Close file
end;

// Load actions procedure : Loads records from actions file into
// an array of similar type

procedure load_actions;
var
  count : integer;
begin
  if fileexists('actions.dat') then          // If actions.dat exists..
  begin
    assign(actionfile,'actions.dat');        // Assign ACTIONFILE to actions.dat
    reset(actionfile);                       // Open ACTIONFILE for reading
    for count := 1 to max_actions do         // Loop max_actions times
    begin
      if eof(actionfile) then break;         // Break loop if end-of-file
      read(actionfile,action[count]);        // Read record from file to array
    end;
    close(actionfile);                       // Close file
  end
  else                                       // Else (File doesn't exist)
  begin
    assign(actionfile,'actions.dat');        // Assign ACTIONFILE to actions.dat
    rewrite(actionfile);                     // Open/Create file (for writing)
    close(actionfile);                       // Close file
  end;
end;

// Save actions procedure : Saves records in actions array to the
// actions file

procedure save_actions;
var
  count : integer;
begin
  assign(actionfile,'actions.dat');          // Assign ACTIONFILE to actions.dat
  rewrite(actionfile);                       // Open ACTIONFILE for writing
  for count := 1 to max_actions do           // Loop max_actions times
  begin
    // Write record (if it exists)
    if ( action[count].name <> '' ) then write(actionfile,action[count]);
  end;
  close(actionfile);                         // Close file
end;


end.                                         // End unit

