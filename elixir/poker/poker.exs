defmodule Poker.ParseCards do
    @moduledoc """
    Functions for parsing a hand of cards and assigning a bit mask to each card of the form xxxAKQJT 98265432 xxxxSHDC
    """

    @type hand :: list(card)
    @type parsed_hand :: list(parsed_card)
    @type card :: String.t()
    @type parsed_card :: bitstring

    @ranks ~w/2 3 4 5 6 7 8 9 10 J Q K A/
    @suits ~w/C D H S/

    @doc """
    Parse each card in a hand using bit mask to represent suit and rank
    """ 
    @spec parse_hand(hand) :: parsed_hand
    def parse_hand(hand), do: hand |> Enum.map(&parse_card/1)

    @doc """
    Parse a single card returning a bit mask to represent suit and rank xxxAKQJT 98265432 xxxxSHDC
    """ 
    @spec parse_card(card) :: parsed_hand
    def parse_card(card), do: card |> String.split_at(-1) |> card_bit_mask

    # Bit mask xxxAKQJT 98265432 xxxxSHDC
    defp card_bit_mask({rank ,suit}), do: << (rank |> rank_bit)::16, (suit |> suit_bit)::8 >> |> (fn  <<x::24>> -> x end).()

    # get bit value to set for rank and suit
    defp rank_bit(rank), do: @ranks |> Enum.find_index(&(&1==rank)) |> pow_2
  
    defp suit_bit(suit), do: @suits |> Enum.find_index(&(&1==suit)) |> pow_2

    defp pow_2(index), do: :math.pow(2, index) |> trunc
end

defmodule Poker.IdentifyHand do
  @moduledoc """
  Based on the methodology outlines in https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
  The approach is to create a bitfield representation of the hand and then use this along with
  some 2's complement voodoo to to derive the name of the hand and the rank
  """

  use Bitwise
  
  @type parsed_hand :: list(parsed_card)
  @type parsed_card :: integer  
  @type poker_hand:: {atom, integer}
  
  # The order of this Keyword list is important as we can derive the index from some bitshiffting on the nibble field 
  # we don't really need the name of the hand for evaluation :)
  @poker_hand_name_and_rank [four_of_a_kind: 8, straight_flush: 9, straight: 5, flush: 6, high_card: 1, one_pair: 2, two_pair: 3,
  royal_flush?: 10,  three_of_a_kind: 4,  full_house: 7] 

  @doc """
  provides the name and rank of the hand held
  """
  @spec poker_hand(parsed_hand) :: poker_hand
  def poker_hand(parsed_hand), do: @poker_hand_name_and_rank |> Enum.at(parsed_hand |> hand_offset)
  
  @doc """
  sets a bit mask for each rank held in a hand AKQJT98765432 note only one bit is set if multi cards held
  """
  @spec cards_bit_field(parsed_hand) :: bitstring
  def cards_bit_field(parsed_hand), do: parsed_hand |> Enum.reduce(0, &bor(&1, &2)) |> Bitwise.>>>(8)

  @doc """ 
  bit mask that holds single bit set for each card held structured there are 52 bits required to hold this
  see https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
  I shove it into 64 bit integer
  """
  @spec nibble_bit_field(parsed_hand) :: bitstring
  def nibble_bit_field(parsed_hand) do
    parsed_hand
    |> Enum.reduce(List.duplicate(0,16), &nibble_reducer/2)
    |> Enum.map(&(<<&1::4>>)) 
    |> Enum.into(<<>>)
    |> (fn <<x::64>> -> x end).() 
  end
  
  @doc """ 
  Binary And all cards in the hand with 1111=0xF will be non zero for a flush
  """
  @spec flush?(parsed_hand) :: boolean
  def flush?(parsed_hand), do: parsed_hand |> Enum.reduce(0xF, &band(&1, &2)) |> Kernel.!=(0)
  
  @doc """
  Check to see if there are five bits set 11111=0x1F, there is some bitshifting voodoo used to normalise the LSB
  """
  @spec straight?(parsed_hand) :: boolean
  def straight?(parsed_hand) do
    parsed_hand
    |> cards_bit_field
    |> (&div(&1 , &1 &&& -&1)).() #bit shifting voodoo :)
    |> Kernel.==(0x1F) #Check lsb for 1111
    |> Kernel.or(parsed_hand |> low_ace_straight?)
  end

  @doc """
  Check for low ace straight A 2 3 4 5 which is 100000001111=0x100f
  """
  @spec low_ace_straight?(parsed_hand) :: boolean
  def low_ace_straight?(parsed_hand), do: parsed_hand |> cards_bit_field |> Kernel.==(0x100f)

  @doc """
  Check for royal flush which is # 1111100000000=0x1f00
  """
  @spec royal_flush?(parsed_hand) :: boolean
  def royal_flush?(parsed_hand), do: parsed_hand |> cards_bit_field |> Kernel.==(0x1f00) |> Kernel.and(parsed_hand |> flush?) 

  #calculates the offset based on the parsed hand for the @poker_hand_name_and_rank 
  defp hand_offset(parsed_hand) do
    parsed_hand
    |> nibble_bit_field
    |> rem(15)
    |> Kernel.-(straight_offset(parsed_hand |> straight?))
    |> Kernel.-(flush_offset(parsed_hand|> flush?))
    |> Kernel.-(royal_flush_offset(parsed_hand |> royal_flush?))
  end

  # sets a bit in accumulator for each card in the hand 
  defp nibble_reducer(parsed_card, acc) do
    (for <<n::1 <- <<parsed_card |> Bitwise.>>>(8)::16>> >>, do: n)  
    |> Enum.zip(acc) 
    |> Enum.map(fn
      {0, x2} -> x2 
      {x1,x2} -> x1+(x2<<<1) |> trunc  end) 
  end
  
  # After the rem 15 operation on the nibble bit field we need to adjust the result for straights and flushes
  # See https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
  # for the calcs of the offsets
  defp straight_offset(true=_is_flush), do: 3
  defp straight_offset(false), do: 1

  defp flush_offset(true=_is_straight), do: 1
  defp flush_offset(false), do: 0

  defp royal_flush_offset(true=_is_royal_flush), do: -6
  defp royal_flush_offset(false), do: 0

end

defmodule Poker.ScoreHand do
  use Bitwise
  alias Poker.IdentifyHand

  @type parsed_hand :: list(parsed_card)
  @type parsed_card :: integer  
  @type hand_score:: bitstring

  @doc """
  provides a score for the hand held based on <<hand_score, card_score>>
  """
  @spec score_hand(parsed_hand):: bitstring
  def score_hand(parsed_hand), do: (parsed_hand |> poker_hand_score) <> (parsed_hand |> cards_score)

  @spec poker_hand_score(parsed_hand):: bitstring
  def poker_hand_score(parsed_hand), do: <<(parsed_hand |> IdentifyHand.poker_hand |> elem(1))::8>>
  
  @doc """ 
  Creates a score for the cards held by the player based on the number of cards of held
  We don't care if the player doesn't hold any cards as these lower bits will be ignored
  """
  def cards_score(parsed_hand), do: parsed_hand |> nibble_list |> sort_by_num_of_cards |> Enum.map(&elem(&1,1))|> encode

  @doc """
  sort the cards by the number of cards held in the hand and the value of the card
  """
  @spec  sort_by_num_of_cards(parsed_hand):: bitstring
  def sort_by_num_of_cards(nibble_list), do: nibble_list |> Enum.reverse |> Enum.with_index(2) |> Enum.sort(&>=/2) 

  #encode list of numbers as bitstring with 4 bits for each number 
  defp encode(xs), do: xs |> Enum.map(&(<<&1::4>>)) |> Enum.into(<<>>)
  
  # gernerate list from nibble_bit_field to get list of cards we throw away the Ace held if its is low
  defp nibble_list(parsed_hand) do 
    for << a::4  <- << (parsed_hand
      |> IdentifyHand.nibble_bit_field
      |> Bitwise.bxor(parsed_hand |> IdentifyHand.low_ace_straight? |> low_ace_bitmask))::56>> ## throw away low aces
    >>, do: a
  end

  # Straight & flush adjuestments to nibble % 15  
  defp low_ace_bitmask(true), do: 0x1000000000000
  defp low_ace_bitmask(false), do: 0

end

defmodule Poker do
  @moduledoc """
    Given a list of poker hands, return a list containing the highest scoring hand.
    see
    - https://en.wikipedia.org/wiki/List_of_poker_hands
    - https://www.codeproject.com/Articles/569271/A-Poker-hand-analyzer-in-JavaScript-using-bit-math
    - http://suffe.cool/poker/evaluator.html
    - http://elasticdog.com/2010/11/porting-a-poker-hand-evaluator-from-c-to-factor/
    
    The approach is give each hand a calculate a score based then just sort, chunk and pull the head to find winners
  """
  use Bitwise
  alias Poker.ParseCards
  alias Poker.ScoreHand

  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand([]), do: []
  def best_hand([card|[]]), do: [card]
  def best_hand(hands) do 
    hands 
    |> Enum.map(&([cards: &1, score: &1 |> ParseCards.parse_hand |> ScoreHand.score_hand]))
    |> Enum.sort_by(&(&1[:score]), &>=/2) 
    |> Enum.chunk_by(&(&1[:score])) 
    |> hd
    |> Enum.map(&(&1[:cards]))
  end

end
