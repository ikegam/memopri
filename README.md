# CLI Utility for Memopri MEP-F10

This is a command line based application to use Casio's Memopri (MEP-F10). MEP-F10 is a sticker printer and it is very cheap around 5000 yen ($50). There are no nice same kinds of device which runs on Linux environemnt. You can print stickers using this software.

* [Amazon Link w/ my affiliaton](http://www.amazon.co.jp/gp/product/B00B973384/ref=as_li_ss_tl?ie=UTF8&camp=247&creative=7399&creativeASIN=B00B973384&linkCode=as2&tag=mixallowblogd-22)


# Installation

* gem install memopri

# Usage

* echo -e "hoge\nhoge" | memopri

# ToDo

* Image
* Fix magic numbers
* Analyze communication protocols more

# Test environment

Debian GNU/Linux w/ ruby 2.1.5p273 (2014-11-13) [x86-64-linux-gnu]
