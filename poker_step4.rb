require './draw_hand.rb'

tehuda_card = draw_hand

def card_suite(card)
  case card[0]
  when "S"
    kono_suite = "スペード"
  when "H"
    kono_suite = "ハート"
  when "D"
    kono_suite = "ダイヤ"
  when "C"
    kono_suite = "クラブ"
  end
  return kono_suite
end

def card_num(card)
  if card[1,2].to_i > 0
    kono_num = card[1,2]
  else
    case card[1,1]
    when "A"
      kono_num = "エース"
    when "K"
      kono_num = "キング"
    when "Q"
      kono_num = "クイーン"
    when "J"
      kono_num = "ジャック"
    end
  end
  return kono_num
end


def draw_card(a)
  suite = card_suite(a)
  num = card_num(a)
  card_string = suite + num
  return card_string
end


def pair(card)
  pair_count = 0
  for i in 0..card.length-2 do
    for j in i+1..card.length-1 do
      if card[i][1,2]==card[j][1,2]
        pair_count += 1
      end
    end
  end
  return pair_count
end

def straight(card)
  a = []
  for i in 0..4 do
    a[i] = num_hantei(card[i]).to_i
  end
  a.sort!
  if a[0]==1&&a[1]==10&&a[2]==11&&a[3]==12&&a[4]==13
    return true
  end
  for i in 0..a.length-2 do
    if a[i]+1 != a[i+1]
      return false
    end
  end
  return true
end

def num_hantei(num)
  case num[1,2]
  when "A"
    return 1
  when "K"
    return 13
  when "Q"
    return 12
  when "J"
    return 11
  else
    return num[1,2]
  end
end

def flash(card)
  for i in 1..card.length-1 do
    if card[0][0]!=card[i][0]
      return false
    end
  end
  return true
end

def straight_flash(card)
  if straight(card) && flash(card)
    return true
  else
    return false
  end
end

def royal_straight_flash(card)
  royal = []
  for i in 0..4 do
    royal[i] = num_hantei(card[i]).to_i
  end
  royal.sort!
  if royal[0]==1&&royal[1]==10&&royal[2]==11&&royal[3]==12&&royal[4]==13&&flash(hand)
    return true
  end
  return false
end

def hand_hantei(hand)
  kaburi = pair(hand)
  if royal_straight_flash(hand)
    poker_hand = "ロイヤルストレートフラッシュ"
  elsif straight_flash(hand)
    poker_hand = "ストレートフラッシュ"
  elsif kaburi == 6
    poker_hand = "フォーカード"
  elsif kaburi == 4
    poker_hand = "フルハウス"
  elsif flash(hand)
    poker_hand = "フラッシュ"
  elsif straight(hand)
    poker_hand = "ストレート"
  else
    case kaburi
    when 1
      poker_hand = "ワンペア"
    when 2
      poker_hand = "ツーペア"
    when 3
      poker_hand = "スリーカード"
    else
      poker_hand = "ブタ"
    end
  end
  return poker_hand
end

puts hand_hantei(tehuda_card)
tehuda_card.each do |card|
  puts draw_card(card)
end
