## no critic: (Modules::ProhibitAutomaticExportation

package Data::Dump::ObjectAsString;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict 'vars', 'subs';
use Exporter qw(import);
our @EXPORT = qw(dd ddx);
our @EXPORT_OK = qw(dump pp quote);

use Data::Dump::Options ();

sub dump {
    local $Data::Dump::Options::OBJECT_AS = 'string';
    Data::Dump::Options::dump(@_);
}

*pp = \&dump;

*quote = \&Data::Dump::Options::quote;

sub dd {
    print &dump(@_), "\n";
}

sub ddx {
    my(undef, $file, $line) = caller;
    $file =~ s,.*[\\/],,;
    my $out = "$file:$line: " . &dump(@_) . "\n";
    $out =~ s/^/# /gm;
    print $out;
}

1;
# ABSTRACT: Like Data::Dump but objects are stringified instead of dumped

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

Use like you would use L<Data::Dump>:

 use Data::Dump::ObjectAsString;
 dd [1,2,3,4];


=head1 DESCRIPTION

This is actually a thin wrapper of L<Data::Dump::Options>. When dumping,
C<$Data::Dump::Options::OBJECT_AS> is locally set to C<string>.


=head1 SEE ALSO

L<Data::Dump::Options>

L<Data::Dump>

=cut
