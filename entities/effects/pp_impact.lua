function EFFECT:Init( data )

	local Impact_vOffset = data:GetOrigin()

	local Impact_NumParticles = 20

	local Impact_emitter = ParticleEmitter( Impact_vOffset, true )
	local Impact_particle = Material("materials/pp_assets/particle_".."impact"..".png")

	for i = 0, Impact_NumParticles do
		local Impact_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Impact_particle = Impact_emitter:Add( Impact_particle, Impact_vOffset + Impact_Pos * 8 )
		if ( Impact_particle ) then
			Impact_particle:SetLighting( true )
			Impact_particle:SetColor( 0, 0, 0 )
			Impact_particle:SetLifeTime( 3 )
			Impact_particle:SetDieTime( 10 )

			Impact_particle:SetStartAlpha( 255 )
			Impact_particle:SetEndAlpha( 0 )

			Impact_particle:SetStartSize( 2 )
			Impact_particle:SetEndSize( 1 )

			Impact_particle:SetRoll( 10 )
			Impact_particle:SetRollDelta( 0 )

			Impact_particle:SetAirResistance( 0 )
			Impact_particle:SetGravity( Vector( 0, 0, -50 ) )
			Impact_particle:SetVelocity( Vector( math.random(-50,50), math.random(-50,50), math.random(50,-100) ) )

			Impact_particle:SetCollide( true )

			Impact_particle:SetAngleVelocity( Angle( math.Rand( -360, 360 ), math.Rand( -360, 360 ), math.Rand( -360, 360 ) ) )

			Impact_particle:SetBounce( 0 )

		end

	end

	Impact_emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end