--PP_ActionEffect(pos, "pp_Fire", 2) --2 is good for denser Fire, 1 for tiny Fire.

function EFFECT:Init( data )

	local Fire_vOffset = function() return data:GetOrigin() + Vector(
		math.random( -20, 20),
		math.random( -20, 20),
		math.random( 0, 20)
	)
	end
	local Fire_NumParticles = 15

	local Fire_emitter = ParticleEmitter( Fire_vOffset(), true )
	local Fire_particle = Material("materials/pp_assets/particle_".."fire"..math.random(1,2)..".png")

	for i = 0, Fire_NumParticles do

		local Fire_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Fire_particle = Fire_emitter:Add( Fire_particle, Fire_vOffset() + Fire_Pos * 8 )
		if ( Fire_particle ) then
			Fire_particle:SetAngles( Angle( 0, math.Rand( -50, 50 ), 90+math.Rand( -10, 10 ) ))
			Fire_particle:SetLifeTime( math.random(1,5) )
			Fire_particle:SetDieTime( 10 )

			Fire_particle:SetStartAlpha( 255 )
			Fire_particle:SetEndAlpha( 0 )

			Fire_particle:SetStartSize( math.random(10,15) )
			Fire_particle:SetEndSize( 1 )

			Fire_particle:SetRoll( 0 )
			Fire_particle:SetRollDelta( math.random(1,50) )

			Fire_particle:SetAirResistance( 100 )
			Fire_particle:SetGravity( Vector( 0, 0, math.random(0,10) ) )

			Fire_particle:SetCollide( false )
			Fire_particle:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -50, 50 ), 0 ) )

			Fire_particle:SetBounce( 1 )
			Fire_particle:SetLighting( false )

			local light = math.random(200,255)
			Fire_particle:SetColor( light, light, light )
		end

	end

	Fire_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end