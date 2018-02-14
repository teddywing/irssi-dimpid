use strict;

use Irssi;

our $VERSION = '1.00';
our %IRSSI = {
	authors     => 'Teddy Wing',
	contact     => 'irssi@teddywing.com',
	name        => 'Dimpid',
	description => 'Dim messages from certain nicks',
	license     => 'GPL',
};


Irssi::signal_add('message public', sub {
	my ($server, $text, $nick, @rest) = @_;

	if ($nick eq 'test-3kj469y5h') {
		Irssi::signal_continue($server, "\x{03}14" . $text . "\x{03}", $nick, @rest);
	}
});
