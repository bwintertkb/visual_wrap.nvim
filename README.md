# visual_wrap.nvim
Wrap your visual blocks with a range of brackets and quotation characters

## Wrap your code 
Once you've highlighted your text in **visual-line** (i.e. visual mode) mode you can use the following keybind to wrap your text:
- `<leader>[` wraps your text as `[..text..]`
- `<leader>]` wraps your text as `[..text..]`
- `<leader>{` wraps your text as `{..text..}`
- `<leader>}` wraps your text as `{..text..}`
- `<leader>(` wraps your text as `(..text..)`
- `<leader>)` wraps your text as `(..text..)`
- `<leader><` wraps your text as `<..text..>`
- `<leader>>` wraps your text as `<..text..>`
- `<leader>"` wraps your text as `"..text.."`
- `<leader>'` wraps your text as `'..text..'`
- `<leader>`\`` wraps your text as `\`..text..\`

### Installation
Using `packer`
```lua
use 'bwintertkb/visual_wrap.nvim'
```
### Setup
```lua
require("visual_wrap").setup()
```
### License
The plugin is ditributed under the [Apache License, Version 2.0](https://opensource.org/licenses/Apache-2.0)
