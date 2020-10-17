local was_ontop = mp.get_property_native("ontop")
local was_on_all_workspaces = mp.get_property_native("on-all-workspaces")

function on_fullscreen_change(name, value)
    local pause = mp.get_property_native("pause")
    if value == false then
        mp.set_property_native("ontop", was_ontop and not pause)
        mp.set_property_native("on-all-workspaces", was_on_all_workspaces)
        return
    end
    mp.set_property_native("ontop", false)
    mp.set_property_native("on-all-workspaces", false)
end

function on_pause_change(name, value)
    local fullscreen = mp.get_property_native("fullscreen")
    if value == false and not fullscreen then
        mp.set_property_native("ontop", was_ontop)
        return
    end
    mp.set_property_native("ontop", false)
end

mp.observe_property("pause", "bool", on_pause_change)

mp.observe_property("fullscreen", "bool", on_fullscreen_change)
