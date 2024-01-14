local populateSaveSlotsOld

local function init( modApi )
    modApi.requirements = {"Sim Constructor"}
end

local function load( modApi, options )
    local scriptPath = modApi:getScriptPath()
    modApi:modifyUIElements( include( scriptPath.."/screen_modifications" ) )

    local saveslotsDialog = include( "fe/saveslots-dialog" )
    populateSaveSlotsOld = populateSaveSlotsOld or saveslotsDialog.populateSaveSlots

    function saveslotsDialog:populateSaveSlots()
        -- start vanilla code --
        local user = savefiles.getCurrentGame()
        -- for backwards compatability
        if user.data.saveSlots == nil then
            user.data.saveSlots = { user.data.campaign }
        end
        -- end vanilla code --

        local MAX_SAVE_SLOTS = 4
        for k,_ in pairs(user.data.saveSlots) do
            if k+1 > MAX_SAVE_SLOTS then
                MAX_SAVE_SLOTS = k+1
            end
        end

        local i = 1
        while true do
            local n, v = debug.getupvalue(populateSaveSlotsOld, i)
            assert(n)
            if n == "MAX_SAVE_SLOTS" then
                debug.setupvalue(populateSaveSlotsOld, i, MAX_SAVE_SLOTS)
                break
            end
            i = i + 1
        end

        return populateSaveSlotsOld(self)
    end
end

return {
    init = init,
    load = load,
}
