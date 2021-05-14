--[[
	cl_deathscreen.lua
	Handles networking events and rendering of the deathscreen
]]--

print("RedFox0x20 TTT Deathscreen loaded")

include("sh_deathscreen_config.lua")

DeathScreen = DeathScreen or {}
DeathScreen.DeathMessage = nil

surface.CreateFont("deathscreen_font", {font = "Tahoma", size=21, weight = 1000,
		antialias = true})

hook.Add("HUDPaint", "Deathscreen_hud", 
	function()
		local ply = LocalPlayer()
		if (not ply:Alive() and DeathScreen.DeathMessage) then
			
			surface.SetFont("deathscreen_font")
			local TextWidth, TextHeight =
			surface.GetTextSize(DeathScreen.DeathMessage or "You are dead")
			
			local ScreenWidth = ScrW()
			local ScreenHeight = ScrH()
			local Padding = 10
			local DrawX = (ScreenWidth/2) - (TextWidth / 2) - Padding
			local DrawW = TextWidth + (Padding * 2)
			local DrawY = 50
			local DrawH = TextHeight + (Padding * 2)

			surface.SetDrawColor(DeathScreen.panel_color:Unpack())
			surface.DrawRect(DrawX, DrawY, DrawW, DrawH)
			
			surface.SetTextColor(DeathScreen.text_color:Unpack())
			surface.SetTextPos(DrawX + Padding, DrawY + Padding)
			surface.DrawText(DeathScreen.DeathMessage or "You are dead")
		end
	end)

function ReceivedDeathMessage(len, sv)
	DeathScreen.DeathMessage = net.ReadString()
	print("Received deathscreen_msg: " .. tostring(DeathMessage))
end

net.Receive("Deathscreen_msg", ReceivedDeathMessage)
