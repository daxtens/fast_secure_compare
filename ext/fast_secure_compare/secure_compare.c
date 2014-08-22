#include <ruby.h>

VALUE FSC_module = Qnil;


static VALUE
method_compare(VALUE self, VALUE secret, VALUE input) {
    Check_Type(secret, T_STRING);
    Check_Type(input, T_STRING);

    // handle 0-length secrets
    if (RSTRING_LEN(secret) == 0 && RSTRING_LEN(input) != 0) {
        return Qfalse;
    }

    int input_pos;
    int secret_pos = 0;
    int input_len = RSTRING_LEN(input);
    int secret_len = RSTRING_LEN(secret);
    char * secret_ = RSTRING_PTR(secret);
    char * input_ = RSTRING_PTR(input);
    int result = secret_len - input_len;
    // make sure our time isn't dependent on secret_len, and only dependent
    // on input_len
    for (input_pos = 0; input_pos < input_len; input_pos++) {
        result |= input_[input_pos] ^ secret_[secret_pos];
        secret_pos = (secret_pos + 1) % secret_len;
    }

    return ((result == 0) ? Qtrue : Qfalse);
}

void
Init_fast_secure_compare(void) {
    FSC_module = rb_define_module("FastSecureCompare");
    rb_define_module_function(FSC_module, "compare", method_compare, 2);
}
