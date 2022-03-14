require_relative 'output'
require_relative 'input'

class Game
  attr_reader :window, :snake

  def initialize
    @window = TermWindow.new(20, 60)

    # Create Snake with coordenates of every slide (3 slides at beginning)
    # TODO: It could be interesting... play with several players (snakes)
    @snake = Snake.new([[4,10], [4,9], [4,8]])
    @input = Input.new(window)
    Output.init
    @output = Output.new(window)
  end

  def play
    score = 0

    food = Food.new(window)
    food.relocate_without_conflict!(@snake)
    window.paint_food(food)

    key = @input.key
    while (key != 27)
      @output.print_at(" SnakeGame - (Press ESC to exit) ", 0, 5)
      @output.print_at(" Score: #{score.to_s} ", 0, window.width - 15)
      window.timeout = 150

      key = @input.update
      case key
      when Curses::KEY_DOWN
        @snake.insert(0, [@snake[0][0], @snake[0][1] + 1])
      when Curses::KEY_UP
        @snake.insert(0, [@snake[0][0], @snake[0][1] - 1])
      when Curses::KEY_LEFT
        @snake.insert(0, [@snake[0][0] - 1, @snake[0][1]])
      when Curses::KEY_RIGHT
        @snake.insert(0, [@snake[0][0] + 1, @snake[0][1]])
      end

      @snake[0][0] = (window.width.to_i - 2) if @snake[0][0] == 0
      @snake[0][1] = (window.height.to_i - 2) if @snake[0][1] == 0
      @snake[0][0] = 1 if @snake[0][0] == window.width - 1
      @snake[0][1] = 1 if @snake[0][1] == window.height - 1

      if @snake.crashed?
        break
      end

      if food.has_been_eaten_by?(@snake)
        score += food.points
        food = Food.new(window)
        food.relocate_without_conflict!(@snake)
        window.paint_food(food)
      else
        last_part = @snake.pop
        @output.print_at(' ', last_part[1], last_part[0])
      end

      window.paint_snake(@snake)
    end

    window.close
    Output.close

    puts("----- GAME OVER -----")
    puts("----- Score: #{score} -----")
  end

  private

  def render
  end

  def update
  end
end
