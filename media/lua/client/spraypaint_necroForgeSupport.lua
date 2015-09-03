Events.OnGameStart.Add( function ()
	print ("Adding spraycans to NecroForge");
	if NecroList then
		if NecroList.Items.SpraycanWhite then	
		else
			NecroList.Items.SpraycanWhite = {"Misc.", nil, nil, "Spraycan White", "spraypaint.SpraycanWhite", "media/textures/items/Item_TZ_Spraycan_White.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanRed then	
		else
			NecroList.Items.SpraycanRed = {"Misc.", nil, nil, "Spraycan Red", "spraypaint.SpraycanRed", "media/textures/items/Item_TZ_Spraycan_Red.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanBlue then	
		else
			NecroList.Items.SpraycanBlue = {"Misc.", nil, nil, "Spraycan Blue", "spraypaint.SpraycanBlue", "media/textures/items/Item_TZ_Spraycan_Blue.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanGreen then	
		else
			NecroList.Items.SpraycanGreen = {"Misc.", nil, nil, "Spraycan Green", "spraypaint.SpraycanGreen", "media/textures/items/Item_TZ_Spraycan_Green.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanOrange then	
		else
			NecroList.Items.SpraycanOrange = {"Misc.", nil, nil, "Spraycan Orange", "spraypaint.SpraycanOrange", "media/textures/items/Item_TZ_Spraycan_Orange.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanYellow then	
		else
			NecroList.Items.SpraycanYellow = {"Misc.", nil, nil, "Spraycan Yellow", "spraypaint.SpraycanYellow", "media/textures/items/Item_TZ_Spraycan_Yellow.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanViolet then	
		else
			NecroList.Items.SpraycanViolet = {"Misc.", nil, nil, "Spraycan Violet", "spraypaint.SpraycanViolet", "media/textures/items/Item_TZ_Spraycan_Violet.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanBlack then	
		else
			NecroList.Items.SpraycanBlack = {"Misc.", nil, nil, "Spraycan Black", "spraypaint.SpraycanBlack", "media/textures/items/Item_TZ_Spraycan_Black.png", nil, nil, nil};
		end
		if NecroList.Items.SpraycanCyan then	
		else
			NecroList.Items.SpraycanCyan = {"Misc.", nil, nil, "Spraycan Cyan", "spraypaint.SpraycanCyan", "media/textures/items/Item_TZ_Spraycan_Cyan.png", nil, nil, nil};
		end
	end
end)
