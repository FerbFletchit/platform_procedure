function EFFECT:Init( data )

	local defusal_vOffset = data:GetOrigin() + Vector(
		math.random( -25, 25),
		math.random( -25, 25),
		math.random( 20, 25)
	)

	local defusal_NumParticles = 1

	local defusal_emitter = ParticleEmitter( defusal_vOffset, false )
	local defusal_particle = Material("materials/pp_assets/particle_".."defuse"..math.random(1,3)..".png")

	for i = 0, defusal_NumParticles do

		local defusal_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local defusal_particle = defusal_emitter:Add( defusal_particle, defusal_vOffset + defusal_Pos * 8 )
		if ( defusal_particle ) then

			defusal_particle:SetAngles( Angle( 0, math.Rand( -50, 50 ), -90+math.Rand( -10, 10 ) ))

			defusal_particle:SetLifeTime( 0 )
			defusal_particle:SetDieTime( math.random(5,8) )

			defusal_particle:SetStartAlpha( 0 )
			defusal_particle:SetEndAlpha( math.Rand(200,220) )

			defusal_particle:SetStartSize( 0 )
			defusal_particle:SetEndSize( math.Rand(1,3) )

			defusal_particle:SetRoll( 0 )
			defusal_particle:SetRollDelta( 0 )

			defusal_particle:SetAirResistance( 300 )
			defusal_particle:SetGravity( Vector( 0, 0, 10 ) )

			defusal_particle:SetCollide( false )

			defusal_particle:SetAngleVelocity( Angle( 0, math.Rand( -180, 180 ), 0 ) )

			defusal_particle:SetBounce( 1 )
			defusal_particle:SetLighting( true )

			defusal_particle:SetColor( math.random(212,222), math.random(175,185), math.random(55,65) )
		end

	end

	defusal_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end