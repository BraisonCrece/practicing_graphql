module Sources
  class BookById < GraphQL::Dataloader::Source
    def fetch(id)
      Book.find(id)
    end
  end
end
