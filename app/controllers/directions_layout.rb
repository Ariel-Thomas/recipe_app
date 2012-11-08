module DirectionsLayout
  private

  class DisplayBlocks
    attr_accessor :title, :text, :direction, :width, :depth
    
    def initialize(args)
      @title = args[:title] || ""
      @text = args[:text] || ""
      @direction = args[:direction]
      @width = args[:width] || 1
      @depth = args[:depth] || 1
    end
  end

  def make_directions_layout(recipe)
    directions_layout = [[],[]]

    recipe.directions.each do |direction|
      display_block = DisplayBlocks.new(title: direction.title, text: direction.text, direction: direction, width: direction.ingredient_entries.length,  depth: 1)

      #left most ingredient block
      direction.results_array.each do |entry|
        result = directions_layout.flatten.select{ |n| n.class == DisplayBlocks && n.direction == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        if (display_block.depth <= result.depth)
          display_block.depth = result.depth + 1
        end

        display_block.width += result.width - 1
      end

      # check for spaces in layout
      direction.ingredients_array.each do |entry|
        directions_layout[0] << entry.to_s

        (display_block.depth - 1).times do |index|
          directions_layout[index + 1] << DisplayBlocks.new(depth: index + 1)
        end
      end

      #create additional layers of depth as necessary
      unless (directions_layout[display_block.depth])
        directions_layout << []
      end

      # check for spaces in layout
      direction.results_array.each do |entry|

        result = directions_layout.flatten.select{ |n| n.class == DisplayBlocks  && n.direction == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        (display_block.depth - result.depth - 1).times do |index|
          directions_layout[result.depth + index + 1] << DisplayBlocks.new(width: result.width, depth: result.depth + index + 1)
        end
      end

      #put our newly create display_block into the layout
      directions_layout[ display_block.depth ] << display_block
    end

    return directions_layout
  end



=begin
  def make_directions_layout(recipe)
    directions_layout = [[],[]]

    recipe.directions.each do |direction|
      hash = { title: direction.title, text: direction.text, direction: direction, width: direction.ingredient_entries.length,  depth: 1 }

      #left most ingredient block
      direction.results_array.each do |entry|
        result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        if (result[:depth] >= hash[:depth])
          hash[:depth] = result[:depth] + 1
        end

        hash[:width] += result[:width] - 1
      end

      direction.ingredients_array.each do |entry|
        directions_layout[0] << entry.to_s

        (hash[:depth] - 1).times do |index|
          directions_layout[index + 1] << { title: "", width: 1,  depth: index + 1 }
        end
      end

      unless (directions_layout[hash[:depth]])
        directions_layout << []
      end

      direction.results_array.each do |entry|
        result = directions_layout.flatten.select{ |n| n.class == Hash && n[:direction] == entry.ingredient.direction }.first

        if (result.nil?)
          next
        end

        (hash[:depth] - result[:depth] - 1).times do |index|
          directions_layout[result[:depth] + index + 1] << { title: "", width: result[:width],  depth: result[:depth] + index + 1 }
        end
      end

      directions_layout[ hash[:depth] ] << hash
    end

    return directions_layout
  end
=end
end
