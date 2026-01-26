# visual_wrap.nvim

Wrap your visual blocks with a range of brackets and quotation characters

## Wrap your code

Once you've highlighted your text in **visual-line** (i.e. visual mode) mode you can use the following default keybinds to wrap your text:

| Keybind | Result |
|---------|--------|
| `<leader>[` | `[..text..]` |
| `<leader>]` | `[..text..]` |
| `<leader>{` | `{..text..}` |
| `<leader>}` | `{..text..}` |
| `<leader>(` | `(..text..)` |
| `<leader>)` | `(..text..)` |
| `<leader><` | `<..text..>` |
| `<leader>>` | `<..text..>` |
| `<leader>"` | `"..text.."` |
| `<leader>'` | `'..text..'` |
| `<leader>\`` | `` `..text..` `` |

## Installation

Using `packer`
```lua
use 'bwintertkb/visual_wrap.nvim'
```

Using `lazy.nvim`
```lua
{ 'bwintertkb/visual_wrap.nvim', opts = {} }
```

## Setup

Basic setup with defaults:
```lua
require("visual_wrap").setup()
```

### Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `silent` | boolean | `true` | Suppress command output in the command line |
| `keymaps` | table | see below | Custom keybindings for each bracket type |

### Silent mode

To suppress command echo when wrapping:
```lua
require("visual_wrap").setup({
    silent = true,
})
```

### Custom keymaps

Override default keybindings or disable specific ones:
```lua
require("visual_wrap").setup({
    silent = true,
    keymaps = {
        ["["] = "<leader>s[",
        ["{"] = "<leader>s{",
        ["("] = "<leader>s(",
        ["'"] = "<leader>sq",
        ['"'] = "<leader>sQ",
        ["`"] = false,  -- disable backtick wrapping
    },
})
```

Setting a keymap to `false` or `nil` disables that binding.

### Default keymaps
```lua
{
    ["["] = "<leader>[",
    ["]"] = "<leader>]",
    ["{"] = "<leader>{",
    ["}"] = "<leader>}",
    ["("] = "<leader>(",
    [")"] = "<leader>)",
    ["<"] = "<leader><",
    [">"] = "<leader>>",
    ['"'] = '<leader>"',
    ["'"] = "<leader>'",
    ["`"] = "<leader>`",
}
```

## License

The plugin is distributed under the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0)
