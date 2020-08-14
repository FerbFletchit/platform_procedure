--PP_ActionEffect(pos, "pp_teleport", 1)
function EFFECT:Init( data )

	local Teleport_vOffset = data:GetOrigin() + Vector(
		math.random( -30, 30),
		math.random( -30, 30),
		math.random( 0, 0 )
	)

	local Teleport_NumParticles = 6

	local Teleport_emitter = ParticleEmitter( Teleport_vOffset, false )
	local Teleport_particle = Material("materials/pp_assets/particle_".."teleport"..math.random(1,2)..".png")

	for i = 0, Teleport_NumParticles do

		local Teleport_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Teleport_particle = Teleport_emitter:Add( Teleport_particle, Teleport_vOffset + Teleport_Pos * 8 )
		if ( Teleport_particle ) then
			Teleport_particle:SetAngles(Angle(0,0,90))
			Teleport_particle:SetLifeTime( 3 )
			Teleport_particle:SetDieTime( 10 )

			Teleport_particle:SetStartAlpha( 255 )
			Teleport_particle:SetEndAlpha( 0 )

			Teleport_particle:SetStartSize( 1 )
			Teleport_particle:SetEndSize( math.random(5,10) )

			Teleport_particle:SetRoll( 0 )
			Teleport_particle:SetRollDelta( 0 )

			Teleport_particle:SetAirResistance( 100 )
			Teleport_particle:SetGravity( Vector( 0, 0, math.random(20,40) ) )

			Teleport_particle:SetCollide( false )

			Teleport_particle:SetAngleVelocity( Angle( 0, math.random(-200,200), 0 ) )

			Teleport_particle:SetBounce( 1 )
			Teleport_particle:SetLighting( false )

			local lighting = math.random(100,255)
			Teleport_particle:SetColor( lighting, lighting, lighting )
		end

	end

	Teleport_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end