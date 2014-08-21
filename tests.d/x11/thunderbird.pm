use base "gnomestep";
use bmwqemu;

sub is_applicable() {
    my $self = shift;
    return $self->SUPER::is_applicable && !$vars{LIVECD};
}

sub run() {
    my $self = shift;
    ensure_installed("MozillaThunderbird");
    x11_start_program("thunderbird");
    assert_screen 'test-thunderbird-1', 3;
    send_key "alt-f4", 1;    # close wizzard
    send_key "alt-f4", 1;    # close prog
}

1;
# vim: set sw=4 et: