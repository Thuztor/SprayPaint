----------------------------------------------------
--          Contextual menu for spraypaint        --
--                                                --
----------------------------------------------------

spraypaintMenu = {};
spraypaintMenu.Color = sprayCanConf.list[1];

spraypaintMenu.doSpraypaintMenu = function(player, context, worldobjects)--{{{
	local playerInventory = getSpecificPlayer(player):getInventory();
	local playerHasSprayCan = false;

	-- Does the player have a spray can ?
	for _,sprayCan in ipairs(sprayCanConf.list) do
		if playerInventory:contains(sprayCan.name) then
			playerHasSprayCan = true;
			break;
		end
	end

	-- Contextual menu creation if player has a spray can
	if playerHasSprayCan then
		context:addOption(getText("UI_SprayOnFloor"), player, spraypaintMenu.showWindow);
	end
end
--}}}
spraypaintMenu.showWindow = function(player, useSprayCan)--{{{
	if useSprayCan then
		for _,sprayCan in ipairs(sprayCanConf.list) do
			if useSprayCan and (sprayCan.name == useSprayCan:getType()) then
				spraypaintMenu.Color = sprayCan;
			end
		end
	end

	if spraypaintMenu.window then
		spraypaintMenu.window:setVisible(true);
		return
	end

	local sprayPanel = ISPanel:new(100, 100, 4 + (4 * 50), 20 + (5 * 50));
	spraypaintMenu.window = sprayPanel:wrapInCollapsableWindow(getText("UI_SprayOnFloor"));
	spraypaintMenu.window:setResizable(false);

	local x, y = 0, 0;
	-- Go through shapes table

	for _,symbolType in ipairs(shapeConf.list[1].symbolTypes) do
		for _,shape in ipairs(symbolType.shapes) do
			local btn = ISButton:new(2 + (x * 50), 20 + (y * 50), 48, 48, "", nil, spraypaintMenu.onSpray);
			btn:setImage(getTexture(shape.name));
			btn.render = spraypaintMenu.renderShapeButton;
			btn.player = player;
			btn.shape = shape;
			sprayPanel:addChild(btn);
			x = x + 1;
			if x >= 4 then
				y = y + 1;
				x = 0;
			end
		end
	end

	x = 0;
	for _,sprayCan in ipairs(sprayCanConf.list) do
		local btn = ISButton:new(2 + (x * 18), 2, 16, 16, "", nil, spraypaintMenu.selectColor);
		btn.player = player;
		btn.item = sprayCan;
		btn.backgroundColor = { r = sprayCan.red, g = sprayCan.green, b = sprayCan.blue, a = 1.0 };
		sprayPanel:addChild(btn);
		x = x + 1;
	end

	spraypaintMenu.window:addToUIManager();
end
--}}}

spraypaintMenu.renderShapeButton = function(self)--{{{
	self:drawTextureScaledAspect(self.image,
		self:getWidth() / 2 - self.image:getWidth() / 2, self:getHeight() - self.image:getHeight(),
		self.image:getWidth(), self.image:getHeight(),
		1, spraypaintMenu.Color.red, spraypaintMenu.Color.green, spraypaintMenu.Color.blue);
end
--}}}
spraypaintMenu.renderColorButton = function(self)--{{{
	self:drawTextureScaledAspect(self.image,
		self:getWidth() / 2 - self.image:getWidth() / 2, self:getHeight() - self.image:getHeight(),
		self.image:getWidth(), self.image:getHeight(),
		1, spraypaintMenu.Color.red, spraypaintMenu.Color.green, spraypaintMenu.Color.blue);
end
--}}}
spraypaintMenu.selectColor = function(_, self)--{{{
	spraypaintMenu.Color = self.item;
end
--}}}

spraypaintMenu.onSpray = function(_, self) -- {{{
	local player = getSpecificPlayer(self.player);
	local inv = player:getInventory();
	local sprayCanItem = inv:FindAndReturn("spraypaint."..spraypaintMenu.Color.name);
	if (not sprayCanItem) or (bcUtils.numUsesLeft(sprayCanItem) < 1) then
		player:Say("I have no spraycan of that color.");
		return;
	end

	if player:getSecondaryHandItem() ~= sprayCanItem then
		ISTimedActionQueue.add(ISEquipWeaponAction:new(player, sprayCanItem, 50, false));
	end

	local tag = Tag:new(self.player, sprayCanItem, self.shape.name, spraypaintMenu.Color.red, spraypaintMenu.Color.green, spraypaintMenu.Color.blue);

	getCell():setDrag(tag, player:getPlayerNum());
end
--}}}
Events.OnFillWorldObjectContextMenu.Add(spraypaintMenu.doSpraypaintMenu);

spraypaintMenu.doInventoryMenu = function(player, context, items) -- {{{
	local item = items[1];
	if not instanceof(item, "InventoryItem") then
		item = item.items[1];
	end
	if item == nil then return end;

	if luautils.stringStarts(item:getType(), "Spraycan") then
		context:addOption(getText("UI_SprayOnFloor"), player, spraypaintMenu.showWindow, item);
	end
end
-- }}}
Events.OnFillInventoryObjectContextMenu.Add(spraypaintMenu.doInventoryMenu);
