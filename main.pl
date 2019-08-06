use strict;
use warnings;

use LWP::UserAgent;
use URI::Find;

use feature "say";

my $url = "https://github.com/nip403/";
my $ua = new LWP::UserAgent;

my $res = $ua->get($url);
die "Error: ".$res->status_line unless $res->is_success;
my $html = $res->decoded_content;

open(FH, ">:encoding(UTF8)", "urls.txt");

my $finder = new URI::Find(
    sub {
        say FH shift;
    }
);

say FH "Root: $url";
$finder->find(\$html);

close(FH);
