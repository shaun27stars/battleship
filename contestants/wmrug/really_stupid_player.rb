class ReallyStupidPlayer
  def name
    # Uniquely identify your player
    "Karl & Shaun"
  end

  def new_game
    @@current_game ||= 0
    @@current_game += 1

    @@last_hits ||= []
    @@previous_last_hits = @@last_hits.dup

    if (@@current_game > 1) && @@last_pos
      @@previous_last_hits << @@last_pos
      
    end
    @@last_pos = nil
    # return an array of 5 arrays containing
    # [x,y, length, orientation]
    # e.g.
    # [
    #   [0, 0, 5, :down],
    #   [4, 4, 4, :across],
    #   [9, 3, 3, :down],
    #   [2, 2, 3, :across],
    #   [9, 7, 2, :down]
    # ]
    # max = 10
    # squares = []
    # %w(5 4 3 3 2).map do |len|
    #   dir = [:down, :across][rand(2)]
    #   if dir == :down
    #     pos = [rand(max), rand(max-len)]

    #   else
    #     pos = [rand(max-len), rand(max)]
    #   end

    # end
    case @@current_game
    when 1
      [
        [5, 9, 5, :across],
        [6, 8, 4, :across],
        [6, 7, 3, :across],
        [6, 6, 3, :across],
        [9, 6, 2, :down]
      ]
    when 2
      [
        [5, 0, 5, :across],
        [0, 5, 4, :down],
        [9, 6, 3, :down],
        [0, 9, 3, :across],
        [8, 9, 2, :across]
      ]
    else
      [
        [1, 4, 5, :down],
        [5, 5, 4, :across],
        [4, 9, 3, :across],
        [6, 2, 3, :across],
        [2, 1, 2, :across]
      ]
    end
  end

  def take_turn(state, ships_remaining)
    # state is the known state of opponents fleet
    # ships_remaining is an array of the remaining opponents ships

    # x = y = nil
    # @@last_pos ||= nil #error case

    # # if (@@last_pos && (state[@@last_pos[0]][@@last_pos[1]]==:hit))
    # # # #   x = y = 0
    # # # #   @@last_pos = nil
    # #   x,y = @@last_pos

    # #   if (x > 0 && state[x-1][y]==:hit)
    if res = @@previous_last_hits.pop
      return res
    end


    # # else
    # begin
    #   if @@last_pos
    #     if state[@@last_pos[1]][@@last_pos[0]]==:hit
    #       @@last_hits << @@last_pos
    #     end
    #     if @@last_pos==[9,9]
    #       @@last_pos = [-2,0]
    #     end
    #     if @@last_pos==[7,9]
    #       @@last_pos = [-1,0]
    #     end
    #     if @@last_pos[0]>=7
    #       x = (@@last_pos[0]+1)%3
    #       y = @@last_pos[1]+1
    #     else
    #       x = @@last_pos[0]+3
    #       y = @@last_pos[1]
    #     end
    #     @@last_pos = [x,y]
    #   else
    #     x = 0
    #     y = 0
    #     @@last_pos = [x,y]
    #   end
    # end until state[y][x] == :unknown

    taken = state.flatten.reject{|p| p==:unknown}
    offset = 0
    if taken.size > 33
      offset = 1
    end
    if taken.size > 66
      offset = 2
    end
    begin
      y = rand(10)
      x = (rand(4)*3)+(y%3) - offset
    end until (x>=0 && x<=9 && state[y][x] == :unknown)
    
      
    # end

    pos = [x,y]


    @@last_pos = pos
    return pos # your next shot co-ordinates
  end

  # you're free to create your own methods to figure out what to do next
end