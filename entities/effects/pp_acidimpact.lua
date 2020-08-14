function EFFECT:Init( data )

	local acid_vOffset = data:GetOrigin() + Vector(
		math.random( -1, 1),
		math.random( -1, 1),
		math.random( 1, 1)
	)

	local acid_NumParticles = 1

	local acid_emitter = ParticleEmitter( acid_vOffset, false )
	local acid_particle = Material("materials/pp_assets/particle_".."acid"..math.random(1,3)..".png")

	for i = 0, acid_NumParticles do

		local acid_Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local acid_particle = acid_emitter:Add( acid_particle, acid_vOffset + acid_Pos * 8 )
		if ( acid_particle ) then

			--particle:acid_particle( Pos * 500 )

			acid_particle:SetLifeTime( 0 )
			acid_particle:SetDieTime( 5 )

			acid_particle:SetStartAlpha( math.random(200,255) )
			acid_particle:SetEndAlpha( 0 )

			local Size = math.Rand( 10, 15 )
			acid_particle:SetStartSize( Size )
			acid_particle:SetEndSize( 0 )

			acid_particle:SetRoll( math.Rand( 0, 90 ) )
			acid_particle:SetRollDelta( math.Rand( -0.1, 0.1 ) )

			acid_particle:SetAirResistance( 300 )
			acid_particle:SetGravity( Vector( 0, 0, -10 ) )

			acid_particle:SetCollide( true )

			acid_particle:SetVelocity( Vector( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )
			acid_particle:SetAngleVelocity( Angle( math.Rand( -5, 5 ), math.Rand( -5, 5 ), math.Rand( -5, 5 ) ) )

			acid_particle:SetBounce( 1 )
			acid_particle:SetLighting( false )

			acid_particle:SetColor( 255, 255, 255 )
		end

	end

	acid_emitter:Finish()

end

function EFFECT:Think()

end

function EFFECT:Render()

	--[[local ang = LocalPlayer():EyeAngles()

 
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )

	self:SetAngles(ang)]]
end