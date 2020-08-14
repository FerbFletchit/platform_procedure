function EFFECT:Init( data )

	local Ritual_vOffset = data:GetOrigin() + Vector(
		math.random( -300, 300),
		math.random( -300, 300),
		math.random( 0, 100)
	)

	local Ritual_NumParticles = 1

	local Ritual_emitter = ParticleEmitter( Ritual_vOffset, true )
	local Ritual_particle = Material("materials/pp_assets/particle_".."ritual"..math.random(1,7)..".png")

	for i = 0, Ritual_NumParticles do

		local Ritual_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Ritual_particle = Ritual_emitter:Add( Ritual_particle, Ritual_vOffset + Ritual_Pos * 8 )
		if ( Ritual_particle ) then

			--particle:Ritual_particle( Pos * 500 )

			Ritual_particle:SetLifeTime( 0 )
			Ritual_particle:SetDieTime( 10 )

			Ritual_particle:SetStartAlpha( math.random(100,200) )
			Ritual_particle:SetEndAlpha( 0 )

			local Size = math.Rand( 5, 10 )
			Ritual_particle:SetStartSize( Size )
			Ritual_particle:SetEndSize( Size/2 )

			Ritual_particle:SetRoll( math.Rand( -90, 90 ) )
			Ritual_particle:SetRollDelta( math.Rand( -0.3, 0.3 ) )

			Ritual_particle:SetAirResistance( 300 )
			Ritual_particle:SetGravity( Vector( 0, 0, -10 ) )

			Ritual_particle:SetCollide( true )

			Ritual_particle:SetAngleVelocity( Angle( math.Rand( -10, 10 ), math.Rand( -10, 10 ), math.Rand( -10, 10 ) ) )

			Ritual_particle:SetBounce( 1 )
			Ritual_particle:SetLighting( true )

			local lighting = math.random(100,200)
			Ritual_particle:SetColor(lighting, lighting, lighting )
		end

	end

	Ritual_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end