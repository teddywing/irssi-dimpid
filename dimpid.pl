# dimpid.pl
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
