#!/usr/bin/perl
# buildrss.pl by Sven Neuhaus
# https://github.com/neuhaus/create-podcast

use strict;
use warnings;
use POSIX qw(strftime locale_h);
use URI::Escape;
use MP3::Info;

die "Usage:\n\t$0 title 'a description' url *.mp3 > file.rss\n" if @ARGV < 4;

my $title       = shift @ARGV;
my $description = shift @ARGV;
my $url         = shift @ARGV;
$url .= "/" unless $url =~ /\/$/;

setlocale(LC_TIME, "C"); # RFC822 timestamp must be in C locale
my $now =  strftime("%a, %d %b %Y %H:%M:%S %z", localtime());

print <<__EOF;
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:atom="http://www.w3.org/2005/Atom">
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
    next unless defined $length;
	next if $length < 1;
	my @stat = stat $file;
	my $mtime =  strftime("%a, %d %b %Y %H:%M:%S %z", localtime($stat[9]));

#  strftime(fmt, sec, min, hour, mday, mon, year,
#                             wday = -1, yday = -1, isdst = -1)

	my $mp3info = get_mp3info($file);
	my $title = $file;
	$title =~ s{\.[^.]+$}{}; # strip extension

	my $uri = uri_escape_utf8($file);
	print <<__EOF;
		<item>
			<title>$title</title>
			<description>$file</description>
			<pubDate>$mtime</pubDate>
			<itunes:duration>$mp3info->{TIME}</itunes:duration>
			<link>$url$uri</link>
			<guid>$url$uri</guid>
			<enclosure url="$url$uri" length="$length" type="audio/mpeg"/>
		</item>
__EOF
}
print <<__EOF;
	</channel>
</rss>
__EOF

exit(0);

# eof. This file has not been truncate
