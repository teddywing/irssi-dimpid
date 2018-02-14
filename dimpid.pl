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


use constant ESCAPE => "\x{03}";
use constant GREY => '14';

Irssi::signal_add('message public', sub {
	my ($server, $text, $nick, @rest) = @_;

	if ($nick eq 'test-3kj469y5h') {
		Irssi::signal_continue(
			$server,
			ESCAPE . GREY . $text . ESCAPE,
			$nick,
			@rest,
		);
	}
});
