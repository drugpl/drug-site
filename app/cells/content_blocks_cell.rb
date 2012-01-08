class ContentBlocksCell < Cell::Rails
  def snippet(label, title)
    @snippet = Snippet[label]
    @title   = title
    render
  end
end
