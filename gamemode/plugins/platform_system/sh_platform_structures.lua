Platform_Manager["Structures"] = { -- This is where we build structures based on a platform.
	
	["Spawn Platform"] = { -- The platform ID.
		["FX"] = 1,
		["Size"] = "8x8x1",
		["Angles"] = Angle(0,0,0),
		["Mass"] = 50000, -- (In Kilograms)
		--["Color"] = Color(255,0,0, 200),
		["Material"] = "!Tile",

		["Child_Blocks"] = {
		}
	},


	["Tree Platform"] = { -- The platform ID.
		["Size"] = "8x8x2",
		["Angles"] = Angle(0,90,0),
		["Mass"] = 20000, -- (In Kilograms)
		["Color"] = PP["Color_Pallete"]["Dirt"],
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"8x8x025",
				function(Base)
					return Base:GetPos() + Vector( 0, 0, 77)
				end,
				Angle(0,0,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 133, 119, 99)
				end,
				Angle(0,223,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 131, 111, 107)
				end,
				Angle(0,223,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 132, 101, 83)
				end,
				Angle(0,223,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 117, -120, 91)
				end,
				Angle(0,-72,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 109, -121, 99)
				end,
				Angle(0,-72,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 101, -127, 91)
				end,
				Angle(0,-72,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -145, 132, 83)
				end,
				Angle(0,87,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -137, 136, 107)
				end,
				Angle(0,87,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -132, 144, 91)
				end,
				Angle(0,87,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -101, -100, 91)
				end,
				Angle(0,-14,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -107, -93, 107)
				end,
				Angle(0,-14,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -116, -89, 83)
				end,
				Angle(0,-14,-90),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x3x075",
				function(Base)
					return Base:GetPos() + Vector( 9, 23, 155)
				end,
				Angle(0,0,-90),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x2x2",
				function(Base)
					return Base:GetPos() + Vector( 9, 18, 238)
				end,
				Angle(0,90,0),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"05x075x025",
				function(Base)
					return Base:GetPos() + Vector( 51, 11, 90)
				end,
				Angle(0,0,0),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 64, -7, 87)
				end,
				Angle(0,90,0),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x075",
				function(Base)
					return Base:GetPos() + Vector( -26, -49, 288)
				end,
				Angle(0,90,0),
				PP["Color_Pallete"]["Grass"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -22, -42, 257)
				end,
				Angle(0,86,0),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
		}
	},

	["Landscape01"] = { -- The platform ID.
		["Size"] = "1x1x025",
		["Angles"] = Angle(0,0,0),
		["Mass"] = 10000, -- (In Kilograms)
		["Color"] = Color(0,0,0),
		--["Material"] = "!groundsand03a",
		["Child_Blocks"] = {
			{
				"2x4x1",
				function(Base)
					return Base:GetPos() + Vector( 117, -145, 18)
				end,
				Angle(0,180,0),
				PP["Color_Pallete"]["Dirt"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x4x1",
				function(Base)
					return Base:GetPos() + Vector( -157, -65, 18)
				end,
				Angle(0,180,0),
				PP["Color_Pallete"]["Dirt"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -103, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -86, -147, 29)
				end,
				Angle(0,180,0),
				Color(91,75,31),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -69, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -53, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -36, -147, 29)
				end,
				Angle(0,180,0),
				Color(91,75,31),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -19, -147, 29)
				end,
				Angle(0,180,0),
				Color(91,75,31),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -2, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 15, -147, 29)
				end,
				Angle(0,180,0),
				Color(91,75,31),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 32, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 49, -147, 29)
				end,
				Angle(0,180,0),
				Color(91,75,31),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 66, -147, 29)
				end,
				Angle(0,180,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x4x025",
				function(Base)
					return Base:GetPos() + Vector( -30, -150, 26)
				end,
				Angle(0,90,0),
				Color(117,97,41),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x4x025",
				function(Base)
					return Base:GetPos() + Vector( -30, -96, 26)
				end,
				Angle(0,90,0),
				Color(117,97,41),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x6x1",
				function(Base)
					return Base:GetPos() + Vector( -251, -17, 18)
				end,
				Angle(0,180,0),
				PP["Color_Pallete"]["Dirt"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x8x1",
				function(Base)
					return Base:GetPos() + Vector( 211, -87, 18)
				end,
				Angle(0,0,0),
				PP["Color_Pallete"]["Dirt"],
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 229, 80, 70)
				end,
				Angle(0,180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x025",
				function(Base)
					return Base:GetPos() + Vector( 233, 70, 37)
				end,
				Angle(0,180,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 236, 77, 54)
				end,
				Angle(0,0,-90),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 237, 73, 78)
				end,
				Angle(0,180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 98, -66, 67)
				end,
				Angle(0,179,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x025",
				function(Base)
					return Base:GetPos() + Vector( 102, -75, 37)
				end,
				Angle(0,179,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 105, -68, 51)
				end,
				Angle(0,-1,-90),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 106, -72, 75)
				end,
				Angle(0,179,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 163, -204, 71)
				end,
				Angle(0,-180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x025",
				function(Base)
					return Base:GetPos() + Vector( 166, -213, 41)
				end,
				Angle(0,-179,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 169, -207, 55)
				end,
				Angle(0,0,-90),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( 171, -210, 80)
				end,
				Angle(0,-180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( -229, 113, 68)
				end,
				Angle(0,180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x025",
				function(Base)
					return Base:GetPos() + Vector( -225, 104, 38)
				end,
				Angle(0,180,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -222, 110, 52)
				end,
				Angle(0,0,-90),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( -221, 107, 76)
				end,
				Angle(0,180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( -278, -128, 68)
				end,
				Angle(0,-180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x075x025",
				function(Base)
					return Base:GetPos() + Vector( -275, -137, 38)
				end,
				Angle(0,-180,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -272, -131, 52)
				end,
				Angle(0,0,-90),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( -270, -134, 76)
				end,
				Angle(0,180,0),
				Color(58,80,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( -128, -42, 49)
				end,
				Angle(0,-179,0),
				Color(150,119,35),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -112, -35, 59)
				end,
				Angle(0,1,90),
				Color(135,111,44),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -112, -86, 59)
				end,
				Angle(0,1,90),
				Color(135,111,44),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x025x025",
				function(Base)
					return Base:GetPos() + Vector( -125, -87, 38)
				end,
				Angle(0,-179,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -111, 14, 59)
				end,
				Angle(0,1,90),
				Color(135,111,44),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( -128, -42, 66)
				end,
				Angle(0,-179,0),
				Color(150,119,35),
				"models/debug/debugwhite",
				"tile",
			},
		}
	},

	["Two_Level"] = { -- The platform ID.
		["Size"] = "8x8x2",
		["Angles"] = Angle(0,0,0),
		["Mass"] = 30000, -- (In Kilograms)
		["Color"] = Color(127,111,63),
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"8x8x025",
				function(Base)
					return Base:GetPos() + Vector( 0, 0, 77)
				end,
				Angle(0,90,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x2x2",
				function(Base)
					return Base:GetPos() + Vector( -143, -137, 131)
				end,
				Angle(0,0,0),
				Color(222,202,148),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x150x1",
				function(Base)
					return Base:GetPos() + Vector( -77, -148, 108)
				end,
				Angle(0,-15,0),
				Color(196,179,130),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x150x1",
				function(Base)
					return Base:GetPos() + Vector( -117, -90, 119)
				end,
				Angle(0,132,90),
				Color(222,202,148),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"05x05x05",
				function(Base)
					return Base:GetPos() + Vector( -68, -89, 96)
				end,
				Angle(0,27,0),
				Color(196,179,130),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"models/aceofspades/prefabs/small_stairwall.mdl",
				function(Base)
					return Base:GetPos() + Vector( -115, -11, 83)
				end,
				Angle(0,180,0),
				Color(90,90,90),
				"",
				"stone",
			},
			{
				"8x8x4",
				function(Base)
					return Base:GetPos() + Vector( -380, -9, 0)
				end,
				Angle(0,0,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"8x8x025",
				function(Base)
					return Base:GetPos() + Vector( -380, -8, 172)
				end,
				Angle(0,-90,0),
				Color(95,127,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x6x05",
				function(Base)
					return Base:GetPos() + Vector( -376, -9, 172)
				end,
				Angle(0,0,0),
				Color(145,145,145),
				"models/debug/debugwhite",
				"tile",
			},

		}
	},

	["Stone_Place"] = { -- The platform ID.
		["Size"] = "4x6x2",
		["Angles"] = Angle(0,0,0),
		["Mass"] = 30000, -- (In Kilograms)
		["Color"] = Color(72,72,72),
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"4x6x025",
				function(Base)
					return Base:GetPos() + Vector( 0, 0, 77)
				end,
				Angle(0,0,0),
				Color(36,36,36),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x1",
				function(Base)
					return Base:GetPos() + Vector( -267, 139, 0)
				end,
				Angle(0,-180,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x025",
				function(Base)
					return Base:GetPos() + Vector( -267, 139, 30)
				end,
				Angle(0,180,0),
				Color(36,36,36),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( -129, 61, 58)
				end,
				Angle(-60,-178,90),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( -128, 92, 58)
				end,
				Angle(-60,-178,90),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -164, 83, 31)
				end,
				Angle(0,180,0),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -141, 83, 43)
				end,
				Angle(0,180,0),
				Color(143,115,39),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -117, 83, 54)
				end,
				Angle(0,180,0),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x3x025",
				function(Base)
					return Base:GetPos() + Vector( -17, 171, 71)
				end,
				Angle(0,-180,0),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -17, 154, 57)
				end,
				Angle(0,180,45),
				Color(108,87,30),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x075x025",
				function(Base)
					return Base:GetPos() + Vector( 22, 148, 28)
				end,
				Angle(0,-90,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -26, 148, 0)
				end,
				Angle(0,-90,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 100, -52, 36)
				end,
				Angle(0,0,-1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 100, 31, 2)
				end,
				Angle(1,0,1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( 28, -147, 9)
				end,
				Angle(0,90,1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( -17, -147, 49)
				end,
				Angle(-1,90,-2),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x2x025",
				function(Base)
					return Base:GetPos() + Vector( -100, -77, 8)
				end,
				Angle(0,-180,-1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -100, 10, 49)
				end,
				Angle(1,-180,-3),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -100, 100, 1)
				end,
				Angle(0,180,2),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -367, 202, 6)
				end,
				Angle(0,-180,-2),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x075x025",
				function(Base)
					return Base:GetPos() + Vector( -367, 89, -13)
				end,
				Angle(-1,-180,2),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x150x025",
				function(Base)
					return Base:GetPos() + Vector( -240, 239, -17)
				end,
				Angle(0,-90,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -320, 239, 9)
				end,
				Angle(0,-90,4),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( -167, 186, 3)
				end,
				Angle(0,0,1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"models/aceofspades/prefabs/ladder.mdl",
				function(Base)
					return Base:GetPos() + Vector( 166, -79, 42)
				end,
				Angle(0,90,-90),
				Color(108,87,30),
				"models/debug/debugwhite",
				"plastic",
			},
			{
				"4x4x025",
				function(Base)
					return Base:GetPos() + Vector( 339, -49, 30)
				end,
				Angle(0,90,0),
				Color(36,36,36),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 392, 50, -15)
				end,
				Angle(1,-90,-1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 239, -118, -24)
				end,
				Angle(0,180,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x1",
				function(Base)
					return Base:GetPos() + Vector( 339, -50, 0)
				end,
				Angle(0,90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x125x025",
				function(Base)
					return Base:GetPos() + Vector( 439, -76, -17)
				end,
				Angle(0,0,-1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 441, -3, 4)
				end,
				Angle(0,0,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 286, -150, 0)
				end,
				Angle(-1,91,1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x05x025",
				function(Base)
					return Base:GetPos() + Vector( 239, -21, -1)
				end,
				Angle(0,-180,1),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( 374, -150, -17)
				end,
				Angle(0,90,0),
				Color(54,53,53),
				"models/debug/debugwhite",
				"tile",
			},


		}
	},

	["Stone_Zone"] = { -- The platform ID.
		["Size"] = "6x6x6",
		["Angles"] = Angle(0,-90,0),
		["Mass"] = 30000, -- (In Kilograms)
		["Color"] = Color(109,109,109),
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"6x6x2",
				function(Base)
					return Base:GetPos() + Vector( -285, -124, 0)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x6x025",
				function(Base)
					return Base:GetPos() + Vector( -286, -123, 77)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x6x05",
				function(Base)
					return Base:GetPos() + Vector( -1, 0, 273)
				end,
				Angle(0,0,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x1x025",
				function(Base)
					return Base:GetPos() + Vector( -167, 101, 125)
				end,
				Angle(0,-180,0),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"025x150x025",
				function(Base)
					return Base:GetPos() + Vector( -118, 164, 218)
				end,
				Angle(0,-270,0),
				Color(87,69,22),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"3x3x05",
				function(Base)
					return Base:GetPos() + Vector( -454, 45, -12)
				end,
				Angle(0,90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"3x3x05",
				function(Base)
					return Base:GetPos() + Vector( -454, 45, 12)
				end,
				Angle(0,90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x2",
				function(Base)
					return Base:GetPos() + Vector( 188, 194, 24)
				end,
				Angle(0,-180,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x05",
				function(Base)
					return Base:GetPos() + Vector( 188, 195, 81)
				end,
				Angle(0,-180,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 387, 175, 89)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 478, 175, 89)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 569, 175, 89)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 660, 175, 89)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 751, 175, 89)
				end,
				Angle(0,-90,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x05",
				function(Base)
					return Base:GetPos() + Vector( 924, 157, 81)
				end,
				Angle(0,-180,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x2",
				function(Base)
					return Base:GetPos() + Vector( 924, 157, 24)
				end,
				Angle(0,-180,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 751, 175, 77)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 660, 175, 77)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 569, 175, 77)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 478, 175, 77)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x2x025",
				function(Base)
					return Base:GetPos() + Vector( 387, 175, 77)
				end,
				Angle(0,-90,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"models/aceofspades/prefabs/zombie_ribs.mdl",
				function(Base)
					return Base:GetPos() + Vector( 43, -180, 154)
				end,
				Angle(90,-90,-180),
				Color(72,72,72),
				"models/debug/debugwhite",
				"plastic",
			},
		}
	},

	["Abstract_Danger"] = { -- The platform ID.
		["Size"] = "4x4x2",
		["Angles"] = Angle(0,0,0),
		["Mass"] = 30000, -- (In Kilograms)
		["Color"] = Color(145,145,145),
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"2x8x1",
				function(Base)
					return Base:GetPos() + Vector( -127, 58, 143)
				end,
				Angle(0,-90,90),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x6x1",
				function(Base)
					return Base:GetPos() + Vector( -79, -2, 95)
				end,
				Angle(0,90,90),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x4x1",
				function(Base)
					return Base:GetPos() + Vector( -55, 69, 47)
				end,
				Angle(0,-180,90),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"2x2x1",
				function(Base)
					return Base:GetPos() + Vector( -55, 117, 0)
				end,
				Angle(-90,-90,-180),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"075x3x075",
				function(Base)
					return Base:GetPos() + Vector( -32, 165, -36)
				end,
				Angle(0,-90,0),
				Color(145,145,145),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x4x2",
				function(Base)
					return Base:GetPos() + Vector( -156, 62, 119)
				end,
				Angle(0,0,0),
				Color(145,145,145),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x8x2",
				function(Base)
					return Base:GetPos() + Vector( 169, -192, -38)
				end,
				Angle(0,-91,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"4x6x2",
				function(Base)
					return Base:GetPos() + Vector( 427, 9, -44)
				end,
				Angle(0,0,0),
				Color(109,109,109),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"8x8x1",
				function(Base)
					return Base:GetPos() + Vector( 672, 195, -24)
				end,
				Angle(0,0,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 838, 348, 2)
				end,
				Angle(86,92,92),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 519, 354, 2)
				end,
				Angle(90,96,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 828, 37, 2)
				end,
				Angle(90,-114,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 501, -116, 30)
				end,
				Angle(90,-88,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 351, 117, 30)
				end,
				Angle(90,-71,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 330, -308, 35)
				end,
				Angle(90,-59,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( -128, 31, 335)
				end,
				Angle(90,-5,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( -34, 70, 144)
				end,
				Angle(90,-34,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( -79, -38, 239)
				end,
				Angle(90,-17,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( -173, 55, 168)
				end,
				Angle(90,-146,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 15, -50, 50)
				end,
				Angle(90,49,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
			{
				"models/props_c17/doll01",
				function(Base)
					return Base:GetPos() + Vector( 9, -304, 35)
				end,
				Angle(90,95,-180),
				Color(255,255,255),
				"",
				"dirt",
			},
		}
	},

	["Lame_Zone"] = { -- The platform ID.
		["Size"] = "8x8x2",
		["Angles"] = Angle(0,-90,0),
		["Mass"] = 30000, -- (In Kilograms)
		["Color"] = Color(218,218,218),
		["Material"] = "models/debug/debugwhite",
		["Child_Blocks"] = {
			{
				"8x8x05",
				function(Base)
					return Base:GetPos() + Vector( 0, 0, 83)
				end,
				Angle(0,0,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"8x8x8",
				function(Base)
					return Base:GetPos() + Vector( 380, -172, 0)
				end,
				Angle(0,-180,0),
				Color(182,182,182),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"8x8x05",
				function(Base)
					return Base:GetPos() + Vector( 381, -173, 368)
				end,
				Angle(0,-180,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"1x8x05",
				function(Base)
					return Base:GetPos() + Vector( 291, 278, 91)
				end,
				Angle(0,45,0),
				Color(127,111,63),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x6x2",
				function(Base)
					return Base:GetPos() + Vector( 513, 465, 0)
				end,
				Angle(0,-180,0),
				Color(182,182,182),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"6x6x05",
				function(Base)
					return Base:GetPos() + Vector( 513, 465, 83)
				end,
				Angle(0,-180,0),
				Color(72,72,72),
				"models/debug/debugwhite",
				"tile",
			},
			{
				"models/aceofspades/prefabs/fort_wall.mdl",
				function(Base)
					return Base:GetPos() + Vector( 554, 19, 210)
				end,
				Angle(-90,0,-180),
				Color(109,109,109),
				"models/debug/debugwhite",
				"plastic",
			},

		}
	}
}


