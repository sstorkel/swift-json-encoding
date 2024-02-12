# JSON Encoding & Decoding 

This Swift playground demonstrates the basics of encoding and decoding data
to JSON using the `JSONEncoding` and JSONDeoding` classes.

It also illustrates a problem that isn't covered in any Swift documentation
or tutorials: `Dictionary` objecst that use keys other than `String` or `Int`
get turned into JSON ***arrays*** rather than dictionaries! The playground
includes a pointer to a [blog post](https://www.fivestars.blog/articles/codable-swift-dictionaries/)
that explains the problem as well as several potential solutions.
