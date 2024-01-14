local modifications = {
    {
        "modal-saveslots.lua",
        { "widgets", 2, "children" },
        {
            [3] = {
                scrollbar_template = [[listbox_vscroll]],
                orientation = 2,
            },
        }
    },
}

return modifications
