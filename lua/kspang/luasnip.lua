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
    })
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
