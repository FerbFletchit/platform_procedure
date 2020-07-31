AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	if not table.HasValue(PP_Loot["Cubes"], PP_PlatformModelToSizeString( self:GetModel() ) ) then
		self:SetModel( PP_SizeToModelString( table.Random( PP_Loot["Cubes"] ) ) )
	end

	self:SetMaterial( "models/shiny" or PP["Default_Material"] )
	self:SetUseType(CONTINUOUS_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSolid(SOLID_VPHYSICS)
    
    self:SetCustomCollisionCheck(true)
	self:PhysWake()

	self:SetGravity(math.Rand(1,3)) -- Lets them act a bit differently from each other.

	timer.Simple(0.1, function() -- Giving time for other sysytems to set it if need be.
		if IsValid(self) then
			local col = self:GetColor() -- This is used to see if the loot cube has already been colored somehwere else, if not randomize.
			if Color(col.r,col.g,col.b) == Color(255,255,255) then
				self:ApplyIngotQuality() -- true for sound effect
			end
		end
	end )

	timer.Simple(PP["Loot_Cube_RemoveTime"], function()
		if IsValid(self) and not IsValid(self:GetParent()) then
			self:Remove()
		end
	end )
end

function ENT:Use( ply )
	if IsValid(self) then
		ply:AddEntityInventoryItem( self )
	end
end

function ENT:StartTouch( ply )
	if IsValid( ply ) then

		if not self["Stopped"] then
			self:SetMoveType(MOVETYPE_NONE)
			
			self["Stopped"] = true

			timer.Simple(0.1, function()

				if IsValid( self ) then

					self:SetMoveType(MOVETYPE_VPHYSICS)

				end

			end )
		end

	end
	--if self["Looted"] then return end

	if IsValid(ply) and ply:IsPlayer() then
		--self["Looted"] = true

		if IsValid(self) then
			ply:AddEntityInventoryItem( self )
		end
	end
end

function ENT:OnRemove()
	self:EmitSound(PP["Sound_Loot_Block_Pickup"], 65, 80, 1, CHAN_ITEM)
end