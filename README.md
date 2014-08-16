This gem provides a simple, fast way to do string comparisons that resist timing attacks.

# What is a timing attack? #
A timing attack is an attack on a system that determines secret information based on how long an operation takes.

Timing attacks are particularly prevalent (and dangerous) in cryptographic operations, but they can also sneak into other types of operation.

In particular, any time you are **comparing user specified input with a secret**, you should consider whether or not you are exposing yourself to a timing attack.

The attack is probably best described by [Nate Lawson](http://rdist.root.org/2010/07/19/exploiting-remote-timing-attacks/):

> The attack is very simple. You repeatedly send guesses about a secret value to the server, which rejects them as incorrect. However, if your first byte of the guess is correct, it takes a very slightly longer time to return the error. With many measurements and some filtering, you can distinguish this difference.

Therefore, it's important that the amount of time these operations take depends *only* on the length of the user's input, and *not* on any characteristic of the secret data.

# How does this gem help? Why should I use it rather than rolling my own? #

This gem provides a secure comparison function that is:

 - very simple: 1 class, 1 method
 - fast: it uses a C back-end rather than a pure Ruby implementation.
 - portable: the C code is platform independent

Furthermore, unlike some other secure comparison fuctions, the code does not require that the strings are the same length, and should not leak the length of the string if the string lengths do not match.

If you're interested in seeing how much faster you can make your code by using this gem, check out the demo folder.

# How do I use this gem in my code? #

```ruby

import 'fast_secure_compare'

FastSecureCompare.compare(my_secret, user_input)
```

# Is there anything else I should know? #

The gem is not foolproof. In particular, it can't protect you against anything designed to exploit cache misses or any other more elaborate form of timing attack. However, none of the existing pure Ruby secure_compare functions do either.
