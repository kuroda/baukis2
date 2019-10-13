class ModelPresenter 
  attr_reader :object, :view_context

  def initialize(object, view_context)
    @object = object
    @view_context = view_context
  end
end
