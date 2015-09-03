-------------------------------------
-- 		 Configuration file		   --
--       for shape of tags		   --
-------------------------------------

shapeConf = {};

shapeConf.list = {
	{
		text = getText("UI_SprayOnFloor"), symbolTypes = {
			{
				text = getText("UI_SimpleSymbol"), shapes = {
					{ id = '', name = 'media/textures/Tags/Item_tz_CROSS_Floor.png',
						icon = 'media/textures/Icons/Icon_CROSS.png', text = getText('UI_Cross')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_SQUARE_Floor.png',
						icon = 'media/textures/Icons/Icon_SQUARE.png', text = getText('UI_Square')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_CIRCLE_Floor.png',
						icon = 'media/textures/Icons/Icon_CIRCLE.png', text = getText('UI_Circle')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_TRIANGLE_Floor.png',
						icon = 'media/textures/Icons/Icon_TRIANGLE.png', text = getText('UI_Triangle')
					},
				}
			},

			{
				text = getText('UI_Arrow'), shapes = {
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowWEST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowWEST.png', text = getText('UI_West')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowNORTH_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowNORTH.png', text = getText('UI_North')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowSOUTH_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowSOUTH.png', text = getText('UI_South')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowEAST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowEAST.png', text = getText('UI_East')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowNORTHWEST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowNORTHWEST.png', text = getText('UI_Northwest')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowNORTHEAST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowNORTHEAST.png', text = getText('UI_Northeast')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowSOUTHWEST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowSOUTHWEST.png', text = getText('UI_Southwest')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_ArrowSOUTHEAST_Floor.png',
						icon = 'media/textures/Icons/Icon_ArrowSOUTHEAST.png', text = getText('UI_Southeast')
					},
				}
			},

			{
				text = getText('UI_SpecialMeaningSymbol'), shapes = {
					{ id = '', name = 'media/textures/Tags/Item_tz_LOOTED_Floor.png',
						icon = 'media/textures/Icons/Icon_LOOTED.png', text = getText('UI_Looted')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_HORDES_Floor.png',
						icon = 'media/textures/Icons/Icon_HORDES.png', text = getText('UI_Hordes')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_NOTSAFE_Floor.png',
						icon = 'media/textures/Icons/Icon_NOTSAFE.png', text = getText('UI_NotSafe')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_SAFE_Floor.png',
						icon = 'media/textures/Icons/Icon_SAFE.png', text = getText('UI_Safe')
					},
					{ id = '', name = 'media/textures/Tags/Item_tz_SAFEHOUSE_Floor.png',
						icon = 'media/textures/Icons/Icon_SAFEHOUSE.png', text = getText('UI_SafeHouse')
					},
				}
			}
		}
	}
};
