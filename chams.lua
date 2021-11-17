local client_set_event_callback, globals_realtime, materialsystem_find_materials, ui_get, ui_new_checkbox, ui_new_color_picker, ui_new_slider = client.set_event_callback, globals.realtime, materialsystem.find_materials, ui.get, ui.new_checkbox, ui.new_color_picker, ui.new_slider

local knife = {
    enable = ui_new_checkbox("SKINS", "Knife options", "Animated chams"),
    wireframe = ui_new_checkbox("SKINS", "Knife options", "Wireframe"),
    color = ui_new_color_picker("SKINS", "Knife options", "Animation color"),
    size = ui_new_slider("SKINS", "Knife options", "Material size", 1 , 10),
    speed = ui_new_slider("SKINS", "Knife options", "Animation speed", 1 , 10)
}

local arm = {
    enable = ui_new_checkbox("SKINS", "Glove options", "Animated chams"),
    wireframe = ui_new_checkbox("SKINS", "Glove options", "Wireframe"),
    color = ui_new_color_picker("SKINS", "Glove options", "Animation color"),
    size = ui_new_slider("SKINS", "Glove options", "Material size", 1 , 10),
    speed = ui_new_slider("SKINS", "Glove options", "Animation speed", 1 , 10)
}

client_set_event_callback("pre_render", function(ctx)
    local kr,kg,kb = ui_get(knife.color)
    local kniferealtime = globals_realtime() * ui_get(knife.speed) / 10 % 1
    local knifematerial = materialsystem_find_materials("knife")

    local ar,ag,ab = ui_get(arm.color)
    local armrealtime = globals_realtime() * ui_get(arm.speed) / 10 % 1
    local armsmaterial = materialsystem_find_materials("arm")

    if knifematerial == nil or armsmaterial == nil then return end

    if ui_get(knife.enable) then
        for i=#knifematerial, 1, -1 do
            knifematerial[i]:set_material_var_flag(28, ui_get(knife.wireframe))
            knifematerial[i]:set_shader_param("$basetexture", "dev/zone_warning")
            knifematerial[i]:set_shader_param("$basetexturetransform", ui_get(knife.size)/10, kniferealtime, kniferealtime)
            knifematerial[i]:color_modulate(kr, kg, kb)
        end
    end
    if ui_get(arm.enable) then
        for i=#armsmaterial, 1, -1 do
            armsmaterial[i]:set_material_var_flag(28, ui_get(arm.wireframe))
            armsmaterial[i]:set_shader_param("$basetexture", "dev/zone_warning")
            armsmaterial[i]:set_shader_param("$basetexturetransform", ui_get(arm.size)/10, armrealtime, armrealtime)
            armsmaterial[i]:color_modulate(ar, ag, ab)
        end
    end
end) 
