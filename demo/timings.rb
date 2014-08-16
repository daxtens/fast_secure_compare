require "benchmark"
require "fast_secure_compare"

# The pure string comparison function that was originally ported to C
# loosely based on https://github.com/rack/rack/blob/master/lib/rack/utils.rb
# and http://security.stackexchange.com/questions/49849/timing-safe-string-comparison-avoiding-length-leak
def secure_compare(a, b)
  l = a.unpack("C*")

  i = 0
  r |= a.length - b.length # fail if the lengths are different
  b.each_byte do |v|
    r |= v ^ l[i]
    i = (i + 1) % a.length # make sure we compare on all bytes of b, even if a is shorter.
  end
  r == 0
end


puts <<eof
Testing methodology
===================

We check the following cases:
  1) Compare two strings with == where the characters are the same until late in the string.
  2) Compare two strings with == where the characters differ early in the string.
  3) Same as 1 but with a pure Ruby implementation of secure_compare.
  4) Same as 2 but with a pure Ruby implementation of secure_compare.
  5) Same as 1 but with the C implementation in the secure_compare gem.
  6) Same as 2 but with the C implementation in the secure_compare gem.
  7) Same as 1 but we SHA2 hash the strings then compare them with ==.
  8) Same as 2 but we SHA2 hash the strings then compare them with ==.

We do 100 tests of each case.

We do two rounds of this:

 - To make the difference (especially in ==) really visible, we use a really long string:
    'The quick fox jumped over the lazy dogue.' repeated 1000 times.

 - For a more realistic test, we do a 2048 bit (256 byte) string.

We change the first character for the early case, and the last character for the late case.

(With regards to tests 7 and 8, a successful attack would also require an attack
on a SHA2 hash function, which is what makes it safe to use ==.)

Interpreting the results
========================

Ruby's benchmark module rounds off numbers quite agressively, so to see anything for the
== cases, refer to the 'real' measurement.

In the first case, you should observe an order of magnitude or greater difference in using
just ==, while you get measurements for both secure_compares that are the same to within
the margin of error.

In the second case, the == are much closer, but should still be distinguishable.

You'll also notice that secure_compare is *much* slower and not super consistent,
especially the pure Ruby one. This is the price you pay for not having a language-level
secure byte comparison primitive.
eof

def compare(base_str)
  early_str = base_str.clone()
  early_str[0] = 'z'

  late_str = base_str.clone()
  late_str[late_str.length-1] = '!'

  Benchmark.bmbm() do |b|
      b.report("==, early fail")          {for i in 0..100 do
                                             base_str == early_str
                                           end}
      b.report("==, late fail")         {for i in 0..100 do
                                           base_str == late_str
                                         end}
      b.report("Pure Ruby secure_compare, 'early'") {for i in 0..100 do
                                                       secure_compare(base_str, early_str)
                                                     end}
      b.report("Pure Ruby secure_compare, 'late'") {for i in 0..100 do
                                                      secure_compare(base_str, late_str)
                                                    end}
      b.report("C-based FastSecureCompare, 'early'") {for i in 0..100 do
                                                    FastSecureCompare.compare(base_str, early_str)
                                                  end}
      b.report("C-based FastSecureCompare, 'late'") {for i in 0..100 do
                                                   FastSecureCompare.compare(base_str, late_str)
                                                 end}
      b.report("SHA2-then-==, 'early'") {for i in 0..100 do
                                                    (Digest::SHA2.new << base_str).to_s == \
                                                    (Digest::SHA2.new << early_str).to_s
                                                  end}
      b.report("SHA2-then-==, 'late'") {for i in 0..100 do
                                                    (Digest::SHA2.new << base_str).to_s == \
                                                    (Digest::SHA2.new << late_str).to_s
                                                 end}
    end
end

puts ""
puts "==== Long text ===="
puts ""
compare('The quick fox jumped over the lazy dogue.'*1000)

puts ""
puts "==== Short text ===="
puts ""
compare('abcdefgh'*32)
