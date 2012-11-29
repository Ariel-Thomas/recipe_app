module RecipesHelper

  def make_directions_layout(recipe)
    directions_layout = DisplayLayout.new([[],[]])

    recipe.directions.reverse_each do |direction|
      if (directions_layout.find_by_direction(direction).nil?)
        add_direction_to_layout(direction,directions_layout)
      end
    end

    return directions_layout
  end

  def add_direction_to_layout(direction, directions_layout)
    display_block = DisplayBlock.new(direction)

    direction.results_array.each do |entry|
      child = add_direction_to_layout entry.ingredient.direction, directions_layout

      display_block.add_child child
    end

    display_block.children.each do |child|
      directions_layout.add_spacing_for display_block, child
    end

    direction.ingredients_array.each do |entry|
      directions_layout.add_ingredient entry, display_block
    end
    
    directions_layout.add_block display_block

    return display_block
  end


  class DisplayBlock
    attr_accessor :title, :text, :direction, :width, :depth
    attr_accessor :child_index
    attr_accessor :children

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
      
      @children = []
    end

    def add_child(child)
      self.widen_by_size_of child
      self.deepen_more_than child
      @children << child
    end

    def deepen_more_than(child)
      if (self.depth <= child.depth)
        self.depth = child.depth + 1
      end
    end

    def widen_by_size_of(child)
      self.width += child.width - 1
    end

    def display_width
      width * 50
    end
  end


  class DisplayLayout < Array


    def find_by_direction(direction)
      self.flatten.select{ |n| n.class == DisplayBlock && n.direction.present? && n.direction == direction }.first
    end

    def add_ingredient(ingredient_entry, display_block)
      self[ 0 ] << ingredient_entry.to_s
      add_spacing_for display_block, nil
    end

    def add_spacing_for(display_block, child)
      if (child.nil?)
        (display_block.depth - 1).times do |index|
          self[index + 1] << DisplayBlock.new(depth: index + 1)
        end
      else
        placement_index = get_placement_index_for child

        (display_block.depth - child.depth - 1).times do |index|
          depth = index + child.depth + 1
          empty_block = DisplayBlock.new(depth: index + 1, width: child.width)
          real_index = get_real_index_from_depth_and_placement_index(depth,placement_index)

          self[depth].insert(real_index,empty_block)
        end
      end
    end

    def get_placement_index_for(display_block)
      cur_col = self[display_block.depth]
      @placement_index = 0;

      cur_col.each do |block|
        if (block != display_block)
          @placement_index += block.width
        else
          break
        end
      end

      return @placement_index
    end

    def get_real_index_from_depth_and_placement_index(depth, placement_index)
      cur_col = self[depth]
      
      block_index = 0;
      @real_index = 0;

      cur_col.each_with_index do |block, index|
        if (placement_index != block_index)
          block_index += block.width
          @real_index += 1
        else
          break
        end
      end

      return @real_index
    end

    def add_block(display_block)
      unless (self[display_block.depth])
        self << []
      end

      self[ display_block.depth ] << display_block
    end
  end
end
