# create-podcast

This little perl script creates a podcast.
It generates a RSS file with audio files.
The script requires the MP3::Info perl module to be installed.

Inspired by https://github.com/silverwizard/Podcast-Create

## How to use

* Change into the directory with the mp3 files. Their filenames should be sorted (i.e. use a numeric prefix).

* Launch `buildrss.pl` with the following parameters
   
    1. Title

    2. Description (protected by quotes if it contains whitespace)

    3. URL - this is the base URL prefix that gets prepended to filenames.

    4. `*.mp3` (or a list of mp3 files)


Redirect the script output into a file and you're done.

*Note:* Some Podcast clients sort the entries by date. If your MP3 files are not sorted by date, you can use 
the following command to give them ascending timestamps:

    perl -e '$x=time; for(@ARGV){utime($x,$x++, $_)}' *.mp3

Examples:

    buildrss.pl Test5 "This is my fifth test" https://example.com/test5/ *.mp3 > test5.rss

    buildrss.pl Test6 "This is my sixth test" https://example.org/test6/ mp3/*.mp3 > test6.rss

The second example uses mp3 files in a subdirectory.
