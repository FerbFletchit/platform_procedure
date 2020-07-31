function EFFECT:Init( data )

	local enemy_spawn_vOffset = data:GetOrigin() + Vector(
		math.random( -10, 10),
		math.random( -10, 10),
		math.random( 0, 10)
	)

	local enemy_spawn_NumParticles = math.random(3,5)

	local enemy_spawn_emitter = ParticleEmitter( enemy_spawn_vOffset, true )
	local enemy_spawn_particle = Material("materials/pp_assets/particle_".."enemy_spawn"..".png")

	for i = 0, enemy_spawn_NumParticles do

		local enemy_spawn_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local enemy_spawn_particle = enemy_spawn_emitter:Add( enemy_spawn_particle, enemy_spawn_vOffset + enemy_spawn_Pos * 8 )
		if ( enemy_spawn_particle ) then

			enemy_spawn_particle:SetLifeTime( 0 )
			enemy_spawn_particle:SetDieTime( 10 )

			enemy_spawn_particle:SetStartAlpha( math.random(100,200) )
			enemy_spawn_particle:SetEndAlpha( 0 )

			local Size = math.Rand( 3, 4 )
			enemy_spawn_particle:SetStartSize( Size )
			enemy_spawn_particle:SetEndSize( 0 )

			enemy_spawn_particle:SetRoll( math.Rand( 0, 90 ) )
			enemy_spawn_particle:SetRollDelta( math.Rand( -0.1, 0.1 ) )

			enemy_spawn_particle:SetAirResistance( 300 )
			enemy_spawn_particle:SetGravity( Vector( 0, 0, -10 ) )

			enemy_spawn_particle:SetCollide( true )

			enemy_spawn_particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )

			enemy_spawn_particle:SetBounce( 1 )
			enemy_spawn_particle:SetLighting( true )

			enemy_spawn_particle:SetColor( math.random(138,148), math.random(0,10), math.random(200,211) )
		end

	end

	enemy_spawn_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end