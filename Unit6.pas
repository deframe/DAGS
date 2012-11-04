unit Unit6;  // Item Procedures & Functions

// Please NOTE : This procedure is VERY similar in structure to unit5.
// All procedures are almost identical so I see little need to comment them fully.

interface

uses
  Unit1, Sysutils;

// Specify procedures & functions implemented in unit

procedure list_items;
procedure view_items;
procedure add_item;
procedure edit_item;
procedure clear_items;
procedure items_menu;

implementation

// List items procedure : This procedure outputs a list of all the defined items in the
// current game environment.

procedure list_items;
var
  count : integer;
begin
  writeln('Items in game : ');
  writeln;
  for count := 1 to max_items do
  begin
    if ( item[count].name <> '' ) then
      writeln('  [' + IntToStr(count) + '] ' + item[count].name);
  end;
end;

// View items procedure : This procedure lists all defined items (by calling
// list_items) then allows the user to view more details on a specific item.
// The details include all/most of the fields of the item record - the name,
// descriptions, etc.

procedure view_items;
var
  option, input_item_number : integer;
begin
  writeln;
  load_items;
  list_items;
  repeat
    writeln;
    write('Do you wish to view more details? [1=Yes, 2=No, 3=List] : ');
    readln(option);
    if ( option = 1 ) then
    begin
      writeln;
      write('Enter the item number you wish to view in detail : ');
      readln(input_item_number);
      if ( input_item_number < 1 ) or ( input_item_number > max_items ) or
      ( item[input_item_number].name = '' ) then
      begin
        writeln;
        writeln('That Item does not exist / is invalid!');
        continue;
      end
      else
      begin
        writeln;
        writeln('-- Details for Item ' + IntToStr(input_item_number) + ' ----------');
        writeln;
        writeln('[Name] ' + item[input_item_number].name);
        writeln;
        writeln('[Short Description] ' + item[input_item_number].shortdescription);
        writeln;
        writeln('[Long Description]');
        writeln(item[input_item_number].longdescription);
        writeln;
        writeln('[Location] ' + IntToStr(item[input_item_number].location));
        writeln;
        writeln('[Use Action] ' + IntToStr(item[input_item_number].useaction));
        writeln;
        writeln('[Use Location] ' + IntToStr(item[input_item_number].uselocation));
      end;
    end
    else if ( option = 2 ) then break
    else if ( option = 3 ) then
    begin
      writeln;
      list_items;
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
      continue;
    end;
  until option = 2;
  items_menu;
end;

// Add item procedure : This controls the adding of a new item record. The user
// must input all relevant fields and is then given the choice of saving the new
// item.

procedure add_item;
var
  count, option : integer;
  temp_name, temp_shortdescription : string[30];
  temp_longdescription : string[255];
  temp_location, temp_useaction, temp_uselocation : integer;
begin
  for count := 1 to max_items do
  begin
    if ( item[count].name = '' ) then break;
  end;
  writeln;
  writeln('Please enter the following details for Item ' + IntToStr(count));
  writeln;
  write('[Name] ');
  readln(temp_name);
  writeln;
  write('[Short Description] ');
  readln(temp_shortdescription);
  writeln;
  writeln('[Long Description]');
  readln(temp_longdescription);
  writeln;
  write('[Location] ');
  readln(temp_location);
  writeln;
  write('[Use Action (0 = Unusable)] ');
  readln(temp_useaction);
  writeln;
  write('[Use Location (0 = Unusable)] ');
  readln(temp_uselocation);
  writeln;
  repeat
    write('Save this record? [1=Yes, 2=No] ');
    readln(option);
    if ( option = 1 ) then
    begin
      item[count].name := temp_name;
      item[count].shortdescription := temp_shortdescription;
      item[count].longdescription := temp_longdescription;
      item[count].location := temp_location;
      item[count].useaction := temp_useaction;
      item[count].uselocation := temp_uselocation;
      save_items;
      writeln;
      writeln('Items Updated!');
    end
    else if ( option = 2 ) then
    begin
      writeln;
      writeln('Items NOT Updated!');
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
    end;
  until ( option = 1 ) or ( option = 2 );
  items_menu;
end;

// Edit item procedure : This procedure allows the user to edit the details of an item
// already held in memory/on file. After changes are complete the user is once again
// asked if he/she would like to save the item or not.

procedure edit_item;
var
  option, saveoption, change : integer;
  optionvalid : boolean;
  temp_name, temp_shortdescription : string[30];
  temp_longdescription : string[255];
  temp_location, temp_useaction, temp_uselocation : integer;
begin
  repeat
    writeln;
    write('Enter the item number you wish to edit [0=List] ');
    readln(option);
    if ( option = 0 ) then
    begin
      writeln;
      list_items;
    end
    else if ( option < 0 ) or ( option > max_items ) or ( item[option].name = '' ) then
    begin
      writeln;
      writeln('That Item does not exist / is invalid!');
    end
    else
    begin
      optionvalid := TRUE;
      writeln;
      writeln('[Name] ' + item[option].name);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Name] ');
          readln(temp_name);
        end
        else if ( change = 2 ) then temp_name := item[option].name
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Short Description] ' + item[option].shortdescription);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Short Description] ');
          readln(temp_shortdescription);
        end
        else if ( change = 2 ) then temp_shortdescription := item[option].shortdescription
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Long Description]');
      writeln(item[option].longdescription);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          writeln('[Long Description]');
          readln(temp_longdescription);
        end
        else if ( change = 2 ) then temp_longdescription := item[option].longdescription
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Location] ' + IntToStr(item[option].location));
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Location] ');
          readln(temp_location);
        end
        else if ( change = 2 ) then temp_location := item[option].location
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Use Action] ' + IntToStr(item[option].useaction));
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Use Action (0 = Unusable)] ');
          readln(temp_useaction);
        end
        else if ( change = 2 ) then temp_useaction := item[option].useaction
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Use Location] ' + IntToStr(item[option].uselocation));
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          write('[Use Location] ');
          readln(temp_uselocation);
        end
        else if ( change = 2 ) then temp_uselocation := item[option].uselocation
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
    end;
  until optionvalid;
  repeat
    writeln;
    write('Save this record? [1=Yes, 2=No] ');
    readln(saveoption);
    if ( saveoption = 1 ) then
    begin
      item[option].name := temp_name;
      item[option].shortdescription := temp_shortdescription;
      item[option].longdescription := temp_longdescription;
      item[option].location := temp_location;
      item[option].useaction := temp_useaction;
      item[option].uselocation := temp_uselocation;
      save_items;
      writeln;
      writeln('Items Updated!');
    end
    else if ( saveoption = 2 ) then
    begin
      writeln;
      writeln('Items NOT Updated!');
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
    end;
  until ( saveoption = 1 ) or ( saveoption = 2 );
  items_menu;
end;

// Clear items procedure : This procedure clears all the item records from memory
// and the items file. It is a rather dangerous option, so confirmation is required.

procedure clear_items;
var
  count : integer;
  confirmation : string[1];
begin
  writeln;
  write('Are you sure? [Y/N] : ');
  readln(confirmation);
  if ( UpperCase(confirmation) = 'Y' ) then
  begin
    for count := 1 to max_items do
    begin
      item[count].name := '';
      item[count].shortdescription := '';
      item[count].longdescription := '';
      item[count].location := 0;
      item[count].useaction := 0;
      item[count].uselocation := 0;
    end;
    writeln;
    writeln('All Items cleared!');
    save_items;
  end
  else if ( UpperCase(confirmation) = 'N' ) then
  begin
    writeln;
    writeln('Items NOT cleared!');
  end
  else
  begin
    writeln;
    writeln('Invalid choice! Items NOT cleared!');
  end;
end;

// Items menu procedure : Displays the Items sub-menu from which all above procedures
// are called.

procedure items_menu;
var
  option : integer;
begin
  writeln;
  writeln('- Items Menu --------------------------------');
  writeln;
  writeln('  1. View Items');
  writeln('  2. Add Item');
  writeln('  3. Edit Item');
  writeln('  4. Clear all Items');
  writeln('  5. Main Menu');
  writeln;
  write('Please select an option : ');
  readln(option);
  case option of
    1 : view_items;
    2 : add_item;
    3 : edit_item;
    4 : clear_items;
    5 : exit;
  else
    begin
      writeln;
      writeln('Invalid Selection!');
      items_menu;
    end;
  end;
end;


end.

