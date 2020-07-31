AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')

function ENT:Initialize()
	
	self:SetModel( "models/aceofspades/gameplay_objects/crate_plate.mdl" )

	self:SetMaterial( "models/shiny" or PP["Default_Material"] )
	self:SetColor( Color(90, 90, 90))
	self:SetUseType(SIMPLE_USE)
	
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    
    self:SetCustomCollisionCheck(true)
    self:SetRenderMode( 1 )
    self:SetRenderFX( 0 )
end



function ENT:StartTouch( ply )
	if ply:GetNW2Bool("PP_Launched") then return end

	if IsValid(ply) and ply:IsPlayer() then
		ply:SetNW2Bool("PP_Launched", true)
		
		self:EmitSound("pp_sound_effects/Spring.mp3", 75, 100, 1, CHAN_AUTO)

		local PhysicsObject = ply:GetPhysicsObject()
		if IsValid(PhysicsObject) then
			PhysicsObject:SetVelocity( Vector(0,0,450) )
		end

		--self:SetPos(self:GetPos()+self:GetUp()*5)
		effects.BeamRingPoint( self:GetPos()+self:GetUp()*5, 1.1, 10, 100, 6, 5, Color(222,222,255))
		
		effects.BeamRingPoint( self:GetPos()+self:GetUp()*5, 1.1, 50, 200, 5, 7, Color(222,222,255))
		
		self:SetRenderFX( 10 )

		timer.Simple(0.4, function()
			if IsValid( self ) then
				--self:DropToFloor()
				self:SetRenderFX( 0 )
			end
		end )

		timer.Simple(1, function()
			if IsValid( ply ) then
				ply:SetNW2Bool("PP_Launched", false)
			end
		end)
	end
end