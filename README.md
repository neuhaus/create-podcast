# create-podcast

This little perl script creates a podcast.
It generates a RSS file with audio files.

Inspired by https://github.com/silverwizard/Podcast-Create

## How to use

* Change into the directory with the mp3 files

* Launch `buildrss.pl` with the following parameters
   
    1. Title

    2. Description (protected by quotes if it contains whitespace)

    3. URL

    4. *.mp3


Redirect its output into a file.

Example:

    `buildrss.pl Test5 "This is my fifth test" https://example.com/test5/ *.mp3 > test5.rss`
