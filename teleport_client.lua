local gRoot = getRootElement();

local screen = {guiGetScreenSize()};

local teleport_position =

	{

	 {"Los Santos", 2485.00000, -1667.00000, 13.34375};
	 {"San Fierro", -2405.00000, -598.00000, 132.64844};
	 {"Las Venturas", 2005.00000, 1543.00000, 13.59075}

	}

function teleport_menu()
	window = guiCreateWindow((screen[1]/2)-(240/2), (screen[2]/2)-(320/2), 240, 320, "Teleport Panel", false);
	guiSetVisible(window, false);
	teleport_button = guiCreateButton(0, 0.78, 1, 0.08, "Teleport", true, window);
	close_button = guiCreateButton(0, 0.88, 1, 0.08, "Close", true, window);
	gridlist = guiCreateGridList(0, 0.08, 1.5, 0.68, true, window);
    guiGridListAddColumn(gridlist, "Position", 0.85);
	for key, teleports in pairs(teleport_position) do
    local row = guiGridListAddRow(gridlist);
    guiGridListSetItemText(gridlist, row, 1, teleports[1], false, false);
    
 	addEventHandler("onClientGUIClick", teleport_button, teleport_Button);
    addEventHandler("onClientGUIClick", close_button, close_Button);
	end;
end;
addEventHandler("onClientResourceStart", root, teleport_menu);

bindKey("f2", "down",
function ()
	guiSetVisible(window, not guiGetVisible(window));
	showCursor(not isCursorShowing());
end);

function teleport_Button(btn)
	local vehicle = getPedOccupiedVehicle(getLocalPlayer());
	local check_gridlist = guiGridListGetItemText(gridlist, guiGridListGetSelectedItem(gridlist), 1);
    for key, teleports in pairs(teleport_position) do
      if teleports[1] == check_gridlist then
      outputChatBox("* You teleported to " ..teleports[1], 0, 255, 0);
      fadeCamera(false, 1.0);
      setTimer(fadeCamera, 1000, 1, true);
      setTimer(setElementPosition, 1000, 1, getLocalPlayer(), teleports[2], teleports[3], teleports[4]);
      	if vehicle then
      	setTimer(setElementPosition, 1000, 1, vehicle, teleports[2], teleports[3], teleports[4]);
      		end;
     	end;
 	end;
end;

function close_Button()
	guiSetVisible(window, false);
	showCursor(false);
end;