class ContentBlocksCell < Cell::Rails
  def snippet
    @snippet = ContentBlocks::Models::Snippet[@opts[:label]]
    render
  end
end
