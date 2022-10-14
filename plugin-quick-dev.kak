# ------------------------------------------------------------------------------
# PLUGIN QUICK DEV
# a scratch space for writing easily reloadable kakscript

# TODO: Figure out how to reference the scratch file paths in a way that works
# when loading the plugin from a local path. Currently, the paths assume the
# plugin was installed in the default `plug.kak` directory.

define-command -override quick-dev-create-scratch-file \
-docstring "create the quick-dev scratch file if it doesn't yet exist" %{
    evaluate-commands %sh{
        quick_dev_scratchpad_file="$kak_config/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
        quick_dev_scratchpad_template_file="$kak_config/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.template"
        if [ -e "$quick_dev_scratchpad_file" ]; then
            printf "%s" "echo -debug 'existing quick-dev scratch file found; leaving it as-is'"
        else
            ( cp --no-clobber $quick_dev_scratchpad_template_file $quick_dev_scratchpad_file ) \
            && printf "%s" "echo -debug 'new quick-dev scratch file created'"
        fi
    }
}

define-command -override quick-dev-edit \
-docstring 'edit the quick-dev scratch file' %{
    edit "%val{config}/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
}

define-command -override quick-dev-reload \
-docstring 'reload the quick-dev scratch file' %{
    source "%val{config}/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
    echo 'The Quick Dev script was reloaded...'
}

define-command -override quick-dev-register-default-mappings \
-docstring 'reload the quick-dev scratch file' %{
    declare-user-mode quick-dev
    map global quick-dev e ": quick-dev-edit<ret>" -docstring 'edit quick-dev script'
    map global quick-dev r ": quick-dev-reload<ret>" -docstring 'reload quick-dev script'
    map global user q ': enter-user-mode quick-dev<ret>' -docstring 'quick-dev mode'
}

# ------------------------------------------------------------------------------
# Initialize quick-dev scratch file on plugin load

quick-dev-create-scratch-file
