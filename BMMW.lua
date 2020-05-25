local font = surface.SetupFont("-", 18, 600, 0, 0, 0x090)
local font1 = surface.SetupFont("Tw Cen MT", 15, 500, 0, 0, 0x090)

local m_iHealth = client.GetNetvar("DT_BasePlayer", "m_iHealth")
local m_bPinPulled = client.GetNetvar("DT_BaseCSGrenade", "m_bPinPulled")
local m_fThrowTime = client.GetNetvar("DT_BaseCSGrenade", "m_fThrowTime")
local m_fFlags = client.GetNetvar("DT_BasePlayer", "m_fFlags")
local m_vecVelocity = client.GetNetvar("DT_BasePlayer", "m_vecVelocity[0]")

function hasbit(x, p)
    return x % (p + p) >= p
end
 
local m_iSide = 0

local screenW, screenH = engine.GetScreenSize()
local iAlpha = 225
local iBoolAlpha = false

local function oCreateMove(pCmd)
      
    local LocalPlayer = entitylist.GetLocalPlayer()
    if not LocalPlayer:IsValidPtr() then return end

    if LocalPlayer:GetPropInt(m_iHealth) < 1 then return end
    local iWeapon = LocalPlayer:GetWeapon()
    if not iWeapon:IsValidPtr() then return end

    if iWeapon:IsGrenade() then
        local throwTime = iWeapon:GetPropFloat(m_fThrowTime)

        if not iWeapon:GetPropBool(m_bPinPulled) then
            if throwTime > 0 then
                return
            end
        end

        if hasbit(pCmd.buttons, 1) or hasbit(pCmd.buttons, 2048) then
            if throwTime > 0 then
                return
            end
        end
    end

    if hasbit(pCmd.buttons, 32) then return end
    if hasbit(pCmd.buttons, 1) then return end

    --CHECKOUT
  
    if client.IsKeyPressed(0x5A) then 
        m_iSide = 1     
    end
  

    if client.IsKeyPressed(0x43) then 
        m_iSide = 2
    end

    if client.IsKeyPressed(0x58) then 
        m_iSide = 3
    end 
    --BEGIN
  
    --LEFT
    if m_iSide == 1 then
        pCmd.viewangles.yaw = pCmd.viewangles.yaw - 90
    end 
  
    --RIGHT 
    if m_iSide == 2 then
        pCmd.viewangles.yaw = pCmd.viewangles.yaw + 90 
    end
  
    --BACKWARDS 
    if m_iBackward == 3 then
        pCmd.viewangles.yaw = pCmd.viewangles.yaw + 180  
    end
	

end

local function onPaint()
    local LocalPlayer = engine.GetLocalPlayer()
    local ThisPlayer = entitylist.GetPlayerByIndex(LocalPlayer) 
    if ThisPlayer:GetPropInt(m_iHealth) < 0 then
        local iAlpha = 225
        local iBoolAlpha = false
    return end
  
    surface.DrawSetTextFont(font)

    if iBoolAlpha == false then    iAlpha = iAlpha - 1
    end     
    if iAlpha == 1 then    iBoolAlpha = true
    end 
    if iBoolAlpha == true then    iAlpha = iAlpha + 1
    end 
    if iAlpha == 255 then    iBoolAlpha = false
    end

    if ThisPlayer:GetPropInt(m_iHealth) > 0 then 
        if m_iSide == 1 then
            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2-8, screenH/2+15)
            surface.DrawPrintText("˅")
          
            surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2-45, screenH/2-16)
            surface.DrawPrintText("˂")

            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2+30, screenH/2-16)
            surface.DrawPrintText("˃")

	    surface.DrawSetTextFont(font1)
	    surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2+6, screenH/2+41)
	    surface.DrawPrintText("LEFT")
	    
        end 
        if m_iSide == 2 then
            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2-8, screenH/2+15)
            surface.DrawPrintText("˅")
          
            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2-45, screenH/2-16)
            surface.DrawPrintText("˂")

            surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2+30, screenH/2-16)
            surface.DrawPrintText("˃")

	    surface.DrawSetTextFont(font1)
	    surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2+6, screenH/2+41)
	    surface.DrawPrintText("RIGHT")
        end 
        if m_iSide == 3 then
            surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2-8, screenH/2+15)
            surface.DrawPrintText("˅")
          
            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2-45, screenH/2-16)
            surface.DrawPrintText("˂")

            surface.DrawSetTextColor(255, 255, 255, 255)
            surface.DrawSetTextPos(screenW/2+30, screenH/2-16)
            surface.DrawPrintText("˃") 

	    surface.DrawSetTextFont(font1)
	    surface.DrawSetTextColor(130, 165, 245, 255)
            surface.DrawSetTextPos(screenW/2+6, screenH/2+41)
	    surface.DrawPrintText("BACK")                   
        end        
    end 
end

client.RegisterCallback("CreateMovement", oCreateMove)
client.RegisterCallback("Paint", onPaint)


--mindamage
local font = surface.setup_font("Tw Cen MT", 15, 500, 0, 0, 0x090)
local screen_w, screen_h = engine.Get_Screen_Size()
local m_iHealth = client.Get_Netvar("DT_BasePlayer", "m_iHealth")
ui.KeyBind("min.damage override", "rb_min_damage_key", 0)
ui.Checkbox("draw indicator", "rb_min_damage_indicator", false)
ui.add_slider_int("auto", "rb_min_damage_auto", 0, 100, 1)
ui.add_slider_int("awp", "rb_min_damage_awp", 0, 100, 40)
ui.add_slider_int("scout", "rb_min_damage_scout", 0, 100, 25)
ui.add_slider_int("revolver", "rb_min_damage_revolver", 0, 100, 100)
ui.Set_Int("rb_min_damage_key_type", 1)
-- pizdec | save old damage
local current_auto_damage = ui.Get_Int("ragebot_auto_min_damage")
local current_awp_damage = ui.Get_Int("ragebot_awp_min_damage")
local current_scout_damage = ui.Get_Int("ragebot_scout_min_damage")
local current_revolver_damage = ui.Get_Int("ragebot_revolver_min_damage")
local function get_dmg(weapon)
    return ui.Get_Int("rb_min_damage_" .. weapon)
end
-- createMove
local function on_move1()
    local is_pressed = ui.get_bind_state("rb_min_damage_key")
    if is_pressed then
        ui.Set_Int("ragebot_auto_min_damage", get_dmg("auto"))
        ui.Set_Int("ragebot_awp_min_damage", get_dmg("awp"))
        ui.Set_Int("ragebot_scout_min_damage", get_dmg("scout"))
        ui.Set_Int("ragebot_revolver_min_damage", get_dmg("revolver"))
    else
        ui.Set_Int("ragebot_auto_min_damage", current_auto_damage)
        ui.Set_Int("ragebot_awp_min_damage", current_awp_damage)
        ui.Set_Int("ragebot_scout_min_damage", current_scout_damage)
        ui.Set_Int("ragebot_revolver_min_damage", current_revolver_damage)
    end
end
-- paint
local function on_paint1()
    local local_player = engine.Get_Local_Player()
    local me = entitylist.GetPlayerByIndex(local_player)
    if me:GetPropInt(m_iHealth) < 0 or not engine.IsInGame() then 
        return
    end
    local is_pressed = ui.get_bind_state("rb_min_damage_key")
    local draw_indicator = ui.Get_Bool("rb_min_damage_indicator")
    if draw_indicator then
        surface.Draw_Set_Text_Font(font)
        if is_pressed then
            surface.Draw_Set_Text_Color(255, 255, 255, 255)
        else
            surface.Draw_Set_Text_Color(0, 0, 0, 0)
        end
        surface.Draw_Set_Text_Pos(screen_w/2+6, screen_h/2+74)
        surface.Draw_Print_Text("DMG")
    end
end
client.Register_Callback("CreateMovement", on_move1)
client.Register_Callback("Paint", on_paint1);

--baim
local font = surface.setup_font("Tw Cen MT", 15, 500, 0, 0, 0x090)
local m_iHealth = client.Get_Netvar("DT_BasePlayer", "m_iHealth")

local screenW, screenH = engine.Get_Screen_Size()
local iAlpha = 225
local iBoolAlpha = false

local g_inverse = false
local clicked = false
local pressed = false

local function handle_clicks()
    if pressed then clicked = false end
    if client.IsKeyPressed(0x5) then if not pressed then clicked = true end  pressed = true --бинд тут меняешь
    else pressed = false clicked = false end
end

local function onMove(UserCmd)
    handle_clicks()

    if clicked then
        g_inverse = not g_inverse
    end

    --YOUR WEAPON
    if g_inverse then
        --ui.Set_Bool("ragebot_auto_prefer_baim", true)
        ui.Set_Bool("ragebot_auto_head_enabled", false)
        ui.Set_Bool("ragebot_scout_head_enabled", false)
        ui.Set_Bool("ragebot_awp_head_enabled", false)
        ui.Set_Bool("ragebot_revolver_head_enabled", false)
        ui.Set_Bool("ragebot_deagle_head_enabled", false)
        ui.Set_Bool("ragebot_pistols_head_enabled", false)
        ui.Set_Bool("ragebot_rifle_head_enabled", false)
    else
        --setup by yourself depended on config
        --ui.Set_Bool("ragebot_auto_prefer_baim", false)
        ui.Set_Bool("ragebot_auto_head_enabled", true)
        ui.Set_Bool("ragebot_scout_head_enabled", true)
        ui.Set_Bool("ragebot_awp_head_enabled", true)
        ui.Set_Bool("ragebot_revolver_head_enabled", true)
        ui.Set_Bool("ragebot_deagle_head_enabled", true)
        ui.Set_Bool("ragebot_pistols_head_enabled", true)
        ui.Set_Bool("ragebot_rifle_head_enabled", true)
    end   
end

local function onPaint()
    local LocalPlayer = engine.Get_Local_Player()
    local ThisPlayer = entitylist.GetPlayerByIndex(LocalPlayer)
    if ThisPlayer:GetPropInt(m_iHealth) < 0 then
        local iAlpha = 225
        local iBoolAlpha = false
    return end

    surface.Draw_Set_Text_Font(font)

    if iBoolAlpha == false then    iAlpha = iAlpha - 1
    end   
    if iAlpha == 1 then    iBoolAlpha = true
    end
    if iBoolAlpha == true then    iAlpha = iAlpha + 1
    end
    if iAlpha == 255 then    iBoolAlpha = false
    end

    if ThisPlayer:GetPropInt(m_iHealth) > 0 then

        --SETUP YOUR SETTINGS HERE
        local iValueBaimScar = ui.Get_Bool("ragebot_auto_head_enabled")
        if iValueBaimScar  == false then
            surface.Draw_Set_Text_Color(255, 255, 255, 255)
        else
            surface.Draw_Set_Text_Color(0, 0, 0, 0)   
        end

        surface.Draw_Set_Text_Pos(screenW/2+6, screenH/2+63)
        surface.Draw_Print_Text("BAIM")
    end
end

client.Register_Callback("CreateMovement", onMove2)
client.Register_Callback("Paint", onPaint2)
client.Register_Callback("Paint", paint2)

--watermark
local font = surface.setup_font("Tw Cen MT", 15, 500, 0, 0, 0x090);

local frame_rate = 0.0
local get_abs_fps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globalvars.get_absolute_frametime()
    return math.floor((1.0 / frame_rate) + 0.5)
end

local function box(x, y, w, h, r, g, b, a)
    surface.draw_set_color(r, g, b, a)
    surface.draw_line(x, y, x, y + h)
    surface.draw_line(x, y + h, x + w + 1, y + h)
    surface.draw_line(x + w, y, x + w, y + h)
    surface.draw_line(x, y, x + w, y)
end

local textSize = 0

local kills = {}
local deaths = {}

local function KillDeathCount(event)
	local local_player = engine.Get_Local_Player( );
	local INDEX_Attacker = engine.GetPlayerIndexByUserID( event:GetInt( 'attacker', 0 ) );
	local INDEX_Victim = engine.GetPlayerIndexByUserID( event:GetInt( 'userid', 0 ) );


	if (event:Get_Name( ) == "client_disconnect") or (event:Get_Name( ) == "begin_new_match") then
		kills = {}
		deaths = {}
	end

	if event:Get_Name( ) == "player_death" then
		if INDEX_Attacker == local_player then
			kills[#kills + 1] = {};
		end
		
		if (INDEX_Victim == local_player) then
			deaths[#deaths + 1] = {};
		end

	end
end

local function paint3()
    ui.Set_Bool("visuals_other_watermark", false)
    
    local screenW, screenH = engine.Get_Screen_Size()

	local latency = client.Get_Latency()
	local latency1 = latency*100
	local a = string.format("%2.1f", latency1)
	local b = a*10
	local v = b/2

    local hour, min, sec = client.Get_System_Time()
    if hour < 10 then hour = "0" .. hour end
    if min < 10 then min = "0" .. min end
    if sec < 10 then sec = "0" .. sec end

    local rightPadding = 20
    local var = screenW - textSize - rightPadding

    local x = var - 10 local y = 9
    local w = textSize + 20 local h = 20

    surface.draw_set_color(30, 30, 38, 80)
    surface.Draw_Filled_Rect(x, y, x + textSize + 20, h * 1.5)
    
	surface.draw_set_color(130, 165, 245, 255)
    surface.Draw_Filled_Rect(x, y, x + textSize + 20, h - 9)
    
	local nexttext = "skeet.cc"
    surface.Draw_Set_Text_Color(255, 255, 255, 255)
    surface.Draw_Set_Text_Font(font)
    surface.Draw_Set_Text_Pos(var, 13)
    surface.Draw_Print_Text(nexttext)

    local wide, tall = surface.Get_Text_Size(font, nexttext)
    var = var + wide

    local username = string.lower(client.Get_Username())
    nexttext = " | " .. username
    surface.Draw_Set_Text_Color(255, 255, 255, 255)
    surface.Draw_Set_Text_Font(font)
    surface.Draw_Set_Text_Pos(var, 13)
    surface.Draw_Print_Text(nexttext)

    wide, tall = surface.Get_Text_Size(font, (nexttext))
    var = var + wide

    nexttext = " | delay: " .. b
    surface.Draw_Set_Text_Color(255, 255, 255, 255)
    surface.Draw_Set_Text_Font(font)
    surface.Draw_Set_Text_Pos(var, 13)
    surface.Draw_Print_Text(nexttext)

    wide, tall = surface.Get_Text_Size(font, nexttext)
    var = var + wide

    nexttext = " | 64tick"
    surface.Draw_Set_Text_Color(255, 255, 255, 255)
    surface.Draw_Set_Text_Font(font)
    surface.Draw_Set_Text_Pos(var, 13)
    surface.Draw_Print_Text(nexttext)

    wide, tall = surface.Get_Text_Size(font, nexttext)
    var = var + wide

    nexttext = " | " .. hour .. ":" .. min .. ":" .. sec
    surface.Draw_Set_Text_Color(255, 255, 255, 255)
    surface.Draw_Set_Text_Font(font)
    surface.Draw_Set_Text_Pos(var, 13)
    surface.Draw_Print_Text(nexttext)

    wide, tall = surface.Get_Text_Size(font, nexttext)
    var = var + wide
	    

	
	textSize = var - (screenW - textSize - rightPadding)
end

client.Register_Callback("Paint", paint3)


local font = surface.setup_font("Tw Cen MT", 15, 500, 0, 0, 0x090)
local m_iHealth = client.Get_Netvar("DT_BasePlayer", "m_iHealth")

local screenW, screenH = engine.Get_Screen_Size()
local iAlpha = 225
local iBoolAlpha = false

local function onPaint3()
	local LocalPlayer = engine.Get_Local_Player()
	local ThisPlayer = entitylist.get_entity_by_index(LocalPlayer)	
	if ThisPlayer:GetPropInt(m_iHealth) < 0 then
		local iAlpha = 225
		local iBoolAlpha = false
	return end
	
	local CurSpeed = ThisPlayer:GetVelocity()
	local Velocity2D = CurSpeed:Length2D()
	local OnMove = Velocity2D < 150	
	
	surface.Draw_Set_Text_Font(font)

	if iBoolAlpha == false then	iAlpha = iAlpha - 1
	end		
	if iAlpha == 1 then	iBoolAlpha = true
	end	
	if iBoolAlpha == true then	iAlpha = iAlpha + 1
	end	
	if iAlpha == 255 then	iBoolAlpha = false
	end
	
	if ThisPlayer:GetPropInt(m_iHealth) > 0 then

	
		--AA mode
		if OnMove then
			surface.Draw_Set_Text_Color(130, 165, 245, 255)
		else
			surface.Draw_Set_Text_Color(130, 165, 245, 255)
		end
	
		surface.Draw_Set_Text_Pos(screenW/2+6, screenH/2+30)
		surface.Draw_Print_Text("OPOSITE")
	
		--DT on check
		local iDT = ui.Get_Bool("ragebot_auto_doubletap")
		if iDT == true and OnMove then
			surface.Draw_Set_Text_Color(127, 255, 0, 255)
		else
			surface.Draw_Set_Text_Color(255, 50, 50, 255)		
		end	
	
		surface.Draw_Set_Text_Pos(screenW/2+6, screenH/2+52)
		surface.Draw_Print_Text("DT")



	end
end


client.Register_Callback("Paint", onPaint3)