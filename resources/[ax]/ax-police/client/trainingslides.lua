local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("ax-police:client:TrainingSlides",function()
    local dialog = exports['qb-input']:ShowInput({
        header = 'Training Room',
        submitText = 'Submit',
        inputs = {
            {
                text = "Select Training Slide", -- text you want to be displayed as a input header
                name = "slidenumber", -- name of the input should be unique otherwise it might override
                type = "select", -- type of the input - Select is useful for 3+ amount of "or" options e.g; someselect = none OR other OR other2 OR other3...etc
                options = { -- Select drop down options, the first option will by default be selected
                    { value = "https://i.imgur.com/8EufrfC.png", text = "Main Slide" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/v6lZM2l.png", text = "Organisational Structure" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/ybduK7D.png", text = "Rules and Regulations: General" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/fa4H25R.png", text = "Rules and Regulations: Vehicles" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/h5kEKST.png", text = "Radio Comms: Procedures" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/dyavciM.png", text = "Two-Way Communication" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/UDYMUb0.png", text = "Firearms & Use of Force" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/ODNttms.png", text = "Law & Legislation" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/BXqmsTt.png", text = "Firearms Permit" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/AxQK1NS.png", text = "Vehicle Stops" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/NfXZ7bm.png", text = "Vehicle Pursuits" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/MwF1ZlK.png", text = "Stopping & Searching" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/gyceyRe.png", text = "Arresting" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/MX0A210.png", text = "Fines & Sentencing" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/p21wj7N.png", text = "Evidence Collection & Storage" }, -- Options MUST include a value and a text option
                    { value = "https://i.imgur.com/qug5Oh9.png", text = "Report Writing" }, -- Options MUST include a value and a text option
                }
            }
        },
    })
    if dialog then
        if not dialog.slidenumber then return end
        TriggerServerEvent('ax-police:server:TrainingSlides', dialog.slidenumber)
    end
end)

RegisterNetEvent("ax-police:client:Slides",function(displayimage)
    local txd = CreateRuntimeTxd('duiTxd')
    local duiObj = CreateDui(''..displayimage..'', 960, 540)
    _G.duiObj = duiObj
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, 'duiTex', dui)
    AddReplaceTexture('gabz_mm_screen', 'script_rt_big_disp', 'duiTxd', 'duiTex')
end)