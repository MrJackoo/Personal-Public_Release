-- Emotes you add in the file will automatically be added to AnimationList.lua
local CustomDP = {}

CustomDP.Expressions = {}
CustomDP.Walks = {}
CustomDP.Shared = {}
CustomDP.Dances = {}
CustomDP.AnimalEmotes = {}
CustomDP.Emotes = {
    ["holdvest"] = {
        "export@holdingvest",
        "head_001_r",
        "Hold Vest (New)",
        AnimationOptions = {
            EmoteMoving = true,
            EmoteLoop = true
        }
    },
    ["holdbaton"] = {
        "export@batonhold",
        "head_000_r",
        "Hold Baton (New)",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
        }
    },
    ["holdtaser"] = {
        "export@taserback",
        "head_000_r",
        "Hide Taser (New)",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = true,
        }
    },
    ["holdrifle"] = {
        "anim@fog_rifle_relaxed",
        "rifle_relaxed_clip",
        "Hold Rifle Relaxed",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false,
        }
    },
    -- ["template"] = {
    --     "templateexport",
    --     "templateexport",
    --     "templatename",
    --     AnimationOptions = {
    --         EmoteLoop = true,
    --         EmoteMoving = true,
    --     }
    -- },

}
CustomDP.PropEmotes = {}

-- Add the custom emotes
for arrayName, array in pairs(CustomDP) do
    if DP[arrayName] then
        for emoteName, emoteData in pairs(array) do
            -- We don't add adult animations if not needed
            if not emoteData.AdultAnimation or not Config.AdultEmotesDisabled then
                DP[arrayName][emoteName] = emoteData
            end
        end
    end
    -- Free memory
    CustomDP[arrayName] = nil
end
-- Free memory
CustomDP = nil
