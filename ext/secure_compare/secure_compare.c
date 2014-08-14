int secure_compare_bytes(const unsigned char * secret, unsigned int secret_len, 
                         const unsigned char * input, unsigned int input_len) {

    int input_pos;
    int secret_pos = 0;
    int result = secret_len - input_len;
    // make sure our time isn't dependent on secret_len, and only dependent
    // on input_len
    for (input_pos = 0; input_pos < input_len; input_pos++) {
        result |= input[input_pos] ^ secret[secret_pos];
        secret_pos = (secret_pos + 1) % secret_len;
    }

    return result;
}
