local M = {}

function M.get_visual(_, parent)
    if #parent.snippet.env.LS_SELECT_RAW > 0 then
        return require("luasnip").snippet_node(nil, {
            require("luasnip").insert_node(1, parent.snippet.env.LS_SELECT_RAW),
        })
    else
        return require("luasnip").snippet_node(nil, {
            require("luasnip").insert_node(1),
        })
    end
end

return M
