# Read the Bible: Word of God from your terminal

## Watch
<a href="https://archive.org/details/new-world-order-bible-versions-full-movie" title="Why the King James Bible?"><img src="https://i.imgur.com/A9piMKc.png" width="250" align="right"></a>

## Environment Variables
The environment variable BIBLE_VERSION is used to define the bible version to use.
Example to define rvr60 as default version:
export BIBLE_VERSION=rvr60
<then run the program>

Note: rvr60 stands for Reina Valera 1960, a spanish version from textus receptus.

## Usage

   usage: rtb [flags] [reference...]

     -v      list versions
     -l      list books
     -W      no line wrap
     -h      show help

     Bible versions:
	 The environment variable BIBLE_VERSION is used to define
	 the bible version to use. Default version is: rdf
	 ex: export BIBLE_VERSION=rvr60

     Reference types:
	 <Book>
	     Individual book
	 <Book>:<Chapter>
	     Individual chapter of a book
	 <Book>:<Chapter>:<Verse>[,<Verse>]...
	     Individual verse(s) of a specific chapter of a book
	 <Book>:<Chapter>-<Chapter>
	     Range of chapters in a book
	 <Book>:<Chapter>:<Verse>-<Verse>
	     Range of verses in a book chapter
	 <Book>:<Chapter>:<Verse>-<Chapter>:<Verse>
	     Range of chapters and verses in a book

	 /<Search>
	     All verses that match a pattern
	 <Book>/<Search>
	     All verses in a book that match a pattern
	 <Book>:<Chapter>/<Search>
	     All verses in a chapter of a book that match a pattern


## Build

rtb can be built by cloning the repository and then running make:

    git clone https://github.com/rafaalpizar/rtb.git
    cd rtb
    make

## License
Public domain
