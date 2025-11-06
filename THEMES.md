# 🎨 Theme Guide

Complete guide to colorschemes available in this Neovim configuration.

## Available Themes

### 1. Tokyo Night (Default)

**Style:** Modern, vibrant dark theme with excellent contrast
**Best for:** All-day coding, eye comfort, professional look
**Repo:** [folke/tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

#### Variants
- `night` - Standard dark variant with deep blue background (default)
- `storm` - Slightly lighter background with storm-like atmosphere
- `moon` - Balanced variant between night and storm
- `day` - Light variant for daytime coding

#### Switch to Tokyo Night
```vim
:colorscheme tokyonight
```

#### Customize
Edit `lua/plugins/ui.lua`:
```lua
require("tokyonight").setup({
  style = "night",  -- "storm", "moon", "day"
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { bold = true },
    variables = {},
  },
  sidebars = { "qf", "help", "terminal", "packer", "neo-tree" },
  on_colors = function(colors)
    -- Customize colors
    colors.hint = colors.orange
    colors.error = "#ff0000"
  end,
  on_highlights = function(hl, colors)
    -- Customize highlights
    hl.CursorLineNr = {
      fg = colors.orange,
      bold = true,
    }
  end,
})
```

#### Features
- Excellent semantic highlighting
- Custom color overrides
- Dark sidebars and floating windows
- Bold functions, italic keywords and comments
- Custom cursor line number highlighting
- Full integration with all plugins

---

### 2. Catppuccin

**Style:** Elegant pastel theme with soothing colors
**Best for:** Reduced eye strain, aesthetics, long coding sessions
**Repo:** [catppuccin/nvim](https://github.com/catppuccin/nvim)

#### Flavors
- `latte` - Light pastel theme for daytime
- `frappe` - Medium contrast dark theme
- `macchiato` - Darker variant with warmer tones
- `mocha` - Darkest variant with deep blacks (default)

#### Switch to Catppuccin
```vim
:colorscheme catppuccin
:colorscheme catppuccin-latte      " Light variant
:colorscheme catppuccin-frappe     " Medium dark
:colorscheme catppuccin-macchiato  " Dark warm
:colorscheme catppuccin-mocha      " Darkest
```

#### Customize
Edit `lua/plugins/ui.lua`:
```lua
require("catppuccin").setup({
  flavour = "mocha",  -- latte, frappe, macchiato, mocha
  transparent_background = false,
  show_end_of_buffer = false,
  term_colors = true,
  dim_inactive = {
    enabled = true,
    shade = "dark",
    percentage = 0.15,
  },
  no_italic = false,
  no_bold = false,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    loops = {},
    functions = { "bold" },
    keywords = {},
    strings = {},
    variables = {},
    numbers = {},
    booleans = {},
    properties = {},
    types = {},
    operators = {},
  },
  color_overrides = {},
  custom_highlights = {},
})
```

#### Features
- Beautiful pastel color palette
- Dim inactive windows
- Full integration with Neovim ecosystem
- Consistent across all UI elements
- Community-driven color choices
- Excellent for readability

---

### 3. Rose Pine

**Style:** Minimal, sophisticated, and elegant
**Best for:** Distraction-free coding, minimalism lovers
**Repo:** [rose-pine/neovim](https://github.com/rose-pine/neovim)

#### Variants
- `main` - Standard balanced variant
- `moon` - Slightly darker with warm undertones (default)
- `dawn` - Light variant with soft colors

#### Switch to Rose Pine
```vim
:colorscheme rose-pine
:colorscheme rose-pine-main
:colorscheme rose-pine-moon
:colorscheme rose-pine-dawn
```

#### Customize
Edit `lua/plugins/ui.lua`:
```lua
require("rose-pine").setup({
  variant = "moon",  -- auto, main, moon, or dawn
  dark_variant = "moon",
  dim_inactive_windows = true,
  extend_background_behind_borders = true,
  enable = {
    terminal = true,
    legacy_highlights = true,
    migrations = true,
  },
  styles = {
    bold = true,
    italic = true,
    transparency = false,
  },
  groups = {
    -- Customize highlight groups
    border = "muted",
    link = "iris",
    panel = "surface",
    error = "love",
    hint = "iris",
    info = "foam",
    warn = "gold",
  },
})
```

#### Features
- Minimal design philosophy
- Soft, natural color palette
- Dims inactive windows
- Clean and distraction-free
- Excellent contrast ratios
- Natural eye comfort

---

### 4. Kanagawa

**Style:** Deep, warm colors inspired by Japanese art
**Best for:** Artistic coders, warm color lovers, evening coding
**Repo:** [rebelot/kanagawa.nvim](https://github.com/rebelot/kanagawa.nvim)

#### Themes
- `wave` - Standard dark theme with ocean-inspired colors (default)
- `dragon` - Slightly lighter with earthy tones
- `lotus` - Light theme with traditional Japanese aesthetics

#### Switch to Kanagawa
```vim
:colorscheme kanagawa
:colorscheme kanagawa-wave
:colorscheme kanagawa-dragon
:colorscheme kanagawa-lotus
```

#### Customize
Edit `lua/plugins/ui.lua`:
```lua
require("kanagawa").setup({
  compile = false,
  undercurl = true,
  commentStyle = { italic = true },
  functionStyle = { bold = true },
  keywordStyle = { italic = true },
  statementStyle = { bold = true },
  typeStyle = {},
  transparent = false,
  dimInactive = true,
  terminalColors = true,
  colors = {
    palette = {},
    theme = {
      wave = {},
      lotus = {},
      dragon = {},
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  theme = "wave",
  background = {
    dark = "wave",
    light = "lotus",
  },
})
```

#### Features
- Inspired by "The Great Wave off Kanagawa"
- Deep, rich color palette
- Warm and inviting tones
- Dims inactive windows
- Excellent for night coding
- Artistic and unique

---

## Making a Theme Permanent

To set a theme as your default, edit `lua/plugins/ui.lua`:

### Method 1: Change the default theme

```lua
-- 1. Set your preferred theme to load immediately
{
  "catppuccin/nvim",
  lazy = false,      -- Load immediately
  priority = 1000,   -- Load before other plugins
  config = function()
    require("catppuccin").setup()
    vim.cmd([[colorscheme catppuccin]])
  end,
}

-- 2. Set Tokyo Night to lazy load instead
{
  "folke/tokyonight.nvim",
  lazy = true,       -- Don't load by default
  priority = 1000,
  config = function()
    require("tokyonight").setup({
      style = "night",
    })
  end,
}
```

### Method 2: Add to init.lua

Add this line to your `init.lua` after all plugins are loaded:
```lua
vim.cmd([[colorscheme catppuccin]])
```

---

## Customizing Lualine to Match Theme

The statusline automatically matches your theme. If you want to customize:

Edit `lua/plugins/ui.lua`, find the lualine setup:

```lua
require("lualine").setup({
  options = {
    theme = "auto",  -- auto, tokyonight, catppuccin, rose-pine, kanagawa
    -- ... other options
  },
})
```

Available lualine themes:
- `"auto"` - Automatically detects colorscheme
- `"tokyonight"`
- `"catppuccin"`
- `"rose-pine"`
- `"kanagawa"`

---

## Transparency Support

To enable transparent background (requires terminal transparency):

**Tokyo Night:**
```lua
require("tokyonight").setup({
  transparent = true,
  styles = {
    sidebars = "transparent",
    floats = "transparent",
  },
})
```

**Catppuccin:**
```lua
require("catppuccin").setup({
  transparent_background = true,
})
```

**Rose Pine:**
```lua
require("rose-pine").setup({
  styles = {
    transparency = true,
  },
})
```

**Kanagawa:**
```lua
require("kanagawa").setup({
  transparent = true,
})
```

---

## Testing Themes Before Committing

Try different themes in your current session:

```vim
:colorscheme tokyonight
:colorscheme tokyonight-storm
:colorscheme tokyonight-moon
:colorscheme tokyonight-day

:colorscheme catppuccin
:colorscheme catppuccin-mocha
:colorscheme catppuccin-macchiato
:colorscheme catppuccin-frappe
:colorscheme catppuccin-latte

:colorscheme rose-pine
:colorscheme rose-pine-moon
:colorscheme rose-pine-dawn

:colorscheme kanagawa
:colorscheme kanagawa-wave
:colorscheme kanagawa-dragon
:colorscheme kanagawa-lotus
```

---

## Quick Theme Switcher Function

Add this to `lua/config/keymaps.lua` for quick theme switching:

```lua
-- Theme switcher
local themes = {
  "tokyonight",
  "tokyonight-storm",
  "tokyonight-moon",
  "catppuccin",
  "rose-pine",
  "kanagawa",
}

local current_theme_index = 1

vim.keymap.set("n", "<leader>ut", function()
  current_theme_index = current_theme_index % #themes + 1
  local theme = themes[current_theme_index]
  vim.cmd("colorscheme " .. theme)
  vim.notify("Theme: " .. theme, vim.log.levels.INFO)
end, { desc = "Toggle theme" })
```

Then use `<leader>ut` to cycle through themes!

---

## Recommended Themes by Use Case

### 🌅 Daytime Coding
1. **Catppuccin Latte** - Soft pastels, easy on eyes
2. **Tokyo Night Day** - Bright and professional
3. **Rose Pine Dawn** - Minimal and elegant

### 🌙 Nighttime Coding
1. **Tokyo Night** - Excellent contrast, vibrant
2. **Kanagawa Wave** - Deep and warm
3. **Catppuccin Mocha** - Soothing pastels

### 💼 Professional/Presentations
1. **Tokyo Night Storm** - Balanced and professional
2. **Rose Pine Main** - Clean and minimal
3. **Catppuccin Macchiato** - Elegant and readable

### 🎨 For Aesthetics Lovers
1. **Kanagawa** - Artistic Japanese-inspired
2. **Rose Pine Moon** - Sophisticated and elegant
3. **Catppuccin** - Beautiful pastel palette

### 👀 For Eye Comfort (Long Sessions)
1. **Catppuccin Mocha** - Soft colors, reduced strain
2. **Rose Pine Moon** - Natural, warm undertones
3. **Tokyo Night Moon** - Balanced brightness

---

## Terminal Emulator Recommendations

For best color accuracy, use terminals with true color support:

### Recommended Terminals
- **Alacritty** - Fast, GPU-accelerated, great color support
- **Kitty** - Feature-rich, excellent rendering
- **WezTerm** - Lua-configurable, fantastic colors
- **iTerm2** (macOS) - Full feature set, great colors
- **Windows Terminal** - Modern, good color support

### Terminal Configuration

Most terminals need true color enabled. Example for **Alacritty** (`~/.config/alacritty/alacritty.yml`):

```yaml
env:
  TERM: xterm-256color

colors:
  draw_bold_text_with_bright_colors: true
```

For **tmux**, add to `~/.tmux.conf`:
```bash
set -g default-terminal "screen-256color"
set -ga terminal-overrides ",*256col*:Tc"
```

---

## Font Recommendations

These themes look best with Nerd Fonts that include programming ligatures:

### Top Recommendations
1. **JetBrains Mono Nerd Font** - Excellent ligatures, clean
2. **Fira Code Nerd Font** - Popular, great ligatures
3. **Cascadia Code Nerd Font** - Microsoft's programming font
4. **Iosevka Nerd Font** - Narrow, space-efficient
5. **Hack Nerd Font** - Classic, readable

Install from: [Nerd Fonts](https://www.nerdfonts.com/)

---

## Troubleshooting

### Colors look wrong
1. Ensure your terminal supports true color
2. Check `echo $TERM` shows `*-256color`
3. Try `:set termguicolors` in Neovim

### Theme not loading
1. Run `:Lazy sync` to ensure all plugins are installed
2. Check for errors with `:checkhealth`
3. Ensure the theme is not set to `lazy = true` if you want it as default

### Statusline doesn't match theme
1. Set lualine theme to `"auto"` or specific theme name
2. Reload Neovim after changing themes

### Transparency not working
1. Ensure your terminal emulator supports transparency
2. Set terminal transparency in terminal config
3. Enable transparency in theme config (see Transparency Support above)

---

## Contributing New Themes

Want to add a new theme? Edit `lua/plugins/ui.lua`:

```lua
-- Add new theme plugin
{
  "author/theme-name.nvim",
  lazy = true,
  opts = {
    -- theme configuration
  },
}
```

Then it will be available with `:colorscheme theme-name`!

---

## Resources

- [Tokyo Night Repository](https://github.com/folke/tokyonight.nvim)
- [Catppuccin Repository](https://github.com/catppuccin/nvim)
- [Rose Pine Repository](https://github.com/rose-pine/neovim)
- [Kanagawa Repository](https://github.com/rebelot/kanagawa.nvim)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [Neovim Colorscheme Gallery](https://vimcolorschemes.com/)

---

**Happy Theming!** 🎨

*Find your perfect coding atmosphere!*
