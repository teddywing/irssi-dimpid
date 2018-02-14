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


use Data::Dumper;

Irssi::theme_register(['dimpid', '%5$0%n']);

Irssi::signal_add('message public', sub {
	my ($server, $text, $nick, $address, $target) = @_;

	Irssi::print(Dumper($target), MSGLEVEL_CLIENTCRAP);

	if ($nick eq 'test-3kj469y5h') {
		$server->printformat($target, MSGLEVEL_PUBLIC, 'dimpid', $text);
	}
});
