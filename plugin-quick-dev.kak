# ------------------------------------------------------------------------------
# PLUGIN QUICK DEV
# a scratch space for writing easily reloadable kakscript

# TODO: Figure out how to reference the scratchpad paths in a way that works
# when loading the plugin from a local path. Currently, the paths assume the
# plugin was installed in the default `plug.kak` directory.

define-command -override quick-dev-create-scratch-file \
-docstring "create the quick-dev scratchpad if it doesn't yet exist" %{
    evaluate-commands %sh{
        quick_dev_scratchpad_file="$kak_config/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
        quick_dev_scratchpad_template_file="$kak_config/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.template"
        if [ -e "$quick_dev_scratchpad_file" ]; then
            printf "%s" "echo -debug 'existing quick-dev scratchpad found; leaving it as-is'"
        else
            ( cp --no-clobber $quick_dev_scratchpad_template_file $quick_dev_scratchpad_file ) \
            && printf "%s" "echo -debug 'new quick-dev scratchpad created'"
        fi
    }
}

define-command -override quick-dev-reset-scratch-file \
-docstring "delete the quick-dev scratchpad and recreate it" %{
    evaluate-commands %sh{
        quick_dev_scratchpad_file="$kak_config/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
        if [ -e "$quick_dev_scratchpad_file" ]; then
            rm $quick_dev_scratchpad_file
            printf "%s" "echo -debug 'existing quick-dev scratchpad removed'"
        fi
    }
    quick-dev-create-scratch-file
}

define-command -override quick-dev-edit \
-docstring 'edit the quick-dev scratchpad' %{
    edit "%val{config}/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
}

define-command -override quick-dev-reload \
-docstring 'reload the quick-dev scratchpad' %{
    source "%val{config}/plugins/kakoune-plugin-quick-dev/quick-dev-scratchpad.kak"
    echo 'The Quick Dev script was reloaded...'
}

define-command -override quick-dev-mode-init \
-docstring 'declare the quick-dev user-mode user mode in a reloadable way' %{
    try %{ declare-user-mode quick-dev }
    # Ensure old key mappings don't stick around if you change mapped keys.
    unmap global quick-dev
}

define-command -override quick-dev-register-default-mappings \
-docstring 'register default mappings for quick-dev mode' %{
    map global quick-dev e ": quick-dev-edit<ret>" \
        -docstring 'edit quick-dev scratchpad'
    map global quick-dev r ": quick-dev-reload<ret>" \
        -docstring 'reload quick-dev scratchpad'
    map global quick-dev R ": quick-dev-reset-scratch-file<ret>" \
        -docstring 'reset quick-dev scratchpad (!destructive!)'
}

# ------------------------------------------------------------------------------
# Initialize quick-dev scratchpad on plugin load

quick-dev-create-scratch-file
