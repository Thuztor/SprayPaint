----------------------------------------------------
--          Contextual menu for spraypaint        --
--                                                --
----------------------------------------------------

spraypaintMenu = {};
spraypaintMenu.Color = sprayCanConf.list[1];
spraypaintMenu.colorButtons = {};

spraypaintMenu.hideWindow = function(self) -- {{{
	ISCollapsableWindow.close(self);
	spraypaintMenu.toolbarButton:setImage(spraypaintMenu.textureOff);
end
-- }}}
spraypaintMenu.addTab = function(name)
  spraypaintMenu.mainPanel = ISPanelJoypad:new(0, 48, spraypaintMenu.window:getWidth(), spraypaintMenu.window:getHeight() - (48 * 2) - spraypaintMenu.window.nested.tabHeight)
  spraypaintMenu.mainPanel:initialise()
  spraypaintMenu.mainPanel:instantiate()
  spraypaintMenu.mainPanel:setAnchorRight(true)
  spraypaintMenu.mainPanel:setAnchorLeft(true)
  spraypaintMenu.mainPanel:setAnchorTop(true)
  spraypaintMenu.mainPanel:setAnchorBottom(true)
  spraypaintMenu.mainPanel:noBackground()
  spraypaintMenu.mainPanel.borderColor = {r=0, g=0, b=0, a=0};
  spraypaintMenu.mainPanel:setScrollChildren(true)

  spraypaintMenu.mainPanel.onJoypadDown = MainOptions.onJoypadDownCurrentTab
  spraypaintMenu.mainPanel.onGainJoypadFocus = MainOptions.onGainJoypadFocusCurrentTab

  spraypaintMenu.mainPanel:addScrollBars();
  spraypaintMenu.window.nested:addView(name, spraypaintMenu.mainPanel)
end
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
		spraypaintMenu.toolbarButton:setImage(spraypaintMenu.textureOn);
		return;
	end

  local sprayPanel = ISTabPanel:new(100, 100, 4 + (4 * 50), 40 + (5 * 50));
  sprayPanel:initialise();
  sprayPanel:setAnchorBottom(true);
  sprayPanel:setAnchorRight(true);
  sprayPanel.target = self;
  sprayPanel:setEqualTabWidth(true)
  sprayPanel:setCenterTabs(true)
	spraypaintMenu.window = sprayPanel:wrapInCollapsableWindow("Spraypaint");
	spraypaintMenu.window.close = spraypaintMenu.hideWindow;
	spraypaintMenu.window.closeButton.onmousedown = spraypaintMenu.hideWindow;
	spraypaintMenu.window:setResizable(false);

	spraypaintMenu.addTab(getText("UI_SprayOnFloor"));

	local x, y = 0, 0;
	-- Go through shapes table

	for _,symbolType in ipairs(shapeConf.list[1].symbolTypes) do
		for _,shape in ipairs(symbolType.shapes) do
			local btn = ISButton:new(2 + (x * 50), 20 + (y * 50), 48, 48, "", nil, spraypaintMenu.onSpray);
			btn:setImage(getTexture(shape.icon));
			btn.render = spraypaintMenu.renderShapeButton;
			btn.player = player;
			btn.shape = shape;
			spraypaintMenu.mainPanel:addChild(btn);
			x = x + 1;
			if x >= 4 then
				y = y + 1;
				x = 0;
			end
		end
	end

	local inv = getSpecificPlayer(player):getInventory();
	x = 0;
	for _,sprayCan in ipairs(sprayCanConf.list) do
		local btn = ISButton:new(2 + (x * 18), 2, 16, 16, "", nil, spraypaintMenu.selectColor);
		btn.player = player;
		btn.item = sprayCan;
		btn.backgroundColor = { r = sprayCan.red, g = sprayCan.green, b = sprayCan.blue, a = 1.0 };
		spraypaintMenu.colorButtons[sprayCan.name] = btn;
		if not inv:FindAndReturn("spraypaint."..sprayCan.name) then
			btn:setVisible(false);
		end
		spraypaintMenu.mainPanel:addChild(btn);
		x = x + 1;
	end

	spraypaintMenu.addTab(getText("UI_ChalkOnFloor"));

	spraypaintMenu.window:addToUIManager();
	spraypaintMenu.toolbarButton:setImage(spraypaintMenu.textureOn);
end
--}}}

spraypaintMenu.renderShapeButton = function(self)--{{{
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

spraypaintMenu.doSpraypaintMenu = function(player, context, worldobjects)--{{{
	local playerInventory = getSpecificPlayer(player):getInventory();
	local playerHasSprayCan = false;
	local sprayCan = nil;

	-- Does the player have a spray can ?
	for _,sprayCan in ipairs(sprayCanConf.list) do
		sprayCan = playerInventory:FindAndReturn("spraypaint."..sprayCan.name)
		if sprayCan then
			playerHasSprayCan = true;
			break;
		end
	end

	-- Contextual menu creation if player has a spray can
	if playerHasSprayCan then
		context:addOption(getText("UI_SprayOnFloor"), player, spraypaintMenu.showWindow, sprayCan);
	end
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

spraypaintMenu.ISITAPerform = ISInventoryTransferAction.perform;
ISInventoryTransferAction.perform = function(self)--{{{
	spraypaintMenu.ISITAPerform(self);
	spraypaintMenu.updateColorButtons(nil);
end
--}}}
spraypaintMenu.updateColorButtons = function(object)--{{{
	if not spraypaintMenu.window then return end;

	local inv = getPlayer():getInventory();
	for _,sprayCan in ipairs(sprayCanConf.list) do
		if inv:FindAndReturn("spraypaint."..sprayCan.name) then
			spraypaintMenu.colorButtons[sprayCan.name]:setVisible(true);
		else
			spraypaintMenu.colorButtons[sprayCan.name]:setVisible(false);
		end
	end
end
--}}}
Events.OnContainerUpdate.Add(spraypaintMenu.updateColorButtons);

spraypaintMenu.textureOff = getTexture("media/textures/Icons/Icon_Spraypaint_Menu_off.png");
spraypaintMenu.textureOn = getTexture("media/textures/Icons/Icon_Spraypaint_Menu_on.png");

spraypaintMenu.showWindowToolbar = function()--{{{ bcToolbar integration
	if spraypaintMenu.window and spraypaintMenu.window:getIsVisible() then
		spraypaintMenu.window:close();
	else
		spraypaintMenu.showWindow(getPlayer():getPlayerNum(), nil);
	end
end
spraypaintMenu.addToolbarButton = function()
	if spraypaintMenu.toolbarButton then return end;
	local craftBtn = ISEquippedItem.instance.craftingBtn;
	spraypaintMenu.toolbarButton = ISButton:new(0, craftBtn:getY() + craftBtn:getHeight() + 5, 64, 64, "", nil, spraypaintMenu.showWindowToolbar);
	spraypaintMenu.toolbarButton:setImage(spraypaintMenu.textureOff);
	spraypaintMenu.toolbarButton:setDisplayBackground(false);
	spraypaintMenu.toolbarButton.borderColor = {r=1, g=1, b=1, a=0.1};

	ISEquippedItem.instance:addChild(spraypaintMenu.toolbarButton);
	ISEquippedItem.instance:setHeight(math.max(ISEquippedItem.instance:getHeight(), spraypaintMenu.toolbarButton:getY() + 64));
end
spraypaintMenu.addToolbarButtonToBCToolBar = function()
	spraypaintMenu.addToolbarButton();
	bcToolbar.moveButtonToToolbar(spraypaintMenu.toolbarButton, "Spraypaint");
end
if getActivatedMods():contains("bcToolbar") then
	require("BCUI/bcToolbar");
	Events.bcToolbarAddButtons.Add(spraypaintMenu.addToolbarButtonToBCToolBar);
end
--}}}

Events.OnCreatePlayer.Add(spraypaintMenu.addToolbarButton);
