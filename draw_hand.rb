class << self

  define_method "draw_hand" do

    winning_hand_keys = DrawHander::FIXING_HANDS.keys

    is_call_winning_hand = winning_hand_keys.any? do |key|
      ARGV[0] == key.to_s
    end

    if is_call_winning_hand
      type = ARGV[0].to_sym
    else
      type = :random
    end

    draw_hander = DrawHander.new(type)
    draw_hander.draw_hand

  end

  private
  class DrawHander

    def initialize(type)
      @drawn_card = []
      @type = type
    end

    def draw_hand
      return draw_random_hand if @type == :random

      FIXING_HANDS[@type]
    end

    private
    def draw_random_hand

      hand = []

      5.times do

        card = nil

        loop do
          card = create_card
          break unless @drawn_card.include?(card)
        end

        @drawn_card << card
        hand << card

      end

      hand
    end

    FIXING_HANDS = {
      :no_winning_hand => ["SA", "D3", "H2", "DK", "H5"],
      :one_pair => ["SA", "HA", "S2", "S3", "S4"],
      :two_pair => ["SA", "HA", "S2", "H2", "S4"],
      :three_card => ["H2", "S2", "D2", "S3", "S4"],
      :straight => ["S2", "D3", "S4", "S5", "H6"],
      :flash => ["S2", "S7", "S4", "S5", "S6"],
      :full_hause => ["H2", "S2", "D2", "S3", "S3"],
      :four_card => ["S2", "D2", "H2", "C2", "C3"],
      :straight_flash => ["S2", "S3", "S4", "S5", "S6"],
      :royal_straight_flash => ["S10", "SJ", "SQ", "SK", "SA"],
    }

    def create_card
      suit = ["S", "H", "D", "C"].sample

      number = rand(13) + 1
      case number
      when 1
         value = "A"
      when 11
        value = "J"
      when 12
        value = "Q"
      when 13
        value = "K"
      else
        value = number.to_s
      end

      suit + value
    end

  end

end
