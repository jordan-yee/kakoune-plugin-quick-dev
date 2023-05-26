# kakoune-plugin-quick-dev

Quickly write and reload kakscript to extend Kakoune's functionality without
breaking your workflow.

> This relies on you to write kakscript to be reloadable, but I've found that
> the little bit of discipline and know-how required to do that unlocks a
> drastically improved development experience.

TODO:
- [ ] Include examples of how to make different kakscript constructs reloadable
  for easy reference.

## Example Usage

(Assuming default mappings...)

1. You're working away and think, "I should configure kak to do ____, but I
   don't want to break my workflow to implement it."
2. Open the quick dev scratch file with `<space>qe`. This will look like:
   ```
   # ------------------------------------------------------------------------------
   # Scratch Space - add your prototype script code here

   # TODO: Modify this function to suit your needs, then reload!
   define-command -override quick-dev-hello-world \
   -docstring 'example quick-dev command' %{
         echo 'hello world!'
   }
   ```
3. Add your prototype kakscript, which can be anything that's reloadable, such
   as `define-command` with an -override flag:
   ```
   # ------------------------------------------------------------------------------
   # Scratch Space - add your prototype script code here

   define-command -override quick-dev-hello-world \
   -docstring 'example quick-dev command' %{
         echo 'hello world, reloaded!'
   }
   ```
4. (Re-)Load your prototype kakscript with `<space>qr`.
5. [optional] Go back to the file you were originally working on with `ga`.
6. Immediately test your changes in the original context in which you had the idea.
   ```
   :quick-dev-hello-world
   # => hello world, reloaded!
   ```
7. Repeat steps 2-6 until the new functionality does what you want.

This is meant be an instant feedback cycle for quick prototyping. Once you're
happy with the new functionality, consider pulling it out of the quick dev
scratch file and into an actual plugin you can share.

## Commands

`quick-dev-create-scratch-file`: create the quick-dev scratch file if it doesn't
yet exist
- This includes some example code & reference links to get you started.

`quick-dev-reset-scratch-file`: delete an existing quick-dev scratch file and
recreate it

`quick-dev-edit`: edit the quick-dev scratch file

`quick-dev-reload`: reload the quick-dev scratch file

`quick-dev-register-default-mappings`: reload the quick-dev scratch file
- `q` (user mode): enter quick-dev mode
  - `e` (quick-dev): edit quick-dev script
  - `r` (quick-dev): reload quick-dev script
  - `R` (quick-dev): reset quick-dev script (!destructive!)

## Installation

With `plug.kak`:
```
# Add the following to your kakrc, then run the `:plug-install` command:
plug "jordan-yee/kakoune-plugin-quick-dev" config %{
  quick-dev-register-default-mappings
}
```

Manual:
1. Clone this repo into the standard plugin directory:
   ```
   git clone https://github.com/jordan-yee/kakoune-plugin-quick-dev.git ~/.config/kak/plugins/kakoune-plugin-quick-dev
   ```
2. Add the following to your kakrc:
   ```
   source "%val{config}/plugins/kakoune-plugin-quick-dev/plugin-quick-dev.kak"
   # Register default mappings OR replace this with your own
   quick-dev-register-default-mappings
   ```

> Currently, this relies on static file path references to the standard plugins
> directory. You could modify the source fairly easily to accomodate a different
> setup if needed.

## Tips / Other Use Cases

To use this plugin for developing other plugins, you can simply source the other
plugin file(s) in the quick-dev file so that they get reloaded when it does.

## See also

- [Discussion: How to reload config without leaving kakoune](https://discuss.kakoune.com/t/how-to-reload-config-without-leaving-kakoune/1586)
- TODO: I once saw blog or forum post or something outlining a good set of
  standards and conventions for Kakoune plugins. I could not find it when
  looking for it to link here.
