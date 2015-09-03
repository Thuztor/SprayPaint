----------------------------------------------------------------------
--                        SPRAYPAINT MOD                            --
--                    BY THUZTOR AND PEANUTS	                    --
----------------------------------------------------------------------
-- Updated to Build 27 by NCrawler									--
----------------------------------------------------------------------


spraypaint = {};
spraypaint.tagList = {};
spraypaint.gameModData = nil;

-- Using the GridSquare load event instead of a global table (which will try to set colors on unloaded grid squares)
Events.LoadGridsquare.Add(function (gridSquare)
	for i = 0,gridSquare:getObjects():size()-1 do
		local obj = gridSquare:getObjects():get(i)
		if obj ~= nil and obj:getName() == 'tag' then
			local md = obj:getModData()
			if md ~= nil and md['isTag'] == 'true' then
				obj:getSprite():setTintMod(ColorInfo.new(md['red'], md['green'], md['blue'], 1.0))
			end
		end
	end
end)

