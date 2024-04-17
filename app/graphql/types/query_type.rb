# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :authors, [Types::AuthorType], null: false, description: "Returns a list of authors"

    field :books, [Types::BookType], null: false, description: "Returns a list of books"

    field :author, Types::AuthorType, null: true do
      description "Returns an author by ID"
      argument :id, ID, required: true
    end

    field :book, Types::BookType, null: true do
      description "Returns a book by ID"
      argument :id, ID, required: true
    end

    def author(id:)
      dataloader.with(Sources::AuthorById).load(id)
    end

    def book(id:)
      dataloader.with(Sources::BookById).load(id)
    end

    def books
      Book.all
    end

    def authors
      Author.all
    end

  end
end
