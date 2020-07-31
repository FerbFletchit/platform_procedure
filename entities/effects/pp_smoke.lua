--PP_ActionEffect(pos, "pp_smoke", 2) --2 is good for denser smoke, 1 for tiny smoke.

function EFFECT:Init( data )

	local Smoke_vOffset = function() return data:GetOrigin() + Vector(
		math.random( -20, 20),
		math.random( -20, 20),
		math.random( 0, 0)
	)
	end
	local Smoke_NumParticles = 10

	local Smoke_emitter = ParticleEmitter( Smoke_vOffset(), true )
	local Smoke_particle = Material("materials/pp_assets/particle_".."smoke"..math.random(1,4)..".png")

	for i = 0, Smoke_NumParticles do

		local Smoke_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Smoke_particle = Smoke_emitter:Add( Smoke_particle, Smoke_vOffset() + Smoke_Pos * 8 )
		if ( Smoke_particle ) then
			Smoke_particle:SetAngles( Angle( 0, math.Rand( -50, 50 ), math.Rand( -10, 10 ) ))
			Smoke_particle:SetLifeTime( math.random(1,5) )
			Smoke_particle:SetDieTime( 10 )

			Smoke_particle:SetStartAlpha( 100 )
			Smoke_particle:SetEndAlpha( 0 )

			Smoke_particle:SetStartSize( math.random(15,25) )
			Smoke_particle:SetEndSize( 1 )

			Smoke_particle:SetRoll( 0 )
			Smoke_particle:SetRollDelta( math.random(1,50) )

			Smoke_particle:SetAirResistance( 300 )
			Smoke_particle:SetGravity( Vector( 0, 0, math.random(10,20) ) )

			Smoke_particle:SetCollide( false )
			Smoke_particle:SetAngleVelocity( Angle( 0, math.Rand( -50, 50 ), math.Rand( -10, 10 ) ) )

			Smoke_particle:SetBounce( 1 )
			Smoke_particle:SetLighting( false )

			Smoke_particle:SetColor( 255, 255, 255 )
		end

	end

	Smoke_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end