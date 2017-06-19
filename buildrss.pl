#!/usr/bin/perl
# buildrss.pl by Sven Neuhaus
# https://github.com/neuhaus/create-podcast

use strict;
use warnings;
use POSIX qw(strftime locale_h);
use URI::Escape;

die "Usage:\n\t$0 title 'a description' url *.mp3 > file.rss\n" if @ARGV < 4;

my $title       = shift @ARGV;
my $description = shift @ARGV;
my $url         = shift @ARGV;
$url .= "/" unless $url =~ /\/$/;

setlocale(LC_TIME, "C"); # RFC822 timestamp must be in C locale
my $now =  strftime("%a, %d %b %Y %H:%M:%S %z", localtime());

print <<__EOF;
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>$title</title>
		<description>$description</description>
		<link>$url</link>
		<atom:link href="$url$title.rss" rel="self" type="application/rss+xml" />
		<pubDate>$now</pubDate>
		<lastBuildDate>$now</lastBuildDate>
__EOF

while(@ARGV) { # go through all filenames
	my $file = shift @ARGV;
	my $length = -s $file;
	my $uri = uri_escape_utf8($file);
	# TODO should use MP3::Info for mp3 file description/title
	print <<__EOF;
		<item>
			<title>$file</title>
			<description>$file</description>
			<link>$url$uri</link>
			<guid>$url$uri</guid>
			<enclosure url="$url$uri" length="$length" type="audio/mpeg" />
		</item>
__EOF
}
print <<__EOF;
	</channel>
</rss>
__EOF

exit(0);

# eof. This file has not been truncate
