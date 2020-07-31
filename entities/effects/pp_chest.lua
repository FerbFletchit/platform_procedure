function EFFECT:Init( data )

	local chest_vOffset = data:GetOrigin() + Vector(
		math.random( -25, 25),
		math.random( -25, 25),
		math.random( 20, 25)
	)

	local chest_NumParticles = 1

	local chest_emitter = ParticleEmitter( chest_vOffset, true )
	local chest_particle = Material("materials/pp_assets/particle_".."chest"..math.random(1,3)..".png")

	for i = 0, chest_NumParticles do

		local chest_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local chest_particle = chest_emitter:Add( chest_particle, chest_vOffset + chest_Pos * 8 )
		if ( chest_particle ) then

			chest_particle:SetLifeTime( 3 )
			chest_particle:SetDieTime( 10 )

			chest_particle:SetStartAlpha( 0 )
			chest_particle:SetEndAlpha( 255 )

			chest_particle:SetStartSize( 3 )
			chest_particle:SetEndSize( 1 )

			chest_particle:SetRoll( 0 )
			chest_particle:SetRollDelta( 0 )

			chest_particle:SetAirResistance( 300 )
			chest_particle:SetGravity( Vector( 0, 0, 10 ) )

			chest_particle:SetCollide( false )

			chest_particle:SetAngleVelocity( Angle( 0, math.Rand( -180, 180 ), 0 ) )

			chest_particle:SetBounce( 1 )
			chest_particle:SetLighting( true )

			chest_particle:SetColor( math.random(212,222), math.random(175,185), math.random(55,65) )
		end

	end

	chest_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end