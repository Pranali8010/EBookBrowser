
# EBookBrowser

A basic app to view the list of books provided by gutendex.com website.

The list is displayed in a pagination fashion showing 32 book items for each pagination request. The next page is fetched once the list is scrolled to the last item of current page.
## Demo

![EBookBrowser Demo](https://github.com/Pranali8010/EBookBrowser/assets/57432358/27aa2d58-fb53-4bdd-9fcc-eb6da8cbf8ac)
## Getting Started

1. Download and install Xcode. EBookBrowser for iOS requires Xcode 13.2 or newer
2. From command line, run `git clone https://github.com/Pranali8010/EBookBrowser.git` in the folder of your preference
3. Open `EBookBrowser.xcodeproj` to open in xcode

## Project Information

### Architecture
EBookBrowser uses MVVM architecture, with dependency injection via Environment object to provide required functionalities to classes. 

### Interface
Complete UI is created using SwiftUI.

### Test coverage
View model class coverage - 100%.

## API Reference

### Get all books request

```
  GET gutendex.com/books
```

#### Response structure
```JSON
{
  "count": <number>,
  "next": <string or null>,
  "previous": <string or null>,
  "results": <array of Books>
}
```

#### Book json structure
```json
{
  "id": <number of Project Gutenberg ID>,
  "title": <string>,
  "subjects": <array of strings>,
  "authors": <array of Persons>,
  "translators": <array of Persons>,
  "bookshelves": <array of strings>,
  "languages": <array of strings>,
  "copyright": <boolean or null>,
  "media_type": <string>,
  "formats": <Format>,
  "download_count": <number>
}
```
