# dimpid.pl
#
# Outputs public messages from certain nicks in grey instead of standard black.
#
# Settings:
#
#     dimpid_nicks: a space-separated list of nicks whose public messages will
#                   be printed in grey.
#
#                   Example: /set dimpid_nicks nibbler hermes zoidberg
#
#
# Copyright (c) 2018 Teddy Wing
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

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


Irssi::command_bind('help dimpid', sub {
	my $help = <<HELP;

%9Description:%9

    Outputs public messages from certain nicks in grey instead of standard
    black.

%9Settings:%9

    dimpid_nicks: a space-separated list of nicks whose public messages will
                  be printed in grey.

                  %9Example:%9 /set dimpid_nicks nibbler hermes zoidberg
HELP

	Irssi::print($help, MSGLEVEL_CLIENTCRAP);
});

Irssi::command_bind('help', sub {
	my ($data, $server, $item) = @_;

	if ($data !~ /^dimpid\s*$/) {
		return;
	}

	Irssi::command_runsub('help', $data, $server, $item);
	Irssi::signal_stop();
});


Irssi::signal_add('message public', sub {
	my ($server, $text, $nick, @rest) = @_;

	my @nicks = split(' ', Irssi::settings_get_str('dimpid_nicks'));

	if (grep($_ eq $nick, @nicks)) {
		Irssi::signal_continue(
			$server,
			ESCAPE . GREY . $text . ESCAPE,
			$nick,
			@rest,
		);
	}
});


Irssi::settings_add_str('dimpid', 'dimpid_nicks', '');
