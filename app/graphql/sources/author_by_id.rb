module Sources
  class AuthorById < GraphQL::Dataloader::Source
    def fetch(id)
      Author.find(id)
    end
  end
end
