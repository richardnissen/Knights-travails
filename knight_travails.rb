class MoveNode
  attr_accessor :position, :parent
  
  TRANSFORMATIONS = [[1, 2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  @@history = []

  def initialize(position, parent)
    @position = position
    @parent = parent
    @@history.push(position)
  end

  def generate_children
    TRANSFORMATIONS.map { |t| [t[0] + @position[0], t[1] + position[1]] }
                        .keep_if { |e| MoveNode.valid?(e) }
                        .map { |e| MoveNode.new(e, self) }
  end

  def self.valid?(position)
    position[0].between?(0, 7) && position[1].between?(0, 7) && !@@history.include?(position)
  end
      
end


def return_parents(node, parents = [node.position])
  return_parents(node.parent, parents.unshift(node.parent.position)) unless node.parent == nil
  parents
end

def knight_moves(start_position, end_position)
  queue = []
  current = MoveNode.new(start_position, nil)
  until current.position == end_position
    current.generate_children.each { |child| queue.push(child)}
    current = queue.shift
  end
  pp return_parents(current)
end

knight_moves([3,3], [0,0])