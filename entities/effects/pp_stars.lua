function EFFECT:Init( data )

	local Stars_vOffset = function() return data:GetOrigin() + VectorRand(-PP["Stars"]["Radius"],PP["Stars"]["Radius"])
end

	local Stars_NumParticles = PP["Stars"]["Amount"]

	local Stars_emitter = ParticleEmitter( Stars_vOffset(), true )
	local Stars_particle = Material("materials/pp_assets/particle_chest3.png")

	for i = 0, Stars_NumParticles do

		local Stars_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Stars_particle = Stars_emitter:Add( Stars_particle, Stars_vOffset() + Stars_Pos * 8 )
		if ( Stars_particle ) then

			--particle:Stars_particle( Pos * 500 )

			Stars_particle:SetLifeTime( 10000000000 )
			Stars_particle:SetDieTime( 100000000000 )

			Stars_particle:SetStartAlpha( math.random(100,150) )
			Stars_particle:SetEndAlpha( 0 )

			local Size = PP["Stars"]["Size"]()
			Stars_particle:SetStartSize( Size )
			Stars_particle:SetEndSize( Size )

			Stars_particle:SetRoll( math.Rand( -90, 90 ) )
			Stars_particle:SetRollDelta( math.Rand( -0.3, 0.3 ) )

			Stars_particle:SetAirResistance( 300 )
			Stars_particle:SetGravity( Vector( 0, 0, 0 ) )

			Stars_particle:SetCollide( true )

			Stars_particle:SetAngleVelocity( Angle( math.Rand( -10, 10 ), math.Rand( -10, 10 ), math.Rand( -10, 10 ) ) )

			Stars_particle:SetBounce( 1 )
			Stars_particle:SetLighting( false )

			local lighting = math.random(0,100)
			Stars_particle:SetColor(lighting, lighting, lighting )
		end

	end

	Stars_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end