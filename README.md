# kakoune-plugin-quick-dev
Quickly write and reload kakscript to extend Kakoune's functionality without breaking your workflow.

## Installation with plug.kak
Add the following to your kakrc, then run the `:plug-install` command:

```
plug "jordan-yee/kakoune-plugin-quick-dev" config %{
  quick-dev-register-default-mappings
}
```

## Usage
Assuming the default mappings from the above config, and a user-mode mapping of `,`:

1. You're working away and think, "I should configure kak to do ____, but I don't want
   to break my workflow to implement it."
2. Open the quick dev scratch file with `,qe`. This will look like:
   ```
   # ------------------------------------------------------------------------------
   # Scratch Space - add your prototype script code here

   # TODO: Modify this function to suit your needs, then reload!
   define-command -override quick-dev-hello-world \
   -docstring 'example quick-dev command' %{
         echo 'hello world!'
   }
   ```
3. Add your prototype kakscript. This can be anything that's reloadable, but is
   generally meant to be new commands with an -override flag. An example command
   definition is given in the scratch file which can be copied as a template.
   ```
   # ------------------------------------------------------------------------------
   # Scratch Space - add your prototype script code here

   define-command -override quick-dev-hello-world \
   -docstring 'example quick-dev command' %{
         echo 'hello world, reloaded!'
   }
   ```
4. [optional] Go back to the file you were originally working on with `ga`.
5. Load your prototype kakscript with `,qr`.
6. Immediately test your changes in the original context from which you had the idea.
   ```
   :quick-dev-hello-world
   # => hello world, reloaded!
   ```
7. Repeat steps 2-6 until the new functionality does what you want.

This is meant be an instant feedback cycle for quick prototyping. Once you're
happy with the new functionality, consider pulling it out of the quick dev
scratch file and into an actual plugin you can share.
