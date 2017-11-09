**Archived** - don't use this! It was an interesting experiment, but it probably doesn't help any reasonable use-case and is old and unmaintained.

# FastSecureCompare #
[![Build Status](https://travis-ci.org/daxtens/fast_secure_compare.svg?branch=master)](https://travis-ci.org/daxtens/fast_secure_compare)
[![Gem Version](https://badge.fury.io/rb/fast_secure_compare.svg)](http://badge.fury.io/rb/fast_secure_compare)

This gem provides a simple, fast way to do string comparisons that resist timing attacks.

It also provides an easy way to (marginally) speed up your existing web apps that use Rails or Rack's secure_compare functions (for example, any app that uses Rails built in sessions) by monkey patching the fast C function over the slow pure Ruby one.

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

The gem also provides monkeypatches for rack and rails, to make it easier to deploy.

# How do I use this gem in my code? #

That depends on your use case:

## By itself ##

```ruby

require 'fast_secure_compare'

FastSecureCompare.compare(my_secret, user_input)
```

## In a Rails app ##
To make all uses of `ActiveSupport::MessageVerifier` (including every time a user's session is verifed!) faster, you need to `require 'fast_secure_compare/rails'` somehow.

In, e.g. Redmine, this is as simple as adding the following line to `Gemfile.local`:

`gem 'fast_secure_compare', :require => "fast_secure_compare/rails"`

Don't forget to run `bundle install`.

## In a Rack app ##

Apps using Rack and calling `Rack::Utils.secure_compare` can be sped up with `require 'fast_secure_compare/rack'`.

Note that this is not well tested and I'd appreciate feedback.

# How much faster is this? #

Well, that depends on how you measure it.

If you do a synthetic microbenchmark (see `demo/timings.rb`), you'll see something like this when comparing two 40 byte strings (like SHA1 hashes), 1000 times over.

The 'early fail' one differs at the first character, while the 'late fail' one differs at the last character.

```
                                         user     system      total        real
==, early fail                       0.000000   0.000000   0.000000 (  0.000191)
==, late fail                        0.000000   0.000000   0.000000 (  0.000219)
Pure Ruby secure_compare, 'early'    0.020000   0.000000   0.020000 (  0.019503)
Pure Ruby secure_compare, 'late'     0.020000   0.000000   0.020000 (  0.019279)
C-based FastSecureCompare, 'early'   0.000000   0.000000   0.000000 (  0.000588)
C-based FastSecureCompare, 'late'    0.000000   0.000000   0.000000 (  0.000582)
```

Interpreting the results, the C based one executes 2 orders of magnitude faster than the pure Ruby, and the same order of magnitude as `==`.

However, if you benchmark an actual application, things will obviously differ. If you look at the difference per call, on my hardware you'd see about a ((0.02-0.0005)/1000) = 20 microsecond difference, which is probably too small to measure.

However, if you are comparing strings that are greater than 40 characters in length, the differences become significantly more pronounced. (This was the original motivation for this gem.)

# Is there anything else I should know? #

* The gem is not foolproof. In particular, it can't protect you against anything designed to exploit cache misses or any other more elaborate form of timing attack. However, none of the existing pure Ruby secure_compare functions do either.

* Putting the argmuents around the wrong way may leak the length of your secret.

* Don't use a secret of length 0.
