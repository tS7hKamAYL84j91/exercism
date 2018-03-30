
defmodule Poker do
  use Bitwise
  #import Bitwise 
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s

  See https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
  See http://suffe.cool/poker/evaluator.html
  See http://elasticdog.com/2010/11/porting-a-poker-hand-evaluator-from-c-to-factor/
  
  """
  @primes_a  [ 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41 ]
  @ranks ~w/2 3 4 5 6 7 8 9 10 J Q K A/
  @suits ~w/C D H S/
  @hands [
    {"4 of a Kind", 19}, 
    {"Straight Flush", 23}, 
    {"Straight", 11}, 
    {"Flush", 13}, 
    {"High Card", 2},
    {"1 Pair", 3}, 
    {"2 Pair", 5}, 
    {"Royal Flush", 29}, 
    {"3 of a Kind", 7}, 
    {"Full House", 17}]

  for {{rank,prime_score}, index} <- @ranks |> Enum.zip(@primes) |> Enum.with_index do
    def rank_encoding(unquote(rank)), do: unquote([
      b: :math.pow(2,index) |> trunc,
      r: index, 
      p: prime_score])
  end

  def suit_encoding(suit) do 
    @suits 
    |> Enum.reverse 
    |> Enum.with_index
    |> Enum.find(&(elem(&1,0)==suit)) 
    |> elem(1)
    |> (fn x -> :math.pow(2,x) end).() 
    |> trunc
  end

  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand([]), do: []
  def best_hand([card|[]]), do: [card]
  def best_hand(hands) do 
    hands 
    |> Enum.map(&([
      poker_hand: &1 |> hand_name, 
      cards: &1, 
      nibble_bit_field: <<(&1 |> hand_name |> elem(1))::8, 
      (&1 |>parse |> nibble_bit_field |> Bitwise.bxor(&1 |> low_ace |> low_ace_offset))::56>>,
      score:  <<(&1 |> hand_name |> elem(1))::8, (&1 |> score)::56>>
           ]))
    |> Enum.sort_by(&(&1[:score]), &>=/2) 
    |> Enum.chunk_by(&(&1[:score])) 
    |> hd
    |> Enum.map(&(&1[:cards]))
  end

  def score(hand) do
    (for << a::4  <- << 
      (hand
      |> Poker.parse 
      |> Poker.nibble_bit_field
      |> Bitwise.bxor(hand |> low_ace |> low_ace_offset))::52>> >>, do: a) 
        |> Enum.reverse 
        |> Enum.with_index(2) 
        |> Enum.sort(fn x,y -> x >= y end) 
        |> Enum.map(fn x -> elem(x,1) end)
        |> Enum.map(fn x -> (<<x::4>>) end) 
        |> Enum.into(<<>>)
        |> (fn <<x::52>> -> x end).() 
  end

  def hand_name(hand) do
    @hands
    |> Enum.at(
      hand
      |> parse
      |> nibble_bit_field
      |> rem(15)
      |> Kernel.-(straight_offset(hand |> parse |> straight?))
      |> Kernel.-(flush_offset(hand |> parse |> flush?))
      |> Kernel.-(royal_flush_offset(
        hand 
        |> parse 
        |> cards_bit_field 
        |> Kernel.==(0x7c00 >>> 2) 
        |> Kernel.and(hand |> parse |> flush?))))
  end 

  def low_ace(hand) when is_list(hand), do: hand |> parse |> cards_bit_field |> Kernel.==(0x100f)
  
  def low_ace_offset(true), do: 0x1000000000000
  def low_ace_offset(false), do: 0

  def straight_offset(true), do: 3
  def straight_offset(false), do: 1

  def flush_offset(true), do: 1
  def flush_offset(false), do: 0

  def royal_flush_offset(true), do: -6
  def royal_flush_offset(false), do: 0

  
  def parse(hand) do 
    hand 
    |> Enum.map(&String.split_at(&1,-1)) 
    |> Enum.map(fn {r,s} -> [ {:suit, s},  {:card, r <> s} | Poker.rank_encoding(r)] end) 
    |> Enum.map(fn card -> card |> Keyword.put(:s, card |> Keyword.get(:suit) |> suit_encoding) end)
    |> Enum.map(fn card -> card |> Keyword.delete(:suit) end)
    |> Enum.map(fn hand -> 
      [card: hand[:card], encoding: (for << n::32 <- << hand[:b]::16, hand[:s]::4, hand[:r]::4, hand[:p]::8>> >>, do: n) |> hd] end)
  end

  def flush?(parsed_hand)  do 
    parsed_hand 
    |> Enum.reduce(0xF000, fn x, acc -> band(x[:encoding], acc) end)
    |> Bitwise.>>>(12)
    |> Kernel.!=(0)
  end

  def straight?(parsed_hand) do
    parsed_hand
    |> cards_bit_field
    |> (fn x -> (x / (x &&& -x)) end).()
    |> trunc
    |> Kernel.==(31)
    |> Kernel.or( parsed_hand |> cards_bit_field |> Kernel.==(0x100f))
  end

  def cards_bit_field(parsed_hand) do
    parsed_hand 
    |> Enum.reduce(0, fn x, acc -> bor(x[:encoding], acc) end) 
    |> Bitwise.>>>(16)  
  end

  def nibble_bit_field(parsed_hand) do
    parsed_hand
    |> Enum.reduce(List.duplicate(0,16), 
      fn x, acc -> (for <<n::1 <- <<x[:encoding] |> Bitwise.>>>(16)::16>> >>, do: n)  
        |> Enum.zip(acc) 
        |> Enum.map(fn
          {0, x2} -> x2 
          {x1,x2} -> x1+(x2<<<1) |> trunc  end) end)
    |> Enum.map(&(<<&1::4>>)) 
    |> Enum.into(<<>>)
    |> (fn <<x::64>> -> x end).() 
  end

end
