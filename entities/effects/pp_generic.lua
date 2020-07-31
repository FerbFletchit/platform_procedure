function EFFECT:Init( data )

	local generic_vOffset = data:GetOrigin() + Vector(
		math.random( -300, 300),
		math.random( -300, 300),
		math.random( 0, 100)
	)

	local generic_NumParticles = 1

	local generic_emitter = ParticleEmitter( generic_vOffset, true )
	local generic_particle = Material("materials/pp_assets/particle_".."generic"..".png")

	for i = 0, generic_NumParticles do

		local generic_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local generic_particle = generic_emitter:Add( generic_particle, generic_vOffset + generic_Pos * 8 )
		if ( generic_particle ) then

			--particle:generic_particle( Pos * 500 )

			generic_particle:SetLifeTime( 0 )
			generic_particle:SetDieTime( 10 )

			generic_particle:SetStartAlpha( math.random(100,200) )
			generic_particle:SetEndAlpha( 0 )

			local Size = math.Rand( 3, 4 )
			generic_particle:SetStartSize( Size )
			generic_particle:SetEndSize( 0 )

			generic_particle:SetRoll( math.Rand( 0, 90 ) )
			generic_particle:SetRollDelta( math.Rand( -0.1, 0.1 ) )

			generic_particle:SetAirResistance( 300 )
			generic_particle:SetGravity( Vector( 0, 0, -10 ) )

			generic_particle:SetCollide( true )

			generic_particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )

			generic_particle:SetBounce( 1 )
			generic_particle:SetLighting( true )

			generic_particle:SetColor( 0, 0, 50 )
		end

	end

	generic_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end