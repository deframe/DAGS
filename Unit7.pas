unit Unit7;  // Action Procedures & Functions

// Please NOTE : This procedure is VERY similar in structure to unit5.
// All procedures are almost identical so I see little need to comment them fully.

interface

uses
  Unit1, Sysutils;

// Specify procedures & functions implemented in unit

procedure list_actions;
procedure view_actions;
procedure add_action;
procedure edit_action;
procedure clear_actions;
procedure actions_menu;

implementation

// List actions procedure : This procedure outputs a list of all the defined actions in the
// current game environment.

procedure list_actions;
var
  count : integer;
begin
  writeln('Actions in game : ');
  writeln;
  for count := 1 to max_actions do
  begin
    if ( action[count].name <> '' ) then
      writeln('  [' + IntToStr(count) + '] ' + action[count].name);
  end;
end;

// View actions procedure : This procedure lists all defined actions (by calling
// list_actions) then allows the user to view more details on a specific action.
// The details include all/most of the fields of the action record - the name,
// types, etc.

procedure view_actions;
var
  option, input_action_number : integer;
begin
  writeln;
  load_actions;
  list_actions;
  repeat
    writeln;
    write('Do you wish to view more details? [1=Yes, 2=No, 3=List] : ');
    readln(option);
    if ( option = 1 ) then
    begin
      writeln;
      write('Enter the item number you wish to view in detail : ');
      readln(input_action_number);
      if ( input_action_number < 1 ) or ( input_action_number > max_actions )
        or ( action[input_action_number].name = '' ) then
      begin
        writeln;
        writeln('That Action does not exist / is invalid!');
        continue;
      end
      else
      begin
        writeln;
        writeln('-- Details for Action ' + IntToStr(input_action_number) + ' ----------');
        writeln;
        writeln('[Name] ' + action[input_action_number].name);
        writeln;
        write('[Action Type] ' + IntToStr(action[input_action_number].actiontype));
        if ( action[input_action_number].actiontype = 1 ) then
        begin
          writeln(' (Open Location)');
          writeln;
          writeln('[Location to Open] ' +
            IntToStr(action[input_action_number].openlocation));
          writeln;
        end;
      writeln('[Action Text]');
      writeln(action[input_action_number].actiontext);
      end;
    end
    else if ( option = 2 ) then break
    else if ( option = 3 ) then
    begin
      writeln;
      list_actions;
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
      continue;
    end;
  until option = 2;
  actions_menu;
end;

// Add action procedure : This controls the adding of a new action record. The user
// must input all relevant fields and is then given the choice of saving the new
// action.

procedure add_action;
var
  count, option : integer;
  temp_name : string[30];
  temp_actiontype, temp_openlocation : integer;
  temp_actiontext : string[255];
begin
  for count := 1 to max_actions do
  begin
    if ( action[count].name = '' ) then break;
  end;
  writeln;
  writeln('Please enter the following details for Action ' + IntToStr(count));
  writeln;
  write('[Name] ');
  readln(temp_name);
  writeln;
  writeln('Available Types : ');
  writeln('  - 1: Open location');
  writeln;
  write('[Type] ');
  readln(temp_actiontype);
  writeln;
  if ( temp_actiontype = 1 ) then
  begin
    write('[Location to Open] ');
    readln(temp_openlocation);
  end;
  writeln;
  writeln('[Action Text]');
  readln(temp_actiontext);
  writeln;
  repeat
    write('Save this record? [1=Yes, 2=No] ');
    readln(option);
    if ( option = 1 ) then
    begin
      action[count].name := temp_name;
      action[count].actiontype := temp_actiontype;
      action[count].openlocation := temp_openlocation;
      action[count].actiontext := temp_actiontext;
      save_actions;
      writeln;
      writeln('Actions Updated!');
    end
    else if ( option = 2 ) then
    begin
      writeln;
      writeln('Actions NOT Updated!');
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
    end;
  until ( option = 1 ) or ( option = 2 );
  actions_menu;
end;

// Edit action procedure : This procedure allows the user to edit the details of an action
// already held in memory/on file. After changes are complete the user is once again
// asked if he/she would like to save the action or not.

procedure edit_action;
var
  option, saveoption, change : integer;
  optionvalid : boolean;
  temp_name : string[30];
  temp_actiontype, temp_openlocation : integer;
  temp_actiontext : string[255];
begin
  repeat
    writeln;
    write('Enter the action number you wish to edit [0=List] ');
    readln(option);
    if ( option = 0 ) then
    begin
      writeln;
      list_actions;
    end
    else if ( option < 0 ) or ( option > max_actions ) or ( action[option].name = '' ) then
    begin
      writeln;
      writeln('That Action does not exist / is invalid!');
    end
    else
    begin
      optionvalid := TRUE;
      writeln;
      writeln('[Name] ' + action[option].name);
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
        else if ( change = 2 ) then temp_name := action[option].name
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      writeln;
      writeln('[Type] ' + IntToStr(action[option].actiontype));
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          writeln('Available Types : ');
          writeln('  - 1: Open location');
          writeln;
          write('[Type] ');
          readln(temp_actiontype);
        end
        else if ( change = 2 ) then temp_actiontype := action[option].actiontype
        else
        begin
          writeln;
          writeln('Invalid Selection!');
        end;
      until ( change = 1 ) or ( change = 2 );
      if ( temp_actiontype = 1 ) then
      begin
        writeln;
        if ( action[option].openlocation > 0 ) then write('[Location to Open] (Prev. ',
          IntToStr(action[option].openlocation), ') ')
        else write('[Location to Open] ');
        readln(temp_openlocation);
      end;
      writeln;
      writeln('[Action Text]');
      writeln(action[option].actiontext);
      writeln;
      write('Change? [1=Yes, 2=No] ');
      readln(change);
      repeat
        if ( change = 1 ) then
        begin
          writeln;
          writeln('[Action Text]');
          readln(temp_actiontext);
        end
        else if ( change = 2 ) then temp_actiontext := action[option].actiontext
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
      action[option].name := temp_name;
      action[option].actiontype := temp_actiontype;
      action[option].openlocation := temp_openlocation;
      action[option].actiontext := temp_actiontext;
      save_actions;
      writeln;
      writeln('Actions Updated!');
    end
    else if ( saveoption = 2 ) then
    begin
      writeln;
      writeln('Actions NOT Updated!');
    end
    else
    begin
      writeln;
      writeln('Invalid Selection!');
    end;
  until ( saveoption = 1 ) or ( saveoption = 2 );
  actions_menu;
end;

// Clear actions procedure : This procedure clears all the action records from memory
// and the actions file. It is a rather dangerous option, so confirmation is required.

procedure clear_actions;
var
  count : integer;
  confirmation : string[1];
begin
  writeln;
  write('Are you sure? [Y/N] : ');
  readln(confirmation);
  if ( UpperCase(confirmation) = 'Y' ) then
  begin
    for count := 1 to max_actions do
    begin
      action[count].name := '';
      action[count].actiontype := 0;
      action[count].openlocation := 0;
      action[count].actiontext := '';
    end;
    writeln;
    writeln('All Actions cleared!');
    save_actions;
  end
  else if ( UpperCase(confirmation) = 'N' ) then
  begin
    writeln;
    writeln('Actions NOT cleared!');
  end
  else
  begin
    writeln;
    writeln('Invalid choice! Actions NOT cleared!');
  end;
end;

// Actions menu procedure : Displays the actions sub-menu from which all above procedures
// are called.

procedure actions_menu;
var
  option : integer;
begin
  writeln;
  writeln('- Actions Menu --------------------------------');
  writeln;
  writeln('  1. View Actions');
  writeln('  2. Add Action');
  writeln('  3. Edit Action');
  writeln('  4. Clear all Actions');
  writeln('  5. Main Menu');
  writeln;
  write('Please select an option : ');
  readln(option);
  case option of
    1 : view_actions;
    2 : add_action;
    3 : edit_action;
    4 : clear_actions;
    5 : exit;
  else
    begin
      writeln;
      writeln('Invalid Selection!');
      actions_menu;
    end;
  end;
end;



end.
