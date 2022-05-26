# ArgumentParser



TODO





// ArgumentParser Validation

[^2]



subcommand

https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part3/

@OptionGroup



customized help info

https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part4/



inversions

https://apple.github.io/swift-argument-parser/documentation/argumentparser/declaringarguments/

```swift
struct Example: ParsableCommand {
    @Flag(inversion: .prefixedNo)
    var index = true

    @Flag(inversion: .prefixedEnableDisable)
    var requiredElement: Bool

    mutating func run() throws {
        print(index, requiredElement)
    }
}
```





# References

[^1]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part1/
[^2]:https://www.andyibanez.com/posts/writing-commandline-tools-argumentparser-part2/



