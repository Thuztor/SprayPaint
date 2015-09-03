----------------------------------------------------------------------
--                        SPRAYPAINT MOD                            --
--                    BY THUZTOR AND PEANUTS	                    --
----------------------------------------------------------------------
-- Updated to Build 27 by NCrawler									--
----------------------------------------------------------------------


spraypaint = {};
spraypaint.tagList = {};
spraypaint.gameModData = nil;

spraypaint.startRain = function()
	local gt = getGameTime();
	local gtmd = gt:getModData();
	if not gtmd.spraypaint then gtmd.spraypaint = {}; end
	gtmd.spraypaint.lastRain = gt:getWorldAgeHours();
end
spraypaint.lastRain = function()
	local gt = getGameTime();
	local gtmd = gt:getModData();
	if not gtmd.spraypaint then gtmd.spraypaint = {}; end
	if not gtmd.spraypaint.lastRain then return 0; end
	return gtmd.spraypaint.lastRain;
end

-- Using the GridSquare load event instead of a global table (which will try to set colors on unloaded grid squares)
Events.LoadGridsquare.Add(function (gridSquare)
	for i = 0,gridSquare:getObjects():size()-1 do
		local obj = gridSquare:getObjects():get(i)
		if obj ~= nil and obj:getName() == 'tag' then
			local md = obj:getModData()
			if md ~= nil and md['isTag'] == 'true' then
				obj:getSprite():setTintMod(ColorInfo.new(md['red'], md['green'], md['blue'], 1.0))
				if md.isChalk then
					if md.lastRainCheck then
						if md.lastRainCheck < spraypaint.lastRain() then
							gridSquare:getObjects():remove(obj);
						end
					else
						md.lastRainCheck = getGameTime():getWorldAgeHours();
					end
				end
			end
		end
	end
end)

Events.OnRainStart.Add(spraypaint.startRain);
