module Sources
  class BooksByAuthorId < GraphQL::Dataloader::Source
    def fetch(author_ids)

      books = Book.where(author_id: author_ids)

      books.group_by(&:author_id)
    end
  end
end
