--PP_ActionEffect(pos, "pp_Heal", 1)
function EFFECT:Init( data )
	local Heal_vOffset = data:GetOrigin() + Vector(
		math.random( -25, 25),
		math.random( -25, 25),
		math.random( 0, 25 )
	)

	local Heal_NumParticles = 6

	local Heal_emitter = ParticleEmitter( Heal_vOffset, true )
	local Heal_particle = Material("materials/pp_assets/particle_".."heal"..math.random(1,3)..".png")

	for i = 0, Heal_NumParticles do

		local Heal_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local Heal_particle = Heal_emitter:Add( Heal_particle, Heal_vOffset + Heal_Pos * 8 )
		if ( Heal_particle ) then
			Heal_particle:SetAngles(Angle(0,0,90))
			Heal_particle:SetLifeTime( 3 )
			Heal_particle:SetDieTime( 10 )

			Heal_particle:SetStartAlpha( 255 )
			Heal_particle:SetEndAlpha( 0 )

			Heal_particle:SetStartSize( 5 )
			Heal_particle:SetEndSize( math.random(5,7) )

			Heal_particle:SetRoll( 0 )
			Heal_particle:SetRollDelta( 0 )

			Heal_particle:SetAirResistance( 100 )
			Heal_particle:SetGravity( Vector( 0, 0, math.random(20,40) ) )

			Heal_particle:SetCollide( false )

			Heal_particle:SetAngleVelocity( Angle( 0, math.random(-200,200), 0 ) )

			Heal_particle:SetBounce( 1 )
			Heal_particle:SetLighting( false )

			local lighting = math.random(-5,5)
			Heal_particle:SetColor( 52+lighting, 183+lighting, 26+lighting )
		end

	end

	Heal_emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end