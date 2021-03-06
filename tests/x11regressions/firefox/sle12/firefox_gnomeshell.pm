# Case#1479556: Firefox: Gnome Shell Integration

use strict;
use base "x11test";
use testapi;

sub run() {
    mouse_hide(1);

    # Clean and Start Firefox
    x11_start_program("xterm -e \"killall -9 firefox;rm -rf .moz* .local/share/gnome-shell/extensions/*\"");
    x11_start_program("firefox");
    assert_screen('firefox-launch',35);

    send_key "ctrl-shift-a";
    assert_and_click('firefox-plugins-tabicon');
    assert_screen('firefox-gnomeshell-default',10);

    send_key "alt-d";
    sleep 1;
    type_string "extensions.gnome.org\n";
    assert_screen('firefox-gnomeshell-frontpage',85);
    send_key "alt-a";
    assert_and_click "firefox-gnomeshell-allowremember";
    assert_and_click "firefox-gnomeshell-check_installed";
    assert_screen("firefox-gnomeshell-installed",35);
    send_key "pgdn";
    assert_screen("firefox-gnomeshell-installed_02",35);

    send_key "alt-d";
    type_string "extensions.gnome.org/extension/512/wikipedia-search-provider/\n";
    assert_screen("firefox-gnomeshell-extension",35);
    sleep 5;
    assert_and_click "firefox-gnomeshell-extension_install";
    assert_and_click "firefox-gnomeshell-extension_confirm";
    sleep 10;
    assert_screen("firefox-gnomeshell-extension_on",15);

    # Exit
    send_key "ctrl-w";
    send_key "alt-f4";

    sleep 2;
    x11_start_program("xterm");
    type_string "ls .local/share/gnome-shell/extensions/\n";
    sleep 2;
    assert_screen('firefox-gnomeshell-checkdir',10);
    type_string "rm -rf .local/share/gnome-shell/extensions/*;exit\n";
    
    if (check_screen('firefox-save-and-quit', 4)) {
       # confirm "save&quit"
       send_key "ret";
    }
}
1;
# vim: set sw=4 et:
