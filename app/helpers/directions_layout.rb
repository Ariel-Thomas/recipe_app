module DirectionsLayout
  private

  def make_directions_layout(recipe)
    directions_layout = DisplayLayout.new([[],[]])

    recipe.directions.each do |direction|
      display_block = DisplayBlock.new(direction)

      direction.results_array.each do |entry|
        child = directions_layout.find_by_direction(entry)
 
        next if child.nil?

        display_block.deepen_more_than child
        display_block.widen_by_size_of child
      end

      direction.ingredients_array.each do |entry|
        directions_layout.add_ingredient entry 
        directions_layout.add_spacing_for display_block 
      end

      directions_layout.add_block display_block
    end

    return directions_layout
  end


  class DisplayBlock
    attr_accessor :title, :text, :direction, :width, :depth
    
    def initialize(args)
      if args.class == Direction
        @title = args.title
        @text = args.text
        @direction = args
        @width = args.ingredient_entries.length
        @depth = 1
      else
        @title = args[:title] || ""
        @text = args[:text] || ""
        @direction = args[:direction]
        @width = args[:width] || 1
        @depth = args[:depth] || 1
      end
    end

    def width_in_pixels
      width * 49
    end

    def deepen_more_than(child)
      if (self.depth <= child.depth)
        self.depth = child.depth + 1
      end
    end

    def widen_by_size_of(child)
      self.width += child.width - 1
    end
  end

  class DisplayLayout < Array
    def add_spacing_for(display_block)
      (display_block.depth - 1).times do |index|
        self[index + 1] << DisplayBlock.new(depth: index + 1)
      end
    end

    def add_block(display_block)
      unless (self[display_block.depth])
        self << []
      end

      self[ display_block.depth ] << display_block
    end

    def add_ingredient(ingredient_entry)
      self[ 0 ] << ingredient_entry.to_s
    end

    def find_by_direction(display_block)
      self.flatten.select{ |n| n.class == DisplayBlock && n.direction == display_block.ingredient.direction }.first
    end
  end

end