if SERVER then

	util.AddNetworkString("PP_Force_Camera_Pos")
	util.AddNetworkString("PP_Force_Camera_Ent")

	local Player = FindMetaTable("Player")

	function ForceAllCameraViewPos(Camera_Table, Duration)
		for key, value in pairs(player.GetAll()) do

			value:Freeze( true )

			timer.Simple(Duration, function()

				if IsValid( value ) then

					value:Freeze( false )

				end

			end )
		end
		
		net.Start("PP_Force_Camera_Pos")
			net.WriteTable(Camera_Table)
			net.WriteInt( Duration, 8 )
		net.Broadcast(self)
	end

	function Player:ForceCameraViewPos(Camera_Table, Duration)
		net.Start("PP_Force_Camera_Pos")
			net.WriteTable(Camera_Table)
			net.WriteInt( Duration, 8 )
		net.Send(self)
	end

	function Player:ForceCameraViewEnt(Camera_Table, Duration)
		net.Start("PP_Force_Camera_Ent")
			net.WriteEntity(Camera_Table)
			net.WriteInt( Duration, 8 )
		net.Send(self)
	end

elseif CLIENT then

	function PP_CameraFadeInSwitch()
		local Black_Face = vgui.Create("DPanel")
		Black_Face:SetSize(ScrW(),ScrH())

		function Black_Face:Paint(w,h)
			draw.RoundedBox(0,0,0,w,h,color_black)
		end
		Black_Face:SetAlpha(0)

		Black_Face:AlphaTo(255, 0.5, 0, function()
			if IsValid(Black_Face) then
				Black_Face:AlphaTo(0, 0.5, 0.5, function()
					if IsValid(Black_Face) then
						Black_Face:Remove()
					end
				end )
			end
		end )
	end

	local Player = FindMetaTable("Player")

	function Player:ForceCameraView(Camera_Table, Duration)
		PP_CameraFadeInSwitch()
		timer.Simple(0.5, function()
			if IsValid(self) and Camera_Table then
				self["Camera_Viewing"] = true
				self["Camera"] = Camera_Table

			end
		end )

		timer.Simple(Duration, function()
			if IsValid(self) then
				self["Camera_Viewing"] = false
				self["Camera"] = nil
			end
		end )
	end

	net.Receive("PP_Force_Camera_Pos", function(len,ply)
		LocalPlayer():ForceCameraView(net.ReadTable(), net.ReadInt(8))
	end )

	net.Receive("PP_Force_Camera_Ent", function(len,ply)
		local Ent = net.ReadEntity()
		if IsValid(Ent) then
			LocalPlayer():ForceCameraView({
			["origin"] = Ent:GetPos()-Ent:GetAngles():Forward()*100+Ent:GetAngles():Up()*60,
			["angles"] = angles,
			["fov"] = 100,
			["drawviewer"] = true,
			}, 
			net.ReadInt(8)
			)
		end
	end )

	local function PP_CameraControl(ply, pos, angles, fov)
		if ply["Camera_Viewing"] then
			return ply["Camera"]
		end
	end
	 
	hook.Add( "CalcView", "PP_CameraControl", PP_CameraControl )

end