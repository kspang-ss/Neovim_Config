-- luasnip.lua
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local extras = require("luasnip.extras")
local rep = extras.rep
local fmt = require("luasnip.extras.fmt").fmt
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node

-- Helper to generate comment lines dynamically based on function arguments
local function generate_comment_nodes(args)
    local func_args = args[1][1] or ""
    local return_type = args[2][1] or ""
    local nodes = {}

    -- Split args
    local args_table = {}
    for arg in string.gmatch(func_args, "([^,]+)") do
        table.insert(args_table, arg)
    end

    -- Format comment
    table.insert(nodes, t({ "/**", " * " }))
    table.insert(nodes, i(1, "Description"))
    table.insert(nodes, t({ "", " *" }))

    -- Add @param for args
    local last_index = 0
    for index, arg_name in ipairs(args_table) do
        table.insert(nodes, t({"", " * @param " .. arg_name .. " - " }))
        table.insert(nodes, i(index + 1))
        last_index = index + 1
    end

    -- Only add @returns if not void
    if return_type ~= "void" then
        table.insert(nodes, t({"", " * @returns " .. return_type .. " - "}))
        table.insert(nodes, i(last_index + 1))
    end

    table.insert(nodes, t({"", " */" }))
    return ls.snippet_node(nil, nodes)
end

ls.add_snippets("all", {
    s("fn", {
        -- update comments :)
        d(4, generate_comment_nodes, { 3, 1 }),
        t({ "", "" }),

        i(1, "type"),
        t(" function "),
        i(2, "functionName"),
        t("("),
        i(3, "args"),
        t(") {"),
        t({ "", "    " }),
        i(0),
        t({ "", "}" }),
    }),
})

local css_snippets = {
    s("cl", fmt([[
    .<> {
        <>
    }
    ]], { i(1, "name"), i(0) }, { delimiters = "<>" })),

    s("clamp", {
        t('clamp-calc('),
        i(1),
        t('px, '),
        i(2),
        t('px);')
    }),

    s("tf", {
        t('transform: translate('),
        i(1),
        t(', '),
        i(2),
        t(');')
    }),

    s("ts", {
        t('transition: var(--trans);'),
    }),
}
local html_snippets = {

    s("if", fmt([[
    <?php if ({}): ?>
    {}
    <?php endif; ?>
    ]], { i(1), i(2) })),

    s("foreach", fmt([[
    <?php foreach ({} as $key => $value): ?>
    {}
    <?php endforeach; ?>
    ]], { i(1), i(2) })),

    s("section", fmt([[
    <section class="{}">
    {}
    </section>
    ]], { i(1), i(2) })),

    s("div", fmt([[
    <div{}>
    {}
    </div>
    ]], { i(1), i(2) })),

    s("span", {
        t('<span'),i(1),t('>'),i(2),t('</span>')
    }),

    s("a", {
        t('<a href="<?php echo '),i(1),t('; ?>" target="_self">'),i(2),t('</a>')
    }),

    s("cl", {
        t('class="'),i(1),t('"')
    }),

    s("php", {
        t('<?php'),i(1),t('?>')
    })
}

ls.add_snippets("css", css_snippets)
ls.add_snippets("scss", css_snippets)

ls.add_snippets("html", html_snippets)
ls.add_snippets("php", html_snippets)
