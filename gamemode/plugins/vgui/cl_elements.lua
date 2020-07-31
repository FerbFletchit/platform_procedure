function PP_DrawShadowedTxt(text,font,x,y,align,align2,color) -- Function for creating shadowed text. 
	draw.SimpleText(text, font, x+2, y+6, PP["Color_Pallete"]["Dark"], align, align2 )
	draw.SimpleText(text, font, x, y, color, align, align2 )
end

function PP_DrawShadowedLightTxt(text,font,x,y,align,color) -- Function for creating shadowed text. 
	draw.SimpleText(text, font, x+2, y+2, PP["Color_Pallete"]["Dark"], align, TEXT_ALIGN_CENTER )
	draw.SimpleText(text, font, x, y, color, align, TEXT_ALIGN_CENTER )
end

function PP_DrawText(text,font,x,y,align,color) -- Function for creating text. 
	draw.SimpleText(text, font, x, y, color, align, TEXT_ALIGN_CENTER )
end