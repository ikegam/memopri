# Memopri Command Line Utility

This gem provides a simple way to print text on a CASIO Memopri MEP-F10 label printer from Linux. The printer communicates over Wi‑Fi and this tool implements the minimal protocol required to send text labels.

## Installation

```
$ gem install memopri
```

The printer must be reachable via the network. The tool depends on [cairo](https://www.cairographics.org/) and [pango](https://pango.gnome.org/) to render text.

## Usage

Print standard input to the first printer found on the network:

```
$ echo "Hello, world" | memopri
```

Specify a printer by IP address:

```
$ echo "Label" | memopri -p 192.168.0.74
```

List discovered devices:

```
$ memopri -l
```

## Development

This project was tested on Debian GNU/Linux with Ruby 2.1.5. Contributions are welcome.
