function EFFECT:Init( data )

	local Jump_vOffset = data:GetOrigin()

	local Jump_NumParticles = 10

	local Jump_emitter = ParticleEmitter( Jump_vOffset, true )
	local Jump_particle = Material("materials/pp_assets/particle_".."jump"..math.random(1,3)..".png")

	for i = 0, Jump_NumParticles do
		local Jump_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Jump_particle = Jump_emitter:Add( Jump_particle, Jump_vOffset + Jump_Pos * 8 )
		if ( Jump_particle ) then
			
			Jump_particle:SetLighting( true )
			Jump_particle:SetColor( math.random(0,60), math.random(0,60), math.random(0,60) )
			Jump_particle:SetLifeTime( math.random(1,2 ) )
			Jump_particle:SetDieTime( 10 )

			Jump_particle:SetStartAlpha( math.random(100,150) )
			Jump_particle:SetEndAlpha( 0 )

			Jump_particle:SetStartSize( math.random(1,2) )
			Jump_particle:SetEndSize( 0.5 )

			Jump_particle:SetRoll( 10 )
			Jump_particle:SetRollDelta( 0 )

			Jump_particle:SetAirResistance( 0 )
			Jump_particle:SetGravity( Vector( 0, 0, -50 ) )
			Jump_particle:SetVelocity( Vector( math.random(-50,50), math.random(-50,50), math.random(50,-100) ) )

			Jump_particle:SetCollide( true )

			Jump_particle:SetAngleVelocity( Angle( math.Rand( -360, 360 ), math.Rand( -360, 360 ), math.Rand( -360, 360 ) ) )

			Jump_particle:SetBounce( 2 )

		end

	end

	Jump_emitter:Finish()
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end