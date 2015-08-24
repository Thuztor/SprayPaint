----------------------------------------------------
--          Contextual menu for spraypaint        --
--                                                --
----------------------------------------------------

spraypaintMenu = {};

spraypaintMenu.doSpraypaintMenu = function(player, context, worldobjects)
	print ("spraypaintMenu.doSpraypaintMenu("..tostring(player)..", "..tostring(context)..", "..tostring(worldobjects));
	local playerInventory = getSpecificPlayer(player):getInventory();
	local playerHasSprayCan = false;

	-- Do the player has a spray can ?
	for _,sprayCan in ipairs(sprayCanConf.list) do
		if playerInventory:contains(sprayCan.name) then
			playerHasSprayCan = true;
			break;
		end
	end

	-- Contextual menu creation if player has a spray can
	if playerHasSprayCan then

		-- Go through shapes table
		for _,place in ipairs(shapeConf.list) do
			local placeOption = context:addOption(place.text, worldobjects, nil);
			local placeSubMenu = context:getNew(context);
			context:addSubMenu(placeOption, placeSubMenu);

			for _,symbolType in ipairs(place.symbolTypes) do
				local symbolTypeOption = placeSubMenu:addOption(symbolType.text, worldobjects, nil);
				local symbolTypeOptionSubMenu = placeSubMenu:getNew(placeSubMenu);
				context:addSubMenu(symbolTypeOption, symbolTypeOptionSubMenu);

				for _,shape in ipairs(symbolType.shapes) do
					local shapeOption = symbolTypeOptionSubMenu:addOption(shape.text, worldobjects, nil);
					local colorSubMenu = symbolTypeOptionSubMenu:getNew(symbolTypeOptionSubMenu);
					context:addSubMenu(shapeOption, colorSubMenu);

					for _,sprayCan in ipairs(sprayCanConf.list) do
						local sprayCanItem = nil;
						local canUseThisSprayCan = false;
						local handItem = getSpecificPlayer(player):getSecondaryHandItem();

						if handItem and handItem:getType() == sprayCan.name and math.floor(handItem:getUsedDelta()/handItem:getUseDelta()) > 0 then
							canUseThisSprayCan = true;
							sprayCanItem = handItem;
						else
							for i = 0, getSpecificPlayer(player):getInventory():getItems():size() - 1 do
								sprayCanItem = getSpecificPlayer(player):getInventory():getItems():get(i);
								if sprayCanItem:getType() == sprayCan.name and math.floor(sprayCanItem:getUsedDelta()/sprayCanItem:getUseDelta()) > 0 then
									canUseThisSprayCan = true;
									break;
								end
							end
						end

						if canUseThisSprayCan then
							colorSubMenu:addOption(sprayCan.text, worldobjects, spraypaintMenu.onSpray, player, sprayCanItem, shape.name, sprayCan);
						end
					end
				end
			end
		end
	end
end

spraypaintMenu.onSpray = function(worldobjects, player, sprayCanItem, shape, sprayCan)
	print("spraypaintMenu.onSpray");
	if getSpecificPlayer(player):getSecondaryHandItem() ~= sprayCanItem then
		ISTimedActionQueue.add(ISEquipWeaponAction:new(getSpecificPlayer(player), sprayCanItem, 50, false));
	end

	local tag = Tag:new(player, sprayCanItem, shape, sprayCan.red, sprayCan.green, sprayCan.blue);

	player = getSpecificPlayer(player);
	getCell():setDrag(tag, player:getPlayerNum());
end

Events.OnFillWorldObjectContextMenu.Add(spraypaintMenu.doSpraypaintMenu);
