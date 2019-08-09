using Lazy
function secret_handshake(code::Integer)
    handshake = ["wink","double blink","close your eyes","jump"]
    is_bit_set(bit) = (code & (1 << bit)) > 0
    @>> 0:(length(handshake) - 1) begin
        filter(is_bit_set) 
        map(x->handshake[x + 1])
        xs->handshake |> length |> is_bit_set ? reverse(xs) : xs
    end
end
