if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if ( CLIENT ) then
	SWEP.PrintName		= "Deployable Platform"
	SWEP.Author		    = "Phineas & Ferb"
	SWEP.Purpose		= "Weapons in hit gamemode PP"
	SWEP.ViewModelFOV	= "70"
	SWEP.Instructions	= "Point, Click"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 1
end

SWEP.Category = "PP" 
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

--------------
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.UseHands = false
SWEP.ViewModel = "models/weapons/v_bugbait.mdl"
SWEP.WorldModel = "models/aceofspades/tools/projectiles/snowball.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.cube1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, 0, 0) },
	["ValveBiped.cube2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.cube"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.cube3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1.016, 1.016, 1.016), pos = Vector(0, 0, 0), angle = Angle(-41.112, 5.556, 0) }
}

-- PP CODE --
SWEP.ViewModelFlip = false

SWEP.HoldType = "slam"

SWEP.ViewModelFOV = 70

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/v_bugbait.mdl"
SWEP.WorldModel = "models/aceofspades/tools/projectiles/snowball.mdl"

SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.VElements = {
	["element_name"] = { type = "Model", model = "models/aceofspades/prefabs/platform.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.752, 7.791, -0.519), angle = Angle(-45.584, 22.208, -10.52), size = Vector(0.107, 0.107, 0.107), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["element_name"] = { type = "Model", model = "models/aceofspades/prefabs/platform.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, -0.519, -2.597), angle = Angle(0, 0, 0), size = Vector(0.107, 0.107, 0.107), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.cube1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Forearm"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(16.666, 0, 0) },
	["ValveBiped.cube2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.cube"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.cube3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["ValveBiped.Bip01_R_Hand"] = { scale = Vector(1.016, 1.016, 1.016), pos = Vector(0, 0, 0), angle = Angle(-41.112, 5.556, 0) }
}

SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 30
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.0125
SWEP.Primary.ClipSize = 1
SWEP.Primary.ClipMax = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Delay = 0.2
SWEP.Primary.Automatic   = false
SWEP.Primary.Ammo        = "none"
SWEP.Primary.TakeAmmo = 0

SWEP.UseHands = true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos = Vector (-5.65, -0, 1)
SWEP.IronSightsAng = Vector (-2, -1, 1.5)

function SWEP:Initialize()
	timer.Simple(0.1, function()

		if not IsValid(self.Weapon) or not IsValid(self) then return end

		local Qual = PP_GetIngotByColor(self:GetColor())[2]["Swep_Multiplier"] or PP["Ingots"][1]["Swep_Multiplier"]
		self.Weapon.PlatformLast = 5 * Qual 

		-- Make gun work code --
		for key, value in pairs(self.VElements) do
			value["color"] = self:GetColor()

			value["material"] = PP["Default_Material"]

		end

		for key, value in pairs(self.WElements) do
			value["color"] = self:GetColor()
			value["material"] = PP["Default_Material"]
		end
		-------------------------
		
		self.Weapon:SetNW2Bool( "Ironsights", false )
		self:SetHoldType( self.HoldType )

	end )

	if CLIENT then
	
		// Create a new table for every weapon instance
		self.VElements = table.FullCopy( self.VElements )
		self.WElements = table.FullCopy( self.WElements )
		self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )

		self:CreateModels(self.VElements) // create viewmodels
		self:CreateModels(self.WElements) // create worldmodels
		
		// init view model bone build function
		if IsValid(self.Owner) then
			local vm = self.Owner:GetViewModel()
			if IsValid(vm) then
				self:ResetBonePositions(vm)
				
					// we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255,255,255,1))
					// ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					// however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")			
			end
		end
	end
end

if CLIENT then

		SWEP.vRenderOrder = nil
		function SWEP:ViewModelDrawn()
			
			local vm = self.Owner:GetViewModel()
			if !IsValid(vm) then return end
			
			if (!self.VElements) then return end
			
			self:UpdateBonePositions(vm)

			if (!self.vRenderOrder) then
				
				// we build a render order because sprites need to be drawn after models
				self.vRenderOrder = {}

				for k, v in pairs( self.VElements ) do
					if (v.type == "Model") then
						table.insert(self.vRenderOrder, 1, k)
					elseif (v.type == "Sprite" or v.type == "Quad") then
						table.insert(self.vRenderOrder, k)
					end
				end
				
			end

			for k, name in ipairs( self.vRenderOrder ) do
			
				local v = self.VElements[name]
				if (!v) then self.vRenderOrder = nil break end
				if (v.hide) then continue end
				
				local model = v.modelEnt
				local sprite = v.spriteMaterial
				
				if (!v.bone) then continue end
				
				local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
				
				if (!pos) then continue end
				
				if (v.type == "Model" and IsValid(model)) then

					model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)

					model:SetAngles(ang)
					//model:SetModelScale(v.size)
					local matrix = Matrix()
					matrix:Scale(v.size)
					model:EnableMatrix( "RenderMultiply", matrix )
					
					if (v.material == "") then
						model:SetMaterial("")
					elseif (model:GetMaterial() != v.material) then
						model:SetMaterial( v.material )
					end
					
					if (v.skin and v.skin != model:GetSkin()) then
						model:SetSkin(v.skin)
					end
					
					if (v.bodygroup) then
						for k, v in pairs( v.bodygroup ) do
							if (model:GetBodygroup(k) != v) then
								model:SetBodygroup(k, v)
							end
						end
					end
					
					if (v.surpresslightning) then
						render.SuppressEngineLighting(true)
					end
					
					render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
					render.SetBlend(v.color.a/255)
					model:DrawModel()
					render.SetBlend(1)
					render.SetColorModulation(1, 1, 1)
					
					if (v.surpresslightning) then
						render.SuppressEngineLighting(false)
					end
					
				elseif (v.type == "Sprite" and sprite) then
					
					local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					render.SetMaterial(sprite)
					render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
					
				elseif (v.type == "Quad" and v.draw_func) then
					
					local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					
					cam.Start3D2D(drawpos, ang, v.size)
						v.draw_func( self )
					cam.End3D2D()

				end
				
			end
			
		end

		SWEP.wRenderOrder = nil
		function SWEP:DrawWorldModel()
			if (self.ShowWorldModel == nil or self.ShowWorldModel) or not IsValid(self.Owner) then
				self:DrawModel()
			end
			
			if (!self.WElements) then return end
			
			if (!self.wRenderOrder) then

				self.wRenderOrder = {}

				for k, v in pairs( self.WElements ) do
					if (v.type == "Model") then
						table.insert(self.wRenderOrder, 1, k)
					elseif (v.type == "Sprite" or v.type == "Quad") then
						table.insert(self.wRenderOrder, k)
					end
				end

			end
			
			if (IsValid(self.Owner)) then
				bone_ent = self.Owner
			else
				// when the weapon is dropped
				bone_ent = self
			end
			
			for k, name in pairs( self.wRenderOrder ) do
			
				local v = self.WElements[name]
				if (!v) then self.wRenderOrder = nil break end
				if (v.hide) then continue end
				
				local pos, ang
				
				if (v.bone) then
					pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent )
				else
					pos, ang = self:GetBoneOrientation( self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand" )
				end
				
				if (!pos) then continue end
				
				local model = v.modelEnt
				local sprite = v.spriteMaterial
				
				if (v.type == "Model" and IsValid(model)) then

					model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)

					model:SetAngles(ang)
					//model:SetModelScale(v.size)
					local matrix = Matrix()
					matrix:Scale(v.size)
					model:EnableMatrix( "RenderMultiply", matrix )
					
					if (v.material == "") then
						model:SetMaterial("")
					elseif (model:GetMaterial() != v.material) then
						model:SetMaterial( v.material )
					end
					
					if (v.skin and v.skin != model:GetSkin()) then
						model:SetSkin(v.skin)
					end
					
					if (v.bodygroup) then
						for k, v in pairs( v.bodygroup ) do
							if (model:GetBodygroup(k) != v) then
								model:SetBodygroup(k, v)
							end
						end
					end
					
					if (v.surpresslightning) then
						render.SuppressEngineLighting(true)
					end
					
					render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
					render.SetBlend(v.color.a/255)
					model:DrawModel()
					render.SetBlend(1)
					render.SetColorModulation(1, 1, 1)
					
					if (v.surpresslightning) then
						render.SuppressEngineLighting(false)
					end
					
				elseif (v.type == "Sprite" and sprite) then
					
					local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					render.SetMaterial(sprite)
					render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
					
				elseif (v.type == "Quad" and v.draw_func) then
					
					local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					
					cam.Start3D2D(drawpos, ang, v.size)
						v.draw_func( self )
					cam.End3D2D()

				end
				
			end
			
		end

		function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
			
			local bone, pos, ang
			if (tab.rel and tab.rel != "") then
				
				local v = basetab[tab.rel]
				
				if (!v) then return end
				
				// Technically, if there exists an element with the same name as a bone
				// you can get in an infinite loop. Let's just hope nobody's that stupid.
				pos, ang = self:GetBoneOrientation( basetab, v, ent )
				
				if (!pos) then return end
				
				pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
				ang:RotateAroundAxis(ang:Up(), v.angle.y)
				ang:RotateAroundAxis(ang:Right(), v.angle.p)
				ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					
			else
			
				bone = ent:LookupBone(bone_override or tab.bone)

				if (!bone) then return end
				
				pos, ang = Vector(0,0,0), Angle(0,0,0)
				local m = ent:GetBoneMatrix(bone)
				if (m) then
					pos, ang = m:GetTranslation(), m:GetAngles()
				end
				
				if (IsValid(self.Owner) and self.Owner:IsPlayer() and 
					ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
					ang.r = -ang.r // Fixes mirrored models
				end
			
			end
			
			return pos, ang
		end

		function SWEP:CreateModels( tab )

			if (!tab) then return end

			// Create the clientside models here because Garry says we can't do it in the render hook
			for k, v in pairs( tab ) do
				if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and 
						string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
					
					v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
					if (IsValid(v.modelEnt)) then
						v.modelEnt:SetPos(self:GetPos())
						v.modelEnt:SetAngles(self:GetAngles())
						v.modelEnt:SetParent(self)
						v.modelEnt:SetNoDraw(true)
						v.createdModel = v.model
					else
						v.modelEnt = nil
					end
					
				elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) 
					and file.Exists ("materials/"..v.sprite..".vmt", "GAME")) then
					
					local name = v.sprite.."-"
					local params = { ["$basetexture"] = v.sprite }
					// make sure we create a unique name based on the selected options
					local tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
					for i, j in pairs( tocheck ) do
						if (v[j]) then
							params["$"..j] = 1
							name = name.."1"
						else
							name = name.."0"
						end
					end

					v.createdSprite = v.sprite
					v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
					
				end
			end
			
		end
		
		local allbones
		local hasGarryFixedBoneScalingYet = false

		function SWEP:UpdateBonePositions(vm)
			
			if self.ViewModelBoneMods then
				
				if (!vm:GetBoneCount()) then return end
				
				// !! WORKAROUND !! //
				// We need to check all model names :/
				local loopthrough = self.ViewModelBoneMods
				if (!hasGarryFixedBoneScalingYet) then
					allbones = {}
					for i=0, vm:GetBoneCount() do
						local bonename = vm:GetBoneName(i)
						if (self.ViewModelBoneMods[bonename]) then 
							allbones[bonename] = self.ViewModelBoneMods[bonename]
						else
							allbones[bonename] = { 
								scale = Vector(1,1,1),
								pos = Vector(0,0,0),
								angle = Angle(0,0,0)
							}
						end
					end
					
					loopthrough = allbones
				end
				// !! ----------- !! //
				
				for k, v in pairs( loopthrough ) do
					local bone = vm:LookupBone(k)
					if (!bone) then continue end
					
					// !! WORKAROUND !! //
					local s = Vector(v.scale.x,v.scale.y,v.scale.z)
					local p = Vector(v.pos.x,v.pos.y,v.pos.z)
					local ms = Vector(1,1,1)
					if (!hasGarryFixedBoneScalingYet) then
						local cur = vm:GetBoneParent(bone)
						while(cur >= 0) do
							local pscale = loopthrough[vm:GetBoneName(cur)].scale
							ms = ms * pscale
							cur = vm:GetBoneParent(cur)
						end
					end
					
					s = s * ms
					// !! ----------- !! //
					
					if vm:GetManipulateBoneScale(bone) != s then
						vm:ManipulateBoneScale( bone, s )
					end
					if vm:GetManipulateBoneAngles(bone) != v.angle then
						vm:ManipulateBoneAngles( bone, v.angle )
					end
					if vm:GetManipulateBonePosition(bone) != p then
						vm:ManipulateBonePosition( bone, p )
					end
				end
			else
				self:ResetBonePositions(vm)
			end
			   
		end
		 
		function SWEP:ResetBonePositions(vm)
			
			if (!vm:GetBoneCount()) then return end
			for i=0, vm:GetBoneCount() do
				vm:ManipulateBoneScale( i, Vector(1, 1, 1) )
				vm:ManipulateBoneAngles( i, Angle(0, 0, 0) )
				vm:ManipulateBonePosition( i, Vector(0, 0, 0) )
			end
			
		end

		/**************************
			Global utility code
		**************************/

		// Fully copies the table, meaning all tables inside this table are copied too and so on (normal table.Copy copies only their reference).
		// Does not copy entities of course, only copies their reference.
		// WARNING: do not use on tables that contain themselves somewhere down the line or you'll get an infinite loop
		function table.FullCopy( tab )

			if (!tab) then return nil end
			
			local res = {}
			for k, v in pairs( tab ) do
				if (type(v) == "table") then
					res[k] = table.FullCopy(v) // recursion ho!
				elseif (type(v) == "Vector") then
					res[k] = Vector(v.x, v.y, v.z)
				elseif (type(v) == "Angle") then
					res[k] = Angle(v.p, v.y, v.r)
				else
					res[k] = v
				end
			end
			
			return res
			
		end
		
	end


function SWEP:PrimaryAttack()
	if SERVER then
		local deployed  = ents.Create("prop_physics")
		
		if IsValid(deployed) then
			deployed:SetModel("models/hunter/blocks/cube075x075x025.mdl")

			deployed:SetPos(self.Weapon:GetPos()+self.Weapon:GetUp()*10)
			deployed:SetAngles( Angle(0, 0, 0) ) -- Angle(-45.584, -22.209, -10.52)
			deployed:Spawn()
			deployed.PlatformLast = self.Weapon.PlatformLast
			deployed:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			deployed:SetMaterial(self.VElements["element_name"]["material"])
			deployed:SetColor(self.VElements["element_name"]["color"])

			local PhysicsObject = deployed:GetPhysicsObject()
			if IsValid(PhysicsObject) then
				PhysicsObject:SetMass(1)
				PhysicsObject:AddVelocity(self.Owner:GetForward()*300)
			end

			local trail = util.SpriteTrail( deployed, 0, Color( 255, 255, 255, 50 ), false, 15, 1, 4, 1 / ( 15 + 1 ) * 0.5, "trails/laser" )

			timer.Simple(1, function()
				if IsValid(deployed) then
					deployed:SetMoveType(MOVETYPE_NONE)
					deployed:SetCollisionGroup(COLLISION_GROUP_NONE)
					deployed:EmitSound("pp_sound_effects/Craft_Drop.mp3",60,80,1,CHAN_AUTO)		
					
					PP_ActionEffect(deployed, "pp_impact", 1)
				end

				timer.Simple( (deployed.PlatformLast or 5), function()
					if IsValid(deployed) then
						PP_ActionEffect(deployed, "pp_impact", 1)
						deployed:EmitSound("pp_sound_effects/Death.mp3",60,80,1,CHAN_AUTO)		
						deployed:Remove()
					end
				end )
			end )
		end

		for key, value in ipairs(self.Owner:GetWeapons()) do -- This is for selecting a weapon after using the this.
			if value != self:GetClass() then -- It had to be done liek this becuase it has to function before stripping this.
				self.Owner:SelectWeapon(value)
				break
			end

		end
		
		self.Owner:StripWeapon( self:GetClass() )

	end
	
end


function SWEP:Reload()

self:SetIronsights( false )

	if (Zoomed) then -- The player is not zoomed in
	
		Zoomed = false -- We tell the SWEP that he is not
		if SERVER then
			self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
		end
	end

 
	if self.ReloadingTime and CurTime() <= self.ReloadingTime then return end
 
	if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
 
		self:DefaultReload( ACT_VM_RELOAD )
                local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
                self.ReloadingTime = CurTime() + AnimationTime
                self:SetNextPrimaryFire(CurTime() + AnimationTime)
                self:SetNextSecondaryFire(CurTime() + AnimationTime)
 
	end
 
end

local IRONSIGHT_TIME = 0.25

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNW2Bool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then 
		return pos, ang 
	end
	
	local Mul = 1.0
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	
	end
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul

	return pos, ang
	
end


/*---------------------------------------------------------
	SetIronsights
---------------------------------------------------------*/
function SWEP:SetIronsights( b )

	self.Weapon:SetNW2Bool( "Ironsights", b )

end


SWEP.NextSecondaryAttack = 0
/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	--[[if ( !self.IronSightsPos ) then return end
	if ( self.NextSecondaryAttack > CurTime() ) then return end
	
	bIronsights = !self.Weapon:GetNW2Bool( "Ironsights", false )
	
	self:SetIronsights( bIronsights )
	
	self.NextSecondaryAttack = CurTime() + 0.3
	
	
	if (!Zoomed) then -- The player is not zoomed in
 
		Zoomed = true -- Now he is
		if SERVER then
			self.Owner:SetFOV( 45, 0.3 ) -- SetFOV is serverside only
		end
	else -- If he is
 
		Zoomed = false -- We tell the SWEP that he is not
		if SERVER then
			self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
		end
	end]]
	
end

/*---------------------------------------------------------
	onRestore
	Loaded a saved game (or changelevel)
---------------------------------------------------------*/
function SWEP:OnRestore()

	self.NextSecondaryAttack = 0
	self:SetIronsights( false )
	
end

function SWEP:Deploy()
self:SetIronsights( false )
	if (Zoomed) then -- The player is not zoomed in
	
		Zoomed = false -- We tell the SWEP that he is not
		if SERVER then
			self.Owner:SetFOV( 0, 0.3 ) -- Setting to 0 resets the FOV
		end
	end
end